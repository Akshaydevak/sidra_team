import 'package:cluster/presentation/wallet_app/wallet_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';

class WalletCardView extends StatelessWidget {
  const WalletCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Container(
                      width: w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){},
                              child: SvgPicture.string(WalletSvg().walletIcon)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "AED 500.25",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 137,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xfffd5762),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "View All",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                width: 137,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Color(0xfffd5762),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Redeem Now",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Transaction Details",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xffe6ecf0),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Column(children: [
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hypermarket",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w / 23,
                              ),
                            ),
                            Text(
                              "Industry",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TR12021NDBXB",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w / 23,
                              ),
                            ),
                            Text(
                              "TRN No.",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TR12021NDBXB",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w / 23,
                              ),
                            ),
                            Text(
                              "Import/Export Code",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w / 2,
                              child: Text(
                                "rawabimarket@gmail.com",
                                style: TextStyle(
                                  color: Color(0x66151522),
                                  fontSize: w / 23,
                                ),
                              ),
                            ),
                            Text(
                              "Business E-Mail",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "24 Hours",
                              style: TextStyle(
                                color: Color(0x66151522),
                                fontSize: w / 23,
                              ),
                            ),
                            Text(
                              "Working Hours",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 23,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ]))),
    );
  }
}
