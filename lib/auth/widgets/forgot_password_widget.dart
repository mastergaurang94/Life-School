import 'dart:async';

import 'package:lifeschool/auth/usecase/get_auth_route.dart';
import 'package:lifeschool/injection/dependency_injection.dart';
import 'package:lifeschool/auth/login_bloc.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatefulWidget {
  @override
  ForgotPasswordWidgetState createState() => ForgotPasswordWidgetState();
}

class ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final LoginBloc _bloc = Injector().loginBloc;
  final GetAuthRoute _getAuthRoute = Injector().getAuthRoute;
  LoginState _loginState = LoginState.IDLE;
  StreamSubscription _loginStateSubscription;

  final _emailController = TextEditingController();
  final _emailNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _loginStateSubscription = _bloc.loginState.listen((loginState) => setState(() => _loginState = loginState));
  }

  @override
  void dispose() {
    _loginStateSubscription?.cancel();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Forgot your password?',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto'))),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Text('Enter your email to find your account.',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto'))),
                  TextFormField(
                    focusNode: _emailNode,
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email, color: _emailNode.hasFocus ? Colors.black : Colors.grey),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: _emailNode.hasFocus ? Colors.black : Colors.grey)),
                    autovalidate: _autoValidate,
                    autocorrect: false,
                    validator: (String value) => _bloc.validateEmail(value),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        _forgotPasswordButton(),
                ]))
                ]))));
  }

  Widget _forgotPasswordButton() {
    if (_loginState == LoginState.LOADING) {
      return Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey
          ),
          child: Container(alignment: Alignment.center, child: CircularProgressIndicator()));
    }

    return RaisedButton(
      child: Text('SEND EMAIL', style: TextStyle(color: Colors.white)),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () async {
        final form = _formKey.currentState;
        if (form.validate()) {
          try {
            await _bloc.handleForgotPasswordPressed(context, _emailController.text);
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Password Reset Email Sent'),
                      content: Text(
                          'An email has been sent to the specified email with reset instructions. Please check all your folders including junk or spam.'),
                      actions: <Widget>[
                        RaisedButton(
                          child: Text('Go back to Log In', style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            final route = await _getAuthRoute.getAuthRouteName();
                            Navigator.of(context).pushReplacementNamed(route);
                          },
                        ),
                      ],
                    ));
          } catch (e) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Failed to send password reset email'),
                      content: Text('Please ensure you entered the correct email. Otherwise, contact support.'),
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
        } else {
          setState(() => _autoValidate = true);
        }
      },
    );
  }
}
