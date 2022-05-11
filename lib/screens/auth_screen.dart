import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
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
    return const Scaffold(
      body: const AuthCard(),
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
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay')),
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
          );
          setState(() {
            _authMode = AuthMode.LoginWithMail;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "SignedUp, Now Tryout Your First Login",
              textAlign: TextAlign.center,
            ),
          ));
          break;
      }
    }
    //check error type
    on HttpException catch (error) {
      _showErrorDialog(error.toString());
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
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      _authMode == AuthMode.Signup
                          ? 'Create An Account'
                          : ' Welcome to \n Where to eat ?',
                      style: const TextStyle(
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
                      style: const TextStyle(
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
                      style: const TextStyle(fontSize: 15),
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
                      if (value!.isEmpty || value.length < 7) {
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
                    selectorConfig: const SelectorConfig(
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
                        style:
                            const TextStyle(fontSize: 17, color: Colors.white),
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
                        style: const TextStyle(fontSize: 15),
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
