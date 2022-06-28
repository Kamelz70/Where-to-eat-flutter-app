import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/dummy_data.dart';
import '../models/review.dart';
import '../models/review_item.dart';

const String UPLOAD_IMAGE_API = 'https://grad-projj.herokuapp.com/image';
const String POST_REVIEW_API = 'https://grad-projj.herokuapp.com/review';
const String GET_PROFILE_POSTS_API =
    'https://grad-projj.herokuapp.com/users/reviews';
const String UPVOTE_API = '';
const String DOWNVOTE_API = '';

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

  Future<void> postReview(Map formData, List<File> reviewImages) async {
    List<String> ImagesUrls = [];
    for (int i = 0; i < reviewImages.length; i++) {
      ImagesUrls.add(await uploadImage(reviewImages[i]));
    }
    ///////////for each doeesn't work
    // reviewImages.forEach((imageFile) async {
    //   ImagesUrls.add(await uploadImage(imageFile));
    // });
    final url = Uri.parse('$POST_REVIEW_API');
    try {
      print('1111111111111111');

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $_authToken',
          },
          body: json.encode({
            "comment": formData['reviewText'],
            "serviceRating": formData['serviceRating'],
            "TasteRating": formData['tasteRating'],
            "costRating": formData['costRating'],
            "quantityRating": formData['quantityRating'],
            "branchId": formData['branchId'],
            "restaurantId": formData['restaurantid'],
            "imgUrl": ImagesUrls,
            "branchReviewsCount": formData['branchReviewsCount'],
            "BranchTotalCostRating": formData['BranchTotalCostRating'],
            "BranchTotalTasteRating": formData['BranchTotalTasteRating'],
            "BranchTotalQuantityRating": formData['BranchTotalQuantityRating'],
            "BranchTotalServiceRating": formData['BranchTotalServiceRating'],
            "restaurantReviewsCount": formData['RestaurantReviewsCount'],
            "restaurantTotalCostRating": formData['RestaurantTotalCostRating'],
            "restaurantTotalTasteRating":
                formData['RestaurantTotalTasteRating'],
            "restaurantTotalQuantityRating":
                formData['RestaurantTotalQuantityRating'],
            "restaurantTotalServiceRating":
                formData['RestaurantTotalServiceRating'],
          }));
      print('222222222222222222222222222222');
      print(response.statusCode);
      print(response.headers);
      print(response.body);

      if (response.statusCode != 201) {
        throw HttpException("Couldn't post reveiw");
      }
      print(response.body);
      // final newReview = Review(
      //   id: DateTime.now().toString(),
      //   serviceRating: formData['serviceRating'],
      //   tasteRating: formData['tasteRating'],
      //   costRating: formData['costRating'],
      //   quantityRating: formData['quantityRating'],
      //   restaurantId: formData['restaurantid'],
      //   authorId: _myUserId,
      //   authorName: _myUserName,
      //   authorImage: '',
      //   branchtId: formData['branchId'],
      //   restaurantName: formData['restaurantName'],
      //   location: formData['restaurantName'],
      //   reviewText: formData['reviewText'],
      //   reviewItems: null,
      //   reviewImages: ImagesUrls,
      //   isLiked: formData['isLiked'],
      // );

      // _items.insert(0, newReview);
      //or _items.add(newProduct);
      print('222222222222222222222222222222');

      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print(error);
      rethrow;
    }
  }

  Future<List<Review>> fetchPostsOfId(String profileId) async {
    final url = Uri.parse('$GET_PROFILE_POSTS_API/$profileId');
    List<Review> reviewsList = [];

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('fetching posts for id');
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('Fetching profile Failed');
      }
      final responseData = json.decode(response.body);
      print(responseData);

      print(responseData[1]['imgUrl'].runtimeType);
      responseData.forEach((review) {
        {
          reviewsList.add(Review(
            id: review['_id'],
            serviceRating: review['serviceRating'].toDouble(),
            tasteRating: review['TasteRating'].toDouble(),
            costRating: review['costRating'].toDouble(),
            quantityRating: review['quantityRating'].toDouble(),
            totalRating: review['TotalRating'].toDouble(),
            authorId: review['owner'],
            // get restaurants for profile id
            authorName: '',
            authorImage: '',
            restaurantId: '',
            restaurantName: '',
            branchtId: review['branchId'],
            location: '', //branch name
            reviewText: review['comment'],
            isLiked: false,
            isUpvoted: review['IsUpvoted'],
            isDownvoted: review['IsDownVoted'],
            reviewItems: null,
            reviewImages: List<String>.from(review['imgUrl']),
            //    reviewImages: review['imgUrl'].isEmpty
            // ? []
            // : review['imgUrl'] as List<String>,
            downVotes: 0,
            upVotes: 0,
          ));
        }
      });
      return reviewsList;
    } catch (error) {
      // ignore: avoid_print
      print('errorrrrrrrrrrrrrrrrrrrrr');

      print(error);
      rethrow;
    }
  }

  Future<void> upvotePost(String id) async {
    final url = Uri.parse(UPVOTE_API);

    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_authToken',
        },
        body: json.encode(
          {
            '_id': id,
          },
        ),
      );
      print('Upvote sent');
      final responseData = response.body;

      print(response.statusCode);
      print(responseData);

      if (response.statusCode != 200 && response.statusCode != 404) {
        throw HttpException('Upvote Failed');
      }
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }

  Future<void> downvotePost(String id) async {
    final url = Uri.parse(DOWNVOTE_API);

    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_authToken',
        },
        body: json.encode(
          {
            '_id': id,
          },
        ),
      );
      print('Downvote sent');
      final responseData = response.body;

      print(response.statusCode);
      print(responseData);

      if (response.statusCode != 200 && response.statusCode != 404) {
        throw HttpException('Downvote Failed');
      }
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }
}
