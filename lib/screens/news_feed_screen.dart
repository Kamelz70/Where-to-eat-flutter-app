import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/data/dummy_data.dart';
import 'package:where_to_eat/screens/new_review_screen.dart';
import 'package:where_to_eat/widgets/reviews_list.dart';

import '../providers/review_provider.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewsData = Provider.of<ReviewProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News Feed",
          textAlign: TextAlign.center,
        ),
      ),
      body:
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          Container(
        height: MediaQuery.of(context).size.height,
        child: ReviewsList(DUMMY_Reviews),
        //reviewsData.items
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: () =>
              Navigator.of(context).pushNamed(NewReviewScreen.routeName),
          color: Theme.of(context).accentColor,
          iconSize: 45.0),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
