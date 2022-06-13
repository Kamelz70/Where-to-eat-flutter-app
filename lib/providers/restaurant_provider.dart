import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/branch.dart';
import '../models/http_exception.dart';
import '../models/restaurant.dart';
import 'package:http/http.dart' as http;

const SEARCH_BY_NAME_API =
    'https://grad-projj.herokuapp.com/Restaurants/search';
const GET_BRANCHES_API = 'https://grad-projj.herokuapp.com/Restaurant/branches';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _items = [];
  RestaurantProvider(this._items);

///////////////////////////////////////////////////////
  ///
  ///     getters
  ///
  ////////////////////////////////////////////////////
  List<Restaurant> get items {
    //copy spread items (brackets means copy)
    return [..._items, ...DUMMY_RestaurantS];
  }

///////////////////////////////////////////////////////
  ///
  ///         Methods
  ///
  /////////////////////////////////////////////////////////////////

  Future<void> fetchTrendingRestaurants() async {
    await Future.delayed(const Duration(seconds: 1));
    _items = DUMMY_RestaurantS;
  }

  Future<List<Restaurant>> searchByName(String searchTerm) async {
    final url = Uri.parse('$SEARCH_BY_NAME_API/$searchTerm');

    try {
      print('fetching restaurants');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode != 200) {
        throw HttpException('Get Restaurants Failed');
      }
      final responseData = json.decode(response.body);
      print(responseData);
      List<Restaurant> restaurantList = [];
      responseData.forEach((restaurant) {
        restaurantList.add(Restaurant(
          id: restaurant['_id'],
          title: restaurant['name'],
          imageUrl: '',
          categories: [],
          serviceRating: restaurant['serviceRating'].toDouble(),
          tasteRating: restaurant['TasteRating'].toDouble(),
          costRating: restaurant['costRating'].toDouble(),
          quantityRating: restaurant['quantityRating'].toDouble(),
          totalRating: restaurant['TotalRating'].toDouble(),
        ));
      });
      return restaurantList;
    } catch (error) {
      // ignore: avoid_print
      print(error);
      throw error;
    }
    return [];
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    // final url = Uri.parse(
    //     'https://shop-application-c27b8-default-rtdb.firebaseio.com/products.json?auth=$_authToken');

    // try {
    //   final response = await http.post(
    //     url,
    //     body: json.encode(
    //       {
    //         'title': product.title,
    //         'description': product.description,
    //         'price': product.price,
    //         'imageUrl': product.imageUrl,
    //         'ownerId': _userId
    //       },
    //     ),
    //   );
    //   final newProduct = Product(
    //       id: json.decode(response.body)['name'],
    //       title: product.title,
    //       description: product.description,
    //       price: product.price,
    //       imageUrl: product.imageUrl);

    //   _items.insert(0, newProduct);
    //   //or _items.add(newProduct);
    //   notifyListeners();
    // } catch (error) {
    //   // ignore: avoid_print
    //   print(error);
    //   throw error;
    // }

    // try {
    //   final newReview = Review(
    //     id: DateTime.now().toString(),
    //     serviceRating: review.serviceRating,
    //     tasteRating: review.tasteRating,
    //     costRating: review.costRating,
    //     quantityRating: review.quantityRating,
    //     restaurantId: review.restaurantId,
    //     authorId: review.authorId,
    //     authorName: review.authorName,
    //     authorImage: review.authorImage,
    //     branchtId: review.branchtId,
    //     restaurantName: review.restaurantName,
    //     location: review.location,
    //     reviewText: review.reviewText,
    //     reviewItems: review.reviewItems,
    //     isLiked: review.isLiked,
    //   );

    //   _items.add(newReview);
    //   //or _items.add(newProduct);
    //   notifyListeners();
    // } catch (error) {
    //   // ignore: avoid_print
    //   print(error);
    //   throw error;
    // }
  }
  Future<Restaurant?> findById(String id) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return _items.firstWhere((element) => element.id == id);
    } catch (error) {
      return DUMMY_RestaurantS.firstWhere((element) => element.id == id);
    }
  }

  Future<List<Branch>> fetchBranches(String restaurantId) async {
    final url = Uri.parse('$GET_BRANCHES_API/$restaurantId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('fetching branches');
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('Fetching branches Failed');
      }
      final responseData = json.decode(response.body);
      print(responseData);
      List<Branch> branchesList = [];

      responseData.forEach((branch) {
        branchesList.add(Branch(
          id: branch['_id'],
          location: PlaceLocation(address: branch['name']),
        ));
      });
      return branchesList;
    } catch (error) {
      // ignore: avoid_print
      print('errorrrrrrrrrrrrrrrrrrrrr');

      print(error);
      rethrow;
    }
  }
}
