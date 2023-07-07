import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SegmantFlowCard extends StatelessWidget {
  final  String ?division,category,subCategory,group,item,uom;
  const SegmantFlowCard({Key? key, this.division, this.category, this.subCategory, this.group, this.item,this.uom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(division);
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return   Container(
      // margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      width: w1,
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
          text: "$division "??"",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w / 28,
            fontWeight: FontWeight.w500,
          ),
          children: [
            WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(
              text: " $category "??' Baby Products',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 28,
                fontWeight: FontWeight.w500,
              ),),
            WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(text: " $subCategory "??' Canned And Bottled '
              , style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 28,
                fontWeight: FontWeight.w500,
              ),),
            WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(text: " $group "??' Food ', style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 28,
              fontWeight: FontWeight.w500,
            ),),    WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(text: " $item "??' Corn Food ', style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 28,
              fontWeight: FontWeight.w500,
            ),),    WidgetSpan(
              child: Icon(Icons.arrow_forward, size: w/25),
            ),
            TextSpan(text: " $uom"??' Corn Food ', style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 28,
              fontWeight: FontWeight.w500,
            ),),
          ],
        ),
      ),
    );
  }
}
