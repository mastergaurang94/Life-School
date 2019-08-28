import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:life_school/models.dart';

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
    return Card(
      color: Colors.indigoAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    return GestureDetector(
        child: Stack(
      alignment: Alignment.center, // TODO: experiment
      children: <Widget>[
        CarouselSlider(
          items: widget.mastermind.imageUrls.map((url) {
            return Image.asset(
              url,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            );
          }).toList(),
          aspectRatio: 1 / 1,
          viewportFraction: 1.0, // TODO: what does this really do?
          enableInfiniteScroll: false,
          onPageChanged: _updateImageIndex,
        ),
      ],
    ));
  }

  Widget _buildCardFacilitator() {
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

  Widget _buildCardLabels() {
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

  Widget _buildCardPricing() {
    return Text('\$' + widget.mastermind.price.toString() + '/hr');
  }

  // TODO: use mock reviews
  Widget _buildCardReviews() {
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
            : Icon(Icons.star, color: Colors.white);
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
