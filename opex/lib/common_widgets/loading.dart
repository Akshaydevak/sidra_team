import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customCupertinoLoading({Color? color, double radius = 10}) => Container(
    child: Center(
        child: CupertinoActivityIndicator(
          radius: radius,
          color: color,
        )));