import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../providers/auth_provider.dart';

// ignore: constant_identifier_names
enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 69, 123, 129).withOpacity(0.5),
                  const Color.fromARGB(255, 210, 207, 142).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 94.0,
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.primary,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: const Text(
                        'MyShop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  var _isPasswordHidden = true;

  void handleEyePressed() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<Auth>(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        final resp = await authProvider.login(
          email: _authData['email']!,
          password: _authData['password']!,
        );
      } else {
        // Sign user up
        final resp = await authProvider.signup(
          email: _authData['email']!,
          password: _authData['password']!,
        );
        debugPrint('_submit resp: $resp');
      }
    } on HttpException catch (e) {
      handleHttpExceptionError(message: e.message);
    } catch (e) {
      debugPrint('e: $e');
      showSnackBar(
          message: 'Could\'t authenticate you. Could you try again later.');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void handleHttpExceptionError({required String message}) {
    debugPrint('message: $message');
    String errorMessage = 'Authentication failed';
    if (message.contains('EMAIL_EXISTS')) {
      errorMessage = 'Email is already in use.';
    }
    if (message.contains('INVALID_EMAIL')) {
      errorMessage = 'Email is not valid.';
    }
    if (message.contains('WEAK_PASSWORD')) {
      errorMessage = 'Password is too weak.';
    }
    if (message.contains('EMAIL_NOT_FOUND')) {
      errorMessage = 'Could not find that email.';
    }
    if (message.contains('INVALID_PASSWORD')) {
      errorMessage = 'Password is invalid.';
    }

    showCupertinoDialog(message: errorMessage);
  }

  Future<dynamic> showCupertinoDialog({required String message}) {
    return showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('Error!'),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Ok'))
            ],
          );
        });
  }

  void showSnackBar({required String message}) {
    final sb = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }

  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: const Offset(0, 0),
    ).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.easeOut));

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            height: _authMode == AuthMode.Signup ? 360 : 300,
            // height: _heightAnimation!.value.height,
            constraints: BoxConstraints(
              // minHeight: _heightAnimation!.value.height,
              minHeight: _authMode == AuthMode.Signup ? 360 : 300,
            ),
            width: deviceSize.width * 0.75,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'E-Mail'),
                        keyboardType: TextInputType.emailAddress,
                        initialValue: 'test@test.com',
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value!.trim();
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                handleEyePressed();
                              },
                              icon: Icon(_isPasswordHidden
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash),
                            )),
                        obscureText: _isPasswordHidden,
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['password'] = value!.trim();
                        },
                      ),
                      AnimatedContainer(
                        curve: Curves.easeOut,
                        constraints: BoxConstraints(
                          minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                          maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                        ),
                        duration: const Duration(milliseconds: 350),
                        child: FadeTransition(
                          opacity: _opacityAnimation!,
                          child: SlideTransition(
                            position: _slideAnimation!,
                            child: TextFormField(
                              enabled: _authMode == AuthMode.Signup,
                              decoration: const InputDecoration(
                                  labelText: 'Confirm Password'),
                              obscureText: _isPasswordHidden,
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match!';
                                      }
                                      return null;
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        RaisedButton(
                          onPressed: _submit,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text(_authMode == AuthMode.Login
                              ? 'LOGIN'
                              : 'SIGN UP'),
                        ),
                      FlatButton(
                        onPressed: _switchAuthMode,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                            '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
