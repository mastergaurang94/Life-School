import 'package:lifeschool/auth/usecase/get_auth_route.dart';
import 'package:lifeschool/injection/dependency_injection.dart';
import 'package:lifeschool/auth/login_bloc.dart';
import 'package:flutter/material.dart';

class VerifyEmailWidget extends StatelessWidget {
  final LoginBloc _bloc = Injector().loginBloc;
  final GetAuthRoute _getAuthRoute = Injector().getAuthRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
            child: Column(children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Check Your Email',
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.5,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto'))),
              Container(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        size: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40, top: 8, bottom: 8),
                        child: FutureBuilder<String>(
                            future: _bloc.getUser(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                final email = snapshot.data;
                                return RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(style: Theme.of(context).textTheme.body1, children: [
                                    TextSpan(text: "We've sent you an email at "),
                                    TextSpan(text: email, style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: ". Please check your inbox and follow the link to verify your account.")
                                  ]),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () async {
                          final route = await _getAuthRoute.getAuthRouteName(); // Updates user object
                          if (route != "/onboarding/email") {
                            Navigator.of(context).pushReplacementNamed(route);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Email not verified'),
                                      content:
                                          Text('Please check your inbox and follow the link to verify your account.'),
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
                        child: Text("I've verified it!", style: TextStyle(color: Colors.white)),
                        color: Colors.blue,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () async {
                          try {
                            _bloc.sendEmailVerification();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Email Verification Sent'),
                                      content: Text("Please check your phone for the code."),
                                      actions: <Widget>[
                                        RaisedButton(
                                          child: Text('OK', style: TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ));
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Problem sending email'),
                                      content: Text('Please try again later.'),
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
                        child: Text("Send email again."),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Woops"),
                                    content: Text(
                                        "It happens to the best of us. We'll delete this account, and you can create another."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("No, go back"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      RaisedButton(
                                        child: Text(
                                          "Sounds great!",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          _bloc.handleDeleteUser();
                                          final route = await _getAuthRoute.getAuthRouteName(); // Updates user object
                                          if (route != "/onboarding/email") {
                                            Navigator.of(context).pushReplacementNamed(route);
                                          }
                                        },
                                      )
                                    ],
                                  ));
                        },
                        child: Text("...I entered the wrong email."),
                      ),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
