import 'package:flutter/foundation.dart';
import 'package:where_to_eat/models/review_item.dart';

class Review {
  final String id;
  final double serviceRating;
  final double tasteRating;
  final double costRating;
  final double quantityRating;
  final String reviewText;
  final int upVotes;
  final int downVotes;
  final String restaurantId;
  final String location;
  final List<ReviewItem>? reviewItems;

  const Review(
      {required this.id,
      required this.serviceRating,
      required this.tasteRating,
      required this.costRating,
      required this.quantityRating,
      required this.reviewText,
      required this.upVotes,
      required this.downVotes,
      required this.restaurantId,
      required this.location,
      this.reviewItems});
}
