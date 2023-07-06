import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/loyalty/widget/loyality_tyre_card.dart';
import 'package:cluster/presentation/loyalty/widget/toggle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/task_svg.dart';
import 'loyality_svg.dart';
import 'new_loyality_tyre.dart';

class LoyalityTyre extends StatelessWidget {
  const LoyalityTyre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Loyality Tyres"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ToggleCard(
                  label: "Enable/Disable Loyalty Points",
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: NewLoyalityTyre(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );

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
                              "Add NewLoyalty Tyres",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/22,
                                fontWeight: FontWeight.w500,
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
                LoyalityTyreCard(
                  svg: LoyalitySvg().basicIcon,
                  label: "BASIC",
                ),
                SizedBox(height: 5,),
                LoyalityTyreCard(
                  svg: LoyalitySvg().silverIcon,
                  label: "SILVER",
                ), SizedBox(height: 5,),
                LoyalityTyreCard(
                  svg: LoyalitySvg().goldenIcon,
                  label: "GOLD",
                ),SizedBox(height: 5,),
                LoyalityTyreCard(
                  svg: LoyalitySvg().plantinumIcon,
                  label: "PLATINUM",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
