import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldTab extends StatelessWidget {
  String ?label,hint;
  Widget ?child;
  bool isMandatory;
  FocusNode ?focusNode;
  int maxLine;
  bool readOnly;
  List<TextInputFormatter> ?inputFormatters;
  TextEditingController ?controller;
  TextInputType ?    keyboardType;
  TextFieldTab({Key? key,this.label="",this.hint="",this.child,this.isMandatory=true,this.controller,this.focusNode,this.maxLine=1,this.keyboardType=  TextInputType.text,this.readOnly=false,this.inputFormatters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  label??"",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10,),
                isMandatory?SvgPicture.string(SellerSvg().validationIcon,height: 15,):Container()
              ],
            ),
            child??Container()
          ],
        ),
        SizedBox(height: 5,),
        TextFormField(
          readOnly:readOnly ,
            controller: controller,
            focusNode:  focusNode,
            scrollPadding: EdgeInsets.all(10),
            cursorColor: Colors.black,
            inputFormatters: inputFormatters,
            // obscureText: show,
            style: TextStyle(color: Colors.black, fontSize: w/26),
            keyboardType:keyboardType,
            maxLines:maxLine ,
            decoration: loginInputDecoration(
              hintText:hint??"",
              ('Username'),


            )),
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
      labelStyle: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.8)),
      // labelText: "  " + label,
      hintText: hintText,
      contentPadding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 10),
      hintStyle: TextStyle(
        color: Color(0x7f666161),
        fontSize: 14,
      ),
      alignLabelWithHint: true,
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffE6ECF0)),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffe6ecf0)),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      isDense: false,
      helperStyle: TextStyle(fontSize: 8),

      helperMaxLines: 15,
    );

