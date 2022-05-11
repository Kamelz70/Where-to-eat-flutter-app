import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/review_item.dart';
import '../providers/new_review_provider.dart';

class ReviewedFoodItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final double rating;
  final FoodType foodType;
  final String description;
  final bool deletible;

  const ReviewedFoodItem(
      {required this.title,
      required this.id,
      required this.price,
      required this.rating,
      required this.foodType,
      required this.description,
      this.deletible = false});

  static const itemReviewImagesPath = 'assets/images/item-review-images/';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.headline4),
                      if (deletible)
                        IconButton(
                          onPressed: () {
                            Provider.of<NewReviewProvider>(context,
                                    listen: false)
                                .deleteItemById(id);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        price.toStringAsFixed(0) + ' EGP',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      )),
                      RatingBarIndicator(
                        rating: rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 17,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
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
