

import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../presentation/seller_app/seller_svg.dart';

class TextFormReusable extends StatefulWidget {
  String? label;
  String? error;
  String? hint;
  void Function(String)? onchange;
  TextEditingController? controller;
  int maxLength;
  FormFieldValidator<String>? validator;
  bool password;
  bool? isMandatory;
  bool readOnly;
  bool isError;
  bool? numField;
  bool? floatVal;
  VoidCallback? onTap;
  TextFormReusable(
      {Key? key,
        this.label,
        this.error,
        this.isMandatory,
        this.numField,
        this.floatVal,
        this.onTap,
        this.controller,
        this.validator,
        this.password = false,
        this.readOnly = false,
        this.isError = false,
        this.hint,
        this.maxLength = 1,  this.onchange})
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
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    // show = widget.password;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: widget.isMandatory==true?MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label??"",
              style: GoogleFonts.roboto(
                color: ColorPalette.black,
                fontSize: w/24,
                fontWeight: FontWeight.w500,
              ),
            ),
            widget.isMandatory==true?Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(" *",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900),),
            ):Container(),
            widget.isError?GestureDetector(
              onTap: widget.onTap,
              child: Text(
                widget.error??"",
                style: GoogleFonts.roboto(
                  color: ColorPalette.primary,
                  fontSize: w/28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ):Text(""),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: widget.readOnly,
          onChanged: widget.onchange,
          scrollPadding: EdgeInsets.all(10),
          cursorColor: ColorPalette.black,
          obscureText: show,
          style: TextStyle(color: ColorPalette.black, fontSize: 16),
          keyboardType: widget.numField==true||widget.floatVal==true?TextInputType.numberWithOptions(decimal: false):TextInputType.emailAddress,
          inputFormatters: [
            widget.numField==true?FilteringTextInputFormatter.digitsOnly:
            widget.floatVal==true?FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')):
            FilteringTextInputFormatter.singleLineFormatter,

          ],
          controller: widget.controller,
          maxLines: widget.maxLength,
          decoration: loginInputDecoration(
            hintText: widget.hint,
            readOnly: widget.readOnly,
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
      bool? readOnly,
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
      fillColor: readOnly==true?Color(0xffEEEEEE):ColorPalette.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: readOnly==true?Colors.white:Color(0xffe6ecf0)),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: readOnly==true?Colors.white:Color(0xffe6ecf0)),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: readOnly==true?Colors.white:ColorPalette.black, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      isDense: false,
      helperStyle: TextStyle(fontSize: 8),
      helperMaxLines: 15,
    );