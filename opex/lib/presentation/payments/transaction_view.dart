import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/payments/payment_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.close),
                      SvgPicture.string(PaymentSvg().shareIcon)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.string(PaymentSvg().completeIcon),
                        SizedBox(height: 10,),
                        Text(
                          "AED 500.25",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),
                  Container(
                    height: h/6,
                    width: w,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: w/1.1,
                            height: h/7,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Account",
                                    style: TextStyle(
                                      color: Color(0x66151522),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "XX 3652",
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                                SizedBox(height: 10,),

                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Transaction App",
                                    style: TextStyle(
                                      color: Color(0x66151522),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Call center App",
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              ],
                            ),
                          ),

                        ),
                        Positioned(
                          left: w/2.6,
                            child: CircleAvatar(radius: 25,))
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Transaction Details",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: w,
                   padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rawabi Market",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Business Name",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hypermarket",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w/23,
                              ),
                            ),
                            Text(
                              "Industry",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w/23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ), SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TR12021NDBXB",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w/23,
                              ),
                            ),
                            Text(
                              "TRN No.",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w/23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ), SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TR12021NDBXB",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w/23,
                              ),
                            ),
                            Text(
                              "Import/Export Code",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w/23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ), SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w/2,
                              child: Text(
                                "rawabimarket@gmail.com",
                                style: TextStyle(
                                  color: Color(0x66151522),
                                  fontSize: w/23,
                                ),
                              ),
                            ),
                            Text(
                              "Business E-Mail",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w/23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ), SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "24 Hours",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w/23,
                              ),
                            ),
                            Text(
                              "Working Hours",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w/23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
