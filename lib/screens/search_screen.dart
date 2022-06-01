import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';
import '../models/restaurant.dart';
import '../providers/profile_provider.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/search_screen/profile_search_list.dart';
import '../widgets/search_screen/restaurant_search_list.dart';

enum SearchMode { RESTAURANTS, PROFILES }

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const historyLength = 5;
  List<String> _searchHistory = [
    'fuchsia',
    'flutter',
    'widgets',
    'resocoder',
  ];
  SearchMode _searchMode = SearchMode.RESTAURANTS;
  List<String> filteredSearchHistory = [];

  String SearchTerm = '';

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController barContoller =
      null as FloatingSearchBarController;

  @override
  void initState() {
    super.initState();
    barContoller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  @override
  void dispose() {
    barContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: FloatingSearchBar(
        controller: barContoller,
        body: FloatingSearchBarScrollNotifier(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 80),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: _searchMode == SearchMode.RESTAURANTS
                          ? () {}
                          : () {
                              setState(() {
                                _searchMode = SearchMode.RESTAURANTS;
                                barContoller.show();
                                barContoller.open();
                              });
                            },
                      icon: Icon(Icons.food_bank),
                      label: Text('Restaurants'),
                      style: ButtonStyle(
                        foregroundColor: _searchMode == SearchMode.RESTAURANTS
                            ? MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary)
                            : MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: _searchMode == SearchMode.PROFILES
                          ? () {}
                          : () {
                              setState(() {
                                _searchMode = SearchMode.PROFILES;
                                barContoller.show();
                                barContoller.open();
                              });
                            },
                      icon: Icon(Icons.person),
                      label: Text('Profiles'),
                      style: ButtonStyle(
                        foregroundColor: _searchMode == SearchMode.PROFILES
                            ? MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary)
                            : MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: _searchMode == SearchMode.RESTAURANTS
                    ? FutureBuilder<List<Restaurant>>(
                        future: SearchTerm.isEmpty
                            ? null
                            : restaurantProvider.searchByName(SearchTerm),
                        builder: (_, restaurantSnapshot) {
                          print('building restaurants list');

                          if (restaurantSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: const CircularProgressIndicator());
                          }
                          return SearchTerm.isEmpty
                              ? RestaurantSearchList([])
                              : RestaurantSearchList(restaurantSnapshot.data!);
                        })
                    : FutureBuilder<List<Profile>>(
                        future: SearchTerm.isEmpty
                            ? null
                            : profileProvider.searchByName(SearchTerm),
                        builder: (_, profilesSnapshot) {
                          print('building profiles list');
                          if (profilesSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: const CircularProgressIndicator());
                          }
                          return SearchTerm.isEmpty
                              ? ProfileSearchList([])
                              : ProfileSearchList(profilesSnapshot.data!);
                        }),
              ),
            ],
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          // setState(() {
          //   filteredSearchHistory = filterSearchTerms(filter: query);
          // });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            SearchTerm = query;
          });
          print('searching');
          barContoller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 7,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      barContoller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(barContoller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(barContoller.query);
                          SearchTerm = barContoller.query;
                        });
                        barContoller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  SearchTerm = term;
                                });
                                barContoller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/////////////////////////////////////////////////////
