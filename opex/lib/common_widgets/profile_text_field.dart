import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/color_palatte.dart';
class ProfileTextFormField extends StatelessWidget {
  String? label;
  String? hint;
  bool? readOnly;
  VoidCallback? onTap;
  TextEditingController? controller;
  int maxLength;
  FormFieldValidator<String>? validator;

   ProfileTextFormField({Key? key,this.label,this.onTap,this.hint,this.controller,this.maxLength=1,this.validator,this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      // color:Colors.yellow,
      child: TextFormField(
        controller: controller,
        showCursor: readOnly==false,
        textAlign: TextAlign.center,
        readOnly: readOnly??false,
        
        decoration: loginInputDecoration(
          onTap: onTap,
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
    }) =>
    InputDecoration(isDense: true,
    //  contentPadding: EdgeInsets.zero,
      suffixIcon: InkWell(
        onTap: onTap,
        child: Icon(Icons.edit,size: 22,color: Color(0xff555555),)),
      // suffixIcon: suffix,
      suffix: suffix,
      errorMaxLines: 2,
      counterText: "",
      labelStyle: TextStyle(fontSize: 16, color:ColorPalette.black.withOpacity(0.8)),
      // labelText: "  " + label,
      hintText: hintText,
      
      contentPadding: EdgeInsets.only(left: 15, top: 17, bottom: 0, right: 10),
      hintStyle:   GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            textStyle: TextStyle()
          ),
      alignLabelWithHint: true,
      fillColor: ColorPalette.white,
      filled: true,

      focusedErrorBorder: UnderlineInputBorder(      
borderRadius: BorderRadius.zero,
                      borderSide:readOnly==false?  BorderSide(color:Colors.black,width: 3):  BorderSide(color: Color(0x7FE6ECF0),width: 3),   
                      ),
      disabledBorder: UnderlineInputBorder(      
borderRadius: BorderRadius.zero,

                      borderSide:readOnly==false?  BorderSide(color:Colors.black,width: 3):  BorderSide(color: Color(0x7FE6ECF0),width: 3),   
                      ),
      errorBorder:UnderlineInputBorder(      
borderRadius: BorderRadius.zero,

                      borderSide:readOnly==false?  BorderSide(color:Colors.black,width: 3):  BorderSide(color: Color(0x7FE6ECF0),width: 3),   
                      ),
       border: UnderlineInputBorder(      
borderRadius: BorderRadius.zero,

                      borderSide:readOnly==false?  BorderSide(color:Colors.black,width: 3):  BorderSide(color: Color(0x7FE6ECF0),width: 3),   
                      ),
      enabledBorder: UnderlineInputBorder(      
borderRadius: BorderRadius.zero,

                      borderSide:readOnly==false?  BorderSide(color:Colors.black,width: 3):  BorderSide(color: Color(0x7FE6ECF0),width: 3),   
                      ),  
              focusedBorder: UnderlineInputBorder(
borderRadius: BorderRadius.zero,

                                           borderSide:readOnly==false?  BorderSide(color:Colors.black,width: 3):  BorderSide(color: Color(0x7FE6ECF0),width: 3),   

                   ),
      // isDense: false,
      helperStyle: TextStyle(fontSize: 8),
      helperMaxLines: 15,
    );