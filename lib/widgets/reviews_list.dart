import 'package:flutter/material.dart';
import 'package:where_to_eat/models/review.dart';
import 'package:where_to_eat/widgets/review_post.dart';

class ReviewsList extends StatelessWidget {
  List<Review> reviewsList = [];
  bool? isLinked;
  ReviewsList(this.reviewsList, {this.isLinked = true});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return ReviewPost(reviewsList[index], isLinked: isLinked);
            },
            itemCount: reviewsList.length)
        // Column is also a layout widget. It takes a list of children and

        ;
  }
}
