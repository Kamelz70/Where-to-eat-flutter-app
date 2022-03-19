import 'package:flutter/material.dart';
import '../widgets/new_review_screen/new_review.dart';
import 'Items_review_screen.dart';

class NewReviewScreen extends StatelessWidget {
  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Vars and consts
  ///
  ////////////////////////////////////////////////////////////////////////////////
  NewReviewScreen({Key? key}) : super(key: key);
  static const routeName = '/new-review-page';

  final _formKey = GlobalKey<FormState>();
  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
  ///
  ////////////////////////////////////////////////////////////////////////////////
  void _fromSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context).pop();
  }

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Build method
  ///
  ////////////////////////////////////////////////////////////////////////////////
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
              elevation: 7,
              margin: EdgeInsets.all(20),
              child: NewReview(_formKey),
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
                  _fromSubmit(context);
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
