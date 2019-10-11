import 'dart:async';

import 'package:lifeschool/auth/login_bloc.dart';
import 'package:lifeschool/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  @override
  SignUpWidgetState createState() {
    return new SignUpWidgetState();
  }
}

class SignUpWidgetState extends State<SignUpWidget> {
  final LoginBloc _bloc = Injector().loginBloc;
  LoginState _loginState = LoginState.IDLE;
  StreamSubscription _loginTypeSubscription, _loginStateSubscription;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final _firstNameNode = FocusNode();
  final _lastNameNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _loginStateSubscription = _bloc.loginState.listen((loginState) => setState(() => _loginState = loginState));
  }

  @override
  void dispose() {
    _loginTypeSubscription?.cancel();
    _loginStateSubscription?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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
                child: ListView(children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto'))),
                  TextFormField(
                    focusNode: _firstNameNode,
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person, color: _firstNameNode.hasFocus ? Colors.black : Colors.grey),
                        labelText: 'First Name',
                        labelStyle: TextStyle(color: _firstNameNode.hasFocus ? Colors.black : Colors.grey)),
                    autocorrect: false,
                    validator: (String value) => _bloc.validateName(value),
                  ),
                  TextFormField(
                    focusNode: _lastNameNode,
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person, color: _lastNameNode.hasFocus ? Colors.black : Colors.grey),
                        labelText: 'Last Name',
                        labelStyle: TextStyle(color: _lastNameNode.hasFocus ? Colors.black : Colors.grey)),
                    autocorrect: false,
                    validator: (String value) => _bloc.validateName(value),
                  ),
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
                  TextFormField(
                    focusNode: _passwordNode,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: _passwordNode.hasFocus ? Colors.black : Colors.grey),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: _passwordNode.hasFocus ? Colors.black : Colors.grey)),
                    obscureText: true,
                    autovalidate: _autoValidate,
                    autocorrect: false,
                    validator: (String value) => _bloc.validatePassword(value),
                  ),
                  TextFormField(
                    focusNode: _confirmPasswordNode,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: _confirmPasswordNode.hasFocus ? Colors.black : Colors.grey),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: _confirmPasswordNode.hasFocus ? Colors.black : Colors.grey)),
                    obscureText: true,
                    autovalidate: _autoValidate,
                    autocorrect: false,
                    validator: (String value) => _bloc.validateConfirmPassword(value, _passwordController.value.text),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        _createAccountButton(),
                      ])),
                ]))));
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty;

  bool get isCreateAccountButtonEnabled => _loginState != LoginState.LOADING && isPopulated;

  Widget _createAccountButton() {
    if (_loginState == LoginState.LOADING) {
      return RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(child: CircularProgressIndicator()),
          color: Colors.blue);
    } else if (_loginState == LoginState.SUCCESS) {
      return Icon(Icons.check, color: Colors.blue, size: 36.0);
    }

    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () {
        final form = _formKey.currentState;
        form.save();
        if (form.validate() && isCreateAccountButtonEnabled) {
          _bloc.handleSignUpPressed(context, _emailController.text, _passwordController.text,
              _confirmPasswordController.text, _firstNameController.text, _lastNameController.text);
        } else {
          setState(() => _autoValidate = true);
        }
      },
      child: Text('CREATE ACCOUNT', style: TextStyle(color: Colors.white)),
      color: Colors.blue,
    );
  }
}
