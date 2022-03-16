import 'package:flutter/material.dart';
import 'package:where_to_eat/data/dummy_data.dart';
import '../widgets/restaurant_item.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);
  static const routeName = '/wishlist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WishList'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return RestaurantItem(
            DUMMY_RestaurantS[index],
          );
        },
        itemCount: DUMMY_RestaurantS.length,
      ),
    );
  }
}
