import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';

class AddRestaurantScreen extends StatelessWidget {
  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Vars and consts
  ///
  ////////////////////////////////////////////////////////////////////////////////
  AddRestaurantScreen({Key? key}) : super(key: key);
  static const routeName = '/add-restaurant';
  final _formKey = GlobalKey<FormState>();
  Map formData = {
    'title': '',
    'image': '',
    'categories': '',
    'location': '',
  };

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
  ///
  ////////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////////////////
  ///
  ///     Build method
  ///
  ////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Restaurant'),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Card(
              elevation: 7,
              margin: const EdgeInsets.all(20),
              child: ListView(
                padding: EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                    bottom: (MediaQuery.of(context).viewInsets.bottom) + 10),
                children: <Widget>[
                  Form(
                    key: _formKey,
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
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: null,
                                onSaved: (value) {
                                  /////////////////////////////
                                  /// needs modification
                                  /////////////////////
                                  formData['title'] = value;
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
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: null,
                                /////////////////////////////
                                /// needs modification
                                /////////////////////
                                onSaved: (value) {
                                  formData['location'] = value;
                                },
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  print(formData);
                  Navigator.of(context).pop();
                },
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
