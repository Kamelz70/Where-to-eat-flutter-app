import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/review_item.dart';

class AddItemReview extends StatefulWidget {
  AddItemReview(this.reviewItemsList, {Key? key}) : super(key: key);
  List<ReviewItem> reviewItemsList;
  @override
  State<AddItemReview> createState() => _AddItemReviewState();
}

class _AddItemReviewState extends State<AddItemReview> {
  Map<String, dynamic> itemData = {
    'id': '',
    'title': '',
    'price': 0.0 as double,
    'foodType': FoodType.FOOD,
    'rating': 3.0 as double,
    'description': '',
  };
  final _formKey = GlobalKey<FormState>();

  void _submitItem(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      widget.reviewItemsList.add(ReviewItem(
        description: itemData['description'],
        foodType: itemData['foodType'],
        id: itemData['id'],
        title: itemData['title'],
        price: itemData['price'],
        rating: itemData['rating'],
      ));
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                    groupValue: itemData['foodType'],
                    onChanged: (FoodType? value) {
                      setState(() {
                        itemData['foodType'] = value;
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
                    groupValue: itemData['foodType'],
                    onChanged: (FoodType? value) {
                      setState(() {
                        itemData['foodType'] = value;
                      });
                    },
                  ),
                  Text('Beverage',
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(width: 20),
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
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: null,
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Please enter a title';
                        }
                      },
                      onSaved: (value) => {itemData['title'] = value},
                    ),
                  ),
                  SizedBox(width: 30),
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
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    child: TextFormField(
                      controller: null,
                      onSaved: (value) {
                        itemData['price'] = double.parse(value!);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a value';
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Icon(Icons.attach_money,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
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
                },
                onSaved: (value) {
                  itemData['description'];
                },
                keyboardType: TextInputType.multiline,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Rating:", style: Theme.of(context).textTheme.headline4),
            SizedBox(width: 20),
            RatingBar.builder(
              unratedColor: Colors.grey.shade300,
              glowColor: Colors.amber,
              itemSize: 30,
              initialRating: 3,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                itemData['rating'] = rating;
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              child: Text('Add Item'),
              onPressed: () {
                _submitItem(context);
              },
            ),
            SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
