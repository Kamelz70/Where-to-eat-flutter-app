import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/data/dummy_data.dart';
import 'package:where_to_eat/widgets/new_review_screen/new_review.dart';
import 'package:where_to_eat/widgets/reviews_list.dart';

import '../models/restaurant.dart';
import '../models/review.dart';
import '../providers/restaurant_provider.dart';
import '../providers/review_provider.dart';
import '../widgets/new_review_screen/new_review.dart';
import 'new_review_screen.dart';

class RestaurantPageScreen extends StatelessWidget {
  static const routeName = '/restaurant-page';

  //for titles like steps, ingredients
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  void _startAddPost(BuildContext context) {
    Navigator.of(context).pushNamed(NewReviewScreen.routeName);
  }

///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////   Build
  @override
  Widget build(BuildContext context) {
    bool isRestaurantFavorite = false;
    final routeArgs = ModalRoute.of(context)!.settings.arguments;
    final restaurantId = routeArgs as String;
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    final restaurantsProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    final restaurant = restaurantsProvider.findById(restaurantId) as Restaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text('${restaurant.title}'),
        actions: [
          //icon Button on top appBar
          IconButton(
            icon: Icon(Icons.star_outline),
            onPressed: () => {},
          )
        ],
      ),
      floatingActionButton: IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () => _startAddPost(context),
          color: Theme.of(context).colorScheme.primary,
          iconSize: 45.0),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              child: Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned(
          //   left: 30,
          //   top: 30,
          //   child: Container(
          //     height: 50,
          //     width: 50,
          //     //        IconButton(
          //     //  icon: Icon(Icons.arrow_back),
          //     //  onPressed: (){
          //     //    Navigator.pop(context);
          //     //  },
          //     //)
          //     child: FloatingActionButton(
          //       backgroundColor: Colors.grey.withOpacity(0.6),
          //       heroTag: 'back',
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       child: const Icon(
          //         Icons.arrow_back,
          //         color: Colors.white,
          //         size: 40,
          //       ),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //   ),
          // ), //MISSING TAGS
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
                child: ListView(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  controller: scrollController,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 10)),
                                SizedBox(height: 10),
                                buildSectionTitle(
                                    context, '${restaurant.title}'),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text("Location") //MISSING ACTUAL LOCATION
                                  ],
                                ),
                              ]),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(height: 50),
                              IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  onPressed: () => _startAddPost(context),
                                  color: Colors.amber,
                                  iconSize: 35.0),
                            ],
                          ),
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Rating",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  RatingTag(
                                    rating: restaurant.costRating.toString(),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("Price"),
                                ],
                              ),
                              Column(
                                children: [
                                  RatingTag(
                                    rating: restaurant.tasteRating.toString(),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("Taste"),
                                ],
                              ),
                              Column(
                                children: [
                                  RatingTag(
                                    rating:
                                        restaurant.quantityRating.toString(),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("Quantity"),
                                ],
                              ),
                              Column(
                                children: [
                                  RatingTag(
                                    rating: restaurant.serviceRating.toString(),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("Service"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 15),
                    //   child: Text(
                    //     "Details",
                    //     style: Theme.of(context).textTheme.headline4,
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Price Range",
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //       ),
                    //     ),
                    //     Text(
                    //       "data", //MISSING
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         color: Colors.amber,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 6,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Cuisines",
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //       ),
                    //     ),
                    //     Text(
                    //       "data", //MISSING
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         color: Colors.amber,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 6,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 11),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "Contact",
                    //         style: TextStyle(
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //       Text(
                    //         "data", //MISSING
                    //         style: TextStyle(
                    //           fontSize: 18,
                    //           color: Colors.amber,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Reviews",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {}, //ADD FUNC
                                icon: Icon(
                                  Icons.equalizer,
                                  color: Colors.amber,
                                  size: 30,
                                )),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {}, //ADD FUNC
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    ReviewPosts(
                        reviewProvider: reviewProvider, restaurant: restaurant),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ReviewPosts extends StatefulWidget {
  const ReviewPosts({
    Key? key,
    required this.reviewProvider,
    required this.restaurant,
  }) : super(key: key);

  final ReviewProvider reviewProvider;
  final Restaurant restaurant;

  @override
  State<ReviewPosts> createState() => _ReviewPostsState();
}

class _ReviewPostsState extends State<ReviewPosts> {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Review>?>(
      initialData: null,
      create: (_) {
        // print('calling future');
        return widget.reviewProvider
            .fetchRestaurantReviews(widget.restaurant.id);
      },
      child: Consumer<List<Review>?>(builder: (_, value, __) {
        if (value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ReviewsList(value);
        }
      }),
    );
  }
}

class RatingTag extends StatelessWidget {
  final String rating;
  const RatingTag({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        "${rating}/5",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
