import 'dart:async';

import 'package:lifeschool/auth/login_bloc.dart';
import 'package:lifeschool/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

enum Gender { Male, Female, Other }

String getGender(Gender value) => value.toString().split('.').last;

class PersonalInfoWidget extends StatefulWidget {
  @override
  PersonalInfoWidgetState createState() {
    return new PersonalInfoWidgetState();
  }
}

class PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  final LoginBloc _bloc = Injector().loginBloc;
  LoginState _loginState = LoginState.IDLE;
  StreamSubscription _loginStateSubscription;

  // TODO: make dynamic initial values
  final _emailController = TextEditingController(text: 'mastergaurang94@gmail.com');
  final _firstNameController = TextEditingController(text: 'Gaurang');
  final _lastNameController = TextEditingController(text: 'Patel');
  final _genderController = TextEditingController(text: getGender(Gender.Male));
  int _gender = Gender.Male.index;

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
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0.0, actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.0),
            child: InkWell(
              child: Text(
                'Save',
                style:
                    TextStyle(fontFamily: 'Roboto', fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              onTap: () {
                // save the data
                // use Futures to show the CircularProgressIndicator: https://stackoverflow.com/questions/47065098/how-to-work-with-progress-indicator-in-flutter
              },
            ),
          ),
        ]),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: ListView(children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text('Edit personal info',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto'))),
                  Container(
                    padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('First Name', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _firstNameController,
                          autocorrect: false,
                          validator: (String value) => _bloc.validateName(value),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last Name', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _lastNameController,
                          autocorrect: false,
                          validator: (String value) => _bloc.validateName(value),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gender', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold)),
                        TextField(
                          controller: _genderController,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder: (context, setState) {
                                  return Dialog(
                                    child: Container(
                                      height: 250.0,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Container(padding: EdgeInsets.all(20.0), child: Text('Gender')),
                                        Container(
                                          child: RadioListTile(
                                            title: Text(getGender(Gender.Male)),
                                            value: Gender.Male.index,
                                            groupValue: _gender,
                                            onChanged: (genderIndex) {
                                              _handleGenderSelected(genderIndex, setState);
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: RadioListTile(
                                            title: Text(getGender(Gender.Female)),
                                            value: Gender.Female.index,
                                            groupValue: _gender,
                                            onChanged: (genderIndex) {
                                              _handleGenderSelected(genderIndex, setState);
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: RadioListTile(
                                            title: Text(getGender(Gender.Other)),
                                            value: Gender.Other.index,
                                            groupValue: _gender,
                                            onChanged: (genderIndex) {
                                              _handleGenderSelected(genderIndex, setState);
                                            },
                                          ),
                                        ),
                                      ]),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _emailController,
                          autocorrect: _autoValidate,
                          validator: (String value) => _bloc.validateEmail(value),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [])),
                ]))));
  }

  void _handleGenderSelected(int genderIndex, setState) {
    setState(() {
      _gender = genderIndex;
      List<Gender> genders = Gender.values;
      _genderController.text = getGender(genders[genderIndex]);
    });
  }
}
