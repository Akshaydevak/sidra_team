import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String? title, Icon? icon) {
  return InputDecoration(
    filled: true,

    // fillColor: Palette.DARK,
    suffixIcon: icon,
    hintText: title,
    hintStyle: TextStyle(color: Colors.white),
    // contentPadding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1),
      // borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1),
      // borderRadius: BorderRadius.circular(28),
    ),
  );
}

Widget boldText(String text, {double fontSize = 14}) => Text(
  text,
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: fontSize,
    color: Colors.black,
  ),
);
Widget dimText(String text,
    {double fontSize = 10, Color color = Colors.grey}) =>
    Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );

Widget smallText(String text, {double fontSize = 10, bool isBold = false}) =>
    Text(
      text,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
    );

Widget greyDivider() => const Divider(
  color: Colors.black,
  thickness: 0.4,
  // height: 1,
  // endIndent: 2,
  // indent: 2,
);
