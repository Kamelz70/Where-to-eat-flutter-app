import 'dart:io';

import 'package:flutter/material.dart';
import 'package:where_to_eat/providers/review_provider.dart';

import '../models/branch.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../models/review_item.dart';

class NewReviewProvider with ChangeNotifier {
  Map<String, dynamic> postFormData = {
    'restaurantName': '',
    'restaurantid': '',
    'RestaurantReviewsCount': '',
    'RestaurantTotalCostRating': '',
    'RestaurantTotalTasteRating': '',
    'RestaurantTotalQuantityRating': '',
    'RestaurantTotalServiceRating': '',
    'isLiked': true,
    'location': '',
    'branchId': '',
    'branchReviewsCount': '',
    'BranchTotalCostRating': '',
    'BranchTotalTasteRating': '',
    'BranchTotalQuantityRating': '',
    'BranchTotalServiceRating': '',
    'reviewText': '',
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
  bool _uploadingPost = false;

  List<ReviewItem> get reviewItemsList {
    //copy spread items (brackets means copy)
    return [..._reviewItemsList];
  }

  List<File> get imageList {
    //copy spread items (brackets means copy)
    return [..._imageList];
  }

  bool get uploadingPost {
    //copy spread items (brackets means copy)
    return _uploadingPost;
  }

  Review get currentReview {
    return Review(
      id: DateTime.now().toString(),
      serviceRating: postFormData['serviceRating'],
      tasteRating: postFormData['tasteRating'],
      costRating: postFormData['costRating'],
      quantityRating: postFormData['quantityRating'],
      authorId: '', //will be replaced when posting,
      authorName: '', //will be replaced when posting,
      restaurantName: postFormData['restaurantName'],
      restaurantId: postFormData['restaurantid'],
      location: postFormData['location'],
      branchtId: postFormData['branchId'],
      reviewText: postFormData['reviewText'],
      isLiked: postFormData['isLiked'],
      reviewItems: _reviewItemsList.isEmpty ? null : _reviewItemsList,
      isUpvoted: false,
      isDownvoted: false,
      date: DateTime.now(),
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

  void selectBranch(Branch branch) {
    postFormData['branchId'] = branch.id;
    postFormData['location'] = branch.location.address;
    postFormData['branchReviewsCount'] = branch.reviewsCount;
    postFormData['BranchTotalCostRating'] = branch.costRating;
    postFormData['BranchTotalTasteRating'] = branch.tasteRating;
    postFormData['BranchTotalQuantityRating'] = branch.quantityRating;
    postFormData['BranchTotalServiceRating'] = branch.serviceRating;
  }

  void selectRestaurant(Restaurant restaurant) {
    postFormData['restaurantName'] = restaurant.title;
    postFormData['restaurantid'] = restaurant.id;
    postFormData['RestaurantReviewsCount'] = restaurant.reviewsCount;
    postFormData['RestaurantTotalCostRating'] = restaurant.costRating;
    postFormData['RestaurantTotalTasteRating'] = restaurant.tasteRating;
    postFormData['RestaurantTotalQuantityRating'] = restaurant.quantityRating;
    postFormData['RestaurantTotalServiceRating'] = restaurant.serviceRating;
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
      'RestaurantReviewsCount': '',
      'RestaurantTotalCostRating': '',
      'RestaurantTotalTasteRating': '',
      'RestaurantTotalQuantityRating': '',
      'RestaurantTotalServiceRating': '',
      'isLiked': true,
      'location': '',
      'branchId': '',
      'branchReviewsCount': '',
      'BranchTotalCostRating': '',
      'BranchTotalTasteRating': '',
      'BranchTotalQuantityRating': '',
      'BranchTotalServiceRating': '',
      'reviewText': '',
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

  Future<void> postCurrentReview(ReviewProvider reviewProvider) async {
    _uploadingPost = true;
    notifyListeners();
    try {
      await reviewProvider.postReview(this);
    } catch (error) {}
    _uploadingPost = false;
    notifyListeners();
  }

  void removeImage(int index) {
    print(index);
    _imageList.removeAt(index);
    notifyListeners();
  }
}
