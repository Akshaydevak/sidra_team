
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../order_app/order_svg.dart';
import '../order_app/screens/order_view.dart';

class SalesNewOrderCard extends StatelessWidget {
  bool isSelect,isMpos;
  bool selected;
  final VoidCallback? onTapCheckBox;
  SalesNewOrderCard({Key? key,this.isSelect=false,  this.onTapCheckBox,this.selected=false,this.isMpos=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
     PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: OrderView(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
          width: w,
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
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order ",
                            style: TextStyle(
                              fontSize: w/22,
                            ),
                          ),

                          Text(
                            "#514464HGT515K",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: w/22,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Ordered on 12 Jun 2020",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.subtextGrey,
                          fontSize: w/25,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                   Container(
                   padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0xfffff3d4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Pending",
                      style: TextStyle(
                        color: Color(0xffe7ad18),
                        fontSize: w/25,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: w,
              padding: EdgeInsets.all(16),
              decoration: isSelect? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0x33fe5762), width: 1, ),
                color: Color(0x0cfe5762),
              ):BoxDecoration(
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
                color: Color(0xfff7f7f7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "6 Items  |  AED 250  |  COD",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),
            )
          ])),
    );
  }
}
