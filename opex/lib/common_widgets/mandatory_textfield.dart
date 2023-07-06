import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/color_palatte.dart';
class MandatoryTextField extends StatelessWidget {
  String? label;
  String? hint;
  TextEditingController? controller;
  int maxLength;
  FormFieldValidator<String>? validator;

   MandatoryTextField({Key? key,this.label,this.hint,this.controller,this.maxLength=1,this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label!,
              style: GoogleFonts.roboto(
                color: ColorPalette.black,
                fontSize: w/23,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "*",
              style: GoogleFonts.roboto(
                fontSize: w/23,
                color: ColorPalette.primary,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          scrollPadding: EdgeInsets.all(10),
          cursorColor: ColorPalette.black,

          style: TextStyle(color: ColorPalette.black, fontSize: 17),
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          maxLines: maxLength,
          decoration: loginInputDecoration(
            hintText: hint,
            ('Username'),

          ),
          validator:validator,
        ),
      ],
    );
  }
}

InputDecoration loginInputDecoration(
    String label, {
      String? hintText,
      Widget? leading,
      Widget? suffix,
    }) =>
    InputDecoration(
      // suffixIcon: suffix,
      suffix: suffix,
      errorMaxLines: 2,
      counterText: "",
      labelStyle: TextStyle(fontSize: 16, color:ColorPalette.black.withOpacity(0.8)),
      // labelText: "  " + label,
      hintText: hintText,
      contentPadding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 10),
      hintStyle: TextStyle(
        color: Color(0x66151522),
        fontSize: 15,
      ),
      alignLabelWithHint: true,
      fillColor: ColorPalette.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffe6ecf0)),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffe6ecf0)),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.black, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      isDense: false,
      helperStyle: TextStyle(fontSize: 8),

      helperMaxLines: 15,
    );
