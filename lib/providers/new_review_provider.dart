import 'package:flutter/material.dart';

import '../models/review_item.dart';

class NewReviewProvider with ChangeNotifier {
  Map<String, dynamic> postFormData = {
    'restaurantName': '',
    'restaurantid': '',
    'isLiked': true,
    'location': '',
    'branchId': '',
    'reviewText': '',
    'authorId': '',
    'authorName': '',
    'serviceRating': '',
    'tasteRating': '',
    'costRating': '',
    'quantityRating': '',
  };
  Map<String, dynamic> currentReviewItem = {
    'id': '',
    'title': '',
    'price': 0.0 as double,
    'foodType': FoodType.FOOD,
    'rating': 3.0 as double,
    'description': '',
  };
  List<ReviewItem> _reviewItemsList = [];
  List<ReviewItem> get reviewItemsList {
    //copy spread items (brackets means copy)
    return [..._reviewItemsList];
  }

  void addReviewItem(ReviewItem reviewItem) {
    _reviewItemsList.add(reviewItem);
    notifyListeners();
  }
}
