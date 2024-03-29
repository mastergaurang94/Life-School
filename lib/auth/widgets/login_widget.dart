import 'dart:async';

import 'package:lifeschool/auth/login_bloc.dart';
import 'package:lifeschool/auth/widgets/forgot_password_widget.dart';
import 'package:lifeschool/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() {
    return new LoginWidgetState();
  }
}

class LoginWidgetState extends State<LoginWidget> {
  final LoginBloc _bloc = Injector().loginBloc;
  LoginState _loginState = LoginState.IDLE;
  StreamSubscription _loginTypeSubscription, _loginStateSubscription;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          Container(padding: EdgeInsets.only(right: 16.0), alignment: Alignment.center, child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordWidget()));
            },
            child: Text('Forgot Password?', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
          )),
        ]),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: ListView(children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Log In',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontSize: 32.0,
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
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        _loginButton(),
                      ])),
                ]))));
  }

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool get isCreateAccountButtonEnabled => _loginState != LoginState.LOADING && isPopulated;

  Widget _loginButton() {
    if (_loginState == LoginState.LOADING) {
      return Container(
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.grey
          ),
          child: Container(alignment: Alignment.center, child: CircularProgressIndicator()));
    } else if (_loginState == LoginState.SUCCESS) {
      return Icon(Icons.check, color: Colors.blue, size: 36.0);
    }

    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () async {
        final form = _formKey.currentState;
        form.save();
        if (form.validate() && isCreateAccountButtonEnabled) {
          try {
            await _bloc.handleLoginPressed(context, _emailController.text, _passwordController.text);
          } catch (e) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Failed to login'),
                      content: Text(
                          'Please retry using your correct username and password or contact support if you have trouble logging in.'),
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
      child: Text('LOG IN', style: TextStyle(color: Colors.white)),
      color: Colors.blue,
    );
  }
}
