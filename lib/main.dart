// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lifeschool/home_widget.dart';
import 'package:lifeschool/auth/widgets/verify_email_widget.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new LifeSchoolApp());
  });
}

class LifeSchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life School',
      theme: ThemeData(
        primaryColor: Colors.white,
        canvasColor: Colors.white,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: SplashRoute,
    );
  }
}

const String SplashRoute = '/'; // TODO: replace with Splash screen
const String ExploreRoute = '/explore';
const String InboxRoute = '/inbox';
const String MastermindsRoute = '/masterminds';
const String ProfileRoute = '/profile';
const String LoginRoute = '/login';
const String OnboardingVerifyEmailRoute = '/onboarding/email';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.explore));
    case ExploreRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.explore));
    case InboxRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.inbox));
    case MastermindsRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.masterminds));
    case LoginRoute:
    case ProfileRoute:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.profile));
    case OnboardingVerifyEmailRoute:
      return MaterialPageRoute(builder: (context) => VerifyEmailWidget());
    default:
      return MaterialPageRoute(builder: (context) => HomeWidget(navItem: NavItem.explore));
  }
}
