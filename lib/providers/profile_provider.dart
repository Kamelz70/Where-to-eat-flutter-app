import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/mongo_errors.dart';
import '../models/http_exception.dart';
import '../models/profile.dart';

// ignore: constant_identifier_names
const UNFOLLOW_API = 'https://grad-projj.herokuapp.com/users/unfollow';
const GET_PROFILE_API = 'https://grad-projj.herokuapp.com/users/account';

class ProfileProvider with ChangeNotifier {
  Profile? _viewedProfile;
  final String _authToken;

  ProfileProvider(
    this._authToken,
  );

  get viewedProfile {
    return _viewedProfile;
  }

  Future<void> fetchProfileByID(String id) async {
    final url = Uri.parse('$GET_PROFILE_API/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_authToken',
        },
      );
      print('fetching profile');
      print(id);
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw HttpException('Fetching profile Failed');
      }
      final responseData = json.decode(response.body);
      print(responseData);
      _viewedProfile = Profile(
          id: responseData['_id'],
          name: responseData['name'],
          imageUrl: 'null', //????????????,
          followersCount: responseData['followersNum'],
          followingCount: responseData['followingNum'],
          reviewsCount: 0, //????????????,
          isFollowed: responseData['IsFollowed']);
    } catch (error) {
      // ignore: avoid_print
      print('errorrrrrrrrrrrrrrrrrrrrr');

      print(error);
      rethrow;
    }
  }

  Future<void> followProfile(String id) async {
    final url = Uri.parse('https://grad-projj.herokuapp.com/users/follow');

    try {
      final response = await http.patch(
        url,
        encoding: Encoding.getByName("UTF-8"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_authToken',
        },
        body: json.encode(
          {
            '_id': id,
          },
        ),
      );
      print('follow sent');
      final responseData = response.body;
      print(response.statusCode);
      print(responseData);

      if (response.statusCode != 200 && response.statusCode != 400) {
        throw HttpException('Follow Failed');
      }
    } catch (error) {
      // ignore: avoid_print
      print(error);
      rethrow;
    }
  }

  Future<void> unfollowProfile(String id) async {
    final url = Uri.parse(UNFOLLOW_API);

    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_authToken',
        },
        body: json.encode(
          {
            '_id': id,
          },
        ),
      );
      print('unfollow sent');
      final responseData = response.body;

      print(response.statusCode);
      print(responseData);

      if (response.statusCode != 200 && response.statusCode != 400) {
        throw HttpException('Unfollow Failed');
      }
    } catch (error) {
      print('error: $error');
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
            isFollowed: profile['IsFollowed']));
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
