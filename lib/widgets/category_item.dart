import 'package:flutter/material.dart';
import 'package:where_to_eat/screens/restaurant_list_screen.dart';

////////////////////////////////////////////////////////////////////////////////////////////////
///   Screens
import '../screens/restaurant_page_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final IconData icon;

  CategoryItem(this.id, this.title, this.icon);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      RestaurantListScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)
          ],
          gradient: LinearGradient(colors: [
            Colors.grey.shade100,
            Colors.grey.shade200,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
            Icon(icon, size: 40, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
