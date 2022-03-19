import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../screens/settings_screen.dart';
import '../screens/wish_list_screen.dart';
import '../widgets/reviews_list.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  void openSettings(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      SettingsScreen.routeName,
    );
  }

  void openWishList(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      WishListScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 80.0,
                    child: ClipRRect(
                      child: Image.network(
                          'https://scontent.fcai1-2.fna.fbcdn.net/v/t1.6435-9/68406470_2329293560457857_238321876919648256_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=174925&_nc_eui2=AeEMJynCO3wr772RkgWuBMF5k6fTKdUXlnCTp9Mp1ReWcO9EoxUbQhdTIs-kvnDs8cl9Nsc4DpfRcEh6rNVrdo9a&_nc_ohc=Ax5-x71qRGkAX-ZFy68&_nc_oc=AQk68tQD5_W47ZfoklJwxVteYayUXApQJu7ggMwwyzkAG8jZWn0wA8RSp2yDLE6T8MI&_nc_ht=scontent.fcai1-2.fna&oh=00_AT8TFgic4bd0h4KqxxqiGeGj_HTbfNmxjChxJJMdlQszqg&oe=622A85B2'),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  Positioned(
                    right: 60,
                    top: 00,
                    child: Text('Settings'),
                  ),
                  Positioned(
                    right: 60,
                    top: 10,
                    child: IconButton(
                      iconSize: 35,
                      onPressed: () => openSettings(context),
                      color: Colors.grey,
                      icon: Icon(Icons.settings),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 00,
                    child: Text('My WishList'),
                  ),
                  Positioned(
                    left: 60,
                    top: 10,
                    child: IconButton(
                      iconSize: 35,
                      onPressed: () => openWishList(context),
                      color: Colors.grey,
                      icon: Icon(Icons.favorite),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text('Mohamed Kamel', style: Theme.of(context).textTheme.headline3),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Followers'),
                      Text(
                        '20',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Following'),
                      Text(
                        '50',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Reviews'),
                      Text(
                        '4',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ReviewsList(DUMMY_Reviews),
          ],
        ),
      ),
    );
  }
}
