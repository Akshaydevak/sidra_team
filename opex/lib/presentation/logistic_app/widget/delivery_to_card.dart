import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/logistic_svg.dart';
class DeliveryToCard extends StatelessWidget {
  String ?svg;
   DeliveryToCard({Key? key,this.svg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return   Container(
      width: w/4.8,
      padding: EdgeInsets.all(10),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
      ),
      child: SvgPicture.string(svg??LogisticSvg().callIcon,color: ColorPalette.primary,),
    );
  }
}
