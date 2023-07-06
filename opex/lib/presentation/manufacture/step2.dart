import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class StepTwo extends StatelessWidget {
  bool isDefines=true;
   StepTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Step : 2",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam dign.",
            style: TextStyle(
              color: ColorPalette.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            "Finance Status",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              SvgPicture.string(isDefines?HomeSvg().radioButtonActive:HomeSvg().radioButtonInActive),
              SizedBox(width: 10,),
              Text(
                "Define",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 20,),
              SvgPicture.string(isDefines==false?HomeSvg().radioButtonActive:HomeSvg().radioButtonInActive),
              SizedBox(width: 10,),
              Text(
                "Not Define",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text(
            "Amount to Recieve",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Tax",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            width: w,
            // height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x05000000),
                  blurRadius: 8,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "-  Select  -",
                  style: TextStyle(
                    color: Color(0xbf666161),
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_outlined)
              ],
            ),
          ),
          SizedBox(height: h/5,)
        ],
      ),
    );
  }
}
