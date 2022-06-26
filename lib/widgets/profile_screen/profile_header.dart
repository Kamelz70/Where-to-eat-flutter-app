import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import '../../helpers/common_functions.dart';
import '../../models/http_exception.dart';
import '../../models/profile.dart';
import '../../providers/auth.dart';
import '../../providers/profile_provider.dart';
import '../../screens/photo_viewer_screen.dart';

enum ProfileFollowState { FOLLOWED, UNFOLLOWED }

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
  late ProfileFollowState profileFollowState;
  ///////////////////////////////////////////////////////
  ///
  ///       Functions
  ///
  ////////////////////////////////////////////////
  _followProfile(BuildContext ctx, String id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<ProfileProvider>(ctx, listen: false).followProfile(id);
      setState(() {
        _isLoading = false;
        widget.profile.followersCount += 1;
        profileFollowState = ProfileFollowState.FOLLOWED;
      });
    } on HttpException catch (error) {
      CommonFunctions.showErrorDialog(ctx, error.toString());
      setState(() {
        _isLoading = false;
      });

      return;
    }
  }

  _unfollowProfile(BuildContext ctx, String id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<ProfileProvider>(ctx, listen: false)
          .unfollowProfile(id);
      setState(() {
        _isLoading = false;
        widget.profile.followersCount -= 1;
        profileFollowState = ProfileFollowState.UNFOLLOWED;
      });
    } on HttpException catch (error) {
      CommonFunctions.showErrorDialog(ctx, error.toString());
      setState(() {
        _isLoading = false;
      });
      return;
    }
  }

  _fetchProfile(BuildContext ctx, String id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      await Provider.of<ProfileProvider>(ctx, listen: false)
          .fetchProfileByID(id);

      profileFollowState == profileProvider.viewedProfile.isFollowed;
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      print(error.toString());
      profileFollowState = ProfileFollowState.UNFOLLOWED;
      setState(() {
        _isLoading = false;
      });
      return;
    }
  }

  Future<void> _takePicture(BuildContext context) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final picker = ImagePicker();

    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    File? _memoryStoredImage;
    _memoryStoredImage = File(imageFile.path);
    // // get the appdata directory
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // //name it with the base name
    // final fileName = path.basename(imageFile.path);
    // final savedImage =
    //     await _mfkn]emoryStoredImage.copy('${appDir.path}/$fileName');
    String url = await profileProvider.uploadAvatarImage(_memoryStoredImage);
    setState(() {
      widget.profile.imageUrl = url;
    });
  }

  void _openimageView(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewerScreen(
          galleryItemsUrls: [url],
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: 0,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////
  ///
  ///       Overrides
  ///
  ////////////////////////////////////////////////
  @override
  initState() {
    super.initState();
    // _fetchProfile(context, widget.profile.id);
    profileFollowState = widget.profile.isFollowed
        ? ProfileFollowState.FOLLOWED
        : ProfileFollowState.UNFOLLOWED;
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
              if (widget.profile.id == authProvider.userId)
                Positioned(
                  top: 0,
                  left: 65,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _takePicture(context);
                    },
                  ),
                ),
              CircleAvatar(
                radius: 70.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: InkWell(
                  onTap: () => _openimageView(context, widget.profile.imageUrl),
                  child: ClipOval(
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
                              color: Colors.white,
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
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(widget.profile.name, style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 10),
        if (widget.profile.id != authProvider.userId)
          ElevatedButton(
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white))
                : profileFollowState == ProfileFollowState.FOLLOWED
                    ? const Text('UnFollow')
                    : const Text('Follow'),
            onPressed: _isLoading
                ? () {}
                : profileFollowState == ProfileFollowState.FOLLOWED
                    ? () {
                        _unfollowProfile(context, widget.profile.id);
                      }
                    : () {
                        _followProfile(context, widget.profile.id);
                      },
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
