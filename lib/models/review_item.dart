import 'package:flutter/foundation.dart';

enum FoodType { FOOD, BEVERAGE }

class ReviewItem {
  final String id;
  final double title;
  final FoodType type;
  final double price;
  final double rating;
  final String description;

  const ReviewItem(
      {required this.id,
      required this.title,
      required this.type,
      required this.price,
      required this.rating,
      required this.description});
}
