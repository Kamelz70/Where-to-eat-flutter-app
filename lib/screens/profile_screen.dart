import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/dummy_data.dart';
import '../models/profile.dart';
import '../models/review.dart';
import '../providers/auth.dart';
import '../providers/profile_provider.dart';
import '../providers/review_provider.dart';
import '../screens/settings_screen.dart';
import '../screens/wish_list_screen.dart';
import '../widgets/profile_screen/profile_header.dart';
import '../widgets/reviews_list.dart';

class ProfileScreen extends StatelessWidget {
  final bool isMe;
  final String? userId;

  const ProfileScreen({this.userId, this.isMe = false, Key? key})
      : super(key: key);

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
    String? Id;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    if (isMe) {
      Id = Provider.of<Auth>(context, listen: false).userId;
    } else {
      Id = userId;
    }
    final iconsColor = Color.fromARGB(251, 111, 111, 111);
    const double iconsSize = 25;

    return Scaffold(
      appBar: isMe
          ? AppBar(title: Text('My Profile'), actions: [
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
            ])
          : AppBar(title: Text('Profile')),
      body: ListView(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: FutureBuilder<Profile>(
                future: profileProvider.fetchProfileByID(Id!),
                builder: (_, profileSnapshot) {
                  Widget child;
                  if (profileSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    child = Container(
                      height: 269,
                      child: Center(
                          child: LinearProgressIndicator(), key: ValueKey(0)),
                    );
                  } else
                    child = ProfileHeader(
                        profile: profileSnapshot.data!,
                        iconsSize: iconsSize,
                        iconsColor: iconsColor);

                  return AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: child,
                  );
                })),
        Container(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: FutureBuilder<List<Review>>(
                future: reviewProvider.fetchPostsOfId(Id),
                builder: (_, reviewsSnapshot) {
                  Widget child;
                  if (reviewsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    child = Container(
                      height: 269,
                      child: Center(
                          child: CircularProgressIndicator(), key: ValueKey(0)),
                    );
                  } else
                    // ignore: curly_braces_in_flow_control_structures
                    child = ReviewsList(
                      reviewsSnapshot.data!,
                    );

                  return AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: child,
                  );
                })),
      ]),
    );
  }
}
