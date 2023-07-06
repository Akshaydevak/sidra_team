import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SegmantFlowCard extends StatelessWidget {
  const SegmantFlowCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return   Container(
      // margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      width: w,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffe0e3e5),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: const Color(0xfff7f7f7),
      ),
      child: RichText(

        text: TextSpan(
          text: 'Bulk ',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w / 25,
            fontWeight: FontWeight.w500,
          ),
          children: [
            WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(
              text: ' Baby Products',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 25,
                fontWeight: FontWeight.w500,
              ),),
            WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(text: ' Canned And Bottled '
              , style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 25,
                fontWeight: FontWeight.w500,
              ),),
            WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(text: ' Food ', style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 25,
              fontWeight: FontWeight.w500,
            ),),    WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(text: ' Corn Food ', style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 25,
              fontWeight: FontWeight.w500,
            ),),
          ],
        ),
      ),
    );
  }
}
