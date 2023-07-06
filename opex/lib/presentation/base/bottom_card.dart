import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
class BottomCard extends StatelessWidget {
  const BottomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: h / 10,
        ),
        Container(
          width: w,
          child: Column(
            children: [
              Text(
                "cluster app",
                style: GoogleFonts.roboto(
                    color: ColorPalette.inactiveGrey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5,),
              Text(
                "V.1.1.0",
                style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w/33,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
