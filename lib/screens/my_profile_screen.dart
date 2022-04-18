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
    const profileImagesPath = 'assets/images/profile-images/';
    final iconsColor = Color.fromARGB(251, 111, 111, 111);
    const double iconsSize = 25;

    return Scaffold(
      appBar: AppBar(title: Text('My Profile'), actions: [
        IconButton(
            iconSize: 35,
            onPressed: () => openWishList(context),
            color: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.favorite)),
        IconButton(
            iconSize: 35,
            onPressed: () => openSettings(context),
            color: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.settings)),
      ]),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: ClipRRect(
                      child: Image.network(
                        /////image here
                        'ss',
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, as, asd) {
                          return Icon(Icons.person,
                              size: 100,
                              color: Theme.of(context).colorScheme.onPrimary);
                        },
                      ),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  // Positioned(
                  //   left: 40,
                  //   top: 00,
                  //   child: Text('My WishList'),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text('Mohamed Kamel', style: Theme.of(context).textTheme.headline2),
            SizedBox(height: 10),
            Divider(thickness: 3, color: Colors.grey.shade200),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person_outline_rounded,
                          size: iconsSize, color: iconsColor),
                      Text('Followers'),
                      Text(
                        '20',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person_rounded,
                          size: iconsSize, color: iconsColor),
                      Text('Following'),
                      Text(
                        '50',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.feed_rounded,
                          size: iconsSize, color: iconsColor),
                      Text('Reviews'),
                      Text(
                        '4',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
        Container(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: ReviewsList(DUMMY_Reviews)),
      ]),
    );
  }
}
