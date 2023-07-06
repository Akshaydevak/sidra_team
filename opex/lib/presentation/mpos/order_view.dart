import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/new_ordercard.dart';
import 'mpos_svg.dart';

class OrderViewScreen extends StatelessWidget {
  const OrderViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Order View",isAction: false,),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(width:w/1.35,child: SearchCard()),
                     Container(
                       padding: EdgeInsets.all(13),
                       width: 50,
                       height: 50,
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
                       child: SvgPicture.string(MposSvg().filterIcon),
                     )
                   ],
                 ),
                 SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "Total 20 Orders",
                       style: GoogleFonts.roboto(
                         color: Color(0xff151522),
                         fontSize: w/20,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Row(
                       children: [
                         Text(
                           "Latest",
                           style: GoogleFonts.roboto(
                             color: ColorPalette.black,
                             fontSize: 15,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                         Icon(Icons.keyboard_arrow_down_outlined)
                       ],
                     )
                   ],
                 ),
                 SizedBox(height: 10,),
                 Container(
                   child: ListView.separated(
                       shrinkWrap: true,
                       primary: false,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (context, index) {
                         return NewOrderCard(
isMpos: true,
                         );
                       },
                       separatorBuilder: (context, index) => Container(
                         height: 10,
                       ),
                       itemCount: 5),

                 ),
                 SizedBox(height: 40,)
               ],
            ),
          ),
        ),
      ),
    );
  }
}
