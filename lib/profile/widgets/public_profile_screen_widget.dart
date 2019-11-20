import 'package:flutter/material.dart';
import 'package:lifeschool/models.dart';

class PublicProfileScreen extends StatefulWidget {
  @override
  PublicProfileScreenState createState() {
    return new PublicProfileScreenState();
  }
}

class PublicProfileScreenState extends State<PublicProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 32.0,
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'assets/panache_desai.jpg',
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/panache_desai.jpg'))),
                ),
              ),
              Padding(padding: EdgeInsets.all(6.0)),
              Text(
                'Mark Stewart',
                style: TextStyle(fontFamily: 'Roboto', fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Text(
                'San Jose, CA',
                style: TextStyle(fontFamily: 'Roboto', color: Colors.grey),
              ),
              Container(
                padding: EdgeInsets.all(2.0),
                width: 80.0,
                child: Card(
                  elevation: 4.0,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('4.5 ', style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0, fontWeight: FontWeight.bold)),
                    Icon(Icons.star, color: Colors.blue),
                  ]),
                ),
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              Divider(
                color: Colors.grey,
                height: 24.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child:
                    Text('About', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              Container(
                // TODO: add see more button
                padding: EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                    'Mark is passionate about health and fitness, relationships, and business. He is looking to expand his understanding of personal finances.',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0)),
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              Divider(
                color: Colors.grey,
                height: 24.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text('Hosted Masterminds',
                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              buildImages(),
              buildInfoDetail(),
              buildImages(),
              buildInfoDetail(),
              Padding(padding: EdgeInsets.all(4.0)),
              Divider(
                color: Colors.grey,
                height: 24.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text('Masterminds Enrolled In',
                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              buildImages(),
              buildInfoDetail(),
              buildImages(),
              buildInfoDetail(),
              Padding(padding: EdgeInsets.all(4.0)),
              Divider(
                color: Colors.grey,
                height: 24.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                    'Reviews from Students & Hosts', // TODO: add separate reviews for host / students to differentiate
                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              _buildReviews(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    final _reviews = generateMockReviews();
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
      padding: EdgeInsets.only(top: 4.0, left: 20.0, right: 20.0),
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

    // TODO: add button to see more reviews

    return ratings;
  }

  Widget buildImages() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: Container(
          height: 200.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(image: AssetImage('assets/will3.png'), fit: BoxFit.cover))),
    );
  }

  Widget buildInfoDetail() {
    return Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Maldives - 12 Days',
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto', fontSize: 15.0),
              ),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    'Teresa Soto',
                    style: TextStyle(color: Colors.grey.shade700, fontFamily: 'Roboto', fontSize: 11.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '3 Videos',
                    style: TextStyle(color: Colors.grey.shade500, fontFamily: 'Roboto', fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
