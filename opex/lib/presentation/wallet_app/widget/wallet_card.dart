import 'package:cluster/presentation/wallet_app/wallet_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../wallet_card_view.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: WalletCardView(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );

      },
      child: Container(
        width: w,
        padding: EdgeInsets.all(10),
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
          color: Color(0xfffcfbfb),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.string(WalletSvg().walletStarIcon),
                SizedBox(width: 5,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AED 364.25",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "PRODUCT HUB",
                      style: GoogleFonts.roboto(
                        color: Color(0xff7d7d7d),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text(
                      "Ref : #6565525454",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
             children: [
               Text(
                 "01 October, 2022",
                 style: TextStyle(
                   color: Color(0xff7d7d7d),
                   fontSize: 14,
                 ),
               ),
               SizedBox(height: 16,),
               Container(
                 width: 94,
                 height: 35,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(4),
                   color: Color(0xfffd5762),
                 ),
                 alignment: Alignment.center,
                 child: Text(
                   "Use Now",
                   style: GoogleFonts.roboto(
                     color: Colors.white,
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
               )
             ],
            )
          ],
        ),
      ),
    );
  }
}
