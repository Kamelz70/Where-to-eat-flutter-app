import 'package:flutter/material.dart';
import 'package:where_to_eat/models/review_item.dart';

import '../data/dummy_data.dart';
import '../widgets/items_review_screen/add_Item_review.dart';
import '../widgets/reviewed_food_item.dart';
import '../widgets/reviewed_food_items_list.dart';
import '../widgets/reviews_list.dart';

class ItemsReviewScreen extends StatefulWidget {
  static const routeName = '/items-review-page';
  List<ReviewItem> reviewItemsList;
  ItemsReviewScreen(this.reviewItemsList, {Key? key}) : super(key: key);
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
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
              child: AddItemReview(widget.reviewItemsList)),
          behavior: HitTestBehavior.opaque,
        );
      },
    ).then((value) {
      setState(() {});
    });
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
              margin: EdgeInsets.all(20),
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
                        icon: Icon(Icons.add_circle_outline),
                      )
                    ],
                  ),
                  ReviewedFoodItemsList(widget.reviewItemsList),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 20),
              ElevatedButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
