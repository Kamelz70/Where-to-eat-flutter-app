import 'package:flutter/material.dart';
import '../widgets/new_review_screen/new_review.dart';
import 'Items_review_screen.dart';

class NewReviewScreen extends StatelessWidget {
  NewReviewScreen({Key? key}) : super(key: key);
  static const routeName = '/new-review-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Review'),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Card(
              margin: EdgeInsets.all(20),
              child: NewReview(),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Text('Attach Dishes'),
                onPressed: () {
                  Navigator.of(context).pushNamed(ItemsReviewScreen.routeName);
                },
              ),
              SizedBox(width: 20),
              ElevatedButton(
                child: Text('Post'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
