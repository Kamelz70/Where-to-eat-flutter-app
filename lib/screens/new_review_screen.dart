import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:textfield_search/textfield_search.dart';
import '../helpers/common_functions.dart';
import '../models/branch.dart';
import '../models/restaurant.dart';
import '../providers/new_review_provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/review_provider.dart';
import '../widgets/new_review_screen/image_input.dart';
import '../widgets/new_review_screen/new_review.dart';
import 'Items_review_screen.dart';

class NewReviewScreen extends StatefulWidget {
  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Vars and consts
  ///
  ////////////////////////////////////////////////////////////////////////////////

  Restaurant? restaurant;
  Branch? branch;
  NewReviewScreen({this.restaurant, this.branch, Key? key}) : super(key: key);
  static const routeName = '/new-review-page';
  static const newReviewImagesPath = 'assets/images/new-review-images/';

  @override
  State<NewReviewScreen> createState() => _NewReviewScreenState();
}

class _NewReviewScreenState extends State<NewReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
  ///
  ////////////////////////////////////////////////////////////////////////////////
  void _submitForm(BuildContext context) {
    final newPostProvider =
        Provider.of<NewReviewProvider>(context, listen: false);
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);

    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (newPostProvider.postFormData['branchId'].isEmpty) {
      CommonFunctions.showErrorDialog(
          context, 'Choose a restauarant and a branch first');
      return;
    }
    _formKey.currentState!.save();
    print(newPostProvider.postFormData);
    reviewProvider.postReview(
        newPostProvider.currentReview, newPostProvider.imageList);
    newPostProvider.clearCurrentReview();
    Navigator.of(context).pop();
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///   Overrides
  ///
  //////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Build method
  ///
  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
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
              child: NewReview(_formKey,
                  restaurant: widget.restaurant, branch: widget.branch),
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
                onPressed: () => _submitForm(context),
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
