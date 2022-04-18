import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/restaurant.dart';
import '../models/review.dart';

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
    await Future.delayed(Duration(seconds: 1));
    _items = DUMMY_RestaurantS;
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
  Restaurant? findById(String id) {
    try {
      return _items.firstWhere((element) => element.id == id);
    } catch (error) {
      return DUMMY_RestaurantS.firstWhere((element) => element.id == id);
    }
  }

  Future<List<Restaurant>> searchByName(String name) async {
    await Future.delayed(Duration(seconds: 1));
    return DUMMY_RestaurantS;
  }
}
