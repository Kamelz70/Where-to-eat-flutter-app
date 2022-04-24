import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/Screens/tabs_screen.dart';
import 'package:where_to_eat/models/http_exception.dart';

import '../providers/auth.dart';

//enum for authentication state
enum AuthMode { Signup, LoginWithMail, LoginWithMobile }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCard(),
    );
  }
}

//////////////////////////////////////////////////////////
///
/// Main Widget
///
//////////////////////////////////////////////////////////
class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  //////////////////////////////////////////////////////////
  ///
  /// Variables and constants
  ///
  //////////////////////////////////////////////////////////
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.LoginWithMail;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    'phone': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  //////////////////////////////////////////////////////////
  ///
  /// Functions
  ///
  //////////////////////////////////////////////////////////

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Okay')),
          ],
        ),
      );
    }

    final authenticationProvider = Provider.of<Auth>(context, listen: false);
    try {
      switch (_authMode) {
        case AuthMode.LoginWithMobile:
          print('LoginWithMobile');
          break;
        case AuthMode.LoginWithMail:
          await authenticationProvider.logInWithEmail(
              _authData['email']!, _authData['password']!);
          break;
        case AuthMode.Signup:
          await authenticationProvider.signUp(
            _authData['email']!,
            _authData['password']!,
            _authData['name']!,
            _authData['phone']!,
          );
          break;
      }
    }
    //check error type
    on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Email already exists';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Not a valid Email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Password too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = "Can't find Email";
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "Invalid Pasword";
      }
      _showErrorDialog(errorMessage);
    }
    //on any other error type
    catch (error) {
      var errorMessage = 'Error Reaching Server';
      _showErrorDialog(errorMessage);

      print(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _setAuthMode(AuthMode mode) {
    setState(() {
      _authMode = mode;
    });
  }

  //////////////////////////////////////////////////////////
  ///
  /// Build Method
  ///
  //////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                _authMode == AuthMode.Signup
                    ? 'Create An Account'
                    : ' Welcome to \n Where to eat ?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (_authMode != AuthMode.Signup)
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(
                _authMode != AuthMode.LoginWithMail
                    ? 'Enter Phone No.\n\nOr'
                    : 'Enter E-mail and Password\n\nOr',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (_authMode != AuthMode.Signup)
            TextButton(
              child: Text(
                _authMode == AuthMode.LoginWithMail
                    ? 'Login With Phone'
                    : 'Login With Email',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                //signup screen
                if (_authMode == AuthMode.LoginWithMail) {
                  _setAuthMode(AuthMode.LoginWithMobile);
                } else {
                  _setAuthMode(AuthMode.LoginWithMail);
                }
                switch (_authMode) {
                  case AuthMode.LoginWithMobile:
                    print('setting auth mode to LoginWithMobile');
                    break;
                  case AuthMode.LoginWithMail:
                    print('setting auth mode to LoginWithMail');
                    break;
                  case AuthMode.Signup:
                    print('setting auth mode to Signup');
                    break;
                }
              },
            ),
          if (_authMode == AuthMode.Signup)
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Account Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _authData['name'] = value as String;
              },
            ),
          if (_authMode == AuthMode.LoginWithMail ||
              _authMode == AuthMode.Signup)
            TextFormField(
              key: UniqueKey(),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return 'invalid E-mail Address';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value!;
              },
              keyboardType: TextInputType.emailAddress,
            ),
          if (_authMode == AuthMode.LoginWithMail ||
              _authMode == AuthMode.Signup)
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.password),
              ),
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Password is too short!';
                }
              },
              onSaved: (value) {
                _authData['password'] = value!;
              },
            ),
          if (_authMode == AuthMode.Signup)
            TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match!';
                  }
                }),
          if (_authMode != AuthMode.LoginWithMail)
            InternationalPhoneNumberInput(
              onInputChanged: (number) {
                print(number);
              },
              keyboardType: TextInputType.phone,
              spaceBetweenSelectorAndTextField: 6,
              validator: (value) {
                if (value!.length < 10) {
                  return 'Phone too short';
                }
              },
              onSaved: (number) {
                _authData['phone'] = number.toString();
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password?',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: Text(
                  _authMode == AuthMode.Signup ? 'Signup' : 'Login',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                onPressed: () {
                  _submit();
                },
              )),
          Row(
            children: <Widget>[
              TextButton(
                child: Text(
                  _authMode == AuthMode.Signup ? 'Login' : 'Signup',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  //signup screen
                  if (_authMode == AuthMode.Signup) {
                    _setAuthMode(AuthMode.LoginWithMail);
                  } else {
                    _setAuthMode(AuthMode.Signup);
                  }
                  switch (_authMode) {
                    case AuthMode.LoginWithMobile:
                      print('setting auth mode to LoginWithMobile');
                      break;
                    case AuthMode.LoginWithMail:
                      print('setting auth mode to LoginWithMail');
                      break;
                    case AuthMode.Signup:
                      print('setting auth mode to Signup');
                      break;
                  }
                },
              ),
              const Text('instead'),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
