import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:where_to_eat/models/review.dart';

class Post extends StatelessWidget {
  Review review;
  Post(this.review);

  @override
  Widget build(BuildContext context) {
    //whole post card
    return Card(
      margin: EdgeInsets.all(20),
      //sizing container
      child: Container(
          padding: EdgeInsets.all(10),
          //column for elements
          child: Column(
            children: <Widget>[
              Container(
                //top info row
                child: Row(
                  children: <Widget>[
                    //profile picture
                    CircleAvatar(
                      radius: 16.0,
                      child: ClipRRect(
                        child: Image.network(
                            'https://scontent.fcai1-2.fna.fbcdn.net/v/t1.6435-9/68406470_2329293560457857_238321876919648256_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=174925&_nc_eui2=AeEMJynCO3wr772RkgWuBMF5k6fTKdUXlnCTp9Mp1ReWcO9EoxUbQhdTIs-kvnDs8cl9Nsc4DpfRcEh6rNVrdo9a&_nc_ohc=NJljR0LuKe4AX_ZbigL&_nc_oc=AQn-PO6ty2GwoViD3igjBG7_uPZDjXY8Yz4KBrHBSEDLH_pozAMucnQSqC00CcBQqlc&_nc_ht=scontent.fcai1-2.fna&oh=00_AT8r_Tybi41y5EG3YqrXvqXAIBUBih6ktDMElehQbIApGQ&oe=61E354B2'),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    Container(
                      //profile name and rating column
                      child: Column(children: [
                        //Profile name
                        Text("Mohamed Kamel"),
                        //ratings
                        RatingBar.builder(
                          itemSize: 17,
                          initialRating: (review.costRating +
                                  review.quantityRating +
                                  review.serviceRating +
                                  review.tasteRating) /
                              4,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(children: <Widget>[
                                Icon(Icons.attach_money,
                                    size: 15, color: Colors.grey),
                                Container(
                                  child: Text("${review.costRating}/5"),
                                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                                ),
                                SizedBox(width: 3),
                                Icon(Icons.circle,
                                    size: 15, color: Colors.grey),
                                Container(
                                  child: Text("${review.quantityRating}/5"),
                                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                                ),
                              ]),
                              SizedBox(height: 3),
                              Row(children: <Widget>[
                                Icon(Icons.room_service,
                                    size: 15, color: Colors.grey),
                                Container(
                                  child: Text("${review.serviceRating}/5"),
                                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                                ),
                                SizedBox(width: 3),
                                Icon(Icons.food_bank,
                                    size: 15, color: Colors.grey),
                                Container(
                                  child: Text("${review.tasteRating}/5"),
                                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                                ),
                              ])
                            ],
                          ),
                        )
                      ], crossAxisAlignment: CrossAxisAlignment.start),
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    Spacer(),
                    //restaurant
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.food_bank_outlined,
                              color: Colors.pink,
                              size: 17.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            SizedBox(width: 3),
                            Text("Restaurant"),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              Icons.room_outlined,
                              color: Colors.pink,
                              size: 17.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text("Location"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(review.reviewText),
              Row(children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_upward_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.arrow_downward_outlined),
                  onPressed: () {},
                ),
                SizedBox(width: 30),
                TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: null,
                    child: const Text('Share'))
              ])
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )),
      elevation: 7,
    );
  }
}
