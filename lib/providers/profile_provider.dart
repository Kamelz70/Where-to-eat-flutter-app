import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helpers/mongo_errors.dart';
import '../models/http_exception.dart';
import '../models/profile.dart';

// ignore: constant_identifier_names
const UNFOLLOW_API = 'https://grad-projj.herokuapp.com/users/unfollow';
const GET_PROFILE_API = 'https://grad-projj.herokuapp.com/users/account';
const UPLOAD_AVATAR_API = 'https://grad-projj.herokuapp.com/avatar';

class ProfileProvider with ChangeNotifier {
  Profile? _viewedProfile;
  final String _authToken;

  ProfileProvider(
    this._authToken,
  );

  get viewedProfile {
    return _viewedProfile;
  }

  Future<String> uploadAvatarImage(File file) async {
    final url = Uri.parse(UPLOAD_AVATAR_API);

    var request = http.MultipartRequest("POST", url);
    //add text fields
    // request.fields["text_field"] = text;
    request.headers["Authorization"] = 'Bearer $_authToken';
    request.headers["Content-Type"] = 'application/json; charset=UTF-8';
    request.fields["Avatar"] = '';
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("upload", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.bytesToString();
    ;
    print(responseData);
    return responseData;
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
          id: responseData['user']['_id'],
          name: responseData['user']['name'],
          imageUrl: responseData['user']['avatar'] == null
              ? ''
              : responseData['user']['avatar'], //????????????,
          followersCount: responseData['user']['followersNum'],
          followingCount: responseData['user']['followingNum'],
          reviewsCount: responseData['user']['ReviewsNum'], //????????????,
          isFollowed: responseData['user']['IsFollowed']);
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

      if (response.statusCode != 200 && response.statusCode != 404) {
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
      print(response.statusCode);

      if (response.statusCode != 200 && response.statusCode != 500) {
        ///////////////////////make it 404
        throw HttpException("Couldn't search profiles");
      }
      final responseData = json.decode(response.body);
      if (responseData.isEmpty) {
        //return empty list of users indicating none are found
        print('empty');

        return [];
      }
      print(responseData);
      List<Profile> profilesList = [];
      responseData.forEach((profile) {
        print('follow state:${profile['IsFollowed']}');
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
