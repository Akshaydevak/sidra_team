import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/stock_app/stock_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class ProductStock extends StatelessWidget {
  const ProductStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Products"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchCard(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     "Total 105 Products",
                     style: GoogleFonts.roboto(
                       color: ColorPalette.black,
                       fontSize: 18,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   Container(
                     width: 147,
                     height: 35,
                     padding: EdgeInsets.only(left: 10,right: 10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(4),
                       border: Border.all(color: Color(0xff8ca6b6), width: 1, ),
                       color: Color(0xffeef3f6),
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           "All Products",
                           style: TextStyle(
                             color: Color(0xff151522),
                             fontSize: 14,
                           ),
                         ),
                         Icon(Icons.keyboard_arrow_down_outlined)
                       ],
                     ),
                   )
                 ],
              ),
              SizedBox(height: 10,),Container(
                width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                       children: [
                             Container(
                               width: 60,
                               height: 60,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                               ),
                               child: FlutterLogo(size: 60),
                             ),
                             SizedBox(width: 10,),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(
                                   width: 171,
                                   height: 37,
                                   child: Text(
                                     "Lorem ipsum doloamet consectetur adipiscing",
                                     style: TextStyle(
                                       color: Colors.black,
                                       fontSize: 16,
                                     ),
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 Row(
                                   children: [
                                     SvgPicture.string(StockSvg().barcodeIcon),
                                     SizedBox(width: 10,),
                                     Text(
                                       "1254875448754",
                                       style: GoogleFonts.roboto(
                                         color: Color(0xff666161),
                                         fontSize: 14,
                                         fontWeight: FontWeight.w600,
                                       ),
                                     )
                                   ],
                                 )
                               ],
                             )
                       ],
                    ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "105",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Add Stock",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        ), separatorBuilder: (context, index) => Divider(color: ColorPalette.divider), itemCount: 5),
              )
            ],
          ),),
        ),
      ),
    );
  }
}
