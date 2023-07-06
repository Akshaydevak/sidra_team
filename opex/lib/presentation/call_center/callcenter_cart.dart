import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import 'cart_tab/cart_screen_callcenter.dart';
import 'cart_tab/orderdetails_screen.dart';

class CallCenterCart extends StatelessWidget {
  const CallCenterCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
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
      body: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
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
                  color: Colors.transparent,
                  // padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          labelColor: Colors.black,
                          indicatorColor: ColorPalette.primary,
                          indicatorWeight: 5,
                          unselectedLabelColor: Colors.black,
                          labelStyle: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          tabs: const [
                            Tab(text: "Cart(6 Items)"),
                            Tab(text: "Order Details"),
                            Tab(text: "Explore"),
                          ]),
                    ],
                  ),
                ),

              ],
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CartScreenCallCenter(),
                      OrderDetails(),
                      Text("ewhf"),

                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
