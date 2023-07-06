import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/payments/payment_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class AddNewCard extends StatelessWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    var h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Add New Card",
          isAction: false,
          action: Icon(Icons.edit),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: w,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0x19000000),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 9,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: Color(0xfff9f7f7),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormReusable(
                        label: "Enter card number",
                        hint: "Enter card number",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormReusable(
                        label: "Name on card",
                        hint: "Enter name",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Valid till",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 16),
                                        fillColor: ColorPalette.white,
                                        filled: true,
                                        hintText: "MM",
                                        hintStyle: TextStyle(
                                          color: Color(0x66151522),
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffe6ecf0)),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffe6ecf0)),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorPalette.black,
                                              width: 1.0),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Container(
                                    width: 60,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 16),
                                        fillColor: ColorPalette.white,
                                        filled: true,
                                        hintText: "YY",
                                        hintStyle: TextStyle(
                                          color: Color(0x66151522),
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffe6ecf0)),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffe6ecf0)),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorPalette.black,
                                              width: 1.0),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CVV",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "CVV",
                                        hintStyle: TextStyle(
                                          color: Color(0x66151522),
                                          fontSize: 15,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 16),
                                        fillColor: ColorPalette.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffe6ecf0)),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffe6ecf0)),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorPalette.black,
                                              width: 1.0),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  SvgPicture.string(PaymentSvg().alertIcon)
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam.",
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: h / 5,), GradientButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SvgPicture.string(PaymentSvg().successIcon,width: 70,),
                                  SizedBox(height: 16,),
                                  Text(
                                    "Your account has been successfully added.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    width: 108,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xfffe5762),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Done",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xfffe5762),
                        Color(0xfffe5762),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: const Color(0xfffe5762),
                    child: Text(
                      "Add New Card",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
