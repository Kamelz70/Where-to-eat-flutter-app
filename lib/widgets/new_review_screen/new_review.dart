import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/new_review_provider.dart';
import 'image_input.dart';

class NewReview extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  const NewReview(this._formKey);
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
  ///
  // void _addImage(File pickedImage) {
  //   _pickedImage = pickedImage;
  // }

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
    final newPostProvider =
        Provider.of<NewReviewProvider>(context, listen: false);

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
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Text('Rating',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5),
              const SizedBox(height: 20),
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
                        const Text('Price'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(counterText: ""),
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['costRating'] =
                                  double.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }

                              double num = double.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }

                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        const Text('/10'),
                      ],
                    ),
                  ),
                  const SizedBox(
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
                        const Text('Taste'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(counterText: ""),
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['tasteRating'] =
                                  double.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }
                              double num = double.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }
                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        const Text('/10'),
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
                        const Text('Quantity'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: "",
                            ),
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['quantityRating'] =
                                  double.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }
                              double num = double.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }
                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        const Text('/10'),
                      ],
                    ),
                  ),
                  const SizedBox(
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
                        const Text('Service'),
                        Container(
                          width: 30,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(counterText: ""),
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            onSaved: (value) {
                              newPostProvider.postFormData['serviceRating'] =
                                  double.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  _ratingInputError =
                                      'Please enter a value between 0 and 10';
                                });
                                return '';
                              }
                              double num = double.parse(value);
                              if (num < 0 || num > 10) {
                                return 'Please enter a rating out of 10 only';
                              }
                              setState(() {
                                _ratingInputError = null;
                              });
                            },
                          ),
                        ),
                        const Text('/10'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
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
        const SizedBox(height: 20),
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
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    newPostProvider.postFormData['isLiked'] = true;
                  });
                },
                child: const Icon(Icons.thumb_up, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
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
                child: const Icon(Icons.thumb_down, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  primary: newPostProvider.postFormData['isLiked']
                      ? Colors.grey[500]
                      : Colors.red, // <-- Button color
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        ImageInput(() {}),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
      ],
    );
  }
}
