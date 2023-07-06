import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusCard extends StatelessWidget {
  String? label, svg;

  StatusCard({Key? key, this.svg, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w / 2.6,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xfffdf2f2),
          width: 1.50,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Color(0xfffd5762),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(svg ?? "",color: Colors.white,),
          SizedBox(
            height: 10,
          ),
          Text(
            label??"VIEW COLLECTIONS",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: w/27,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
