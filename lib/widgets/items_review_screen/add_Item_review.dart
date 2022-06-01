import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../models/review_item.dart';
import '../../providers/new_review_provider.dart';

class AddItemReview extends StatefulWidget {
  const AddItemReview({Key? key}) : super(key: key);

  @override
  State<AddItemReview> createState() => _AddItemReviewState();
}

class _AddItemReviewState extends State<AddItemReview> {
  final _formKey = GlobalKey<FormState>();

  void _addItem(BuildContext context, NewReviewProvider newPostProvider) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    newPostProvider.addReviewItem(ReviewItem(
        description: newPostProvider.currentReviewItem['description'],
        foodType: newPostProvider.currentReviewItem['foodType'],
        id: DateTime.now().toString(),
        title: newPostProvider.currentReviewItem['title'],
        price: newPostProvider.currentReviewItem['price'],
        rating: newPostProvider.currentReviewItem['rating']));
    newPostProvider.clearCurrentReviewItem();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final newPostProvider =
        Provider.of<NewReviewProvider>(context, listen: false);
    return ListView(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Type",
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  Radio<FoodType>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    focusColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    value: FoodType.FOOD,
                    groupValue: newPostProvider.currentReviewItem['foodType'],
                    onChanged: (FoodType? value) {
                      setState(() {
                        newPostProvider.currentReviewItem['foodType'] = value;
                      });
                    },
                  ),
                  Text('Food', style: Theme.of(context).textTheme.headline4),
                  Radio<FoodType>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    focusColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    value: FoodType.BEVERAGE,
                    groupValue: newPostProvider.currentReviewItem['foodType'],
                    onChanged: (FoodType? value) {
                      setState(() {
                        newPostProvider.currentReviewItem['foodType'] = value;
                      });
                    },
                  ),
                  Text('Beverage',
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(width: 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      "Name",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        newPostProvider.currentReviewItem['title'] = value;
                      },
                      initialValue: newPostProvider.currentReviewItem['title'],
                      controller: null,
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          {newPostProvider.currentReviewItem['title'] = value},
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      "Price",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        newPostProvider.currentReviewItem['price'] =
                            double.parse(value);
                      },
                      initialValue:
                          newPostProvider.currentReviewItem['price'] == 0
                              ? ''
                              : newPostProvider.currentReviewItem['price']
                                  .toStringAsFixed(0),
                      controller: null,
                      onSaved: (value) {
                        newPostProvider.currentReviewItem['price'] =
                            double.parse(value!);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a value';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Icon(Icons.attach_money,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Rating:", style: Theme.of(context).textTheme.headline4),
                  const SizedBox(width: 20),
                  RatingBar.builder(
                    unratedColor: Colors.grey.shade300,
                    glowColor: Colors.amber,
                    itemSize: 30,
                    initialRating: newPostProvider.currentReviewItem['rating'],
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      newPostProvider.currentReviewItem['rating'] = rating;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  newPostProvider.currentReviewItem['description'] = value;
                },
                initialValue: newPostProvider.currentReviewItem['description'],
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  labelText: "Item Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Please describe your experience in 5 characters at least';
                  }
                  return null;
                },
                onSaved: (value) {
                  newPostProvider.currentReviewItem['description'];
                },
                keyboardType: TextInputType.multiline,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              child: const Text('Add Item'),
              onPressed: () {
                _addItem(context, newPostProvider);
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
