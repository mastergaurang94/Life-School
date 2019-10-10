import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:lifeschool/models.dart';
import 'package:lifeschool/utils.dart';
import 'package:lifeschool/enroll/order_page_widget.dart';

class MastermindDetailWidget extends StatefulWidget {
  final Mastermind mastermind;

  MastermindDetailWidget(this.mastermind);

  @override
  MastermindDetailWidgetState createState() => MastermindDetailWidgetState();
}

class MastermindDetailWidgetState extends State<MastermindDetailWidget> {
  int _currentImageIndex = 0;

  void _updateImageIndex(int index) {
    setState(() => _currentImageIndex = index);
  }

  void _handleOnPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderPageWidget(widget.mastermind)),
    );
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
            Divider(
              color: Colors.grey,
              height: 32.0,
              endIndent: 16.0,
              indent: 16.0
            ),
            _buildContactFacilitator(),
            Divider(
                color: Colors.grey,
                height: 16.0,
                endIndent: 16.0,
                indent: 16.0
            ),
            _buildOverview(),
            _buildWhoFor(),
            _buildWhatYouGet(),
            _buildWhatYouLearn(),
            _buildStructure(),
            // _buildProgressBar(),
            _buildReviews(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular((12.0))),
          color: Colors.blue,
        ),
        child: MaterialButton(
          onPressed: () => _handleOnPressed(),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Text(generateCallToActionString(widget.mastermind.price),
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
            return Hero(
                tag: 'mastermind_carousel_' + url.toString(),
                child: Image.asset(
                  url,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                ));
          }).toList(),
          aspectRatio: 0.9,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          onPageChanged: _updateImageIndex,
          enlargeCenterPage: true,
        ),
        Positioned(
            top: 24.0,
            left: 16.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 28.0,
              ),
            )),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                utilsMap<Widget>(widget.mastermind.imageUrls, (index, url) {
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

  Widget _buildTitle() {
    return Container(
        padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: Text(widget.mastermind.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 24.0,
            )));
  }

  Widget _buildFacilitator() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Meet your Facilitator",
              style: getHeaderTextStyle(),
            ),
            Container(
                child: ListTile(
              leading: CircleAvatar(
                radius: 28.0,
                backgroundImage:
                    AssetImage(widget.mastermind.facilitator.imageUrl),
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
      padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Questions about ' + widget.mastermind.facilitator.name + '\'s mastermind?',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16,
            )
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
          GestureDetector(
              onTap: () {
                // Go to Inbox
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                width: 380,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text('Contact facilitator',
                  style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 0.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto'))
              )
          )
        ]
      )
    );
  }

  Widget _buildOverview() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "About this Mastermind",
              style: getHeaderTextStyle(),
            ),
            Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.mastermind.overview))
          ]),
    );
  }

  Widget _buildWhoFor() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Who This is For",
              style: getHeaderTextStyle(),
            ),
            Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.mastermind.whoThisFor))
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
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("What You'll Get", style: getHeaderTextStyle()),
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                color: Colors.blueGrey[50],
                child: Column(
                    children:
                        List<Widget>.generate(whatYouGet.length, (int index) {
                  return Row(children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    Padding(padding: EdgeInsets.only(left: 8.0)),
                    Text(whatYouGet[index]),
                  ]);
                })))
          ]),
    );
  }

  Widget _buildWhatYouLearn() {
    const cardSize = 275.0;
    const colorOptions = [
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.yellow,
      Colors.blue
    ];

    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
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
                        padding:
                            const EdgeInsets.only(left: 12.0, bottom: 16.0),
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
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Mastermind Structure",
              style: getHeaderTextStyle(),
            ),
            Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.mastermind.whoThisFor))
          ]),
    );
  }

  // TODO: need to expand on reviews
  Widget _buildReviews() {
    final _reviews = widget.mastermind.reviews;
    final _reviewQuantity = _reviews.length;
    final _averageScore =
        (_reviews.map((r) => r.score).reduce((a, b) => a + b) / _reviewQuantity)
            .round();

    var stars = Row(
      children: List<Icon>.generate(5, (int index) {
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
              child:
                  Text('What People Are Saying', style: getHeaderTextStyle()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                stars,
                Text(_reviewQuantity.toString() + ' Reviews',
                    style: getHeaderTextStyle()),
              ],
            ),
          ],
        ));
  }
}
