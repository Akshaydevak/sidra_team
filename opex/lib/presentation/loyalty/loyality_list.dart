import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/loyalty/widget/previous_historycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/mpos_svg.dart';

class LoyalityList extends StatelessWidget {
  const LoyalityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Loyality List"),
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
                    Text(
                      "Total 1500 Loyalties",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: w/3.5,
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
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
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_up_rounded,color: Colors.black,)
                            ],
                          ) ,
                        ),
                        SizedBox(width: 5,),
                        Container(
                          // width: 57,

                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xfffe5762), width: 1, ),
                            color: Color(0x0cfe5762),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.string(MposSvg().filterIcon),
                              SizedBox(width: 5,),
                              Text(
                                "5",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.primary,
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PreviousHistoryCard(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 6,
                        ),
                    itemCount: 6)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
