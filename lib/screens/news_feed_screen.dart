import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/screens/new_review_screen.dart';
import 'package:where_to_eat/widgets/reviews_list.dart';

import '../models/review.dart';
import '../providers/new_review_provider.dart';
import '../providers/review_provider.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  Future<List<Review>> _fetchReviewPosts(BuildContext context) async {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);

    await reviewProvider.fetchAndSetNewsFeed();
    return reviewProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    final newReviewProvider = Provider.of<NewReviewProvider>(context);
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
          SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: _fetchReviewPosts(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      "Couldn't fetch posts, check your connection and retry"));
            } else {
              return RefreshIndicator(
                onRefresh: () => _fetchReviewPosts(ctx),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Consumer<ReviewProvider>(
                    builder: (_, reviewsData, child) {
                      return ReviewsList(reviewsData.items);
                    },
                  ),
                ),
              );
            }
          },
        ),
        //reviewsData.items
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: newReviewProvider.uploadingPost
          ? CircularProgressIndicator()
          : IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () =>
                  Navigator.of(context).pushNamed(NewReviewScreen.routeName),
              color: Theme.of(context).colorScheme.primary,
              iconSize: 45.0),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
