// @dart=2.9
import 'package:flutter/material.dart';
import 'package:where_to_eat/Screens/explore_screen.dart';
import 'package:where_to_eat/data/dummy_data.dart';
import 'package:where_to_eat/models/restaurant.dart';
import 'package:where_to_eat/screens/restaurant_list_screen.dart';
import 'package:where_to_eat/screens/restaurant_page_screen.dart';
import 'package:where_to_eat/screens/settings_screen.dart';
import 'package:where_to_eat/screens/wish_list_screen.dart';
////////////////////////////////////////////////////////////////
///   Widgets
import './widgets/new_post.dart';
import 'package:where_to_eat/widgets/post.dart';

import './screens/my_profile_screen.dart';
///////////////////////////////////////////////////////////////
///   Screens
import 'Screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Restaurant> _availableRestaurants = DUMMY_RestaurantS;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 55, 55, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 55, 55, 1)),
              headline3: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  color: Color.fromRGBO(55, 55, 55, 1)),
            ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(),
        ExploreScreen.routeName: (ctx) => ExploreScreen(),
        RestaurantPageScreen.routeName: (ctx) => RestaurantPageScreen(),
        RestaurantListScreen.routeName: (ctx) =>
            RestaurantListScreen(_availableRestaurants),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        WishListScreen.routeName: (ctx) => WishListScreen(),
      },
      //when it doesnt find named route, it goes to ongenroute
      onGenerateRoute: (settings) {
        print("Error: Unknown named route, going to home route as a measure");

        return MaterialPageRoute(
          builder: (context) => TabsScreen(),
        );
      },
      //when it doesnt find named route, it goes to ongenroute
      onUnknownRoute: (settings) {
        print("Error: Unknown route, going to home route as a measure");
        return MaterialPageRoute(
          builder: (context) => TabsScreen(),
        );
      },
    );
  }
}
