import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_svg.dart';
import 'package:cluster/presentation/seller_app/seller_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../order_app/order_svg.dart';

class SellerCard extends StatelessWidget {
  const SellerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: SellerView(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      //  SellerView
      },
      child: Container(
        width: w,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RM General Trading",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "Super Market",
                  style: TextStyle(
                    color: Color(0xff7d7d7d),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    SvgPicture.string(ProfileSvg().emailIcon),
                    SizedBox(width: 5,),
                    Text(
                      "www.rawabimarket.com",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ) ,SizedBox(height: 5,),
                Row(
                  children: [
                    SvgPicture.string(OrderSvg().callIcon,color: ColorPalette.primary,height: 15,width: 15,),
                    SizedBox(width: 5,),
                    Text(
                      "+971 986587454",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
