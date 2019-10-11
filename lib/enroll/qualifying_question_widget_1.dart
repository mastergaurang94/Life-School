import 'package:flutter/material.dart';

import 'package:lifeschool/models.dart';
import 'package:lifeschool/utils.dart';

import 'package:lifeschool/enroll/review_and_pay_widget.dart';

class QualifyingQuestionWidget extends StatefulWidget {
  final Mastermind mastermind;

  QualifyingQuestionWidget(this.mastermind);

  @override
  QualifyingQuestionWidgetState createState() => QualifyingQuestionWidgetState();
}

class QualifyingQuestionWidgetState extends State<QualifyingQuestionWidget> {
  void _handleOnPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewAndPayWidget(widget.mastermind)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28.0,
            )),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ListView(children: [
          _buildStepNumber(),
          _buildTitle(),
          _buildSubtitle(),
          getDivider(),
          _buildBody(),
          getDivider(),
        ]),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('\$' + (widget.mastermind.price * 1.17).toStringAsFixed(2) + ' Total',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700)),
              MaterialButton(
                  onPressed: () => _handleOnPressed(),
                  color: Colors.blue,
                  clipBehavior: Clip.antiAlias,
                  minWidth: 150.0,
                  child: Text('Next',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700)))
            ],
          )),
    );
  }

  Widget _buildStepNumber() {
    return Container(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text('Step 2 of 3',
            style: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: 16.0, fontFamily: 'Roboto')));
  }

  Widget _buildTitle() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(widget.mastermind.facilitator.name + ' wants to know...',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto')));
  }

  Widget _buildSubtitle() {
    return Container(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('What industry are you in and what do you or your business do?',
            style: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: 18.0, fontFamily: 'Roboto')));
  }

  // TODO: Text validation + error message pop-up if no text entered
  Widget _buildBody() {
    return Container(
        constraints: BoxConstraints.expand(height: 304),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write message here.',
            hintStyle: TextStyle(color: Colors.grey, letterSpacing: 0.5, fontSize: 18.0, fontFamily: 'Roboto'),
          ),
          style: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: 18.0, fontFamily: 'Roboto'),
        ));
  }
}
