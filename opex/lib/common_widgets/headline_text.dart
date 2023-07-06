import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/color_palatte.dart';
class HeadlineText extends StatelessWidget {
  String ?headText;
   HeadlineText({Key? key,this.headText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return   Column(
      mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          headText??"Quick access to :",
          style: GoogleFonts.roboto(
            color:  ColorPalette.black,
            fontSize: w / 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
