import 'package:flutter/foundation.dart';

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

  const Review({
    required this.id,
    required this.serviceRating,
    required this.tasteRating,
    required this.costRating,
    required this.quantityRating,
    required this.reviewText,
    required this.upVotes,
    required this.downVotes,
    required this.restaurantId,
    required this.location,
  });
}
