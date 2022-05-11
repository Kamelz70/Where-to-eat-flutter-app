import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////////
///   Screens
import './explore_screen.dart';
import './search_screen.dart';
import 'profile_screen.dart';
import './news_feed_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  const TabsScreen({Key? key}) : super(key: key);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  ///////////////////////////////////////////////////////////////////
  ///
  ///           Varbiables and consts
  ///
////////////////////////////////////////////////////////////////////////////////

  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

///////////////////////////////////////////////////////////////////
  ///
  ///           Functions
  ///
////////////////////////////////////////////////////////////////////////////////

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  ///////////////////////////////////////////////////////////////////
  ///
  ///           Overrides
  ///
////////////////////////////////////////////////////////////////////////////////

  @override
  initState() {
    _pages = [
      {
        'page': ExploreScreen(),
        'title': 'Explore',
      },
      {
        'page': const SearchScreen(),
        'title': 'Search',
      },
      {
        'page': const NewsFeedScreen(),
        'title': 'News Feed',
      },
      {
        'page': const ProfileScreen(isMe: true),
        'title': 'My Profile',
      },
    ];
  }

///////////////////////////////////////////////////////////////////
  ///
  ///           Build
  ///
////////////////////////////////////////////////////////////////////////////////
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
            icon: Icon(Icons.person),
            label: 'Me',
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
