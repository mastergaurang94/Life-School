import 'package:flutter/material.dart';

class NotificationsWidget extends StatefulWidget {
  @override
  NotificationsWidgetState createState() {
    return new NotificationsWidgetState();
  }
}

class NotificationsWidgetState extends State<NotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications', style: TextStyle(fontFamily: 'Roboto')), centerTitle: false),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(32.0),
            child: Text(
              'At this time, notifications are not sent.\n\nThe option to manage them will be available soon here.',
              style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0)
            )
          ),
        ],
      ),
    );
  }
}
