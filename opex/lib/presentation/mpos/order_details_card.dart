import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../order_app/order_svg.dart';
import '../order_app/orderapp_card.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: SingleChildScrollView(child:
        Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClusterCard(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sbin Sreenivas",
                                style: GoogleFonts.roboto(
                                  color: Color(0xfffe5762),
                                  fontSize: w / 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.string(OrderSvg().callIcon),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.string(OrderSvg().msgIcon),
                            ],
                          ),
                        ],
                      )),
                  Container(
                    width: w,
                    height: 1,
                    color: const Color(0xffE6ECF0),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(8),
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPalette.cardBackground,
                          ),
                          child: SvgPicture.string(OrderSvg().phoneIcon),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "+91 8606200441",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w / 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    width: w,
                    height: 1,
                    color: const Color(0xffE6ECF0),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPalette.cardBackground,
                          ),
                          child: SvgPicture.string(OrderSvg().mailIcon),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "afthaburahman313@gmail.com",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w / 22,
                          ),
                        ),
                      ],
                    ),
                  ), Container(
                    margin: const EdgeInsets.only(left: 50),
                    width: w,
                    height: 1,
                    color: const Color(0xffE6ECF0),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPalette.cardBackground,
                          ),
                          child: SvgPicture.string(OrderSvg().locationIcon),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: w/1.8,
                          child:   Text(
                            "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: w,

              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                children: [SvgPicture.string(OrderSvg().directionIcon),
                  SizedBox(width: 10,),
                  Text(
                    "84KD26293YL1AD166LPLR7",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Delivery Details",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClusterCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: const [
                          Text(
                            "Delivery on ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "12 Jun 2022",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: w,
                    margin: EdgeInsets.only(left: 50),
                    height: 1,
                    color: Color(0xffE6ECF0),
                  ),
                  Container(
                    width: w,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note :",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Payment Method",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClusterCard(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0x7fe6ecf0),
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Image.asset("asset/cardicon.png"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Afthabu Rahman PP",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "****  ****  **** ",
                              style: TextStyle(
                                color: Color(0xff1b1b1f),
                                fontSize: 18,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "5326",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )),
            SizedBox(height: 20,)
          ],
        ),
      )),
    );
  }
}
