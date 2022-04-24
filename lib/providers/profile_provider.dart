import 'package:flutter/material.dart';

import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _myProfile;

  get myProfile {
    return _myProfile;
  }

  Future<void> fetchmyProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    _myProfile = Profile(
        id: 'myId',
        name: 'Mohamed Kamel',
        imageUrl: 'dd',
        followersCount: 20,
        followingCount: 10,
        reviewsCount: 10);
    notifyListeners();
  }

  Future<Profile> fetchProfileByID(String id) async {
    await Future.delayed(Duration(seconds: 1));
    if (id == 'me')
      return Profile(
          id: id,
          name: 'Mohamed Kamel',
          imageUrl: 'dd',
          followersCount: 20,
          followingCount: 10,
          reviewsCount: 10);
    else
      return Profile(
          id: id,
          name: 'Ahmed Ali',
          imageUrl: 'dd',
          followersCount: 24,
          followingCount: 60,
          reviewsCount: 5);
  }
}
