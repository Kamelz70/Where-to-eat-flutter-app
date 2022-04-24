import 'package:flutter/material.dart';

import '../../models/profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.profile,
    required this.iconsSize,
    required this.iconsColor,
  }) : super(key: key);

  final Profile profile;
  final double iconsSize;
  final Color iconsColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                    profile.imageUrl,
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
        Text(profile.name, style: Theme.of(context).textTheme.headline2),
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
                    profile.followersCount.toString(),
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
                    profile.followingCount.toString(),
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
                  Icon(Icons.feed_rounded, size: iconsSize, color: iconsColor),
                  Text('Reviews'),
                  Text(
                    profile.reviewsCount.toString(),
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
      ],
    );
  }
}
