import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/self_checkout/self_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';

class CartCouponCard extends StatefulWidget {
  const CartCouponCard({Key? key}) : super(key: key);

  @override
  State<CartCouponCard> createState() => _CartCouponCardState();
}

class _CartCouponCardState extends State<CartCouponCard> {
  int selected = 0;

  void onselect(index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      //
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  "Coupon",
                  style: GoogleFonts.inter(
                    color: Color(0xff1b1b1f),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.1,
            color: ColorPalette.divider,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe3ce10),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "25% Off",
                      style: GoogleFonts.inter(
                        color: Color(0xff0a0a0a),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      // color: Colors.yellow,
                      width: w / 1.43,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lorem ipsum dolar sit amet thi...",
                            style: GoogleFonts.inter(
                              color: Color(0x99151522),
                              fontSize: w / 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showModalBottomSheet();
                            },
                            child: Text(
                              "Change",
                              style: GoogleFonts.inter(
                                color: Color(0xffff477b),
                                fontSize: w / 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showModalBottomSheet() {
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
              return Container(
                  padding: EdgeInsets.all(16),
                  height: 350,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: ScrollConfiguration(
                    behavior: NoGlow(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Choose a coupon",
                            style: GoogleFonts.inter(
                              color: ColorPalette.black,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      // onselect(index);

                                      selected = index;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: w,
                                      padding: EdgeInsets.all(10),
                                      decoration: selected == index
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Color(0x7feb3a6c),
                                                width: 1.50,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x05000000),
                                                  blurRadius: 8,
                                                  offset: Offset(1, 1),
                                                ),
                                              ],
                                              color: Color(0x19ff487c),
                                            )
                                          : BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffdec910),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: w / 1.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "25% Off",
                                                      style: GoogleFonts.inter(
                                                        color:
                                                            ColorPalette.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    GestureDetector(onTap: (){
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              contentPadding: EdgeInsets.all(10),
                                                              content: Container(

                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: <Widget>[
                                                                   SvgPicture.string(SelfSvg().giftIcon),
                                                                    SizedBox(height: 16,),
                                                                    Text(
                                                                      "25% Off",
                                                                      style: GoogleFonts.inter(
                                                                        color: Color(0xff0a0a0a),
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 16,),
                                                                    Text(
                                                                      "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ",
                                                                      textAlign: TextAlign.center,
                                                                      style: GoogleFonts.inter(
                                                                        color: ColorPalette.subtextGrey,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                      child: Text(
                                                        "APPLY",
                                                        style: GoogleFonts.inter(
                                                          color:
                                                              Color(0xffff477b),
                                                          fontSize: w / 26,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia conseq uat duis enim velit mollit.",
                                                  style: GoogleFonts.inter(
                                                    color: ColorPalette
                                                        .subtextGrey,
                                                    fontSize: w / 27,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _showModalBottomSheet1();
                                                  },
                                                  child: Text(
                                                    "T&C APPLY",
                                                    style: GoogleFonts.inter(
                                                      color: Color(0xffff477b),
                                                      fontSize: w / 27,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: 5)
                        ],
                      ),
                    ),
                  ));
            },
          );
        });
  }

  _showModalBottomSheet1() {
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
              return Container(
                  height: 350,
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffe8e8e8),
                              ),
                              padding: EdgeInsets.all(8),
                              child: SvgPicture.string(SelfSvg().closeIcon)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Terms and Conditions",
                          style: GoogleFonts.inter(
                            color: ColorPalette.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.string(SelfSvg().pointIcon),
                          SizedBox(width: 5,),
                          Container(
                            width: w/1.15,
                              child: Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia conse quat duis enim velit mollit. Exercitation veniam consequat sunt nost rud amet. Amet minim mollit non deserunt ulla mco est sit aliqua dolor do amet sint. "))
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.string(SelfSvg().pointIcon),
                          SizedBox(width: 5,),
                          Container(
                            width: w/1.15,
                              child: Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia conse quat duis enim velit mollit. Exercitation veniam consequat sunt nost rud amet. Amet minim mollit non deserunt ulla mco est sit aliqua dolor do amet sint. "))
                        ],
                      ),
                    ],
                  ));
            },
          );
        });
  }
}
