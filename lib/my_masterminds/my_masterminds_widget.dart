import 'package:flutter/material.dart';

import 'package:lifeschool/main.dart';
import 'package:lifeschool/models.dart';
import 'package:lifeschool/utils.dart';

class MyMastermindsWidget extends StatefulWidget {
  MyMastermindsWidget();

  @override
  MyMastermindsWidgetState createState() => MyMastermindsWidgetState();
}

class MyMastermindsWidgetState extends State<MyMastermindsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: ListView(children: [
        _buildTitle(),
        _buildEnrolledMasterminds(),
        _buildPastMasterminds(),
        getDivider(),
        // TODO: show more button
      ]),
    ));
  }

  Widget _buildTitle() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Masterminds',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto')));
  }

  List<Widget> _buildMastermindPresenter(List<Mastermind> masterminds) {
    List<Widget> _mastermindWidgets = masterminds
        .map((mastermind) => Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            child: Container(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Image.asset(
                    mastermind.imageUrls[0], // TODO: Replace with Mastermind Logo
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 12.0, bottom: 2.0, left: 16.0, right: 16.0),
                      child: Text(mastermind.title,
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto'))),
                  Container(
                      padding: EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
                      child: Text(mastermind.facilitator.name,
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.5,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto'))),
                ]))))
        .toList();

//    _mastermindWidgets = []; // TODO remove after network call
    if (_mastermindWidgets.length == 0) {
      _mastermindWidgets = [
        Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Text('No Enrolled Masterminds',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto'))),
          Container(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text('Start exploring masterminds that are right for you',
                  style: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: 16.0, fontFamily: 'Roboto'))),
          Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, ExploreRoute);
                  },
                  child: Container(
                      decoration: new BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Text('Explore Life School',
                          style: TextStyle(
                              color: Colors.blue,
                              letterSpacing: 0.5,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto')))))
        ]))
      ];
    }

    return _mastermindWidgets;
  }

  Widget _buildEnrolledMasterminds() {
    List<Widget> _mastermindWidgets = _buildMastermindPresenter([mockMasterminds[4]]);

    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('Masterminds You\'re Enrolled In',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto'))),
          ]..addAll(_mastermindWidgets),
        ));
  }

  Widget _buildPastMasterminds() {
    List<Widget> _mastermindWidgets = _buildMastermindPresenter([]);

    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text('Masterminds You\'ve Been In',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto')),
            )
          ]..addAll(_mastermindWidgets),
        ));
  }
}
