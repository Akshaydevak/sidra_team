import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../order_app/order_svg.dart';

class PickAndPackCard extends StatefulWidget {

  const PickAndPackCard({Key? key}) : super(key: key);

  @override
  State<PickAndPackCard> createState() => _PickAndPackCardState();
}

class _PickAndPackCardState extends State<PickAndPackCard> {
  bool isPick=false;
  bool isQuality=false;
  bool isPack=false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
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
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xfff0f1f2),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                        right: 0,
                        child: SvgPicture.string(MposSvg().giftIcon))
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "15464646545 ",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 209,
                      height: 37,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing ea...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w / 22,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Brand ",
                                style: TextStyle(
                                  color: const Color(0xff666161),
                                  fontSize: w / 22,
                                ),
                              ),
                              Text(
                                ": ",
                                style: TextStyle(
                                  color: const Color(0xff666161),
                                  fontSize: w / 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Specimen",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price ",
                                style: TextStyle(
                                  color: const Color(0xff666161),
                                  fontSize: w / 22,
                                ),
                              ),
                              Text(
                                ": ",
                                style: TextStyle(
                                  color: const Color(0xff666161),
                                  fontSize: w / 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "AED 145.50 / Piece",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isPick=!isPick;
                        });
                      },
                      child: isPick
                          ? Container(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.string(
                              OrderSvg().checkBoxActiveIcon))
                          : SvgPicture.string(OrderSvg().checkBoxIcon,height: 35,width: 35,),
                    ),
                    Text(
                      "Picked",
                      style: GoogleFonts.roboto(
                        color: Color(0xff1b1b1f),
                        fontSize: w/26,

                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ), Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isQuality=!isQuality;
                        });
                      },
                      child: isQuality
                          ? Container(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.string(
                              OrderSvg().checkBoxActiveIcon))
                          : SvgPicture.string(OrderSvg().checkBoxIcon,height: 35,width: 35,),
                    ),
                    Text(
                      "QuantityChecked",
                      style: GoogleFonts.roboto(
                        color: Color(0xff1b1b1f),
                        fontSize: w/26,

                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isPack=!isPack;
                        });
                      },
                      child: isPack
                          ? Container(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.string(
                              OrderSvg().checkBoxActiveIcon))
                          : SvgPicture.string(OrderSvg().checkBoxIcon,height: 35,width: 35,),
                    ),
                    Text(
                      "Packed",
                      style: GoogleFonts.roboto(
                        color: Color(0xff1b1b1f),
                        fontSize: w/26,

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
    );
  }
}
