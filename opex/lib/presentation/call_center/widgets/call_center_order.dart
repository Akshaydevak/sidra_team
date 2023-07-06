import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CallCenterOrder extends StatelessWidget {
  const CallCenterOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: ColorPalette.inactiveGrey,
          ),
          SizedBox(width: 5,),
          Container(
            width: w/1.39,
            // color: Colors.grey,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Afthabu Rahman P P",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Order ID : #125455658",
                          style: TextStyle(
                            color: Color(0xff7d7d7d),
                            fontSize: w/26,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0x33ef6d1f),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Pending",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          color: Color(0xffef6d1f),
                          fontSize: w/25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(color: ColorPalette.divider,),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ORDER DATE",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.subtextGrey,
                            fontSize: w/27,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "12 July 2012",
                          style:  GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ORDER DATE",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.subtextGrey,
                            fontSize: w/27,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "12 July 2012",
                          style:  GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
