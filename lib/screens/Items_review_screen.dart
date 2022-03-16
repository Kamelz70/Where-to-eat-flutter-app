import 'package:flutter/material.dart';

import '../widgets/items_review_screen/add_Item_review.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (_) {
        return GestureDetector(
          onTap: null,
          child: AddItemReview(),
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
              margin: EdgeInsets.all(20),
              child: ListView(
                padding: const EdgeInsets.all(20),
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
