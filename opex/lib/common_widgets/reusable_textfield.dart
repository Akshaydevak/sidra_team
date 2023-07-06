// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormReusable extends StatefulWidget {
  String? label;
  String? hint;
  TextEditingController? controller;
  int maxLength;
  FormFieldValidator<String>? validator;
  bool password;

  // Widget? suffix;
  TextFormReusable(
      {Key? key,
      this.label,
      this.controller,
      this.validator,
      this.password = false,
      this.hint,
      this.maxLength = 1})
      : super(key: key);

  @override
  State<TextFormReusable> createState() => _TextReusableState();
}

class _TextReusableState extends State<TextFormReusable> {
  bool show = true;

  @override
  void initState() {
    show = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    // show = widget.password;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label??"",
          style: GoogleFonts.roboto(
            color: ColorPalette.black,
            fontSize: w/24,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          
          scrollPadding: EdgeInsets.all(10),
          cursorColor: ColorPalette.black,
          obscureText: show,
          style: TextStyle(color: ColorPalette.black, fontSize: 17),
          keyboardType: TextInputType.emailAddress,
          controller: widget.controller,
          maxLines: widget.maxLength,
          decoration: loginInputDecoration(
            hintText: widget.hint,
            ('Username'),
            suffix: widget.password
                ? InkWell(
                    onTap: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    child: Container(
                        height: 16,
                        margin: EdgeInsets.only(right: 5, left: 5),
                        child: show
                            ? Icon(
                                Icons.remove_red_eye_outlined,
                                size: 16.0,
                                color: Color(0xff7C7C7C),
                              )
                            :
                            // SvgPicture.string(IconConstants().eyeIcon,height: 16,width: 16,):
                            Icon(
                                Icons.remove_red_eye_outlined,
                                size: 16.0,
                                color: Color(0xff7C7C7C),
                              )))
                : null,
          ),
          validator: widget.validator,
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
        fontSize: 14,
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
