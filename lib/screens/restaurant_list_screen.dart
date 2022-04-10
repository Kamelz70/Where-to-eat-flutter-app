import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/models/restaurant.dart';
import 'package:where_to_eat/widgets/restaurant_item.dart';

import '../providers/restaurant_provider.dart';

class RestaurantListScreen extends StatefulWidget {
  static const routeName = 'restaurant-list';

  RestaurantListScreen();

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  Widget build(BuildContext context) {
    late final Future<void> futureFunctionState;
    List<Restaurant> restaurantList =
        Provider.of<RestaurantProvider>(context).items;

    if (ModalRoute.of(context)!.settings.arguments != null) {
      futureFunctionState =
          ModalRoute.of(context)!.settings.arguments as Future<void>;
    } else {
      futureFunctionState =
          Provider.of<RestaurantProvider>(context).fetchTrendingRestaurants();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: FutureBuilder(
          future: futureFunctionState,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return RestaurantItem(
                    restaurantList[index],
                  );
                },
                itemCount: restaurantList.length,
              );
            }
          }),
      //     ListView.builder(
      //   itemBuilder: (ctx, index) {
      //     return RestaurantItem();
      //   },
      //   itemCount: 1,
      // )
      //
    );
  }
}
