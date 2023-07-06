import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class SingleRow extends StatelessWidget {
  String ?svg,label;
  Color ? color;
  VoidCallback ?onTap;
  Widget ?endIcon;
  SingleRow({Key? key,this.svg, this.color,this.label,this.onTap,this.endIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(

              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: color??Colors.yellow,
              ),
              child: Center(
                child: SvgPicture.string(svg??""),
              ),
            ),
            SizedBox(width: 15,),
            Text(
              label??"Label",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 18,

                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        GestureDetector(
            onTap:onTap,
            child:endIcon)
      ],
    );
  }
}
