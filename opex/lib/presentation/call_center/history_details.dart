import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/call_center/widgets/card_list.dart';
import 'package:cluster/presentation/call_center/widgets/delivery_address_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../mpos/qr_screen.dart';

class HistoryDetailsScreen extends StatefulWidget {
  HistoryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<HistoryDetailsScreen> createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  bool isPayment = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: ColorPalette.primary, // Status bar
        ),
        backgroundColor: ColorPalette.primary,
        elevation: 0,
        title: Text("ID : #2343787"),
        actions: [
          CircleAvatar(
            radius: 25,
            backgroundColor: ColorPalette.divider,
          ),
          SizedBox(
            width: 16,
          ),
        ],
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
                Text(
                  "Delivery address",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 22,
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
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0x4ca9a8a8),
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Al Rashidiyyah, Ajman",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "MP Tower, Thondayad bypass,\nKozhikode, 673572",
                            style: GoogleFonts.roboto(
                              color: Color(0xff6d6d6d),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          _showModalBottomSheet();
                        },
                        child: Text(
                          "Change",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0x4ca9a8a8),
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "+",
                            style: TextStyle(
                              color: ColorPalette.primary,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Coupon",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0x4ca9a8a8))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0x4ca9a8a8)))),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Payment options",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
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
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0xfffe5762),
                      width: 1,
                    ),
                    color: Color(0x0cfe5762),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.string(isPayment == false
                          ? HomeSvg().radioButtonActive
                          : HomeSvg().radioInActive),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Instant Payment",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                isPayment == false
                    ? Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          CardList(),
                        ],
                      )
                    : Container(),
                SizedBox(height: 10,),
                Container(
                  width: w,
                 padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.string(isPayment
                          ? HomeSvg().radioButtonActive
                          : HomeSvg().radioInActive),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: w/1.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pay on Delivery",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. Etiam cras ur na conseq.",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                GradientButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const QrScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
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
                      "Create Invoice",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                GradientButton(
                    onPressed: () {
                      // PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen: const AddNewList(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );
                    },
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: const Color(0xfffe5762),
                    child: Text(
                      "Hold this Order",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: ColorPalette.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),GradientButton(
                    onPressed: () {
                      // PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen: const AddNewList(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );
                    },
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: const Color(0xfffe5762),
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: ColorPalette.primary,
                        fontSize: 18,
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

  _showModalBottomSheet() {
    int isSelect=0;
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return  Container(

                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Address",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Apply",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: ColorPalette.divider,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. ",
                                style: TextStyle(
                                  color: Color(0xff6d6d6d),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 10,),
                              ListView.separated(
                                shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => GestureDetector(
                                    onTap: (){
                                      setState((){
                                        isSelect=index;
                                      });
                                    },
                                      child: DeliveryAddressCard(isSelect:isSelect==index ,)),
                                  separatorBuilder: (context, index) => SizedBox(height: 10,), 
                                  itemCount: 5)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

              );
            },
          );
        });
  }
}
