import 'package:flutter/material.dart';

import 'package:lifeschool/home_widget.dart';
import 'package:lifeschool/models.dart';

class NextStepsWidget extends StatefulWidget {
  final Mastermind mastermind;

  NextStepsWidget(this.mastermind);

  @override
  NextStepsWidgetState createState() => NextStepsWidgetState();
}

class NextStepsWidgetState extends State<NextStepsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.masterminds)),
                  (Route<dynamic> route) => false);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: 28.0,
            )),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTitle(),
            _buildNextSteps(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Next steps from your facilitator',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto')));
  }

  Widget _buildNextSteps() {
    List<String> mockNextSteps = ['Join this WhatsApp Group', 'Add this event to Calendar', 'Join this Facebook Group'];

    List<Widget> nextStepsWidgets = mockNextSteps
        .map((String action) => Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Step #' + (mockNextSteps.indexOf(action) + 1).toString() + ': ' + action,
                  style: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: 16.0, fontFamily: 'Roboto')),
            ))
        .toList();

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text('You are on your way but first a few must-do\'s: ',
              style: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: 16.0, fontFamily: 'Roboto')),
        ),
      ]..addAll(nextStepsWidgets),
    ));
  }
}
