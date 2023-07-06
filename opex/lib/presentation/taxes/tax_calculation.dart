import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class TaxCalculation extends StatelessWidget {
  const TaxCalculation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Tax Calculator",
          isAction: false,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(children: [
                  Container(
                    width: w/2.3,
                    child: Text(
                      "Principle Amount",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: w/22,
                      ),
                    ),
                  ),
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x23d8753d),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "AED",
                      style: GoogleFonts.roboto(
                        color: Color(0xffd7743d),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width:10),
                  Container(
                    width: w/3,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 8,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                  )

                ],),
            SizedBox(height: 10,),
                Row(children: [
                  Container(
                    width: w/2.3,
                    child: Text(
                      "Interest Rate",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: w/22,
                      ),
                    ),
                  ),
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x23d8753d),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "%",
                      style: GoogleFonts.roboto(
                        color: Color(0xffd7743d),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width:10),
                  Container(
                    width: w/3,
                    height: 50,

                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xffe6ecf0)
                            )
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xffe6ecf0)
                            )
                        ), enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xffe6ecf0)
                            )
                        ),
                      ),


                    ),
                  )

                ],),
                SizedBox(height: 10,),
                Container(
                  width: w,
                  // height: 251,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0a000000),
                        blurRadius: 117,
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding:EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MONTH",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffdf2f2),
                            ),
                            child: Icon(Icons.keyboard_arrow_down_outlined,color: ColorPalette.primary,),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "12",
                              style: GoogleFonts.roboto(
                                color: Color(0xff4c3939),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffdf2f2),
                            ),
                            child: Icon(Icons.keyboard_arrow_up,color: ColorPalette.primary,),
                          )
                        ],
                      ),
                      Divider(),
                      Text(
                        "MONTH",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffdf2f2),
                            ),
                            child: Icon(Icons.keyboard_arrow_down_outlined,color: ColorPalette.primary,),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "12",
                              style: GoogleFonts.roboto(
                                color: Color(0xff4c3939),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffdf2f2),
                            ),
                            child: Icon(Icons.keyboard_arrow_up,color: ColorPalette.primary,),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                GradientButton(
                    onPressed: () {

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
                      "Compare",
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
