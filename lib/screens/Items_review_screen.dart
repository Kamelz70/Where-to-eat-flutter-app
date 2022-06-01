import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/new_review_provider.dart';
import '../widgets/items_review_screen/add_Item_review.dart';
import '../widgets/reviewed_food_items_list.dart';

class ItemsReviewScreen extends StatefulWidget {
  static const routeName = '/items-review-page';
  const ItemsReviewScreen({Key? key}) : super(key: key);
  @override
  State<ItemsReviewScreen> createState() => _ItemsReviewScreenState();
}

class _ItemsReviewScreenState extends State<ItemsReviewScreen> {
  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///           Functions
  ///
  //////////////////////////////////////////////////////////////////////////////////

  void _showAddDish() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0)),
      ),
      builder: (_) {
        return GestureDetector(
          onTap: null,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: (MediaQuery.of(context).viewInsets.bottom) + 10),
              child: const AddItemReview()),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///           Build Method
  ///
  //////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items Review'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 7,
              margin: const EdgeInsets.all(20),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Items',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline5),
                      IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        iconSize: 30,
                        onPressed: _showAddDish,
                        icon: const Icon(Icons.add_circle_outline),
                      )
                    ],
                  ),
                  Consumer<NewReviewProvider>(
                    builder: (ctx, newPostProvider, ch) {
                      return ReviewedFoodItemsList(
                          newPostProvider.reviewItemsList,
                          deletible: true);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 20),
              ElevatedButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
