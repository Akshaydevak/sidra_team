import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/color_palatte.dart';
class ProfileTextFormField extends StatelessWidget {
  String? label;
  String? hint;
  bool? readOnly;
  bool? focus;
  Widget? suffixIcon;

  FocusNode? myfocus;
  VoidCallback? onTap;
  void Function(String)? onChanege;
  TextEditingController? controller;
  int maxLength;
  FormFieldValidator<String>? validator;

   ProfileTextFormField({Key? key,this.label,this.onTap,this.hint,this.controller,this.maxLength=1,this.myfocus,this.validator,this.readOnly,this.onChanege,this.focus,this.suffixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      // color:Colors.yellow,
      height: 35,
      width: w,
      child: TextFormField(
        autofocus: focus??false,
        controller: controller,
        showCursor: readOnly==false,
        textAlign: TextAlign.center,
        readOnly: readOnly??false,
        onChanged: onChanege,
        focusNode: myfocus,
        
        decoration: loginInputDecoration(
          onTap: onTap,
          suffixIcon: suffixIcon,

          readOnly: readOnly,
              // hintText: hint,
              ('Username'),
    
            ),),
    );
  }
}


InputDecoration loginInputDecoration(
    String label, {
      String? hintText,
      bool? readOnly,
      VoidCallback? onTap,
      Widget? leading,
      Widget? suffix,
      Widget? suffixIcon,
    }) =>
    InputDecoration(isDense: true,
    //  contentPadding: EdgeInsets.zero,
      suffixIcon: suffixIcon,
      // InkWell(
      //   onTap: onTap,
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 25),
      //     child: Icon(Icons.edit,size: 15,color: Color(0xff555555),),
      //   )),
      // suffixIcon: suffix,
      suffix: suffix,
      errorMaxLines: 2,
      counterText: "",
      labelStyle: TextStyle(fontSize: 16, color:ColorPalette.black.withOpacity(0.8)),
      // labelText: "  " + label,
      hintText: hintText,
      
      // contentPadding: EdgeInsets.only(left: 15, top: 25, bottom: 0, right: 10),
      hintStyle:   GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            textStyle: TextStyle()
          ),
      alignLabelWithHint: true,
      fillColor: ColorPalette.white,
      // filled: true,
      focusedErrorBorder: UnderlineInputBorder(
borderRadius: BorderRadius.zero,
                      borderSide:   BorderSide(color: Colors.grey.shade200,width: 1),
                      ),
      disabledBorder: UnderlineInputBorder(
borderRadius: BorderRadius.zero,

        borderSide:   BorderSide(color: Colors.grey.shade200,width: 1),
                      ),
      errorBorder:UnderlineInputBorder(
borderRadius: BorderRadius.zero,

borderSide:   BorderSide(color: Colors.grey.shade200,width: 1),
                      ),
       border: UnderlineInputBorder(
borderRadius: BorderRadius.zero,
borderSide:   BorderSide(color: Colors.grey.shade200,width: 1),
                      ),
      enabledBorder: UnderlineInputBorder(
borderRadius: BorderRadius.zero,
borderSide:   BorderSide(color: Colors.grey.shade200,width: 1),
                      ),
              focusedBorder: UnderlineInputBorder(
borderRadius: BorderRadius.zero,

borderSide:   BorderSide(color: Colors.grey.shade200,width: 1),),
//
//                    ),
      // isDense: false,
      helperStyle: TextStyle(fontSize: 8),
      helperMaxLines: 15,
    );