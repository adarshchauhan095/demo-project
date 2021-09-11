import 'package:flutter/material.dart';

Widget text(
  String? text, {
  var fontSize = 18.0,
  Color? textColor,
}) {
  return Text(
    text!,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: fontSize,
      color: textColor ?? Colors.black,
      height: 1.5,
    ),
  );
}

bool isNegative(value) {
  if (double.parse(value) < 0) {
    return true;
  }
  return false;
}

String limitString(value) {
  if (value != null) {
    return double.parse(value).toStringAsFixed(2);
  }
  return "0";
}

Widget loader() {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Loading..."),
          ),
        ],
      ),
    ),
  );
}
