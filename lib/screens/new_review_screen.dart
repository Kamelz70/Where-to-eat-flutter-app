import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/review_item.dart';
import '../providers/new_review_provider.dart';
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
  newPostProvider=Provider.of<NewReviewProvider>(context)
  final _formKey = GlobalKey<FormState>();
  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
  ///
  ////////////////////////////////////////////////////////////////////////////////
  void _formSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    print(this.formData);
    //Navigator.of(context).pop();
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
              child: NewReview(_formKey, formData),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Text('Attach Dishes'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemsReviewScreen(reviewItemsList)),
                  );
                },
              ),
              SizedBox(width: 20),
              ElevatedButton(
                child: Text('Post'),
                onPressed: () {
                  _formSubmit(context);
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
