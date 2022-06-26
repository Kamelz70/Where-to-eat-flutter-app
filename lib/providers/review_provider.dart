import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/dummy_data.dart';
import '../models/review.dart';

const String UPLOAD_IMAGE_API = 'https://grad-projj.herokuapp.com/image';

class ReviewProvider with ChangeNotifier {
  List<Review> _items = [];
  final String _authToken;
  final String _myUserId;
  final String _myUserName;
  ReviewProvider(
    this._authToken,
    this._myUserId,
    this._myUserName,
  );

///////////////////////////////////////////////////////
  ///
  ///     getters
  ///
  ////////////////////////////////////////////////////
  List<Review> get items {
    //copy spread items (brackets means copy)
    return [..._items];
  }

///////////////////////////////////////////////////////
  ///
  ///         Methods
  ///
  /////////////////////////////////////////////////////////////////

  Future<void> fetchAndSetNewsFeed([bool filterByUser = false]) async {
    // try {
    //   String filterString = '';
    //   if (filterByUser) {
    //     filterString = '&orderBy="ownerId"&equalTo="$_userId"';
    //   }
    //   final url = Uri.parse(
    //       'https://shop-application-c27b8-default-rtdb.firebaseio.com/products.json?auth=$_authToken$filterString');

    //   final response = await http.get(url);
    //   final data = json.decode(response.body) as Map<String, dynamic>;
    //   if (data == null) {
    //     return;
    //   }

    //   ///
    //   final favoritesUrl = Uri.parse(
    //       'https://shop-application-c27b8-default-rtdb.firebaseio.com/userFavorites/$_userId.json?auth=$_authToken');
    //   final favoritesResponse = await http.get(favoritesUrl);
    //   final favoritesData = json.decode(favoritesResponse.body);

    //   ///
    //   final List<Product> loadedProducts = [];
    //   data.forEach((prodId, prodData) {
    //     loadedProducts.add(Product(
    //       id: prodId,
    //       title: prodData['title'],
    //       description: prodData['description'],
    //       price: prodData['price'],
    //       isFavorite:
    //           //?? means check if null and put
    //           favoritesData == null
    //               ? false
    //               : favoritesData[prodId] as bool ?? false,
    //       imageUrl: prodData['imageUrl'],
    //     ));
    //   });
    //   _items = loadedProducts;
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
    await Future.delayed(const Duration(seconds: 1));

    _items = _items.isEmpty ? [..._items, ...DUMMY_Reviews] : _items;
    print('refreshing');
    notifyListeners();
  }

  Future<List<Review>> fetchRestaurantReviews(String restaurantId) async {
    print('fetching Restaurant revs');

    await Future.delayed(const Duration(seconds: 1));
    return DUMMY_Reviews;
  }

  Future<List<Review>> fetchBranchReviews(String branchId) async {
    print('fetching branch revssssssssssssssssssssssssssssssssssss');
    await Future.delayed(const Duration(seconds: 1));
    return DUMMY_Reviews;
  }

  Future<String> uploadImage(File image) async {
    try {
      final url = Uri.parse(UPLOAD_IMAGE_API);

      var request = http.MultipartRequest("POST", url);
      request.headers["Authorization"] = 'Bearer $_authToken';
      request.headers["Content-Type"] = 'application/json; charset=UTF-8';
      request.fields["Avatar"] = '';
      //create multipart using imagepath, string or bytes
      var pic = await http.MultipartFile.fromPath("upload", image.path);
      //add multipart to request
      request.files.add(pic);
      var response = await request.send();
      if (response.statusCode != 201) {
        throw HttpException("Couldn't Upload Post image");
      }
      //Get the response from the server
      var responseData = json.decode(await response.stream.bytesToString());
      ;
      print(responseData);
      return responseData['url'];
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<void> postReview(Review review, List<File> reviewImages) async {
    try {
      List<String> ImagesUrls = [];
      for (int i = 0; i < reviewImages.length; i++) {
        ImagesUrls.add(await uploadImage(reviewImages[i]));
      }
      ///////////for each doeesn't work
      // reviewImages.forEach((imageFile) async {
      //   ImagesUrls.add(await uploadImage(imageFile));
      // });
      print(ImagesUrls);
      final newReview = Review(
        id: DateTime.now().toString(),
        serviceRating: review.serviceRating,
        tasteRating: review.tasteRating,
        costRating: review.costRating,
        quantityRating: review.quantityRating,
        restaurantId: review.restaurantId,
        authorId: _myUserId,
        authorName: _myUserName,
        authorImage: review.authorImage,
        branchtId: review.branchtId,
        restaurantName: review.restaurantName,
        location: review.location,
        reviewText: review.reviewText,
        reviewItems: review.reviewItems,
        reviewImages: ImagesUrls,
        isLiked: review.isLiked,
      );

      _items.insert(0, newReview);
      //or _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print(error);
      rethrow;
    }
  }

  Future<List<Review>> fetchPostsOfId(String profileId) async {
    await Future.delayed(const Duration(seconds: 1));
    return DUMMY_Reviews;
  }
}
