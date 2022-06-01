import 'package:flutter/material.dart';

import '../../Screens/profile_screen.dart';
import '../../models/profile.dart';

class ProfileSearchList extends StatelessWidget {
  final List<Profile> ResultList;

  const ProfileSearchList(
    this.ResultList,
  );

  @override
  Widget build(BuildContext context) {
    if (ResultList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return ProfileSearchItem(ResultList[index]);
          },
          itemCount: ResultList.length),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
///
///
///
///   Sub Widgets
///
///
///
///////////////////////////////////////////////////////////////////////////
class ProfileSearchItem extends StatelessWidget {
  ///////////////////////////////////////////////////////////////////
  ///
  ///           Vars and consts
  final Profile currentItem;

  const ProfileSearchItem(this.currentItem);
  ///////////////////////////////////////////////////////////////////
  ///
  ///           Functions

  //select meal tap function handler
  void _selectProfile(BuildContext context, Profile profile) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileScreen(profile: profile),
      ),
    );
  }
///////////////////////////////////////////////////////////////////
  ///
  ///           Build

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7,
      child: InkWell(
        onTap: () => _selectProfile(context, currentItem),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListTile(
            leading: ClipRRect(
              // ignore: prefer_const_constructors
              borderRadius: BorderRadius.all(
                const Radius.circular(15),
              ),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Image.network(
                  /////image here
                  currentItem.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, as, asd) {
                    return Icon(Icons.person,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimary);
                  },
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    /////////////////title
                    currentItem.name,
                    style: Theme.of(context).textTheme.headline4,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.feed_outlined,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 3),
                        Text('Reviews: ${currentItem.reviewsCount}'),
                        const SizedBox(width: 3),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person_outline_rounded,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 3),
                        Text('Followers: ${currentItem.followersCount}'),
                        const SizedBox(width: 3),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    /////////////////rating
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
