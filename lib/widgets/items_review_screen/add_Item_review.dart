import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum Food { FOOD, BEVERAGE }

class AddItemReview extends StatefulWidget {
  const AddItemReview({Key? key}) : super(key: key);

  @override
  State<AddItemReview> createState() => _AddItemReviewState();
}

class _AddItemReviewState extends State<AddItemReview> {
  Food? _val;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: (MediaQuery.of(context).viewInsets.bottom) + 10),
      children: <Widget>[
        Form(
          key: null,
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
                  Radio<Food>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    focusColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    value: Food.FOOD,
                    groupValue: _val,
                    onChanged: (Food? value) {
                      setState(() {
                        _val = value;
                      });
                    },
                  ),
                  Text('Food', style: Theme.of(context).textTheme.headline4),
                  Radio<Food>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    focusColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber),
                    value: Food.BEVERAGE,
                    groupValue: _val,
                    onChanged: (Food? value) {
                      setState(() {
                        _val = value;
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
                      onSaved: (_) => {},
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
                      onSaved: (_) => {},
                    ),
                  ),
                  Icon(Icons.attach_money,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Item Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 4,
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
              initialRating: 4,
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
                print(rating);
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
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
