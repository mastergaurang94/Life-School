// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lifeschool/home_widget.dart';

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
      title: 'Life School',
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.blueGrey,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );
  }
}

const String HomeRoute = '/';
const String ExploreRoute = '/explore';
const String InboxRoute = '/inbox';
const String MastermindsRoute = '/masterminds';
const String ProfileRoute = '/profile';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.explore));
    case ExploreRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.explore));
    case InboxRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.inbox));
    case MastermindsRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.masterminds));
    case ProfileRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.profile));
  }
}