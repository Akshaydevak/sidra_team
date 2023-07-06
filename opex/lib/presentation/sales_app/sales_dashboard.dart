import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:cluster/presentation/sales_app/sales_new_order_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

import '../task_operation/home_card.dart';
import '../mpos/search_card.dart';
import '../order_app/screens/all_order_tab.dart';

import '../order_app/quick_access.dart';

class SalesDashboard extends StatefulWidget {
  const SalesDashboard({Key? key}) : super(key: key);

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Seller App"),
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: 14,
                // ),
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
                                  sub: "Invoice Generated",
                                ),
                                HomeCard(
                                  head: '3652',
                                  sub: "Subscribtion Orders",
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 26,
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
                        height: 14,
                      ),
                      QuickAccess(),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New Orders",
                              style: GoogleFonts.roboto(
                                color: Color(0xff151522),
                                fontSize: w/22,
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
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                                primary: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    SalesNewOrderCard(),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10,
                                    ),
                                itemCount: 5),

                          BottomCard()
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
