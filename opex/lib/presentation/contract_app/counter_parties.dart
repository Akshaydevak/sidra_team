import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/mpos_svg.dart';
import '../mpos/search_card.dart';

class CounterParties extends StatelessWidget {
  const CounterParties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Counter Parties"),
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
                    GestureDetector(
                      onTap: (){
                        // _showModalBottomSheet();

                      },child: Container(
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
                      child: SvgPicture.string(MposSvg().filterIcon,color: ColorPalette.subtextGrey,),
                    ),
                    )
                  ],
                ),

                SizedBox(height: 16,),
                Text(
                  "Total 124 Counter Parties",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(

                    width: w,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0x28d9d9d9),
                    ),

                  child: ListView.separated(
                    primary: true,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    separatorBuilder: (context, index) => Divider(
                    indent: 30,
                    ),
                    itemBuilder: (context, index) =>Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundColor: ColorPalette.inactiveGrey,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            "Afthimal1254@gmail.com",
                            style: TextStyle(
                              color: Color(0xff151522),
                              fontSize: w/22,
                            ),
                          )
                        ],
                      ),
                    ) ,
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
