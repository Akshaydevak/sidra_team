// ignore_for_file: prefer_const_constructors

import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

Widget customStackedLoader(
    BuildContext context, double? opacity, Color? color,{double? height,double? padding,}) {
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;
  return Container(
      // width: width,
      color: color?.withOpacity(opacity ?? 0.1),
      //  Colors.grey.withOpacity(opacity??0.1),
      height: height??h,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(padding??165),
      child: Container()
      // loading_indicator(
      //     indicatorType: Indicator.ballRotateChase,
      //     colors: [ColorPalette.primary],
      //     strokeWidth: 0.1,
      //     backgroundColor: Colors.transparent,
      //     pathBackgroundColor: Colors.black)
      // customCupertinoLoading(color: Colors.black54,radius: 20)
      // LoaderTransparent()
      );
}
