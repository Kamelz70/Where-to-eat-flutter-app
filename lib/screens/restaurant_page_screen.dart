import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:where_to_eat/data/dummy_data.dart';
import 'package:where_to_eat/widgets/new_review_screen/new_review.dart';
import 'package:where_to_eat/widgets/reviews_list.dart';

import '../widgets/new_review_screen/new_review.dart';

class RestaurantPageScreen extends StatelessWidget {
  static const routeName = '/restaurant-page';

  //for titles like steps, ingredients
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  //for lists like steps, ingredients
  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  void _startAddPost(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(),
          child: GestureDetector(
            onTap: null,
            child: NewReview(),
            behavior: HitTestBehavior.opaque,
          ),
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////   Build
  @override
  Widget build(BuildContext context) {
    bool isRestaurantFavorite = false;
    final routeArgs = ModalRoute.of(context)!.settings.arguments;
    final mealId = routeArgs as String;

    final selectedMeal =
        DUMMY_RestaurantS.firstWhere((element) => element.id == mealId);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
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
                    Text("${selectedMeal.costRating}/5")
                  ]),
                  Row(
                    children: [
                      Icon(Icons.room_service),
                      SizedBox(
                        width: 6,
                      ),
                      Text("${selectedMeal.serviceRating}/5")
                    ],
                  ),
                  Row(children: [
                    Icon(Icons.room_outlined),
                    SizedBox(
                      width: 6,
                    ),
                    Text("${selectedMeal.quantityRating}/5")
                  ]),
                  Row(children: [
                    Icon(Icons.food_bank),
                    SizedBox(
                      width: 6,
                    ),
                    Text("${selectedMeal.tasteRating}/5")
                  ])
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Overall rating:"),
                SizedBox(width: 10),
                RatingBar.builder(
                  itemSize: 17,
                  initialRating: (selectedMeal.quantityRating +
                          selectedMeal.tasteRating +
                          selectedMeal.serviceRating +
                          selectedMeal.costRating) /
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
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            buildSectionTitle(context, "Reviews"),
            Container(
                height: MediaQuery.of(context).size.height * 0.54,
                child: ReviewsList(DUMMY_Reviews))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
        actions: [
          //icon Button on top appBar
          IconButton(
            icon: Icon(Icons.star_outline),
            onPressed: () => {},
          )
        ],
      ),
      floatingActionButton: IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () => _startAddPost(context),
          color: Theme.of(context).accentColor,
          iconSize: 45.0),
    );
  }
}
