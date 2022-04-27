import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:where_to_eat/models/review.dart';

import '../Screens/profile_screen.dart';
import '../models/review_item.dart';
import 'reviewed_food_item.dart';
import 'reviewed_food_items_list.dart';

class ReviewPost extends StatelessWidget {
  Review review;
  bool? isLinked;
  ReviewPost(this.review, {this.isLinked = true});
  PageController _pageController = new PageController();

  void openProfile(BuildContext context, String profileId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileScreen(userId: profileId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //whole post card
    return Card(
        margin: EdgeInsets.all(15),
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
                  SizedBox(width: 10),
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
                          SizedBox(width: 7),
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
                  Spacer(),

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
              SizedBox(height: 19),
              Flexible(
                fit: FlexFit.loose,
                child: Stack(
                  children: [
                    // CarouselVariableHight(caruselItems: [
                    //   Text(review.reviewText),
                    //   ReviewedFoodItemsList([
                    //     ReviewedFoodItem(
                    //         title: 'Stero Trio',
                    //         price: 20,
                    //         rating: 5,
                    //         foodType: FoodType.FOOD,
                    //         description: 'a good plate'),
                    //     ReviewedFoodItem(
                    //         title: 'Stero Trio',
                    //         price: 20,
                    //         rating: 5,
                    //         foodType: FoodType.FOOD,
                    //         description: 'a good plate'),
                    //     ReviewedFoodItem(
                    //         title: 'Stero Trio',
                    //         price: 20,
                    //         rating: 5,
                    //         foodType: FoodType.FOOD,
                    //         description: 'a good plate'),
                    //   ]),
                    // ], controller: _pageController),
                    ExpandablePageView(
                      controller: _pageController,
                      children: [
                        Text(review.reviewText),
                        if (review.reviewItems != null)
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: 20, maxHeight: 300),
                            child: ListView(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromARGB(100, 230, 174, 7),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: ReviewedFoodItemsList(
                                        review.reviewItems!)),
                                Divider(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              if (review.reviewItems != null)
                Center(
                  child: SmoothPageIndicator(
                    onDotClicked: (value) {
                      _pageController.animateToPage(value,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    },
                    controller: _pageController,
                    count: 2,
                    effect: WormEffect(
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.amber),
                  ),
                ),
              SizedBox(height: 10),

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
                            padding: EdgeInsets.all(2),
                            onPressed: () {},
                            iconSize: 20,
                            icon:
                                Icon(Icons.arrow_drop_up, color: Colors.white),
                          ),
                        ),
                        ///////////////////////////////////////////
                        /// UpVotes
                        Text('23'),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: IconButton(
                            padding: EdgeInsets.all(2),
                            onPressed: () {},
                            iconSize: 20,
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                          ),
                        ),
                        /////////////////////////////////////////
                        /// DownVotes
                        Text('23'),
                        IconButton(
                          icon: Icon(Icons.comment_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2),
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

// class CarouselVariableHight extends StatefulWidget {
//   final List<Widget> caruselItems;
//   final PageController controller;
//   CarouselVariableHight({required this.caruselItems, required this.controller});
//   @override
//   CarouselVariableHightState createState() => CarouselVariableHightState();
// }

// class CarouselVariableHightState extends State<CarouselVariableHight> {
//   double? height;
//   GlobalKey stackKey = GlobalKey();
//   bool? widgetHasHeigh;

//   @override
//   void initState() {
//     WidgetsBinding.instance?.addPostFrameCallback(_afterLayout);
//     super.initState();
//   }

//   _afterLayout(_) {
//     final RenderBox renderBox =
//         stackKey.currentContext!.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//     setState(() {
//       if (size.height == null || size.height < 70) {
//         height = 70;
//       } else {
//         height = size.height;
//       }
//     });
//   }

//   _buildStack() {
//     Widget firstElement;
//     if (height == null) {
//       firstElement = Container();
//     } else {
//       firstElement = Container(
//         height: height,
//         child: PageView(
//           controller: widget.controller,
//           children: widget.caruselItems,
//         ),
//       );
//     }

//     return IndexedStack(
//       key: stackKey,
//       children: <Widget>[
//         firstElement,
//         ...widget.caruselItems,
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildStack();
//   }
// }

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
