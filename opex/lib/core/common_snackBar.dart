// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

////* assign a GlobalKey to the Scaffold, then use the key.currentState property to obtain the ScaffoldState rather than
/// using the Scaffold.of() function.   /
/* exception Occurs in  Debugg procedure due to this  (when using  Scaffold.of() instead of  scafoldKey.currentState line NO:15) */
void showDailogPopUp(BuildContext context, Widget child) {
  showDialog(
    context: context,
    builder: (context) => child,
  );
}
showSnackBar(
  BuildContext context, {
  required String message,
  required Color color,
  IconData icon = Icons.done_all_outlined,
  bool autoDismiss = true,
}) {      
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
        SnackBar(
      duration: autoDismiss ? Duration(seconds: 3) : Duration(days: 4),
      padding: EdgeInsets.all(0),
      content: Container(
        padding: EdgeInsets.all(10),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  message,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  //  style: TextStyle(color: Palette.DARK)
                ),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    ));
}

SnackBar snackBar({
  required String message,
  required Color color,
  required Widget icon,
  bool autoDismiss = true,
}) {
  return SnackBar(
    duration: autoDismiss ? Duration(seconds: 1) : Duration(days: 1),
    content: Row(
      children: [
        Expanded(
          child: Text(
            message,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        icon,
      ],
    ),
    backgroundColor: color,
  );
}

