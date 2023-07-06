import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class BasicDetails extends StatelessWidget {
  String? head,label;
   BasicDetails({Key? key,this.head,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head??"Join Date",
          style: TextStyle(
            color: ColorPalette.inactiveGrey,
            fontSize: w/25,
          ),
        ),
        Text(
         label?? "12 Jan 2022",
          style: GoogleFonts.roboto(
            color: ColorPalette.black,
            fontSize: w/24,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
