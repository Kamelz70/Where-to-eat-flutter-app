import 'package:flutter/material.dart';
import 'package:where_to_eat/screens/restaurant_list_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final IconData icon;
  final String imageUrl;

  const CategoryItem(this.id, this.title, this.icon, this.imageUrl);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      RestaurantListScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Image.network(imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover),
          ),
          Container(
            margin: const EdgeInsets.only(top: 70),
            child: Center(
              //conatiner for when text overflows
              child: Container(
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(15),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => selectCategory(context),
            borderRadius: BorderRadius.circular(15),
            splashColor: Theme.of(context).primaryColor,
            child: const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.8),
          spreadRadius: 4,
          blurRadius: 15,
          offset: const Offset(0, 7), // changes position of shadow
        ),
      ]),
    );
  }
}
