import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:cluster/presentation/order_app/quick_access.dart';
import 'package:cluster/presentation/task_operation/home_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


import '../../../common_widgets/headline_text.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import 'all_order_tab.dart';
import '../new_ordercard.dart';
import 'order_view.dart';

class OrderHomePage extends StatefulWidget {
  const OrderHomePage({Key? key}) : super(key: key);

  @override
  State<OrderHomePage> createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Order Management"),
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 14,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SearchCard(),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HomeCard(
                                  head: "120",
                                  sub: "New Orders",
                                ),
                                HomeCard(
                                  head: '3652',
                                  sub: "Pending Orders",
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
                                  head: "120",
                                  sub: "Returned Orders",
                                ),
                                HomeCard(
                                  head: '3652',
                                  sub: "SubscriptionOrders",
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      HeadlineText(headText: "Quick access to :"),
                      QuickAccess(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New Orders",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // AllOrderTab
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: AllOrderTab(),
                                  withNavBar: true,
                                  // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                              },
                              child: Text(
                                "View All",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.primary,
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => NewOrderCard(),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: 5),
                      BottomCard()
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
