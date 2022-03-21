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
  List<ReviewItem> _reviewItemsList = [];
  List<ReviewItem> get reviewItemsList {
    //copy spread items (brackets means copy)
    return [..._reviewItemsList];
  }

  void addReviewItem(ReviewItem review) {
    _reviewItemsList.add(ReviewItem);
  }
}
