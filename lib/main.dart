// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:life_school/home_feed_page.dart';
import 'package:life_school/mastermind_widget.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new LifeSchoolApp());
  });
}

class LifeSchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Life School',
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.blueGrey,
        ),
        home: MainScaffold());
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _tabSelectedIndex = 0;

  void _onTabTapped(BuildContext context, int index) {
    setState(() => _tabSelectedIndex = index);
  }

  Widget _buildBody() {
    return Center(
      child: HomeFeedPage(),
    );
  }

  Widget _buildBottomNavigation() {
    const selectedIcons = <IconData>[
      Icons.search,
      Icons.chat_bubble,
      Icons.person,
    ];
    const unselectedIcons = <IconData>[
      Icons.search,
      Icons.chat_bubble_outline,
      Icons.person_outline,
    ];
    final bottomNavigationItems = List.generate(3, (int i) {
      final iconData =
          _tabSelectedIndex == i ? selectedIcons[i] : unselectedIcons[i];
      return BottomNavigationBarItem(icon: Icon(iconData), title: Container());
    }).toList();

    return Builder(builder: (BuildContext context) {
      return BottomNavigationBar(
        iconSize: 32.0,
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationItems,
        currentIndex: _tabSelectedIndex,
        onTap: (int i) => _onTabTapped(context, i),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Life School'),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
