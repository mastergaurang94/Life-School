import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lifeschool/enroll/order_page_widget.dart';

import 'package:lifeschool/models.dart';
import 'package:lifeschool/utils.dart';

class DetailedMastermindWidget extends StatefulWidget {
  final Mastermind mastermind;

  DetailedMastermindWidget(this.mastermind);

  @override
  DetailedMastermindWidgetState createState() => DetailedMastermindWidgetState();
}

class DetailedMastermindWidgetState extends State<DetailedMastermindWidget> {
  int _currentImageIndex = 0;

  void _updateImageIndex(int index) {
    setState(() => _currentImageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            _buildImages(),
            _buildTitle(),
            _buildFacilitator(),
            _buildContactFacilitator(),
            _buildOverview(),
            _buildWhoFor(),
            _buildWhatYouGet(),
            _buildWhatYouLearn(),
            _buildStructure(),
            _buildReviews(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular((12.0))),
          color: Colors.blue,
        ),
        child: MaterialButton(
          height: 60.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderPageWidget(widget.mastermind)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(widget.mastermind.price > 1000 ? 'Apply Now' : 'Enroll',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800)),
          ),
        ),
      ),
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
          aspectRatio: 1.0,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          onPageChanged: _updateImageIndex,
          enlargeCenterPage: true,
        ),
        Positioned(
            top: 16.0,
            left: 16.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white, // TODO: what about white backgrounds?
                size: 32.0,
              ),
            )),
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
        padding: EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.mastermind.title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 24,
                ),
              )
            ]));
  }

  Widget _buildFacilitator() {
    return Container(
      padding: EdgeInsets.only(top: 24.0, left: 12.0, right: 8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 4.0),
              child: Text("Meet your Facilitator", style: getHeaderTextStyle()),
            ),
            Container(
                padding: EdgeInsets.only(top: 4.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 28.0,
                    backgroundImage: AssetImage(widget.mastermind.facilitator.imageUrl),
                  ),
                  title: Text(widget.mastermind.facilitator.name),
                  subtitle: Text(widget.mastermind.coverDescription),
                  isThreeLine: true,
                )),
          ]),
    );
  }

  Widget _buildContactFacilitator() {
    return Container(
        padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Divider(
            color: Colors.grey,
            height: 24.0,
          ),
          Text(
            'Questions about ' + widget.mastermind.facilitator.name + '\'s mastermind?',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16,
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Text('Contact facilitator',
                      style: TextStyle(
                          color: Colors.blue,
                          letterSpacing: 0.5,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto')))),
          Divider(
            color: Colors.grey,
            height: 24.0,
          )
        ]));
  }

  Widget _buildOverview() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "About this Mastermind",
              style: getHeaderTextStyle(),
            ),
            Container(padding: EdgeInsets.only(top: 8.0), child: Text(widget.mastermind.overview))
          ]),
    );
  }

  Widget _buildWhoFor() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Who This is For",
              style: getHeaderTextStyle(),
            ),
            Container(padding: EdgeInsets.only(top: 8.0), child: Text(widget.mastermind.whoThisFor))
          ]),
    );
  }

  Widget _buildWhatYouGet() {
    List<String> whatYouGet = generateWhatYouGet();

    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      margin: EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("What You'll Get", style: getHeaderTextStyle()),
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                color: Colors.blueGrey[50],
                child: Column(
                    children: List<Widget>.generate(whatYouGet.length, (int index) {
                  return Container(
                    padding: EdgeInsets.only(left: 6.0),
                      child: Row(children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    Padding(padding: EdgeInsets.only(left: 8.0)),
                    Text(whatYouGet[index]),
                  ]));
                })))
          ]),
    );
  }

  Widget _buildWhatYouLearn() {
    const cardSize = 275.0;
    const colorOptions = [Colors.red, Colors.orange, Colors.green, Colors.yellow, Colors.blue];

    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("What You'll Learn", style: getHeaderTextStyle()),
            ),
            Container(
              height: cardSize,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: colorOptions[index],
                      ),
                      margin: EdgeInsets.only(right: 8.0),
                      width: cardSize,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Text(
                          generateWhatYouLearn()[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      alignment: Alignment(-1.0, 1.0),
                    );
                  }),
            ),
          ]),
    );
  }

  // TODO: do we need a structure?
  Widget _buildStructure() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Mastermind Structure",
              style: getHeaderTextStyle(),
            ),
            Container(padding: EdgeInsets.only(top: 8.0), child: Text(widget.mastermind.whoThisFor))
          ]),
    );
  }

  // TODO: need to expand on reviews
  Widget _buildReviews() {
    final _reviews = widget.mastermind.reviews;
    final _reviewQuantity = _reviews.length;
    final _averageScore = (_reviews.map((r) => r.score).reduce((a, b) => a + b) / _reviewQuantity).round();

    var stars = Row(
      children: new List<Icon>.generate(5, (int index) {
        return (index + 1 <= _averageScore)
            ? Icon(Icons.star, color: Colors.yellow[500])
            : Icon(Icons.star, color: Colors.grey);
      }),
    );

    return Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('What People Are Saying', style: getHeaderTextStyle()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                stars,
                Text(_reviewQuantity.toString() + ' Reviews', style: getHeaderTextStyle()),
              ],
            ),
          ],
        ));
  }
}
