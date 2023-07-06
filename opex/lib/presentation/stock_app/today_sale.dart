import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/stock_app/stock_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'out_stock_card.dart';

class TodaySaleScreen extends StatelessWidget {
  const TodaySaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Today’s Sale"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                   children: [
                     Container(
                       width: w,

                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                         boxShadow: [
                           BoxShadow(
                             color: Color(0x05000000),
                             blurRadius: 8,
                             offset: Offset(1, 1),
                           ),
                         ],
                         color: Colors.white,
                       ),
                       child: Stack(
                         children: [


                       Container(
                         padding: EdgeInsets.all(16),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               "Sold Products",
                               style: GoogleFonts.roboto(
                                 color: Colors.black,
                                 fontSize: 16,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                             SizedBox(height: 10,),
                             Text(
                               "120",
                               style: GoogleFonts.roboto(
                                 color: Colors.black,
                                 fontSize: 34,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                             SizedBox(height: 5,),
                             Row(
                               children: [
                                 SvgPicture.string(StockSvg().graphIcon),
                                 Text(
                                   "15%  Yesterday",
                                   style: GoogleFonts.roboto(
                                     color: Color(0xff58bb2c),
                                     fontSize: 14,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 )
                               ],
                             )
                           ],
                         ),
                       ),
                           Positioned(
                             right: 0,
                               top: 10,
                               child: Icon(Icons.more_vert))
                ])
                     ) ,
                     SizedBox(height: 5,),
                     Container(
                       width: w,

                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                         boxShadow: [
                           BoxShadow(
                             color: Color(0x05000000),
                             blurRadius: 8,
                             offset: Offset(1, 1),
                           ),
                         ],
                         color: Colors.white,
                       ),
                       child: Stack(
                         children: [


                       Container(
                         padding: EdgeInsets.all(16),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               "Today’s Orders",
                               style: GoogleFonts.roboto(
                                 color: Colors.black,
                                 fontSize: 16,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                             SizedBox(height: 10,),
                             Text(
                               "120",
                               style: GoogleFonts.roboto(
                                 color: Colors.black,
                                 fontSize: 34,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                             SizedBox(height: 5,),
                             Row(
                               children: [
                                 SvgPicture.string(StockSvg().graphIcon),
                                 Text(
                                   "15%  Yesterday",
                                   style: GoogleFonts.roboto(
                                     color: Color(0xff58bb2c),
                                     fontSize: 14,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 )
                               ],
                             )
                           ],
                         ),
                       ),
                           Positioned(
                             right: 0,
                               top: 10,
                               child: Icon(Icons.more_vert))
                ])
                     )
                   ],
                ),
              ),
              Container(padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Most Unit Sold",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Out of stock items",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "View All",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => OutStockCard(),
                        separatorBuilder: (context, index) => SizedBox(height: 10,),
                        itemCount: 6)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
