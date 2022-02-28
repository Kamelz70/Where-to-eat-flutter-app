import 'package:flutter/material.dart';
import 'package:where_to_eat/models/review.dart';
import 'package:where_to_eat/widgets/post.dart';

class ReviewsList extends StatelessWidget {
  List<Review> reviewsList = [];
  ReviewsList(this.reviewsList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemBuilder: (context, index) {
              return Post(reviewsList[index]);
            },
            itemCount: reviewsList.length)
        // Column is also a layout widget. It takes a list of children and

        ;
  }
}
