import 'package:flutter/material.dart';
import 'package:lifeschool/profile/widgets/contact_support_widget.dart';
import 'package:lifeschool/profile/widgets/notifications_widget.dart';
import 'package:lifeschool/profile/widgets/personal_information_widget.dart';
import 'package:lifeschool/profile/widgets/public_profile_screen_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return new ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0, bottom: 8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    CircleAvatar(
                      radius: 32.0,
                      backgroundImage: AssetImage('assets/panache_desai.jpg'),
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mark Stewart',
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(2.0)),
                        InkWell(
                          child: Text(
                            'View Profile',
                            style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0, color: Colors.blueAccent),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PublicProfileScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('ACCOUNT SETTINGS',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0, color: Colors.grey)),
                    Padding(padding: EdgeInsets.all(8.0)),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(right: 2.0, top: 4.0, bottom: 4.0),
                        width: double.infinity,
                        child: Text('Personal Information', style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonalInfoWidget()),
                        );
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 24.0,
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(right: 2.0, top: 4.0, bottom: 4.0),
                        width: double.infinity,
                        child: Text('Payments and Payouts', style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0)),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 24.0,
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(right: 2.0, top: 4.0, bottom: 4.0),
                        width: double.infinity,
                        child: Text('Notifications', style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationsWidget()),
                        );
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 24.0,
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    InkWell(
                      child:
                          Text('SUPPORT', style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0, color: Colors.grey)),
                      onTap: () {},
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(right: 2.0, bottom: 4.0),
                        width: double.infinity,
                        child: Text('Contact Support', style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactSupportWidget()),
                        );
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 24.0,
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    InkWell(
                      child: Text('LEGAL', style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0, color: Colors.grey)),
                      onTap: () {},
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(right: 2.0, bottom: 4.0),
                        width: double.infinity,
                        child: Text('Terms of Service', style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0)),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 24.0,
                    ),
                    Padding(padding: EdgeInsets.all(12.0)),
                    InkWell(
                      child: Text('LOG OUT',
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0, color: Colors.blueAccent)),
                      onTap: () {

                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Divider(
                      color: Colors.grey,
                      height: 24.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
