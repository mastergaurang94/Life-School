import 'package:flutter/material.dart';

import 'package:lifeschool/explore/mastermind_widget.dart';
import 'package:lifeschool/models.dart';

class ExploreFeedWidget extends StatefulWidget {
  final ScrollController pageController;

  ExploreFeedWidget({this.pageController});

  @override
  _ExploreFeedWidgetState createState() => _ExploreFeedWidgetState();
}

class _ExploreFeedWidgetState extends State<ExploreFeedWidget> {
  final _masterminds = mockMasterminds;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, position) {
                    if (position == 0) {
                      return Container(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(_masterminds.length.toString() + '+ masterminds to join!',
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto')));
                    }

                    int listIndex = position - 1;
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: MastermindWidget(_masterminds[listIndex]));
                  },
                  itemCount: _masterminds.length + 1,
                  scrollDirection: Axis.vertical,
                  controller: widget.pageController))
        ]));
  }
}

// TODO: widget for search bar
