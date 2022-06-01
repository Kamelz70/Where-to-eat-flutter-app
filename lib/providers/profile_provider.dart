import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/mongo_errors.dart';
import '../models/http_exception.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _viewedProfile;
  final String _authToken;

  ProfileProvider(this._authToken);

  get viewedProfile {
    return _viewedProfile;
  }

  Future<void> fetchProfileByID(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    print('Fetxhing profile');
    if (id == 'me') {
      _viewedProfile = Profile(
          id: id,
          name: 'Mohamed Kamel',
          imageUrl: 'dd',
          followersCount: 20,
          followingCount: 10,
          reviewsCount: 10);
    } else {
      _viewedProfile = Profile(
          id: id,
          name: 'Ahmed Ali',
          imageUrl: 'dd',
          followersCount: 24,
          followingCount: 60,
          reviewsCount: 5);
    }
  }

  Future<void> followProfile(String id) async {
    final url = Uri.parse('https://grad-projj.herokuapp.com/users/follow');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            '_id': id,
            'token': _authToken,
          },
        ),
      );
      print('follow sent');
      final responseData = json.decode(response.body);
      print(responseData);

      if (responseData['error'] != null) {
        throw HttpException(MongoErrors.getMongoErrorMessage(responseData));
      }
    } catch (error) {
      // ignore: avoid_print
      print(error);
      rethrow;
    }
  }

  Future<List<Profile>> searchByName(String searchTerm) async {
    final url =
        Uri.parse('https://grad-projj.herokuapp.com/users/search/$searchTerm');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('fetching profiles');
      final responseData = json.decode(response.body);
      print(responseData);
      List<Profile> profilesList = [];
      responseData.forEach((profile) {
        profilesList.add(Profile(
          id: profile["_id"],
          name: profile["name"],
          imageUrl: 'null',
          followersCount: profile['followersNum'],
          followingCount: profile['followingNum'],
          reviewsCount: profile['Reviews'].length,
        ));
      });

      return profilesList;
    } catch (error) {
      // ignore: avoid_print
      print(error);
      throw error;
    }
    return [];
  }
}
