import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/widgets/reviews_list.dart';

import '../models/restaurant.dart';
import '../models/review.dart';
import '../providers/restaurant_provider.dart';
import '../providers/review_provider.dart';
import 'new_review_screen.dart';

class RestaurantPageScreen extends StatelessWidget {
  static const routeName = '/restaurant-page';
  static const foodImagePath = 'assets/images/item-review-images/food.png';

  //for titles like steps, ingredients
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
        title: Text(restaurant.title),
        actions: [
          //icon Button on top appBar
          IconButton(
            icon: const Icon(Icons.star_outline),
            onPressed: () => {},
          )
        ],
      ),
      floatingActionButton: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => _startAddPost(context),
          color: Theme.of(context).colorScheme.primary,
          iconSize: 45.0),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.maxFinite,
              child: Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, sad, asd) {
                  return Image.asset(foodImagePath, height: 150);
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  controller: scrollController,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                const SizedBox(height: 10),
                                buildSectionTitle(
                                    context, restaurant.title),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text("Location") //MISSING ACTUAL LOCATION
                                  ],
                                ),
                              ]),
                          const Spacer(),
                          Column(
                            children: [
                              const SizedBox(height: 50),
                              IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
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
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text("Price"),
                                ],
                              ),
                              Column(
                                children: [
                                  RatingTag(
                                    rating: restaurant.tasteRating.toString(),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text("Taste"),
                                ],
                              ),
                              Column(
                                children: [
                                  RatingTag(
                                    rating:
                                        restaurant.quantityRating.toString(),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text("Quantity"),
                                ],
                              ),
                              Column(
                                children: [
                                  RatingTag(
                                    rating: restaurant.serviceRating.toString(),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text("Service"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
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
                                icon: const Icon(
                                  Icons.equalizer,
                                  color: Colors.amber,
                                  size: 30,
                                )),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {}, //ADD FUNC
                              child: const Text(
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
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        "$rating/5",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
