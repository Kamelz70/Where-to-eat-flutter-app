import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/branch.dart';
import '../models/http_exception.dart';
import '../models/restaurant.dart';
import 'package:http/http.dart' as http;

///////////////////////////////////////////////////////
///
///     Constants
///
////////////////////////////////////////////////////

const SEARCH_BY_NAME_API =
    'https://grad-projj.herokuapp.com/Restaurants/search';
const GET_BRANCHES_API = 'https://grad-projj.herokuapp.com/Restaurant/branches';
const GET_RESTAURANT_API = 'https://grad-projj.herokuapp.com/Restaurant';
const GET_BRANCH_API = '';

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
          reviewsCount: restaurant['NoOfReviews'],
          serviceRating: double.parse(restaurant['serviceRating']),
          tasteRating: double.parse(restaurant['TasteRating']),
          costRating: double.parse(restaurant['costRating']),
          quantityRating: double.parse(restaurant['quantityRating']),
          totalRating: double.parse(restaurant['TotalRating']),
        ));
      });

      return restaurantList;
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
    return [];
  }

  Future<void> addRestaurant(Restaurant restaurant) async {}

  Future<Restaurant?> fetchRestaurantById(String id) async {
    final url = Uri.parse('$GET_RESTAURANT_API/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('fetching Restaurant');
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('Fetching Restaurant Failed');
      }
      final responseData = json.decode(response.body);
      print(responseData);

      return Restaurant(
          totalRating: responseData['TotalRating'].toDouble(),
          costRating: responseData['costRating'].toDouble(),
          tasteRating: responseData['TasteRating'].toDouble(),
          quantityRating: responseData['quantityRating'].toDouble(),
          serviceRating: responseData['serviceRating'].toDouble(),
          id: responseData['_id'],
          title: responseData['name'],
          imageUrl: '',
          categories: []);
    } catch (error) {
      // ignore: avoid_print
      print('errorrrrrrrrrrrrrrrrrrrrr');

      print(error);
      rethrow;
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
        branchesList.add(
          Branch(
            id: branch['_id'],
            location: PlaceLocation(
              address: branch['name'],
            ),
            reviewsCount: branch['NoOfReviews'],
            costRating: double.parse(branch['costRating']),
            tasteRating: double.parse(branch['TasteRating']),
            quantityRating: double.parse(branch['quantityRating']),
            serviceRating: double.parse(branch['serviceRating']),
            totalRating: double.parse(branch['TotalRating']),
          ),
        );
      });
      return branchesList;
    } catch (error) {
      // ignore: avoid_print
      print('errorrrrrrrrrrrrrrrrrrrrr');

      print(error);
      rethrow;
    }
  }

  Future<Branch?> fetchBranchById(String id) async {
    final url = Uri.parse('$GET_BRANCH_API/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('fetching Restaurant');
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('Fetching Branch Failed');
      }
      final responseData = json.decode(response.body);
      print(responseData);

      return Branch(
        id: responseData['_id'],
        reviewsCount: responseData['reviewsCount'],
        totalRating: responseData['TotalRating'].toDouble(),
        costRating: responseData['costRating'].toDouble(),
        tasteRating: responseData['TasteRating'].toDouble(),
        quantityRating: responseData['quantityRating'].toDouble(),
        serviceRating: responseData['serviceRating'].toDouble(),
        location: responseData['name'],
      );
    } catch (error) {
      // ignore: avoid_print
      print('errorrrrrrrrrrrrrrrrrrrrr');

      print(error);
      rethrow;
    }
  }
}
