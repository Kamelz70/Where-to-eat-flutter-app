import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/new_review_provider.dart';
import '../providers/review_provider.dart';
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

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Build method
  ///
  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final newPostProvider =
        Provider.of<NewReviewProvider>(context, listen: false);
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Review'),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Card(
              elevation: 7,
              margin: const EdgeInsets.all(20),
              child: NewReview(_formKey),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Attach Dishes'),
                onPressed: () {
                  Navigator.of(context).pushNamed(ItemsReviewScreen.routeName);
                },
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                child: const Text('Post'),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  print(newPostProvider.postFormData);
                  reviewProvider.postReview(newPostProvider.currentReview);
                  newPostProvider.clearCurrentReview();
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
