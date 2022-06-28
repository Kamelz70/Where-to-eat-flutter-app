import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/dummy_data.dart';
import '../models/review.dart';
import '../models/review_item.dart';
import 'new_review_provider.dart';

const String UPLOAD_IMAGE_API = 'https://grad-projj.herokuapp.com/image';
const String POST_REVIEW_API = 'https://grad-projj.herokuapp.com/review';
const String GET_PROFILE_POSTS_API =
    'https://grad-projj.herokuapp.com/users/reviews';
const String UPVOTE_API = 'https://grad-projj.herokuapp.com/review/upvotes';
const String DOWNVOTE_API =
    'https://grad-projj.herokuapp.com/ /review/downvotes';
const String FETCH_NEWSFEED_API =
    'https://grad-projj.herokuapp.com/user/newsFeed';

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
  List<Review> _decodeReviewsResponse(List responseData) {
    List<Review> reviewsList = [];
    responseData.forEach((review) {
      {
        List<ReviewItem> reviewItems =
            List<Map<String, dynamic>>.from(review['Dishes'])
                .map<ReviewItem>((item) {
          return ReviewItem(
            id: item['_id'],
            title: item['name'],
            foodType: item['Type'] == true ? FoodType.FOOD : FoodType.BEVERAGE,
            price: double.parse(item['price']),
            rating: double.parse(item['rating']),
            description: '',
          );
        }).toList();

        reviewsList.add(Review(
          id: review['_id'],
          serviceRating: review['serviceRating'].toDouble(),
          tasteRating: review['TasteRating'].toDouble(),
          costRating: review['costRating'].toDouble(),
          quantityRating: review['quantityRating'].toDouble(),
          totalRating: review['TotalRating'].toDouble(),
          authorId: review['owner'],
          // get restaurants for profile id
          authorName: review['authorName'],
          authorImage: review['authorImage'],
          restaurantId: review['ResturantID'],
          restaurantName: review['restaurantName'],
          branchtId: review['branchId'],
          location: review['location'], //branch name
          reviewText: review['comment'],
          isLiked: review['wouldRecommend'],
          isUpvoted: review['IsUpvoted'],
          isDownvoted: review['IsDownVoted'],
          reviewItems: reviewItems.isEmpty ? null : reviewItems,
          reviewImages: List<String>.from(review['imgUrl']),
          date: DateTime.parse(review['createdAt']),
          downVotes: review['downVotesCount'],
          upVotes: review['upVotesCount'],
        ));
      }
    });
    return reviewsList;
  }

  Future<void> fetchAndSetNewsFeed([bool filterByUser = false]) async {
    final url = Uri.parse('$FETCH_NEWSFEED_API');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_authToken',
        },
      );
      print('fetching NEWSFEED');
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('Fetching profile Failed');
      }
      final responseData = json.decode(response.body);
      print(responseData);

      _items = _decodeReviewsResponse(responseData);
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print('errorrrrrrrrrrrrrrrrrrrrr');

      print(error);
      rethrow;
    }
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

  Future<void> postReview(
    NewReviewProvider newReviewProvider,
  ) async {
    List<File> reviewImages = newReviewProvider.imageList;
    Map formData = newReviewProvider.postFormData;
    List<ReviewItem> reviewItems = newReviewProvider.reviewItemsList;
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
            "wouldRecommend": formData['isLiked'],
            "dishes": reviewItems.map<Map<String, dynamic>>((item) {
              return {
                'name': item.title,
                'rating': item.rating,
                'price': item.price,
                'Type': item.foodType == FoodType.FOOD ? true : false,
              };
            }).toList(),
          }));
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

      return _decodeReviewsResponse(responseData);
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
