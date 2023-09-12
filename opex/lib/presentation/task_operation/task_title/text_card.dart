import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCard extends StatelessWidget {
  String? title,subText;
  bool isTask;
  TextCard({Key? key,this.subText,this.title,this.isTask=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            title??"",
            style:isTask? TextStyle(
              color: ColorPalette.black,
              fontSize: w/24,
            ):GoogleFonts.roboto(
              color: Color(0xff151522),
              fontSize: w/24,

              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Divider(
          indent: 16,
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 5),
          child:  Text(
            subText?? "",
            style: TextStyle(
              color: ColorPalette.black,
              fontSize: w/24,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
