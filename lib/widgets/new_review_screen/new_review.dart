import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../providers/new_review_provider.dart';

class NewReview extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  NewReview(this._formKey);
  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  //////////////////////////////////////////////////////////////////////////
  ///
  ///       Consts and vars
  ///
//////////////////////////////////////////////////////////////////////////
  //final amountController = TextEditingController();
  static const newReviewImagesPath = 'assets/images/new-review-images/';

//////////////////////////////////////////////////////////////////////////
  ///
  ///       Functions
  ///
//////////////////////////////////////////////////////////////////////////
//Submit data function
  void _submitData() {
    //String titletext = titleController.text;
    //double amount = double.parse(amountController.text);

    //widget.newTxHandler(titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

//////////////////////////////////////////////////////////////////////////
  ///
  ///       Build Method
  ///
//////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final newPostProvider = Provider.of<NewReviewProvider>(context);

    String? _ratingInputError = null;
    final _starSize = MediaQuery.of(context).size.height * 0.05;
    return ListView(
      padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: (MediaQuery.of(context).viewInsets.bottom) + 10),
      children: <Widget>[
        Form(
          key: widget._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Info',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 20),
              //restarant,branch inputs container
              //restarant,branch column
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Restaurant",
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: null,
                      onSaved: (value) {
                        /////////////////////////////
                        /// needs modification
                        /////////////////////
                        newPostProvider.postFormData['restaurantName'] = value;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      "Branch",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: null,
                      /////////////////////////////
                      /// needs modification
                      /////////////////////
                      onSaved: (value) {
                        newPostProvider.postFormData['location'] = value;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Rating',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 20),
              if (_ratingInputError != null) Text(_ratingInputError),
              Row(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 26,
                          child: Image.asset(
                            newReviewImagesPath + 'price.png',
                          ),
                        ),
                        Text('Price'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(counterText: ""),
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['costRating'] =
                                  int.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }

                              int num = int.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }

                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        Text('/10'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 26,
                          child: Image.asset(
                            newReviewImagesPath + 'taste.png',
                          ),
                        ),
                        Text('Taste'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(counterText: ""),
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['tasteRating'] =
                                  int.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }
                              int num = int.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }
                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        Text('/10'),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 26,
                          child: Image.asset(
                            newReviewImagesPath + 'quantity.png',
                          ),
                        ),
                        Text('Quantity'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: "",
                            ),
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['quantityRating'] =
                                  int.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }
                              int num = int.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }
                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        Text('/10'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 26,
                          child: Image.asset(
                            newReviewImagesPath + 'service.png',
                          ),
                        ),
                        Text('Service'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(counterText: ""),
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['serviceRating'] =
                                  int.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }
                              int num = int.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }
                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        Text('/10'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              TextFormField(
                onSaved: (value) {
                  newPostProvider.postFormData['reviewText'] = value;
                },
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return 'Please describe your experience in 10 characters at least';
                  }
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Describe your Experience",
                  errorMaxLines: 2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLengthEnforcement: MaxLengthEnforcement.none,
                keyboardType: TextInputType.multiline,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("Did you like the restaurant?",
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    newPostProvider.postFormData['isLiked'] = true;
                  });
                },
                child: Icon(Icons.thumb_up, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  primary: newPostProvider.postFormData['isLiked']
                      ? Colors.green
                      : Colors.grey[500], // <-- Button color
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    newPostProvider.postFormData['isLiked'] = false;
                  });
                },
                child: Icon(Icons.thumb_down, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  primary: newPostProvider.postFormData['isLiked']
                      ? Colors.grey[500]
                      : Colors.red, // <-- Button color
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
      ],
    );
  }
}
