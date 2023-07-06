import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../../core/color_palatte.dart';
class StepOne extends StatelessWidget {
  const StepOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step : 1",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5,),
        const Text(
          "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam dign.",
          style: TextStyle(
            color: ColorPalette.black,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "Contract Type",
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
        SizedBox(height: 10,),
        TextFormReusable(
          label: "Title",
          hint: "eg.lorem ipsum dolar sit",
        ),
        SizedBox(height: 16,),
        TextFormReusable(
          label: "Description",
          hint: "eg.lorem ipsum dolar sit",
        ),   SizedBox(height: 16,),
        TextFormReusable(
          label: "Requester Name",
          hint: "eg.lorem ipsum dolar sit",
        ),
        SizedBox(height: 10,),
        Text(
          "Contract Effective on",
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
        SizedBox(height: 10,),
        Text(
          "Contract End on",
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
        ),SizedBox(height: 10,),
        Text(
          "Termination Period",
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

      ],
    );
  }
}
