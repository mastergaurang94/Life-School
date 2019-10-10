import 'package:flutter/material.dart';

import 'package:lifeschool/models.dart';
import 'package:lifeschool/enroll/order_confirmation_widget.dart';
import 'package:lifeschool/utils.dart';

class ReviewAndPayWidget extends StatefulWidget {
  final Mastermind mastermind;

  ReviewAndPayWidget(this.mastermind);

  @override
  ReviewAndPayWidgetState createState() => ReviewAndPayWidgetState();
}

class ReviewAndPayWidgetState extends State<ReviewAndPayWidget> {
  void _handleOnPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderConfirmationWidget(widget.mastermind)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28.0,
            )),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ListView(children: [
          _buildStepNumber(),
          _buildTitle(),
          _buildMastermindSummary(),
          getDivider(),
//           _buildPaymentSelection(),
          getDivider(),
          _buildFeesSummary(),
          getDivider(),
          _buildTermsDescription(),
        ]),
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
              child: Text('Confirm - \$234.00',
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

  Widget _buildStepNumber() {
    return Container(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text('Step 3 of 3',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontSize: 16.0,
                fontFamily: 'Roboto')));
  }

  Widget _buildTitle() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Review and Pay',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto')));
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
                'Start Date - Sept 18',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontSize: 18.0,
                    fontFamily: 'Roboto'),
              )),
        ]),
        Column(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage(widget.mastermind
                  .imageUrls[0]), // TODO: replace with Mastermind logo
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSelection() {}

  Widget _buildFeesSummary() {
    TextStyle _getTextStyle() =>
        TextStyle(letterSpacing: 0.5, fontSize: 18.0, fontFamily: 'Roboto');

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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mastermind Investment', style: _getTextStyle()),
                  Text('\$' + mastermindPrice.toStringAsFixed(2),
                      style: _getTextStyle()),
                ])),
        Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service Fee', style: _getTextStyle()),
                  Text('\$' + servicePrice.toStringAsFixed(2),
                      style: _getTextStyle()),
                ])),
        Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Taxes', style: _getTextStyle()),
                  Text('\$' + taxPrice.toStringAsFixed(2),
                      style: _getTextStyle()),
                ])),
        getDivider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total (USD)',
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
              )),
          Text('\$' + totalPrice.toStringAsFixed(2),
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
              )),
        ]),
      ],
    );
  }

  Widget _buildTermsDescription() {
    return Container(
      child: Text(
          'I agree to the Mastermind Rules, Cancellation Policy, and the Facilitator Refund Policy. I also agree to pay the total amount shown, which includes taxes and service fees.',
          style: TextStyle(
            letterSpacing: 0.5,
            fontSize: 18.0,
            fontFamily: 'Roboto',
          )),
    );
  }
}
