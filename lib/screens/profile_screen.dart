import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';
import '../models/review.dart';
import '../providers/auth.dart';
import '../providers/profile_provider.dart';
import '../providers/review_provider.dart';
import '../screens/settings_screen.dart';
import '../screens/wish_list_screen.dart';
import '../widgets/profile_screen/profile_header.dart';
import '../widgets/reviews_list.dart';

class ProfileScreen extends StatefulWidget {
  final bool isMe;
  String? userId;
  Profile? profile;

  ProfileScreen(
      // ignore: avoid_init_to_null
      {this.userId,
      this.isMe = false,
      this.profile,
      Key? key})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  void _refreshProfile(
    ProfileProvider profileProvider,
    String Id,
  ) async {
    if (widget.profile != null) {
      try {
        widget.profile = await profileProvider.fetchProfileByID(Id) as Profile;
      } catch (error) {
        print(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const profileImagesPath = 'assets/images/profile-images/';
    String? Id;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<Auth>(context, listen: false);
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    if (widget.isMe) {
      Id = authProvider.userId;
    } else {
      Id = widget.profile == null ? widget.userId : widget.profile!.id;
    }
    const iconsColor = Color.fromARGB(251, 111, 111, 111);
    const double iconsSize = 25;
    Widget ProfileViewChild;
    final Widget _profileHeader =
        _buildProfileHeader(profileProvider, Id!, iconsSize, iconsColor);
    ProfileViewChild = Scaffold(
      appBar: widget.isMe
          ? AppBar(title: const Text('My Profile'), actions: [
              IconButton(
                  iconSize: 35,
                  onPressed: () => openWishList(context),
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.favorite)),
              IconButton(
                  iconSize: 35,
                  onPressed: () => openSettings(context),
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.settings)),
            ])
          : AppBar(title: const Text('Profile')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: _profileHeader,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: FutureBuilder<List<Review>>(
              future: widget.profile == null
                  ? reviewProvider.fetchPostsOfId(Id)
                  : reviewProvider.fetchPostsOfId(widget.profile!.id),
              builder: (_, reviewsSnapshot) {
                Widget child;
                if (reviewsSnapshot.hasError) {
                  child = Center(
                      child: Text(
                          "couldn't fetch porsts, check connection and retry"));
                } else if (reviewsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  child = const SizedBox(
                    height: 269,
                    child: Center(
                        child: CircularProgressIndicator(), key: ValueKey(0)),
                  );
                } else
                  // ignore: curly_braces_in_flow_control_structures
                  child = ReviewsList(reviewsSnapshot.data!, isLinked: false);

                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );

    return RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ProfileViewChild);
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///         sub-widgets
  ///
  ////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildProfileHeader(ProfileProvider profileProvider, String Id,
      double iconsSize, Color iconsColor) {
    return FutureBuilder<void>(
      key: UniqueKey(),
      future:
          widget.profile == null ? profileProvider.fetchProfileByID(Id) : null,
      builder: (_, profileSnapshot) {
        if (profileSnapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Center(
              child: Text(
                  "Couldn't load Profile Check your connection and refresh"),
            ),
          );
        } else if (profileSnapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator(key: ValueKey(0));
        } else {
          return ProfileHeader(
            profile: widget.profile == null
                ? profileProvider.viewedProfile
                : widget.profile,
            iconsSize: iconsSize,
            iconsColor: iconsColor,
          );
        }
      },
    );
  }
}
