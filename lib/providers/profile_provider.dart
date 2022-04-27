import 'package:flutter/material.dart';

import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _viewedProfile;

  get viewedProfile {
    return _viewedProfile;
  }

  Future<void> fetchProfileByID(String id) async {
    await Future.delayed(Duration(seconds: 1));
    print('Fetxhing profile');
    if (id == 'me')
      _viewedProfile = Profile(
          id: id,
          name: 'Mohamed Kamel',
          imageUrl: 'dd',
          followersCount: 20,
          followingCount: 10,
          reviewsCount: 10);
    else
      _viewedProfile = Profile(
          id: id,
          name: 'Ahmed Ali',
          imageUrl: 'dd',
          followersCount: 24,
          followingCount: 60,
          reviewsCount: 5);
  }
}
