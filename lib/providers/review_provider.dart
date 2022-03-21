import 'package:flutter/material.dart';

import '../models/review.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> _items = [];
  ReviewProvider(this._items);

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
  }

  Future<void> postReview(Review review) async {
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

    try {
      final newReview = Review(
        id: DateTime.now().toString(),
        serviceRating: review.serviceRating,
        tasteRating: review.tasteRating,
        costRating: review.costRating,
        quantityRating: review.quantityRating,
        restaurantId: review.restaurantId,
        authorId: review.authorId,
        authorName: review.authorName,
        authorImage: review.authorImage,
        branchtId: review.branchtId,
        restaurantName: review.restaurantName,
        location: review.location,
        reviewText: review.reviewText,
        reviewItems: review.reviewItems,
        isLiked: review.isLiked,
      );

      _items.insert(0, newReview);
      //or _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print(error);
      throw error;
    }
  }
}