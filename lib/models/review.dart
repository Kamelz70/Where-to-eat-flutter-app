import 'package:flutter/foundation.dart';
import 'package:where_to_eat/models/review_item.dart';

class Review {
  final String id;
  final double serviceRating;
  final double tasteRating;
  final double costRating;
  final double quantityRating;
  final String authorId;
  final String authorName;
  final String authorImage;
  final String restaurantId;
  final String restaurantName;
  final String branchtId;
  final String location;
  final String reviewText;
  final bool isLiked;
  final List<ReviewItem>? reviewItems;
  int downVotes;
  int upVotes;

  Review({
    required this.id,
    required this.serviceRating,
    required this.tasteRating,
    required this.costRating,
    required this.quantityRating,
    required this.authorId,
    required this.authorName,
    required this.authorImage,
    required this.restaurantId,
    required this.branchtId,
    required this.restaurantName,
    required this.location,
    required this.reviewText,
    required this.isLiked,
    this.reviewItems,
    this.upVotes = 0,
    this.downVotes = 0,
  });
}
