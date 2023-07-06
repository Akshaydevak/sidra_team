import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'customer_details.dart';
import 'mpos_svg.dart';

class CustomerListCard extends StatelessWidget {
  const CustomerListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: CustomerDetails(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        width: w,

        padding: EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: ColorPalette.inactiveGrey,
              ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Afthabu Rahman",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Thondayadu, Kozhikode",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: 14,
                      ),
                    )
                  ],
                )
              ],
            ),
            SvgPicture.string(MposSvg().moreIcon)
          ],
        ),
      ),
    );
  }
}
