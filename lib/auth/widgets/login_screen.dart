import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifeschool/auth/login_bloc.dart';
import 'package:lifeschool/auth/widgets/login_widget.dart';
import 'package:lifeschool/auth/widgets/sign_up_widget.dart';
import 'package:lifeschool/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final LoginBloc _bloc = Injector().loginBloc;
  LoginState _loginState = LoginState.IDLE;
  StreamSubscription _loginTypeSubscription, _loginStateSubscription;

  @override
  void initState() {
    super.initState();
    _loginStateSubscription = _bloc.loginState.listen((loginState) => setState(() => _loginState = loginState));
  }

  @override
  void dispose() {
    _loginTypeSubscription?.cancel();
    _loginStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: ListView(children: [
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.school, size: 100), // TODO: real Life School logo
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'Sign in to get started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Text(
                'By tapping continue, log in, or create an account, I agree to Life School\'s Terms of Service, Payment Terms of Service, Privacy Policy, and Nondiscrimination Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[1000],
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _facebookLoginButton(context),
                _googleLoginButton(context),
              ]),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _createAccountButton(context),
                _loginButton(context),
              ]),
            )
          ]),
        ),
      ),
    );
  }

  Widget _loginButton(context) {
    return RaisedButton(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginWidget()),
        );
      },
      child: Text('LOG IN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
      color: Colors.white,
    );
  }

  Widget _createAccountButton(context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpWidget()),
        );
      },
      child: Text('CREATE AN ACCOUNT', style: TextStyle(color: Colors.white)),
      color: Colors.blue,
    );
  }

  Widget _googleLoginButton(context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () async {
        try {
          await _bloc.handleGoogleLoginPressed(context);
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Failed to continue with Google'),
                    content: Text('Please retry or try again later.'),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text('OK', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
        }
      },
      label: Text('CONTINUE WITH GOOGLE', style: TextStyle(color: Colors.white)),
      color: Colors.redAccent,
    );
  }

  Widget _facebookLoginButton(context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.facebook, color: Colors.blueAccent),
      onPressed: () async {
        try {
          await _bloc.handleFacebookLoginPressed(context);
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Failed to continue with Facebook'),
                    content: Text('Please retry or try again later.'),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text('OK', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
        }
      },
      label: Text('CONTINUE WITH FACEBOOK', style: TextStyle(color: Colors.grey[800])),
      color: Colors.white,
    );
  }
}
