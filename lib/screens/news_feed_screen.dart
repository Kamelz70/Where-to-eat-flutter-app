import 'package:flutter/material.dart';
import 'package:where_to_eat/data/dummy_data.dart';
import 'package:where_to_eat/widgets/new_post.dart';
import 'package:where_to_eat/widgets/post.dart';
import 'package:where_to_eat/widgets/reviews_list.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  _startAddPost(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(),
          child: GestureDetector(
            onTap: null,
            child: NewPost(),
            behavior: HitTestBehavior.opaque,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "News Feed",
          textAlign: TextAlign.center,
        ),
      ),
      body:
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          Container(
              height: MediaQuery.of(context).size.height,
              child: ReviewsList(
                  DUMMY_Reviews)), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddPost(context),
          color: Theme.of(context).accentColor,
          iconSize: 45.0),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
