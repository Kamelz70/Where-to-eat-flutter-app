import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  //final amountController = TextEditingController();
//Submit data function
  void _submitData() {
    //String titletext = titleController.text;
    //double amount = double.parse(amountController.text);

    //widget.newTxHandler(titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _starSize = MediaQuery.of(context).size.height * 0.05;
    return Container(
      padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: (MediaQuery.of(context).viewInsets.bottom) + 10),
      child: ListView(
        children: <Widget>[
          Container(
            //main column
            child: Column(
              children: [
                //restarant,branch inputs container

                //restarant,branch column

                TextField(
                  decoration: InputDecoration(labelText: "Restaurant"),
                  controller: null,
                  onSubmitted: (_) => {},
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Branch"),
                  controller: null,
                  onSubmitted: (_) => {},
                ),
                //Space
                SizedBox(height: 60),
                Container(
                  child: Column(children: [
                    //First rating row
                    Row(
                      children: [
                        Text("Cost"),
                        RatingBar.builder(
                          itemSize: _starSize,
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    //Second rating row
                    Row(
                      children: [
                        Text("Taste"),
                        RatingBar.builder(
                          itemSize: _starSize,
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    //Third rating row
                    Row(
                      children: [
                        Text("Service"),
                        RatingBar.builder(
                          itemSize: _starSize,
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    //Fourth rating row
                    Row(children: [
                      Text("Quantity"),
                      RatingBar.builder(
                        itemSize: _starSize,
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 200,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          SizedBox(height: 50),
          TextField(
              decoration: InputDecoration(labelText: "Comment"),
              maxLines: 4,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              keyboardType: TextInputType.multiline),
          SizedBox(height: 70),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  elevation: 7,
                ),
                onPressed: () => _submitData(),
                child: Text('Submit'),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) * 0.05),
        ],
      ),
    );
  }
}
