import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueButton extends StatelessWidget {
  VoidCallback? onTap;
  String label;
   ContinueButton({Key? key,this.onTap,this.label="Continue"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w1,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xfffe5762),
        ),
        child: Center(
           child: Text(
             label,
             textAlign: TextAlign.center,
             style: GoogleFonts.roboto(
               color: Colors.white,
               fontSize: w/20,

               fontWeight: FontWeight.w600,
             ),
           ),
        ),
      ),
    );
  }
}
