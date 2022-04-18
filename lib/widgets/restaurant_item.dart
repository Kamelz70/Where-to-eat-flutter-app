import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:where_to_eat/screens/restaurant_page_screen.dart';
import '../models/restaurant.dart';

class RestaurantItem extends StatelessWidget {
///////////////////////////////////////////////////////////////////
  ///
  ///           Vars and consts
  final Restaurant currentRestaurant;
  RestaurantItem(this.currentRestaurant);

  static const foodImagePath = 'assets/images/item-review-images/food.png';

  ///////////////////////////////////////////////////////////////////
  ///
  ///           Functions

  //select meal tap function handler
  void _selectRestaurant(BuildContext context) {
    Navigator.of(context).pushNamed(
      RestaurantPageScreen.routeName,
      arguments: currentRestaurant.id,
    );
  }
///////////////////////////////////////////////////////////////////
  ///
  ///           Build

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectRestaurant(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 7,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  /////////////////title
                  currentRestaurant.title,
                  style: Theme.of(context).textTheme.headline4,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.star_rounded,
                      color: Theme.of(context).colorScheme.primary),

                  /////////////////rating
                  Text(((currentRestaurant.quantityRating +
                              currentRestaurant.tasteRating +
                              currentRestaurant.serviceRating +
                              currentRestaurant.costRating) /
                          4)
                      .toString()),
                  SizedBox(width: 10),
                  Icon(Icons.attach_money,
                      color: Theme.of(context).colorScheme.primary),

                  /////////////////rating
                  Text("70-80"),
                  // Row(children: [
                  //   Icon(Icons.schedule),
                  //   SizedBox(
                  //     width: 6,
                  //   ),
                  //   Text("${currentRestaurant.costRating}/5")
                  // ]),
                  // Row(
                  //   children: [
                  //     Icon(Icons.room_service),
                  //     SizedBox(
                  //       width: 6,
                  //     ),
                  //     Text("${currentRestaurant.serviceRating}/5")
                  //   ],
                  // ),
                  // Row(children: [
                  //   Icon(Icons.room_outlined),
                  //   SizedBox(
                  //     width: 6,
                  //   ),
                  //   Text("${currentRestaurant.quantityRating}/5")
                  // ]),
                  // Row(children: [
                  //   Icon(Icons.food_bank),
                  //   SizedBox(
                  //     width: 6,
                  //   ),
                  //   Text("${currentRestaurant.tasteRating}/5")
                  // ])
                ],
              ),
              Text('Location Data'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.network(
                        currentRestaurant.imageUrl,
                        fit: BoxFit.cover,
                        height: 200,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(1),
                        icon: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        color: Colors.white,
                        onPressed: () => _selectRestaurant(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
