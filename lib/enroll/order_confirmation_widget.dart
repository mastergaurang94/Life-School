import 'package:flutter/material.dart';

import 'package:lifeschool/models.dart';
import 'package:lifeschool/my_masterminds/next_steps_widget.dart';

class OrderConfirmationWidget extends StatefulWidget {
  final Mastermind mastermind;

  OrderConfirmationWidget(this.mastermind);

  @override
  OrderConfirmationWidgetState createState() => OrderConfirmationWidgetState();
}

class OrderConfirmationWidgetState extends State<OrderConfirmationWidget> {
  void _handleOnPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextStepsWidget(widget.mastermind)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You\'re enrolled in ' + widget.mastermind.facilitator.name + '\'s mastermind!',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: 42.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.black,
          padding: EdgeInsets.all(24.0),
          child: MaterialButton(
              onPressed: () => _handleOnPressed(),
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text('See Next Steps',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontSize: 24.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800)))),
    );
  }
}
