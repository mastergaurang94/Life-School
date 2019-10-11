import 'package:flutter/material.dart';
import 'package:lifeschool/enroll/contact_facilitator_widget.dart';

import 'package:lifeschool/models.dart';
import 'package:lifeschool/utils.dart';

class OrderPageWidget extends StatefulWidget {
  final Mastermind mastermind;

  OrderPageWidget(this.mastermind);

  @override
  OrderPageWidgetState createState() => OrderPageWidgetState();
}

class OrderPageWidgetState extends State<OrderPageWidget> {
  void _handleOnPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactFacilitatorWidget(widget.mastermind)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: 28.0,
            )),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildMastermindSummary(),
            getDivider(),
            _buildWhatYouGet(),
            // _buildDates(), // TODO: include starting dates + timer for urgency
            _buildFeesSummary(),
            getDivider(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: MaterialButton(
            onPressed: () => _handleOnPressed(),
            child: Container(
              child: Text('Enroll',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800)),
            ),
          ),
        ),
      ),
    );
  }

  int _getAverageScore() {
    final _reviews = widget.mastermind.reviews;
    final _reviewQuantity = _reviews.length;
    return (_reviews.map((r) => r.score).reduce((a, b) => a + b) / _reviewQuantity).round();
  }

  Widget _buildMastermindSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(children: [
          Text(widget.mastermind.facilitator.name + '\'s Mastermind',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 0.5,
                fontSize: 16.0,
                fontFamily: 'Roboto',
              )),
          Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '\$' + widget.mastermind.price.toInt().toString() + ' Total',
                style: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: 18.0, fontFamily: 'Roboto'),
              )),
          Container(
            child: Row(
              children: [
                Row(
                  children: List<Icon>.generate(5, (int index) {
                    return (index + 1 <= _getAverageScore())
                        ? Icon(Icons.star, color: Colors.yellow[500], size: 16.0)
                        : Icon(Icons.star, color: Colors.grey, size: 16.0);
                  }),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.mastermind.reviews.length.toString() + ' Reviews',
                    style: TextStyle(color: Colors.grey, letterSpacing: 0.5, fontSize: 16.0, fontFamily: 'Roboto'),
                  ),
                ),
              ],
            ),
          ),
        ]),
        Column(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage(widget.mastermind.imageUrls[0]), // TODO: replace with Mastermind logo
            ),
          ],
        ),
      ],
    );
  }

  // TODO: create separate attribute for order page what you'll get
  Widget _buildWhatYouGet() {
    List<String> whatYouGet = generateWhatYouGet();

    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text("What You'll Get", style: getHeaderTextStyle()),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 4.0),
//                color: Colors.blueGrey[50],
            child: Column(
                children: List<Widget>.generate(whatYouGet.length, (int index) {
              return Row(children: <Widget>[
                Icon(Icons.check, color: Colors.green, size: 28.0),
                Padding(padding: EdgeInsets.only(left: 16.0)),
                Flexible(
                    child: Text(whatYouGet[index],
                        style: TextStyle(letterSpacing: 0.5, fontSize: 18.0, fontFamily: 'Roboto'))),
              ]);
            }))),
        getDivider()
      ]),
    );
  }

  Widget _buildFeesSummary() {
    TextStyle _getTextStyle() => TextStyle(letterSpacing: 0.5, fontSize: 18.0, fontFamily: 'Roboto');

    double mastermindPrice = widget.mastermind.price;
    double servicePrice = widget.mastermind.price * .1;
    double taxPrice = widget.mastermind.price * 0.07;
    double totalPrice = mastermindPrice + servicePrice + taxPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FEE & TAX DETAILS',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              letterSpacing: 0.5,
              fontFamily: 'Roboto',
            )),
        Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Mastermind Investment', style: _getTextStyle()),
              Text('\$' + mastermindPrice.toInt().toString(), style: _getTextStyle()),
            ])),
        Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Service Fee', style: _getTextStyle()),
              Text('\$' + servicePrice.toInt().toString(), style: _getTextStyle()),
            ])),
        Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Taxes', style: _getTextStyle()),
              Text('\$' + taxPrice.toInt().toString(), style: _getTextStyle()),
            ])),
        getDivider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total (USD)', style: _getTextStyle()),
          Text('\$' + totalPrice.toInt().toString(), style: _getTextStyle()),
        ]),
      ],
    );
  }
}
