import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: ColorPalette.inactiveGrey,
            radius: 60,
          ),
          SizedBox(height: 30,),
          Text(
            "Scan with Your Phone",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            "Simply scan the barcode of an item and add them to your bag",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff3d3d3d),
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
