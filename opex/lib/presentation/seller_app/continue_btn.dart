import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueButton extends StatelessWidget {
  VoidCallback? onTap;
  String label;
   ContinueButton({Key? key,this.onTap,this.label="Continue"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        height: 62,
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
