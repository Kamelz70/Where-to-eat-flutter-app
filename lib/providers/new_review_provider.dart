import 'dart:io';

import 'package:flutter/material.dart';

import '../models/review.dart';
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
    'price': 0.0,
    'foodType': FoodType.FOOD,
    'rating': 3.0,
    'description': '',
  };
  List<ReviewItem> _reviewItemsList = [];
  List<File> _imageList = [];

  List<ReviewItem> get reviewItemsList {
    //copy spread items (brackets means copy)
    return [..._reviewItemsList];
  }

  List<File> get imageList {
    //copy spread items (brackets means copy)
    return [..._imageList];
  }

  Review get currentReview {
    return Review(
      id: DateTime.now().toString(),
      serviceRating: postFormData['serviceRating'] as double,
      tasteRating: postFormData['tasteRating'],
      costRating: postFormData['costRating'],
      quantityRating: postFormData['quantityRating'],
      authorId: postFormData['authorId'],
      authorName: postFormData['authorName'],
      restaurantName: postFormData['restaurantName'],
      restaurantId: postFormData['restaurantid'],
      location: postFormData['location'],
      branchtId: postFormData['branchId'],
      reviewText: postFormData['reviewText'],
      isLiked: postFormData['isLiked'],
      reviewItems: _reviewItemsList.isEmpty ? null : _reviewItemsList,
      reviewImages: _imageList,
    );
  }

  void addReviewItem(ReviewItem reviewItem) {
    _reviewItemsList.add(reviewItem);
    notifyListeners();
  }

  void addImage(File image) {
    _imageList.add(image);
    notifyListeners();
  }

  void deleteItemById(String id) {
    _reviewItemsList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearCurrentReviewItem() {
    currentReviewItem = {
      'id': '',
      'title': '',
      'price': 0.0,
      'foodType': FoodType.FOOD,
      'rating': 3.0,
      'description': '',
    };
  }

  void clearCurrentReview() {
    postFormData = {
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
    currentReviewItem = {
      'id': '',
      'title': '',
      'price': 0.0,
      'foodType': FoodType.FOOD,
      'rating': 3.0,
      'description': '',
    };
    _reviewItemsList = [];
    _imageList = [];
    notifyListeners();
  }

  void removeImage(int index) {
    print(index);
    _imageList.removeAt(index);
    notifyListeners();
  }
}
