import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DropDownCard extends StatelessWidget {
  DropDownCard({Key? key,this.label,this.onTap,this.selValue,this.isMandatory}) : super(key: key);
  String? selValue,label;
  VoidCallback? onTap;
  bool? isMandatory;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label?? "Select Segment",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w/24,
                fontWeight: FontWeight.w500,
              ),
            ),
            isMandatory==true?Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(" *",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900),),
            ):Container()
          ],
        ),
        const SizedBox(height: 5,),
        GestureDetector(
          onTap: onTap ,
          child: Container(
              width: w1 ,
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xffe6ecf0), width: 1, ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
                color: Color(0xffF4F4F4),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selValue??"-  Select  -",
                    style: selValue==""?TextStyle(
                      color: const Color(0xbf666161),
                      fontSize: w/22,
                    ):TextStyle(
                      color: ColorPalette.primary,
                      fontSize: w/22,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down_outlined),
                ],
              )
          ),
        ),
      ],
    );
  }
}


//
class ReadDropDownCard extends StatelessWidget {
  ReadDropDownCard({Key? key,this.label,this.onTap,this.selValue}) : super(key: key);
  String? selValue,label;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label?? "Select Segment",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w/24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5,),
        GestureDetector(
          child: Container(
              width: w1 ,
              // padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //height: 20.0,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xffe6ecf0),
                    width: 1
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
                color: Colors.white,
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selValue??"-  Select  -",
                    style: selValue==""?TextStyle(
                      color: const Color(0xbf666161),
                      fontSize: w/22,
                    ):TextStyle(
                      color: Colors.black,
                      fontSize: w/22,
                    ),
                  ),
                ],
              )
          ),
        ),
      ],
    );
  }
}
