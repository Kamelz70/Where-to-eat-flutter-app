import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/common_functions.dart';
import '../../models/http_exception.dart';
import '../../models/profile.dart';
import '../../providers/auth.dart';
import '../../providers/profile_provider.dart';

class ProfileHeader extends StatefulWidget {
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
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool _isLoading = false;
  _followProfile(BuildContext ctx, String id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<ProfileProvider>(ctx, listen: false).followProfile(id);
    } on HttpException catch (error) {
      CommonFunctions.showErrorDialog(ctx, error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Image.network(
                  /////image here
                  widget.profile.imageUrl,
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
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(widget.profile.name, style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 10),
        if (widget.profile.id != authProvider.userId)
          _isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: const Text('Follow'),
                  onPressed: () => _followProfile(context, widget.profile.id),
                ),
        Divider(thickness: 3, color: Colors.grey.shade200),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person_outline_rounded,
                      size: widget.iconsSize, color: widget.iconsColor),
                  const Text('Followers'),
                  Text(
                    widget.profile.followersCount.toString(),
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
                      size: widget.iconsSize, color: widget.iconsColor),
                  const Text('Following'),
                  Text(
                    widget.profile.followingCount.toString(),
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
                      size: widget.iconsSize, color: widget.iconsColor),
                  const Text('Reviews'),
                  Text(
                    widget.profile.reviewsCount.toString(),
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
