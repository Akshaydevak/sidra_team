import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileTextField extends StatelessWidget {
  TextEditingController?  controller;
  bool readOnly;
   ProfileTextField({Key? key,this.controller,this.readOnly=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return TextFormField(
      readOnly: readOnly,
      cursorColor: Colors.black,
      controller: controller,
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: w / 22,
          fontWeight: FontWeight.w500,
        ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none
      ),
    );
  }
}
