import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../order_app/order_svg.dart';

class BussinessUnit extends StatelessWidget {
  const BussinessUnit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Business Units",isAction: false,),
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
                Container(
                  width: w,
                  // height: 80,
                  padding: EdgeInsets.all(16),
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
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 35,
                            backgroundColor: ColorPalette.inactiveGrey,
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
                                  fontSize: 18,
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
                              )
                            ],
                          )
                        ],
                      ),
                      SvgPicture.string(OrderSvg().callIcon,color: ColorPalette.primary ,),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  "Business Units",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: w,
                  height: 187,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:  Color(0xff69ca1d),
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
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Super Market",
                                  style: TextStyle(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: w/1.5 ,
                                  child: Text(
                                    "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: w/25,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
