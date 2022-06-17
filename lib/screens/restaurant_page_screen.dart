import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/widgets/reviews_list.dart';

import '../models/branch.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../providers/restaurant_provider.dart';
import '../providers/review_provider.dart';
import 'new_review_screen.dart';

class RestaurantPageScreen extends StatefulWidget {
  /////////////////////////////////////////////////////////
  ///
  ///       Constants
  ///
///////////////////////////////////////////////////////
  static const routeName = '/restaurant-page';
  static const foodImagePath = 'assets/images/item-review-images/food.png';

  final String? restaurantId;
  final Restaurant? restaurant;

  const RestaurantPageScreen(
      // ignore: avoid_init_to_null
      {this.restaurantId,
      this.restaurant,
      Key? key})
      : super(key: key);

  @override
  State<RestaurantPageScreen> createState() => _RestaurantPageScreenState();
}

class _RestaurantPageScreenState extends State<RestaurantPageScreen> {
/////////////////////////////////////////////////////////
  ///
  ///       Vars
  ///
///////////////////////////////////////////////////////
  List<Branch> _branchesList = [];
  Branch? _selectedBranch = null;
/////////////////////////////////////////////////////////
  ///
  ///       Functions
  ///
///////////////////////////////////////////////////////

  Future<void> _fetchBranches(BuildContext context, String restaurantId) async {
    print('ggggggggggggggggggggg');
    _branchesList =
        await Provider.of<RestaurantProvider>(context, listen: false)
            .fetchBranches(restaurantId);
  }

  void _startAddPost(BuildContext context) {
    Navigator.of(context).pushNamed(NewReviewScreen.routeName);
  }

///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////   Build
  @override
  Widget build(BuildContext context) {
    // List<DropdownMenuItem<int>>? items = [];/////////////////////////////////////////////////////////////////////////////////////////
    bool isRestaurantFavorite = false;

    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    final restaurantsProvider =
        Provider.of<RestaurantProvider>(context, listen: false);

    Restaurant? viewedRestaurant;
    return FutureBuilder<Restaurant?>(
      future: widget.restaurant == null
          ? restaurantsProvider.fetchRestaurantById(widget.restaurantId!)
          : null,
      builder: (_, restaurantSnapshot) {
        if (restaurantSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(child: LinearProgressIndicator(), key: ValueKey(0)));
        } else {
          widget.restaurant == null
              ? viewedRestaurant = restaurantSnapshot.data
              : viewedRestaurant = widget.restaurant;
          //////////////////////////////////////////////////
          ///
          ///     Build futureBuilders before scaffold
          ///     beacause if they're built in scaffold, any setState will
          ///     rebuild the futureBuilders
          ///
          ////////////////////////////////////////////////////
          final Widget _branchSelector =
              _buildBranchSelector(viewedRestaurant!.id);
          final Widget _reviewPosts = _selectedBranch == null
              ? _buildReviewPosts(reviewProvider, viewedRestaurant!.id)
              : _buildReviewPosts(reviewProvider, _selectedBranch!.id,
                  isBranch: true);

          ///////////////////////////////////////////
          /////
          ///   Building the scaffold
          ///
          /////////////////////////////////////////////
          return Scaffold(
            appBar: AppBar(
              title: Text(viewedRestaurant!.title),
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
                      viewedRestaurant!.imageUrl,
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
                        return Image.asset(RestaurantPageScreen.foodImagePath,
                            height: 150);
                      },
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.75,
                  minChildSize: 0.75,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      const SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          viewedRestaurant!.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.amber,
                                            size: 20,
                                          ),
                                          Text("Branch",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                          SizedBox(width: 20),
                                          _branchSelector,
                                          //MISSING ACTUAL LOCATION
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ]),
                                const Spacer(),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Rating",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          _selectedBranch == null
                              ? _buildRatingSection(
                                  costRating:
                                      viewedRestaurant!.costRating.toString(),
                                  tasteRating:
                                      viewedRestaurant!.tasteRating.toString(),
                                  quantityRating: viewedRestaurant!
                                      .quantityRating
                                      .toString(),
                                  serviceRating: viewedRestaurant!.serviceRating
                                      .toString(),
                                )
                              : _buildRatingSection(
                                  costRating:
                                      _selectedBranch!.costRating.toString(),
                                  tasteRating:
                                      _selectedBranch!.tasteRating.toString(),
                                  quantityRating: _selectedBranch!
                                      .quantityRating
                                      .toString(),
                                  serviceRating:
                                      _selectedBranch!.serviceRating.toString(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                          _reviewPosts
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

//////////////////////////////////////////////////////////////////////
  ///
  ///   sub-widgets
  ///
/////////////////////////////////////////////////////
  Widget _buildBranchSelector(String restaurantId) {
    return FutureBuilder(
      future: _fetchBranches(context, restaurantId),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return DropdownButton(
            hint: Text('Select a branch to view'),
            icon: Icon(Icons.keyboard_arrow_down),
            value: _selectedBranch == null ? null : _selectedBranch!.id,
            items: [
              ..._branchesList.map((Branch branch) {
                return DropdownMenuItem(
                  value: branch.id,
                  child: Text(branch.location.address),
                );
              }).toList()
            ],
            onChanged: (newValue) {
              setState(() {
                _selectedBranch =
                    _branchesList.firstWhere((branch) => branch.id == newValue);
              });
            },
          );
        }
      },
    );
  }

  Widget _buildReviewPosts(ReviewProvider reviewProvider, String id,
      {bool isBranch = false}) {
    return FutureProvider<List<Review>?>(
      initialData: null,
      create: (_) {
        // print('calling future');
        if (isBranch) {
          return reviewProvider.fetchBranchReviews(id);
        } else {
          return reviewProvider.fetchRestaurantReviews(id);
        }
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

  Widget _buildRatingTag(String rating) {
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

  Widget _buildRatingSection(
      {required String costRating,
      required String tasteRating,
      required String quantityRating,
      required String serviceRating}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _buildRatingTag(
                costRating,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text("Price"),
            ],
          ),
          Column(
            children: [
              _buildRatingTag(
                tasteRating,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text("Taste"),
            ],
          ),
          Column(
            children: [
              _buildRatingTag(
                quantityRating,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text("Quantity"),
            ],
          ),
          Column(
            children: [
              _buildRatingTag(
                serviceRating,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text("Service"),
            ],
          ),
        ],
      ),
    );
  }
}
