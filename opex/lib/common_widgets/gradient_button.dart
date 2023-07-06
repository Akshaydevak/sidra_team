// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {

  final Widget child;
  final VoidCallback? onPressed;
  final Gradient gradient;
  final Color color;

  const GradientButton({
    required this.onPressed,
    required this.child,
    required this.gradient,required this.color });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      splashColor: Colors.black12,
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(38.0),
      ),
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all(
            color: color
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:
        Container(
            constraints: BoxConstraints(
                maxWidth: 200.0,
                minHeight: 40.0),
            alignment: Alignment.center,
            child: child
        ),
      ),
    );
  }
}