import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../order_app/order_svg.dart';
import '../../task_operation/task_svg.dart';
class PreviousHistoryCard extends StatefulWidget {

   PreviousHistoryCard({Key? key}) : super(key: key);

  @override
  State<PreviousHistoryCard> createState() => _PreviousHistoryCardState();
}

class _PreviousHistoryCardState extends State<PreviousHistoryCard> {
  bool isSelect=false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
        color: Color(0xfffcfbfa),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child:Text(
              "Bulk > Baby Products",
              style: TextStyle(
                color: ColorPalette.subtextGrey,
                fontSize: 13,
              ),
            ),
          ),
          Container(
            width: w,
            height: 1,
            color: ColorPalette.divider,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Spend",
                      style: GoogleFonts.poppins(
                        color: ColorPalette.subtextGrey,
                        fontSize: w/25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "AED 10",
                      style: GoogleFonts.poppins(
                        color: ColorPalette.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Container(height: 85,
                width: 1,
                color: ColorPalette.divider,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "They will get",
                          style: GoogleFonts.poppins(
                            color: ColorPalette.subtextGrey,
                            fontSize: w/26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "1",
                          style: GoogleFonts.poppins(
                            color: ColorPalette.black,
                            fontSize: w/20,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSelect=!isSelect;
                        });
                      },
                      child: SvgPicture.string(
                          isSelect?HomeSvg().toggleActive:HomeSvg().toggleInActive),
                    ),
                    SizedBox(width: 8,),
                    PopupMenuButton(
                      icon: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xfffceeee),
                        ),
                        child: Icon(Icons.more_vert),
                      ),
                      //don't specify icon if you want 3 dot menu
                      color: Colors.white,
                      elevation: 2,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            padding: const EdgeInsets.all(0),
                            value: 'a',
                            enabled: true,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Edit',
                                    style: GoogleFonts.poppins(
                                        color: ColorPalette.primary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )),  PopupMenuItem(
                            padding: const EdgeInsets.all(0),
                            value: 'a',
                            enabled: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Delete Loyality',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black54,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ))
                      ],
                      onSelected: (value) {},
                    ),
                  ],
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
