import 'package:flutter/material.dart';
import 'package:where_to_eat/models/restaurant.dart';
import 'package:where_to_eat/widgets/restaurant_item.dart';

class RestaurantListScreen extends StatefulWidget {
  static const routeName = 'restaurant-list';

  final List<Restaurant> availableRestaurants;

  RestaurantListScreen(this.availableRestaurants);

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  String categoryTitle = '';

  List<Restaurant> displayedMeals = [];

  var _loadedData = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_loadedData) {
      final routeArgs =
          (ModalRoute.of(context)!.settings.arguments) as Map<String, String>;

      categoryTitle = (routeArgs['title'] as String);
      final String categoryId = routeArgs['id'] as String;
      displayedMeals = widget.availableRestaurants.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    _loadedData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return RestaurantItem(
            displayedMeals[index],
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
