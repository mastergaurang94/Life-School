import 'package:flutter/material.dart';

import 'package:life_school/mastermind_widget.dart';
import 'package:life_school/models.dart';

class HomeFeedPage extends StatefulWidget {
  final ScrollController pageController;

  HomeFeedPage({this.pageController});

  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  final _masterminds = mockMasterminds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) => MastermindWidget(_masterminds[position]),
      itemCount: _masterminds.length,
      scrollDirection: Axis.vertical,
      controller: widget.pageController
    );
  }
}

// TODO: widget for search bar