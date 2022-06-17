import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import '../../screens/add_restaurant_screen.dart';
import '../../screens/restaurant_page_screen.dart';

class RestaurantSearchList extends StatelessWidget {
  final List<Restaurant> ResultList;

  const RestaurantSearchList(
    this.ResultList,
  );

  @override
  Widget build(BuildContext context) {
    if (ResultList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
      child: ListView(
        shrinkWrap: true,
        children: [
          TextButton(
            child: const Text("Can't find your restaurant?"),
            onPressed: () {
              Navigator.of(context).pushNamed(AddRestaurantScreen.routeName);
            },
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return RestaurantSearchItem(ResultList[index]);
              },
              itemCount: ResultList.length),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
///
///
///
///   Sub Widgets
///
///
///
///////////////////////////////////////////////////////////////////////////
class RestaurantSearchItem extends StatelessWidget {
  ///////////////////////////////////////////////////////////////////
  ///
  ///           Vars and consts
  final Restaurant currentItem;
  static const foodImagePath = 'assets/images/item-review-images/food.png';

  const RestaurantSearchItem(this.currentItem);
  ///////////////////////////////////////////////////////////////////
  ///
  ///           Functions

  //select meal tap function handler
  void _selectRestaurant(BuildContext context, Restaurant restaurant) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantPageScreen(restaurant: restaurant),
      ),
    );
  }
///////////////////////////////////////////////////////////////////
  ///
  ///           Build

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7,
      child: InkWell(
        onTap: () => _selectRestaurant(context, currentItem),
        child: ListTile(
          leading: ClipRRect(
            // ignore: prefer_const_constructors
            borderRadius: BorderRadius.all(
              const Radius.circular(15),
            ),
            child: SizedBox(
              height: 90,
              width: 70,
              child: Image.network(currentItem.imageUrl, fit: BoxFit.fitHeight,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }, errorBuilder: (_, sad, asd) {
                return Image.asset(foodImagePath, width: 70);
              }),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    /////////////////title
                    currentItem.title,
                    style: Theme.of(context).textTheme.headline4,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.star_rounded,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 3),

                  /////////////////rating
                  Text(((currentItem.quantityRating +
                              currentItem.tasteRating +
                              currentItem.serviceRating +
                              currentItem.costRating) /
                          4)
                      .toString()),
                  const SizedBox(width: 10),
                  Icon(Icons.attach_money,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Location Data'),
                  Ink(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
