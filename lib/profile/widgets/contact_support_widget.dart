import 'package:flutter/material.dart';

class ContactSupportWidget extends StatefulWidget {
  @override
  ContactSupportWidgetState createState() {
    return new ContactSupportWidgetState();
  }
}

class ContactSupportWidgetState extends State<ContactSupportWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Support', style: TextStyle(fontFamily: 'Roboto')), centerTitle: false),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(32.0),
              child: Text(
                  'We\'re always working to improve the Life School experience, and given that we are in a private beta release stage, we would love to hear what\'s working and how we can do better.\n\nAt this time, you can contact the founder directly at his personal e-mail: mastergaurang94@gmail.com.',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0)
              )
          ),
        ],
      ),
    );
  }
}
