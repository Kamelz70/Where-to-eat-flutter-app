import 'package:flutter/material.dart';
import 'package:where_to_eat/models/review.dart';
import 'package:where_to_eat/widgets/reviewed_food_item.dart';

import '../models/review_item.dart';

class ReviewedFoodItemsList extends StatelessWidget {
  final List<ReviewItem> reviewedFoodItemsList;
  ReviewedFoodItemsList(this.reviewedFoodItemsList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return ReviewedFoodItem(
                title: reviewedFoodItemsList[index].title,
                price: reviewedFoodItemsList[index].price,
                rating: reviewedFoodItemsList[index].rating,
                foodType: reviewedFoodItemsList[index].foodType,
                description: reviewedFoodItemsList[index].description,
              );
            },
            itemCount: reviewedFoodItemsList.length)
        // Column is also a layout widget. It takes a list of children and

        ;
  }
}
