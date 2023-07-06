
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/inventory/inventory_quickaccess.dart';
import 'package:cluster/presentation/order_app/quick_access.dart';
import 'package:cluster/presentation/promotion_app/promotion_quickaccess.dart';
import 'package:cluster/presentation/promotion_app/quick_access_card.dart';
import 'package:cluster/presentation/promotion_app/recent_promotion_card.dart';
import 'package:cluster/presentation/promotion_app/slider_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


import '../../common_widgets/headline_text.dart';
import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'multibuy_list.dart';
import 'new_promotion.dart';

class PromotionDashBoard extends StatelessWidget {
  const PromotionDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Promotion App"),
      ),

      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SliderCard(),
              Container(
                width: w,
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16,top: 0,bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadlineText(headText: "Quick access to :"),
                    PromotionQuickAccess(),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: MultiBuyListScreen(label: "Promotion Sale",),
                              withNavBar: true,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                          },
                          child: QuickAccesscard(
                            label: "Promotion Sale",
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: MultiBuyListScreen(label: "MultiBuy",),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                            child: QuickAccesscard(
                              label: "MultiBuy",
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap:(){
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: MultiBuyListScreen(label: "Buy1 Get1",),
                              withNavBar: true,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                          },
                          child: QuickAccesscard(
                            label: "Buy1 Get1",
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: MultiBuyListScreen(label: "Buy More Get More",),
                              withNavBar: true,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );

                          },
                          child: QuickAccesscard(
                            label: "Buy More Get More",
                          ),
                        )
                      ],
                    ),

                    HeadlineText(headText: "Recently added promotion"),


                    ListView.separated(
                      primary: true,
                      shrinkWrap: true,
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, index) =>
                          const RecentPromotionCard(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                    BottomCard()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
