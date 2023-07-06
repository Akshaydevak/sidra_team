import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../order_app/order_svg.dart';
import 'order_details_card.dart';
import 'order_line.dart';

class MposOrderView extends StatelessWidget {
  const MposOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body:DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[



              Container(
                height: h/1.25,
                color:  Colors.white,
                // padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 130,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: w / 1.1,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0x4ca9a8a8),
                                  width: 1,
                                ),
                                color: Color(0xfff8f7f5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Order ID",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff1b1b1f),
                                          fontSize: w / 22,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "#OTHG3514",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xff1b1b1f),
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Order Date",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff1b1b1f),
                                          fontSize: w / 22,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        " 15 Jan, 2022",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xff1b1b1f),
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Container(
                              width: 80,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0xffe6ecf0),
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
                              child: SvgPicture.string(OrderSvg().qrIcon),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      width: w,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: w,
                              height: 5,
                              color: Color(0xfff8f7f5),
                            ),
                          ),
                          Container(
                            width: w/1.5,
                            child: TabBar(
                              padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                labelColor: Colors.black,
                                indicatorColor: ColorPalette.primary,indicatorWeight: 5,
                                unselectedLabelColor: Colors.black,
                                labelStyle:
                                GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                unselectedLabelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                labelPadding: EdgeInsets.zero,
                                tabs: [
                                  Tab(text: "Order Lines",),
                                  const Tab(text: "Order Details"),
                                ]),
                          ),

                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        color:  Colors.white,
                        child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              OrderLineScreen(),
                              OrderDetailsCard(),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
