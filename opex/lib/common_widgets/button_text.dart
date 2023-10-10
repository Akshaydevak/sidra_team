import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonText extends StatelessWidget {
  String label;
  Color color;
   ButtonText({Key? key,required this.label,this.color=Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Text(
      label,
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
        color: color,
        fontSize: w/22,
        fontWeight: FontWeight.w500,
      ),
    ) ;
  }
}
