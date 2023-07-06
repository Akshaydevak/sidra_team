import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonText extends StatelessWidget {
  String label;
  Color color;
   ButtonText({Key? key,required this.label,this.color=Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.of(context).size.width;
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
