import 'package:cluster/presentation/purchase_app/purchase_svg.dart';
import 'package:cluster/presentation/purchase_app/view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PurchaseOrdercard extends StatelessWidget {
  bool isRecieve;
   PurchaseOrdercard({Key? key,this.isRecieve=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ViewScreen(),
          withNavBar: true,
          // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      //  ViewScreen
      },
      child: Container(
        width: w,
        // height: 174,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffe6ecf0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0f000000),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: w,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "P.O : 130215421",
                        style: TextStyle(
                          color: Color(0xff7d7d7d),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "From : Sidra Application",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Order date :",
                            style:
                                TextStyle(fontSize: 14, color: Color(0xff7D7D7D)),
                          ),
                          Text(
                            " 12 July 2020, 10:30 AM",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffE6ECF0),
                  width: w,
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                        child: SvgPicture.string(PurchaseSvg().downloadIcon)),
                    Container(
                      width: 1,
                      color: Color(0xffE6ECF0),
                      height: 50,
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: SvgPicture.string(PurchaseSvg().shareIcon)),
                  ],
                )
              ],
            ),
            Positioned(
              right: 0,
              top: 10,
              child:isRecieve? Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  "130 Products",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 14,
                    // fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ):Container(
                width: 120,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color(0x33189c3d),
                ),
                alignment: Alignment.center,
                child: Text(
                  "AED. 3245.50",
                  style: GoogleFonts.roboto(
                    color: Color(0xff199c3e),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
