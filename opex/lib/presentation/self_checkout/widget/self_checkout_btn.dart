import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SelfCheckoutBtn extends StatelessWidget {
  String? label;
  VoidCallback ?onTap;
   SelfCheckoutBtn({Key? key,this.label,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xffff467a), Color(0xff9c0e36)], ),
        ),
        alignment: Alignment.center,
        child: Text(
          label??"Add new card",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: w/22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SelfCheckoutInactiveButton extends StatelessWidget {
  String? label;
  Color ?textColor;
   SelfCheckoutInactiveButton({Key? key,this.label,this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffe8e8e8),
      ),
      alignment: Alignment.center,
      child: Text(
        label??"Continue",
        style: GoogleFonts.inter(
          color: textColor??Colors.white,
          fontSize: w/22,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
