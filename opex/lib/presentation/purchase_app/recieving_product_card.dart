import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import '../order_app/order_svg.dart';

class RecievingProductCard extends StatefulWidget {
  RecievingProductCard({Key? key}) : super(key: key);

  @override
  State<RecievingProductCard> createState() => _RecievingProductCardState();
}

class _RecievingProductCardState extends State<RecievingProductCard> {
  bool isRecieve = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        _showModalBottomSheet();
      },
      child: Container(
        width: w,
        // height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffe6ecf0),
            width: 1,
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, top: 20, bottom: 10, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w / 1.62,
                    child: Text(
                      "Musafir Pure Loium Nahjtu Sodi\num Nasafir Pu..",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    "AED 420.50",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 27,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Color(0xffE6ECF0),
              thickness: 1.1,
            ),
            Container(
              width: w,
              padding: EdgeInsets.only(top: 10, bottom: 20, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isRecieve = !isRecieve;
                          });
                        },
                        child: isRecieve
                            ? Container(
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.string(
                                    OrderSvg().checkBoxActiveIcon),
                              )
                            : SvgPicture.string(OrderSvg().checkBoxIcon),
                      ),
                      Text(
                        "Is Received",
                        style: GoogleFonts.poppins(
                          color: Color(0xff1b1b1f),
                          fontSize: w / 26,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Ordered\nQuantiry",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 70,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffe0e3e5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Color(0xfff7f7f7),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "54",
                          style: GoogleFonts.roboto(
                            color: Color(0x66151522),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Recieved\nQuantiry",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          width: 70,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Color(0xffe6ecf0).withOpacity(0.5),
                                        width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Color(0xffe6ecf0),
                                        width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: Color(0xffe6ecf0),
                                      width: 1)),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    List<String> head=["Vendor Reference Code","Init Cost","Currant Quantity","Discount","Purchase UOM","FOC","Requested Quantity","Vatable Amount","Excise Tax","Actual Cost","VAT","Grand TOTAL"];
    List<String> subHead=["125421","AED 201.50","125421","AED 30.50","Pack","AED 25.50","14","AED 35.50","AED 55.50","AED 1052.50","AED 22.50","AED 548.50"];
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
                          children: [
                            Container(

                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xfff0f1f2),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "15464646545 ",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: w/1.5,
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing ealiquam ...",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xffE6ECF0),
                      ),
                      GridView.builder(
                        itemCount: head.length,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        primary: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:3.5/2,
                        crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10
                      ), itemBuilder: (context, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                             width: 186,
                             height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  head[index],
                                  style: TextStyle(
                                    color: Color(0xff666161),
                                    fontSize: w/26,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  subHead[index],
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 18,

                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),)
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
