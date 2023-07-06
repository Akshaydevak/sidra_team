import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'out_stock_card.dart';

class StockCardView extends StatelessWidget {
  const StockCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "",
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutStockCard(isStock: true),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Stock Manage",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: w,
                  // height: 393,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Color(0xffe6ecf0),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
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
                            "VIRTUAL QUANTITY",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Color(0xffccdae3), width: 1, ),
                                  color: Color(0xfff9f9f9),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: ColorPalette.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 70,
                                height: 36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Color(0xffccdae3), width: 1, ),
                                  color: Color(0xfff9f9f9),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "19",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 35,
                                height: 36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xfffe5762),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "+",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        color: ColorPalette.divider,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "RETURNED QUANTITY",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.subtextGrey,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "19",
                            style: GoogleFonts.poppins(
                              color: ColorPalette.subtextGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: ColorPalette.divider,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "DAMAGED QUANTITY",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.subtextGrey,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "109",
                            style: GoogleFonts.poppins(
                              color: ColorPalette.subtextGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: ColorPalette.divider,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "REPLACED QUANTITY",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.subtextGrey,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "1109",
                            style: GoogleFonts.poppins(
                              color: ColorPalette.subtextGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: ColorPalette.divider,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "RESERVED QUANTITY",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.subtextGrey,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "1109",
                            style: GoogleFonts.poppins(
                              color: ColorPalette.subtextGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Profile related info placed here.  Whishlist is used to save your favourite items for later.",
                  style: TextStyle(
                    color: Color(0xff3c3b3b),
                    fontSize: w/28,
                  ),
                ),
                SizedBox(height: 40,),
                GradientButton(
                    color:ColorPalette.primary ,
                    onPressed: () {
                      // PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen: const NewPromotion(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );


                    },
                    gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:[ColorPalette.primary, ColorPalette.primary]),
                    child: Text(
                      "Update",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w/22,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
