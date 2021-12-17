import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////////
///   Screens
import './explore_screen.dart';
import './search_screen.dart';
import './my_profile_screen.dart';
import './news_feed_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  ///////////////////////////////////////////////////////////////////
  ///
  ///           Varbiables and consts
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

///////////////////////////////////////////////////////////////////
  ///
  ///           Functions
  void _selectPage(int index) {
    print(index);
    setState(() {
      _selectedPageIndex = index;
    });
  }

  ///////////////////////////////////////////////////////////////////
  ///
  ///           Overrides
  @override
  initState() {
    _pages = [
      {
        'page': ExploreScreen(),
        'title': 'Explore',
      },
      {
        'page': SearchScreen(),
        'title': 'Search',
      },
      {
        'page': NewsFeedScreen(),
        'title': 'News Feed',
      },
      {
        'page': MyProfileScreen(),
        'title': 'My Profile',
      },
    ];
  }

///////////////////////////////////////////////////////////////////
  ///
  ///           Build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration_sharp),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_rounded),
            label: 'News Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _selectPage,
      ),
      body: (_pages[_selectedPageIndex]['page'] as Widget),
    );
  }
}
