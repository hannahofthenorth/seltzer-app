import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    String firstName,
    String lastName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(this.isLoading, this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

//TODO: add controllers to navigate between fields easier
class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _username = '';
  var _userPassword = '';
  var _userFirstName = '';
  var _userLastName = '';
  bool _isInAsyncCall = false;
  bool _isUniqueUsername = true;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    // setState(() {
    //   _isInAsyncCall = true;
    // });

    // final match = Firestore.instance
    //     .collection('users')
    //     .where('username', isGreaterThanOrEqualTo: _username)
    //     .where('username', isLessThan: _username + 'z')
    //     .getDocuments();
    // match.then((QuerySnapshot querySnapshot) {
    //   if (querySnapshot.documents.length != 0) {
    //     print(_isUniqueUsername);
    //     _isUniqueUsername = !_isUniqueUsername;
    //     print(_isUniqueUsername);
    //   }
    // });

    // setState(() {
    //   _isInAsyncCall = false;
    // });

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _username.trim(),
        _userFirstName.trim(),
        _userLastName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin)
                    Center(
                      child:
                          Text('Please fill out the fields below to sign up!'),
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter your email address',
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter an email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters for your username';
                        }
                        bool isUnique = true;

                        var myFuture = Future(() {
                          final match = Firestore.instance
                              .collection('users')
                              .where('username', isGreaterThanOrEqualTo: value)
                              .where('username', isLessThan: value + 'z')
                              .getDocuments();
                          match.then((QuerySnapshot querySnapshot) {
                            if (querySnapshot.documents.length != 0) {
                              isUnique = !isUnique;
                            }
                          });
                          return isUnique;
                        });
                        myFuture.then((result) {
                          print('myFuture.then result');
                          print(result);
                          if (!result) {
                            print('username in use');
                            return 'Username in use';
                          }
                          return null;
                        });
                        // print('check');
                        // print(isUnique);
                        // if (!_isUniqueUsername) {
                        //   print('!isUniqueUsername?????????');
                        //   _isUniqueUsername = true;
                        //   return 'Username in use';
                        // }

                        // if (_isUniqueUsername) {
                        //   print('unique username');
                        //   return 'Username is unique';
                        // }
                        // return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter a username'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('firstName'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 2) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userFirstName = value;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter your first name'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('lastName'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 1) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userLastName = value;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter your last name'),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    decoration: InputDecoration(labelText: 'Enter a password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Sign me up!'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'I already have an account',
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
