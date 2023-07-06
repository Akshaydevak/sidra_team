import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'collection_point_view.dart';
import 'collection_view.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: CollectionPointView(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      //CollectionPointView
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
                 Container(
                   width: 57,
                   height: 57,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     color: Color(0xff1ecac0),
                   ),
                   alignment: Alignment.center,
                   child: Text(
                     "P",
                     style: GoogleFonts.roboto(
                       color: Colors.white,
                       fontSize: 36,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ),
                 SizedBox(width: 10,),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         "POS Collection",
                         style: GoogleFonts.roboto(
                           color: Colors.black,
                           fontSize: 16,

                           fontWeight: FontWeight.w500,
                         ),
                       ),
                       Text(
                         "Created on 12 Jun 2020",
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
