import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:life_school/detailed_mastermind_widget.dart';

import 'package:life_school/models.dart';
import 'package:life_school/utils.dart';

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
    void _handleOnTap () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailedMastermindWidget(widget.mastermind)),
      );
    }

    return InkWell(
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImages(),
            _buildFacilitator(),
            _buildLabels(),
            _buildPricing(),
            _buildReviews(),
          ],
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
            return Image.asset(
              url,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: utilsMap<Widget>(widget.mastermind.imageUrls, (index, url) {
              return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == index
                          ? Colors.white
                          : Colors.white70));
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFacilitator() {
    return ListTile(
      leading: CircleAvatar(
        radius: 28.0,
        backgroundImage: AssetImage(widget.mastermind.facilitator.imageUrl),
      ),
      title: Text(widget.mastermind.facilitator.name),
      subtitle: Text(widget.mastermind.coverDescription),
      isThreeLine: true,
    );
  }

  Widget _buildLabels() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          new List<Chip>.generate(widget.mastermind.labels.length, (int index) {
        return Chip(
          label: Text(widget.mastermind.labels[index]),
        );
      }),
    );
  }

  Widget _buildPricing() {
    return Text(
      '\$' + widget.mastermind.price.toString() + '/hr',
      style: getHeaderTextStyle(),
    );
  }

  Widget _buildReviews() {
    final _reviews = widget.mastermind.reviews;
    final _reviewQuantity = _reviews.length;
    final _averageScore =
        (_reviews.map((r) => r.score).reduce((a, b) => a + b) / _reviewQuantity)
            .round();

    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: new List<Icon>.generate(5, (int index) {
        return (index + 1 <= _averageScore)
            ? Icon(Icons.star, color: Colors.yellow[500])
            : Icon(Icons.star, color: Colors.grey);
      }),
    );

    final ratings = Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          Text(
            _reviewQuantity.toString() + ' Reviews',
            style: getHeaderTextStyle(),
          ),
        ],
      ),
    );

    return ratings;
  }
}
