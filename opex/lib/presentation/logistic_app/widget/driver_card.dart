import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverCard extends StatelessWidget {
  bool isSelect;
String? svg;
  DriverCard({Key? key, this.isSelect = false,this.svg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w / 4.8,
      height: 88,
      decoration: isSelect
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
              color: Color(0xfffe5762),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffeef3f6),
            ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(svg??"",color: isSelect?ColorPalette.white:ColorPalette.inactiveGrey,),
          Text(
            "2 Wheeler",
            style:isSelect? GoogleFonts.roboto(
              color: Colors.white,
              fontSize: w/24,
              fontWeight: FontWeight.w500,
            ): GoogleFonts.roboto(
                color: Colors.black,
                fontSize:  w/24,
                fontWeight: FontWeight.w500,
              ),

          )
        ],
      ),
    );
  }
}
