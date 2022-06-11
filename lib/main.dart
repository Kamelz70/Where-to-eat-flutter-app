// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/Screens/explore_screen.dart';
import 'package:where_to_eat/data/dummy_data.dart';
import 'package:where_to_eat/models/restaurant.dart';
import 'package:where_to_eat/providers/auth.dart';
import 'package:where_to_eat/providers/restaurant_provider.dart';
import 'package:where_to_eat/screens/auth_screen.dart';
import 'package:where_to_eat/screens/new_review_screen.dart';
import 'package:where_to_eat/screens/restaurant_list_screen.dart';
import 'package:where_to_eat/screens/restaurant_page_screen.dart';
import 'package:where_to_eat/screens/settings_screen.dart';
import 'package:where_to_eat/screens/splash_screen.dart';
import 'package:where_to_eat/screens/wish_list_screen.dart';
import 'providers/new_review_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/review_provider.dart';
import 'screens/Items_review_screen.dart';
////////////////////////////////////////////////////////////////
///   Widgets

///////////////////////////////////////////////////////////////
///   Screens
import 'Screens/tabs_screen.dart';
import 'screens/add_restaurant_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Restaurant> _availableRestaurants = DUMMY_RestaurantS;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewProvider([]),
        ),
        ChangeNotifierProvider(
          create: (_) => NewReviewProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider([]),
        ),
        ChangeNotifierProxyProvider<Auth, ProfileProvider>(
          //we better not use the .value with provider in this case
          // as it creates the list of products for more efficiency
          update: (ctx, auth, previousPrifileProvider) => ProfileProvider(
            auth.token,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authenticator, _) => MaterialApp(
          title: 'Where to eat?',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: const Color.fromARGB(249, 255, 255, 255),
                titleTextStyle: Theme.of(context).textTheme.headline6,
                foregroundColor: Colors.orange),

            // This is the theme of your application.
            colorScheme:
                Theme.of(context).colorScheme.copyWith(primary: Colors.orange),
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                  headline2: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    color: Color.fromARGB(255, 67, 67, 67),
                  ),
                  headline3: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    color: Color.fromARGB(255, 138, 138, 138),
                  ),
                  headline4: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'RobotoCondensed',
                    color: Color.fromRGBO(55, 55, 55, 1),
                  ),
                  //orange form headlines
                  headline5: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoCondensed',
                    color: Colors.orange,
                    //Theme.of(context).colorScheme.primary,
                  ),
                  bodyText2: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'RobotoCondensed',
                    //Theme.of(context).colorScheme.primary,
                  ),
                ),
          ),

          home: authenticator.isAuth
              ? const TabsScreen()
              : FutureBuilder(
                  future: authenticator.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : const AuthScreen(),
                ),
          routes: {
            TabsScreen.routeName: (ctx) => const TabsScreen(),
            ExploreScreen.routeName: (ctx) => ExploreScreen(),
            RestaurantListScreen.routeName: (ctx) =>
                const RestaurantListScreen(),
            SettingsScreen.routeName: (ctx) => const SettingsScreen(),
            WishListScreen.routeName: (ctx) => const WishListScreen(),
            NewReviewScreen.routeName: (ctx) => NewReviewScreen(),
            ItemsReviewScreen.routeName: (ctx) => const ItemsReviewScreen(),
            AddRestaurantScreen.routeName: (ctx) => AddRestaurantScreen(),
          },
          //when it doesnt find named route, it goes to ongenroute
          onGenerateRoute: (settings) {
            print(
                "Error: Unknown named route, going to home route as a measure");

            return MaterialPageRoute(
              builder: (context) => const TabsScreen(),
            );
          },
          //when it doesnt find named route, it goes to ongenroute
          onUnknownRoute: (settings) {
            print("Error: Unknown route, going to home route as a measure");
            return MaterialPageRoute(
              builder: (context) => const TabsScreen(),
            );
          },
        ),
      ),
    );
  }
}
