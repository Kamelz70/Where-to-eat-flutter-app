import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/review_item.dart';

class ReviewedFoodItem extends StatelessWidget {
  final String title;
  final double price;
  final double rating;
  final FoodType foodType;
  final String description;

  const ReviewedFoodItem({
    required this.title,
    required this.price,
    required this.rating,
    required this.foodType,
    required this.description,
  });

  static const itemReviewImagesPath = 'assets/images/item-review-images/';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 7,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              height: 60,
              child: Image.asset(
                /////////////////food type here
                itemReviewImagesPath + 'food.png',
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /////////////////name here
                  Text(title, style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price.toStringAsFixed(0) + ' EGP'),
                      RatingBarIndicator(
                        rating: rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 17,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(description,
                      style: Theme.of(context).textTheme.bodyText2)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
