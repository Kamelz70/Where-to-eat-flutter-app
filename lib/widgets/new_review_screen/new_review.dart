import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:textfield_search/textfield_search.dart';
import '../../models/branch.dart';
import '../../models/restaurant.dart';
import '../../providers/new_review_provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/review_provider.dart';
import '../../screens/Items_review_screen.dart';
import '../../screens/new_review_screen.dart';
import 'image_input.dart';

class NewReview extends StatefulWidget {
  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Vars and consts
  ///
  ////////////////////////////////////////////////////////////////////////////////
  late final GlobalKey formKey;
  Restaurant? restaurant;
  Branch? branch;
  NewReview(this.formKey, {this.restaurant, this.branch, Key? key})
      : super(key: key);
  static const routeName = '/new-review-page';
  static const newReviewImagesPath = 'assets/images/new-review-images/';

  @override
  State<NewReview> createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  late final TextEditingController _restaurantFieldController;

  late final TextEditingController _branchFieldController;

  List<MiniSearchItem> _miniSearchBranchesList = [];
  List<Branch> _BranchesList = [];
  List<Restaurant> _RestaurantsList = [];

  bool _loadingBranches = false;

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
  ///
  ////////////////////////////////////////////////////////////////////////////////

  Future<List> _fetchRestaurants(
      BuildContext context, String searchTerm) async {
    List _resultList = [];
    setState(() {});
    _RestaurantsList =
        await Provider.of<RestaurantProvider>(context, listen: false)
            .searchByName(
      searchTerm,
    );

    _RestaurantsList.forEach((restaurant) {
      _resultList.add(
        MiniSearchItem(label: restaurant.title, value: restaurant.id),
      );
    });

    return _resultList;
  }

  Future<void> _fetchBranches(BuildContext context, String restaurantId) async {
    setState(() {
      _loadingBranches = true;
    });
    _BranchesList =
        await Provider.of<RestaurantProvider>(context, listen: false)
            .fetchBranches(restaurantId);
    _miniSearchBranchesList = _BranchesList.map((branch) {
      return MiniSearchItem(label: branch.location.address, value: branch.id);
    }).toList();
    setState(() {
      _loadingBranches = false;
    });
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///
  ///   Overrides
  ///
  //////////////////////////////////////////////////////////////////////////////
  @override
  initState() {
    _restaurantFieldController = TextEditingController();
    _branchFieldController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _restaurantFieldController.dispose();
    _branchFieldController.dispose();
  }

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Build method
  ///
  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final newPostProvider =
        Provider.of<NewReviewProvider>(context, listen: false);
    if (widget.restaurant != null) {
      newPostProvider.selectRestaurant(widget.restaurant!);
      _restaurantFieldController.text = widget.restaurant!.title;
    }
    if (widget.branch != null) {
      newPostProvider.selectBranch(widget.branch!);

      _branchFieldController.text = widget.branch!.location.address;
    }
    String? _ratingInputError;
    final _starSize = MediaQuery.of(context).size.height * 0.05;
    return ListView(
      padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: (MediaQuery.of(context).viewInsets.bottom) + 10),
      children: <Widget>[
        Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Info',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Restaurant",
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  Spacer(),
                  Icon(Icons.food_bank,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 5),
                  ///////////////////////////////
                  /// Restaurant search input
                  /////////////////////////////
                  SizedBox(
                    width: 200,
                    child: widget.restaurant == null
                        ? TextFieldSearch(
                            label: 'Complex Future List',
                            controller: _restaurantFieldController,
                            future: () {
                              return _fetchRestaurants(
                                  context, _restaurantFieldController.text);
                            },
                            getSelectedValue: (item) {
                              print(item.value);
                              newPostProvider.selectRestaurant(
                                  _RestaurantsList.firstWhere((restaurant) =>
                                      restaurant.id == item.value));

                              _branchFieldController.clear();
                              _fetchBranches(context, item.value as String);
                            },
                            minStringLength: 2,
                            decoration: InputDecoration(
                                hintText: 'Search For Restaurant'),
                          )
                        : Text(
                            widget.restaurant!.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontSize: 17),
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
                  Spacer(),
                  Icon(Icons.location_on,
                      color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 5),
                  if (_loadingBranches) CircularProgressIndicator(),
                  ///////////////////////////////
                  /// Branch search input
                  /////////////////////////////
                  SizedBox(
                      width: 200,
                      child: widget.branch == null
                          ? TextFieldSearch(
                              label: 'Branch List',
                              controller: _branchFieldController,
                              initialList: _miniSearchBranchesList,
                              itemsInView: 50,
                              getSelectedValue: (item) {
                                print(item.value);
                                newPostProvider.selectBranch(
                                    _BranchesList.firstWhere(
                                        (branch) => branch.id == item.value));
                              },
                              decoration:
                                  InputDecoration(hintText: 'Select Branch'),
                            )
                          : Text(widget.branch!.location.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: 17))),
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
                        SizedBox(
                          height: 26,
                          child: Image.asset(
                            NewReviewScreen.newReviewImagesPath + 'price.png',
                          ),
                        ),
                        const Text('Price'),
                        SizedBox(
                          width: 30,
                          ///////////////////////////////
                          /// Price Rating input
                          /////////////////////////////
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
                              return null;
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
                        SizedBox(
                          height: 26,
                          child: Image.asset(
                            NewReviewScreen.newReviewImagesPath + 'taste.png',
                          ),
                        ),
                        const Text('Taste'),
                        SizedBox(
                          width: 30,
                          ///////////////////////////////
                          /// taset Rating input
                          /////////////////////////////
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
                              return null;
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
                        SizedBox(
                          height: 26,
                          child: Image.asset(
                            NewReviewScreen.newReviewImagesPath +
                                'quantity.png',
                          ),
                        ),
                        const Text('Quantity'),
                        SizedBox(
                          width: 30,
                          ///////////////////////////////
                          /// quantity Rating input
                          /////////////////////////////
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
                              return null;
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
                        SizedBox(
                          height: 26,
                          child: Image.asset(
                            NewReviewScreen.newReviewImagesPath + 'service.png',
                          ),
                        ),
                        const Text('Service'),
                        SizedBox(
                          width: 30,
                          ///////////////////////////////
                          /// service Rating input
                          /////////////////////////////
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
                              return null;
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
              ///////////////////////////////
              /// Review Text input
              /////////////////////////////
              TextFormField(
                onSaved: (value) {
                  newPostProvider.postFormData['reviewText'] = value;
                },
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return 'Please describe your experience in 10 characters at least';
                  }
                  return null;
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
            ///////////////////////////////
            /// Like/Dislike Buttons
            /////////////////////////////
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

////////////////////////////////////////////////////////////////////////
///
///       Sub-Widget-build-methods &  other Classes
///
////////////////////////////////////////////////////////////////////////////
///

// Mock Test Item Class
class MiniSearchItem {
  final String label;
  dynamic value;

  MiniSearchItem({required this.label, this.value});

  factory MiniSearchItem.fromJson(Map<String, dynamic> json) {
    return MiniSearchItem(label: json['label'], value: json['value']);
  }
  toLowerCase() {
    return this.label.toLowerCase();
  }
}
