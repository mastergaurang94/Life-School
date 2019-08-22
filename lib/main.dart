// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(LifeSchoolApp());

class LifeSchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Life School',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Life School'),
        ),
        body: Center(
          child: MastermindWidget(),
        ),
      ),
    );
  }
}

class MastermindWidget extends StatefulWidget {
  @override
  MastermindWidgetState createState() => MastermindWidgetState();
}

class MastermindWidgetState extends State<MastermindWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, position) => _buildMastermindCard(),
      itemCount: 10,
      scrollDirection: Axis.vertical,
    );
  }

  Widget _buildMastermindCard() {
    return Container(
      color: Colors.orangeAccent,
      child: Column(
        children: [
          _buildCardImages(),
          _buildCardFacilitator(),
          _buildCardLabels(),
          _buildCardPricing(),
          _buildCardReviews(),
        ],
      ),
    );
  }

  // FOR NOW: just add images that already have text overlayed on them
  Widget _buildCardImages() {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/panache.png',
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget _buildCardFacilitator() {
    return ListTile(
      leading: FlutterLogo(size: 72.0),
      title: Text('Panache Desai'),
      subtitle: Text(
        'Panache has never before worked so closely and intensely with such a small group of experienced practitioners.'
      ),
      isThreeLine: true,
    );
  }

  Widget _buildCardLabels() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          label: Text('Virtual'),
        ),
        Chip(
          label: Text('Weekly'),
        ),
        Chip(
          label: Text('3 months'),
        ),
        Chip(
          label: Text('12 People'),
        )
      ],
    );
  }

  Widget _buildCardPricing() {
    return Text('\$200/hr');
  }

  Widget _buildCardReviews() {
    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.yellow[500]),
        Icon(Icons.star, color: Colors.yellow[500]),
        Icon(Icons.star, color: Colors.yellow[500]),
        Icon(Icons.star, color: Colors.white),
        Icon(Icons.star, color: Colors.white),
      ],
    );

    final ratings = Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          Text(
            '170 Reviews',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );

    return ratings;
  }
}