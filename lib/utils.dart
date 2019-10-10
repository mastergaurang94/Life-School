import 'package:flutter/material.dart';

// Calls a handler function for every member of the list
List<T> utilsMap<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

TextStyle getHeaderTextStyle() {
  return TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 20,
  );
}

Widget getDivider() => Divider(
  color: Colors.grey,
  height: 32.0,
);