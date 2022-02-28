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
  ///////////////////////////////////////////////////////////////////
  ///
  ///           Functions

  //select meal tap function handler
  void selectRestaurant(BuildContext context) {
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
      onTap: () => selectRestaurant(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(currentRestaurant.imageUrl,
                      height: 250, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 20,
                  right: 15,
                  //conatiner for when text overflows
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      currentRestaurant.title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(children: [
                    Icon(Icons.schedule),
                    SizedBox(
                      width: 6,
                    ),
                    Text("${currentRestaurant.costRating}/5")
                  ]),
                  Row(
                    children: [
                      Icon(Icons.room_service),
                      SizedBox(
                        width: 6,
                      ),
                      Text("${currentRestaurant.serviceRating}/5")
                    ],
                  ),
                  Row(children: [
                    Icon(Icons.room_outlined),
                    SizedBox(
                      width: 6,
                    ),
                    Text("${currentRestaurant.quantityRating}/5")
                  ]),
                  Row(children: [
                    Icon(Icons.food_bank),
                    SizedBox(
                      width: 6,
                    ),
                    Text("${currentRestaurant.tasteRating}/5")
                  ])
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Overall rating:"),
                RatingBar.builder(
                  itemSize: 17,
                  initialRating: (currentRestaurant.quantityRating +
                          currentRestaurant.tasteRating +
                          currentRestaurant.serviceRating +
                          currentRestaurant.costRating) /
                      4,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
