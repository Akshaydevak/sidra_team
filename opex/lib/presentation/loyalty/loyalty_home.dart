import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/loyalty/loyality_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import '../task_operation/home_card.dart';
import '../task_operation/task_svg.dart';
import '../task_operation/task_title/four_card.dart';
import 'widget/loyality_card.dart';
import 'loyality_creation.dart';
import 'loyality_list.dart';
import 'loyality_settings.dart';
import 'loyality_tyres.dart';

class LoyaltyHome extends StatelessWidget {
  const LoyaltyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Loyality"),
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
                SearchCard(
                  hint: "Search loyality ...",
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Overall List (This month)",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "81,120",
                      sub: "Monthly Loyality",
                    ),
                    HomeCard(
                      head: '32',
                      sub: "Applied Category",
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "32,200",
                      sub: "Loyality Expired",
                    ),
                    HomeCard(
                      head: '364',
                      sub: "Transactions",
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: LoyalityTyre(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                    //  ContractList
                  },
                  child: Container(
                    width: w,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    // height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffdf2f2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.string(LoyalitySvg().heartIcon),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Loyalty Tyres",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 20,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.string(TaskSvg().arrowIcon)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Quick access to :",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: LoyalityCreation(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        //  LoyalityCreation
                        },
                        child: FourCard(
                          label: "Create New",
                        )),
                    GestureDetector(child: FourCard(
                      label: "Insights",
                    )),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: LoyalityList(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      //  LoyalityList
                      },
                      child: FourCard(
                        label: "Loyality List",
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: LoyalitySetting(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      //  LoyalitySetting
                      },
                      child: FourCard(
                        label: "Settings",
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Loyality Transactions",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: w/22,
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
                    itemBuilder: (context, index) => LoyalityCard(),
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemCount: 6),
                 BottomCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
