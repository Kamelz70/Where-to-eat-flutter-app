import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:where_to_eat/models/review.dart';

import '../models/review_item.dart';
import 'reviewed_food_item.dart';
import 'reviewed_food_items_list.dart';

class ReviewPost extends StatelessWidget {
  Review review;
  ReviewPost(this.review);
  PageController _pageController = new PageController();

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
                  CircleAvatar(
                    radius: 19.0,
                    child: ClipRRect(
                      child: Image.network(
                        'https://scontent.fcai1-2.fna.fbcdn.net/v/t1.6435-9/68406470_2329293560457857_238321876919648256_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=174925&_nc_eui2=AeEMJynCO3wr772RkgWuBMF5k6fTKdUXlnCTp9Mp1ReWcO9EoxUbQhdTIs-kvnDs8cl9Nsc4DpfRcEh6rNVrdo9a&_nc_ohc=Ax5-x71qRGkAX-ZFy68&_nc_oc=AQk68tQD5_W47ZfoklJwxVteYayUXApQJu7ggMwwyzkAG8jZWn0wA8RSp2yDLE6T8MI&_nc_ht=scontent.fcai1-2.fna&oh=00_AT8TFgic4bd0h4KqxxqiGeGj_HTbfNmxjChxJJMdlQszqg&oe=622A85B2',
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  SizedBox(width: 10),
                  //// name and rating small column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ////////////////////////////////////////////////////////////////////////////////////////////////
                      ///reviewer name
                      Text("Mohamed Kamel"),
                      Row(
                        children: [
                          Text("Rated: ${review.costRating}/10"),
                          SizedBox(width: 7),
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 9,
                            child: Icon(
                              ////////////////////////////////////////////////////////////////////////////////////////////////
                              ///If liked ?
                              Icons.thumb_up,
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
                        Text('7amada erstaurant'),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Theme.of(context).colorScheme.primary,
                                size: 15),
                            Text('7amada erstaut'),
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
                        ReviewedFoodItemsList([
                          ReviewedFoodItem(
                              title: 'Stero Trio',
                              price: 20,
                              rating: 5,
                              foodType: FoodType.FOOD,
                              description: 'a good plate'),
                          ReviewedFoodItem(
                              title: 'Stero Trio',
                              price: 20,
                              rating: 5,
                              foodType: FoodType.FOOD,
                              description: 'a good plate'),
                          ReviewedFoodItem(
                              title: 'Stero Trio',
                              price: 20,
                              rating: 5,
                              foodType: FoodType.FOOD,
                              description: 'a good plate'),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
                children: [
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.arrow_drop_up, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.green, // <-- Button color
                      ),
                    ),
                  ),
                  Text('23'),
                  SizedBox(
                    height: 25,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.arrow_drop_down, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.red, // <-- Button color
                      ),
                    ),
                  ),
                  Text('23'),
                  IconButton(
                    icon: Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  Spacer(),
                  Text(
                    '1 hour ago',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class CarouselVariableHight extends StatefulWidget {
  final List<Widget> caruselItems;
  final PageController controller;
  CarouselVariableHight({required this.caruselItems, required this.controller});
  @override
  CarouselVariableHightState createState() => CarouselVariableHightState();
}

class CarouselVariableHightState extends State<CarouselVariableHight> {
  double? height;
  GlobalKey stackKey = GlobalKey();
  bool? widgetHasHeigh;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    final RenderBox renderBox =
        stackKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    setState(() {
      if (size.height == null || size.height < 70) {
        height = 70;
      } else {
        height = size.height;
      }
    });
  }

  _buildStack() {
    Widget firstElement;
    if (height == null) {
      firstElement = Container();
    } else {
      firstElement = Container(
        height: height,
        child: PageView(
          controller: widget.controller,
          children: widget.caruselItems,
        ),
      );
    }

    return IndexedStack(
      key: stackKey,
      children: <Widget>[
        firstElement,
        ...widget.caruselItems,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildStack();
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
              onSizeChange: (size) =>
                  setState(() => _heights![index] = size.height),
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
