import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dart:math';

class Mastermind {
  List<String> imageUrls;
  final Facilitator facilitator;
  String coverDescription;
  List<String> labels; // todo: set
  double price;
  List<Review> reviews;
  String overview;
  String whoThisFor;

  Mastermind(
      {@required this.imageUrls,
      @required this.facilitator,
      @required this.coverDescription,
      @required this.labels,
      @required this.price,
      @required this.overview,
      @required this.whoThisFor,
      this.reviews});
}

class Facilitator {
  final String name;

  final String imageUrl;
  final List<Mastermind> masterminds;

  const Facilitator({
    @required this.name,
    this.imageUrl,
    this.masterminds = const <Mastermind>[],
  });
}

class Student {
  final String name;
  final String imageUrl;

  const Student({
    @required this.name,
    this.imageUrl,
  });
}

class Review {
  final Student student;
  int score;
  double description;

  Review({@required this.student, @required this.score, this.description});
}

// Mock Data
const panacheDesai =
    Facilitator(name: 'Panache Desai', imageUrl: 'assets/panache_desai.jpg');
const robertKiyosaki = Facilitator(
    name: 'Robert Kiyosaki', imageUrl: 'assets/robert_kiyosaki.jpg');
const tonyRobbins =
    Facilitator(name: 'Tony Robbins', imageUrl: 'assets/tony_robbins.jpg');
const willSmith =
    Facilitator(name: 'Will Smith', imageUrl: 'assets/will_smith.jpeg');
const shaunWhite =
    Facilitator(name: 'Shaun White', imageUrl: 'assets/shaun_white.jpg');

const gaurangPatel = Student(name: 'Gaurang Patel');
const anandPanchal = Student(name: 'Anand Panchal');
const harshilPatel = Student(name: 'Harshil Patel');
const ramuVelu = Student(name: 'Ramu Velu');

const students = [gaurangPatel, anandPanchal, harshilPatel, ramuVelu];

// TODO: add to mastermind model
const Set<String> whatYouGet = {
  'Exclusive Weekly Content and Strategies',
  'Group Facilitator Guidance',
  'Personal 1:1 Facilitator Guidance',
  'Private Support Community',
  'Mentorship from Expert Guest Speakers',
  'Interactive Weekly Conference Calls',
  'Access to Live Events',
};

const Set<String> whatYouLearn = {
  'Goal Setting',
  'Life Mastery',
  'Emotional Fitness',
  'Relationship Communication',
  'Connecting with Who You Are',
  'Single Family Home Real Estate',
  'Budgeting',
  'Having Fun',
  'Scuba Diving',
  'Snowboarding',
  'Aikido',
  'Building a Wide Network',
  'Sexual Mastery',
  'Spiritual Jedi Training'
};

List<String> generateWhatYouLearn() {
  var rng = new Random();
  return whatYouLearn.toList()..shuffle();
}

List<String> generateWhatYouGet() {
  var rng = new Random();
  var shuffledList = whatYouGet.toList()..shuffle();
  return shuffledList.take(rng.nextInt(whatYouGet.length - 4) + 3).toList();
}

List<Review> generateMockReviews() {
  var rng = new Random();
  return new List<Review>.generate(rng.nextInt(100), (int index) {
    return Review(
      student: students[index % 4],
      score: rng.nextInt(1) + 4, // to ensure 4+ stars
    );
  });
}

final mockMasterminds = <Mastermind>[
  Mastermind(
    facilitator: panacheDesai,
    imageUrls: [
      'assets/panache1.png',
      'assets/panache2.png',
      'assets/panache3.png',
    ],
    coverDescription: 'Panache has never before worked so closely and intensely with such a small group of experienced practitioners',
    whoThisFor: 'Panache has never before worked so closely and intensely with such a small group of experienced practitioners',
    overview: 'Panache has never before worked so closely and intensely with such a small group of experienced practitioners, Panache has never before worked so closely and intensely with such a small group of experienced practitioners',
    labels: [
      'Virtual',
      'Weekly',
      '3 months',
      '12 people',
    ],
    price: 200,
    reviews: generateMockReviews(),
  ),
  Mastermind(
    facilitator: tonyRobbins,
    imageUrls: [
      'assets/tony1.png',
      'assets/tony2.png',
    ],
    coverDescription: 'As a Tony Robbins Platinum Partnership member you’ll receive exclusive invitations to get coaching from Tony',
    whoThisFor: 'As a Tony Robbins Platinum Partnership member you’ll receive exclusive invitations to get coaching from Tony',
    overview: 'As a Tony Robbins Platinum Partnership member you’ll receive exclusive invitations to get coaching from TonyAs a Tony Robbins Platinum Partnership member you’ll receive exclusive invitations to get coaching from TonyAs a Tony Robbins Platinum Partnership member you’ll receive exclusive invitations to get coaching from Tony',
    labels: [
      'Live',
      'Monthly'
      '3 months',
      '150 people',
    ],
    price: 2000,
    reviews: generateMockReviews(),
  ),
  Mastermind(
    facilitator: robertKiyosaki,
    imageUrls: [
      'assets/kiyosaki1.png',
      'assets/kiyosaki2.png',
    ],
    coverDescription: 'Robert Kiyosaki brings real financial eduation to people by helping them create long term cash flow no matter where they start',
    whoThisFor: 'Robert Kiyosaki brings real financial eduation to people by helping them create long term cash flow no matter where they start',
    overview: 'Robert Kiyosaki brings real financial eduation to people by helping them create long term cash flow no matter where they startRobert Kiyosaki brings real financial eduation to people by helping them create long term cash flow no matter where they startRobert Kiyosaki brings real financial eduation to people by helping them create long term cash flow no matter where they start',
    labels: [
      'Virtual',
      'Weekly',
      '3 months',
      '40 people',
    ],
    price: 400,
    reviews: generateMockReviews(),
  ),
  Mastermind(
    facilitator: willSmith,
    imageUrls: [
      'assets/will1.png',
      'assets/will2.png',
      'assets/will3.png',
    ],
    coverDescription: 'Will Smith and Jada Pinkett Smith bring to you the secrets to long lasting desire and happiness in your relationship',
    whoThisFor: 'Will Smith and Jada Pinkett Smith bring to you the secrets to long lasting desire and happiness in your relationship',
    overview: 'Will Smith and Jada Pinkett Smith bring to you the secrets to long lasting desire and happiness in your relationshipWill Smith and Jada Pinkett Smith bring to you the secrets to long lasting desire and happiness in your relationship',
    labels: [
      'Virtual',
      'Weekly',
      '6 months',
      '10 people',
    ],
    price: 799,
    reviews: generateMockReviews(),
  ),
  Mastermind(
    facilitator: shaunWhite,
    imageUrls: [
      'assets/shaun1.png',
    ],
    coverDescription: 'Get insights into how to improve your snowboarding from world renown Olympic athelete Shaun White',
    whoThisFor: 'Get insights into how to improve your snowboarding from world renown Olympic athelete Shaun White',
    overview: 'Get insights into how to improve your snowboarding from world renown Olympic athelete Shaun WhiteGet insights into how to improve your snowboarding from world renown Olympic athelete Shaun WhiteGet insights into how to improve your snowboarding from world renown Olympic athelete Shaun White',
    labels: [
      'Virtual',
      'Weekly',
      '3 months',
      '12 people',
    ],
    price: 300,
    reviews: generateMockReviews(),
  ),
];
