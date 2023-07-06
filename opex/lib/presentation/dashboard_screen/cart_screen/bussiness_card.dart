import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_widgets/gradient_button.dart';
import '../../../../core/color_palatte.dart';

class BussinessCard extends StatefulWidget {
  const BussinessCard({Key? key}) : super(key: key);

  @override
  State<BussinessCard> createState() => _BussinessCardState();
}

class _BussinessCardState extends State<BussinessCard> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: FlutterLogo(size: 60),
          ),
          Container(
            width: w / 1.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Afthabu Rahman share a purchase order with you",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w / 22,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // padding: EdgeInsets.all(16),
                  width: w / 1.4,
                  // height: 148,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0x4ca9a8a8),
                      width: 1,
                    ),
                    color: Color(0xffF8F7F5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 14),
                        child: Row(
                          children: [
                            Text(
                              "Order ID : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 25,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "3654136434",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "No.of Items :  ",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff6d6d6d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "23",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Order Type   : ",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff6d6d6d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Purchase Order",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Order Date   : ",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff6d6d6d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "12 Jun 2022",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _showModalBottomSheet();
                  },
                  child: Container(
                    width: w / 1.4,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xfffe5762),
                        width: 1,
                      ),
                      color: Color(0x0cfe5762),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "View Orders",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(

            builder: (BuildContext context, StateSetter setState) {

              return Container(
                padding: EdgeInsets.only(top: 20,left: 16,right: 16),
                // height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Id : #35165445413",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(14),
                        width: w,
                        height: 115,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                          color: Color(0xfff8f7f5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "No.of Items :  ",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff6d6d6d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "23",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Order Type   : ",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff6d6d6d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Purchase Order",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Order Date   : ",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff6d6d6d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "12 Jun 2022",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ) ,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Order Lines",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: w,
                      padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Color(0xfffff6f7),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              child: FlutterLogo(size: 55),
                            ),
                            Container(
                              width: w/1.45,
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam",
                                style: TextStyle(
                                  color: Color(0xff030202),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),    SizedBox(height: 10,),
                      Container(
                        width: w,
                      padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Color(0xfffff6f7),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              child: FlutterLogo(size: 55),
                            ),
                            Container(
                              width: w/1.45,
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam",
                                style: TextStyle(
                                  color: Color(0xff030202),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      GradientButton(
                        color:ColorPalette.primary ,
                          onPressed: () {



                          },
                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ColorPalette.primary, ColorPalette.primary]),
                          child: Text(
                            "Add to Cart",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
