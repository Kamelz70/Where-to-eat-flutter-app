import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:where_to_eat/models/review.dart';

import '../Screens/profile_screen.dart';
import '../screens/photo_viewer_screen.dart';
import 'reviewed_food_items_list.dart';

class ReviewPost extends StatelessWidget {
  Review review;
  bool? isLinked;
  ReviewPost(this.review, {Key? key, this.isLinked = true}) : super(key: key);
  PageController _pageController = new PageController();

  void _openimageView(
      BuildContext context, List<File> items, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewerScreen(
          galleryItems: items,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: initialIndex,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  void openProfile(BuildContext context, String profileId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileScreen(userId: profileId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int tabsCount = 1;
    if (review.reviewItems != null) tabsCount += 1;
    tabsCount += review.reviewImages.length;
    //whole post card
    return Card(
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //header row
              Row(
                children: [
                  GestureDetector(
                    onTap: isLinked!
                        ? () {
                            openProfile(context, review.authorId);
                          }
                        : () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: ClipRRect(
                        child: Image.network(
                          review.authorImage,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (_, as, asd) {
                            return Icon(Icons.person,
                                size: 25,
                                color: Theme.of(context).colorScheme.onPrimary);
                          },
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  //// name and rating small column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ////////////////////////////////////////////////////////////////////////////////////////////////
                      ///reviewer name
                      GestureDetector(
                        onTap: isLinked!
                            ? () {
                                openProfile(context, review.authorId);
                              }
                            : () {},
                        child: Text(
                          review.authorName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      Row(
                        children: [
                          Text("Rated: ${review.costRating}/10"),
                          const SizedBox(width: 7),
                          CircleAvatar(
                            backgroundColor:
                                review.isLiked ? Colors.green : Colors.red,
                            radius: 9,
                            child: Icon(
                              ////////////////////////////////////////////////////////////////////////////////////////////////
                              ///If liked ?
                              review.isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_down,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),

                  ///restaurant small column
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /////////////////////////////////////
                        /// ////Name And Location of res
                        /////////////////
                        Text(review.restaurantName),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Theme.of(context).colorScheme.primary,
                                size: 15),
                            Text(review.location,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.grey.shade500)),
                          ],
                        ),
                      ])
                ],
              ),
              const SizedBox(height: 19),
              Flexible(
                fit: FlexFit.loose,
                child: Stack(
                  children: [
                    ExpandablePageView(
                      controller: _pageController,
                      children: [
                        Text(review.reviewText),
                        if (review.reviewItems != null)
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 20, maxHeight: 300),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            100, 230, 174, 7),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(20),
                                      ),
                                    ),
                                    child: ReviewedFoodItemsList(
                                        review.reviewItems!)),
                                const Divider(),
                              ],
                            ),
                          ),
                        ...review.reviewImages.map((image) {
                          return InkWell(
                            onTap: () {
                              _openimageView(context, review.reviewImages,
                                  review.reviewImages.indexOf(image));
                            },
                            child: Container(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image as File,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (tabsCount > 1)
                Center(
                  child: SmoothPageIndicator(
                    onDotClicked: (value) {
                      _pageController.animateToPage(value,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    },
                    controller: _pageController,
                    count: tabsCount,
                    effect: const WormEffect(
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.amber),
                  ),
                ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.green,
                          child: IconButton(
                            padding: const EdgeInsets.all(2),
                            onPressed: () {},
                            iconSize: 20,
                            icon: const Icon(Icons.arrow_drop_up,
                                color: Colors.white),
                          ),
                        ),
                        ///////////////////////////////////////////
                        /// UpVotes
                        const Text('23'),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: IconButton(
                            padding: const EdgeInsets.all(2),
                            onPressed: () {},
                            iconSize: 20,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                          ),
                        ),
                        /////////////////////////////////////////
                        /// DownVotes
                        const Text('23'),
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    '1 hour ago',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey.shade500),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class ExpandablePageView extends StatefulWidget {
  final List<Widget>? children;
  final PageController controller;
  const ExpandablePageView({
    Key? key,
    required this.children,
    required this.controller,
  }) : super(key: key);

  @override
  _ExpandablePageViewState createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  List<double>? _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights![_currentPage];

  @override
  void initState() {
    _heights = widget.children!.map((e) => 0.0).toList();
    super.initState();
    widget.controller
      ..addListener(() {
        final _newPage = widget.controller.page!.round();
        if (_currentPage != _newPage) {
          setState(() => _currentPage = _newPage);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights![0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        controller: widget.controller,
        children: _sizeReportingChildren
            .asMap() //
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children!
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            //needed, so that parent won't impose its constraints on the children, thus skewing the measurement results.
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) => setState(() => {
                    if (_heights![index] < 400)
                      {_heights![index] = size.height}
                    else
                      {_heights![index] = 400}
                  }),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}

class SizeReportingWidget extends StatefulWidget {
  final Widget? child;
  final ValueChanged<Size>? onSizeChange;

  const SizeReportingWidget({
    Key? key,
    @required this.child,
    @required this.onSizeChange,
  }) : super(key: key);

  @override
  _SizeReportingWidgetState createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _notifySize());
    return widget.child!;
  }

  void _notifySize() {
    if (!this.mounted) {
      return;
    }
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange!(size!);
    }
  }
}
