import 'package:flutter/material.dart';
void showDailogPopUp(BuildContext context, Widget child) {
  showDialog(
    context: context,
    builder: (context) => child,
  );
}