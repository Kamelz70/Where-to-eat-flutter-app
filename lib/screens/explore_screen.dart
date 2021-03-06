import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/screens/restaurant_list_screen.dart';
import 'package:where_to_eat/screens/wish_list_screen.dart';

import '../providers/restaurant_provider.dart';

class ExploreScreen extends StatelessWidget {
  ///////////////////////////////////////////////////////////////////
  ///
  /// Variables and constants
  ///
  ////////////////////////////////////////////////////////////////////
  static const routeName = '/explore';
  static const exploreScreenImagesPath = 'assets/images/explore-screen-images/';
  static final List<Map<String, dynamic>> exploreMaps = [
    {
      'title': 'Nearby',
      'imageLocation': '${exploreScreenImagesPath}nearby.png',
      'onTap': (context) {
        Navigator.of(context).pushNamed(WishListScreen.routeName);
      }
    },
    {
      'title': 'Cuisine',
      'imageLocation': '${exploreScreenImagesPath}cuisine.png',
      'onTap': (context) {
        Navigator.of(context).pushNamed(WishListScreen.routeName);
      }
    },
    {
      'title': 'Trending',
      'imageLocation': '${exploreScreenImagesPath}trending.png',
      'onTap': (context) {
        Navigator.of(context).pushNamed(
          RestaurantListScreen.routeName,
          arguments: Provider.of<RestaurantProvider>(context, listen: false)
              .fetchTrendingRestaurants(),
        );
      }
    },
    {
      'title': 'Price Range',
      'imageLocation': '${exploreScreenImagesPath}price-range.png',
      'onTap': (context) {
        Navigator.of(context).pushNamed(WishListScreen.routeName);
      }
    },
    {
      'title': 'Tagline',
      'imageLocation': '${exploreScreenImagesPath}tagline.png',
      'onTap': (context) {
        Navigator.of(context).pushNamed(WishListScreen.routeName);
      }
    },
    {
      'title': 'For You',
      'imageLocation': '${exploreScreenImagesPath}for-you.png',
      'onTap': (context) {
        Navigator.of(context).pushNamed(WishListScreen.routeName);
      }
    }
  ];

  ///////////////////////////////////////////////////////////////////
  ///
  /// Functions
  ///
  ////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////
  ///
  /// Build Method
  ///
  ////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Explore'),
      ),
      body: GridView.builder(
        itemCount: exploreMaps.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        itemBuilder: (ctx, index) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(5, 5),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  exploreMaps[index]['onTap'](context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                          exploreMaps[index]['imageLocation'] as String,
                          fit: BoxFit.fitHeight),
                    ),
                    Text(exploreMaps[index]['title'] as String,
                        style: Theme.of(context).textTheme.headline3)
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 11 / 13,
          crossAxisSpacing: 20,
          mainAxisSpacing: 25,
        ),
      ),
    );
  }
}
