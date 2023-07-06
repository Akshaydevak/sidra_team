import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);

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
            "Offer and Rewards",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            "Get notifiesd on early offers and also earn exclusive app coupons.",
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
