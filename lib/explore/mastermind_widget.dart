import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lifeschool/explore/detailed_mastermind_widget.dart';

import 'package:lifeschool/models.dart';
import 'package:lifeschool/utils.dart';

class MastermindWidget extends StatefulWidget {
  final Mastermind mastermind;

  MastermindWidget(this.mastermind);

  @override
  MastermindWidgetState createState() => MastermindWidgetState();
}

class MastermindWidgetState extends State<MastermindWidget> {
  int _currentImageIndex = 0;

  void _updateImageIndex(int index) {
    setState(() => _currentImageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    void _handleOnTap() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailedMastermindWidget(widget.mastermind)),
      );
    }

    return InkWell(
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImages(),
              _buildLabels(),
              _buildTitle(),
              _buildFacilitator(),
              _buildPricing(),
              _buildReviews(),
              Padding(padding: EdgeInsets.only(bottom: 16.0))
            ],
          ),
        ),
      ),
      onTap: _handleOnTap,
    );
  }

  Widget _buildImages() {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          items: widget.mastermind.imageUrls.map((url) {
            return Hero(
                tag: 'mastermind_carousel_' + url.toString(), // TODO: animate widget to work across screens
                child: Image.asset(
                  url,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                ));
          }).toList(),
          aspectRatio: 1.1,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          onPageChanged: _updateImageIndex,
          enlargeCenterPage: true,
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            constraints: BoxConstraints.expand(width: double.infinity, height: 40),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: utilsMap<Widget>(widget.mastermind.imageUrls, (index, url) {
              return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: _currentImageIndex == index ? Colors.white : Colors.white70));
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
        padding: EdgeInsets.only(top: 4.0, left: 12.0, right: 12.0),
        child: Text(widget.mastermind.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16,
            )));
  }

  Widget _buildFacilitator() {
    return Container(
        padding: EdgeInsets.only(top: 4.0, left: 12.0, right: 12.0),
        child: Text('Facilitated by ' + widget.mastermind.facilitator.name,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16,
            )));
  }

  Widget _buildLabels() {
    String labels = widget.mastermind.labels.join(' • '); // TODO: resolve bug with 'one time 4 days' missing dot

    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
      child: Text(labels.toUpperCase(),
          style: TextStyle(color: Colors.blue, fontFamily: 'Roboto', letterSpacing: 0.5, fontSize: 12)),
    );
  }

  // TODO: show total pricing
  Widget _buildPricing() {
    return Container(
        padding: EdgeInsets.only(top: 4.0, left: 12.0, right: 12.0),
        child: Text(
          '\$' + widget.mastermind.price.toString() + '/hr',
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto', letterSpacing: 0.5, fontSize: 16),
        ));
  }

  Widget _buildReviews() {
    final _reviews = widget.mastermind.reviews;
    final _reviewQuantity = _reviews.length;
    final _averageScore = (_reviews.map((r) => r.score).reduce((a, b) => a + b) / _reviewQuantity).round();

    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Icon>.generate(5, (int index) {
        return (index + 1 <= _averageScore)
            ? Icon(Icons.star, size: 16.0, color: Colors.yellow[500])
            : Icon(Icons.star, size: 16.0, color: Colors.grey);
      }),
    );

    final ratings = Container(
      padding: EdgeInsets.only(top: 4.0, left: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          stars,
          Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                _reviewQuantity.toString() + ' Reviews',
                style: TextStyle(color: Colors.black, fontFamily: 'Roboto', letterSpacing: 0.5, fontSize: 16),
              )),
        ],
      ),
    );

    return ratings;
  }
}
