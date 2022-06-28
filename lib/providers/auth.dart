import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_to_eat/models/http_exception.dart';

import '../helpers/mongo_errors.dart';

/////////////////////////////////////////////////////////////////////////////////
///
///
/// create user:  https://grad-projj.herokuapp.com/users
/// Login:        https://grad-projj.herokuapp.com/users/login
/// Loguot:       https://grad-projj.herokuapp.com/users/logout
///
///
///
///
///
///
///
///
///
///
class Auth with ChangeNotifier {
  //token for comm. with server, expires!!!
  String? _token;
  String? _userId;
  String? _userName;
  bool get isAuth {
    //return token != null;
    //the following isn't correct
    return _token != null;
  }

  String? get token {
    return _token;
  }

  String? get userId {
    return _userId;
    //_userId;
  }

  String? get userName {
    return _userName;
  }

  Future<void> signUp(String email, String password, String accountName) async {
    print('Signing up with email:$email and pass $password');

    // , String phone
    ///////////////////////////////////////////////////
    String urlString = 'https://grad-projj.herokuapp.com/users';
    final url = Uri.parse(urlString);
    print(json
        .encode({'email': email, 'password': password, 'name': accountName}));
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, String>{
            "email": email,
            "password": password,
            "name": accountName
          }));
      print('Sending Request');
      final reponseData = json.decode(response.body);
      print('Reciewd Request:');

      print(reponseData);
      print('End of Request:');

      if (reponseData['errors'] != null ||
          reponseData['name'] == 'MongoError') {
        throw HttpException(MongoErrors.getMongoErrorMessage(reponseData));
      }

      notifyListeners();

      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logInWithEmail(String email, String password) async {
    print('Logging in with email:$email and pass $password');

    const String urlString = 'https://grad-projj.herokuapp.com/users/login';
    final url = Uri.parse(urlString);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {'email': email, 'password': password},
        ),
      );

      print(response.statusCode);
      final reponseData = json.decode(response.body);
      print(reponseData);
      if (reponseData['errors'] != null ||
          reponseData['name'] == 'MongoError' ||
          response.statusCode == 400) {
        throw HttpException(MongoErrors.getMongoErrorMessage(reponseData));
      }

      _token = reponseData['token'];
      _userId = reponseData['user']['_id'];
      _userName = reponseData['user']['name'];
      notifyListeners();
      print("saving token: $_token");
      print("saving userId: $_userId");
      print("saving userName: $_userName");

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'userName': _userName,
      });

      prefs.setString('userData', userData);

      return;
    } catch (error) {
      rethrow;
    }
  }

  void logout() async {
    print('logging out');
    String urlString = 'https://grad-projj.herokuapp.com/users/logout';
    final url = Uri.parse(urlString);
    try {
      print('token is $_token');
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(
            {'token': _token},
          ),
        );
        final reponseData = json.decode(response.body);
        print(reponseData);
      } catch (error) {
        print('error: $error');
      }

      // if (reponseData['error'] != null) {
      //   throw HttpException(reponseData['name']);
      // }

      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');
      _token = null;
      _userId = null;
      _userName = null;

      notifyListeners();

      return;
    } catch (error) {
      rethrow;
    }
  }

  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer!.cancel();
  //   }
  //   final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData') as String)
        as Map<String, Object>;
    // final extExpiryDate =
    //     DateTime.parse(extractedUserData['expiryDate'] as String);
    // if (extExpiryDate.isBefore(DateTime.now())) {
    //   return false;
    // }
    //    {'token': _token, 'userId': _userId, 'expiryDate': _expiryDate});

    _token = extractedUserData['token'] as String?;
    _userId = extractedUserData['userId'] as String?;
    _userName = extractedUserData['userName'] as String?;
    print('userId is $_userId');
    notifyListeners();
    return true;
  }
}
