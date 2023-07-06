import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/payments/payment_logs.dart';
import 'package:cluster/presentation/payments/payment_transaction_card.dart';
import 'package:cluster/presentation/payments/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/home_card.dart';
import '../task_operation/task_title/four_card.dart';

class PaymentsHome extends StatelessWidget {
  const PaymentsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Payments",
          isAction: true,
        ),
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
                  // height: 145,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 9,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: Color(0xfff2eeee),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 59.50,
                            height: 1.50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff919191),
                                width: 0.50,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "BY CARD",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 59.50,
                            height: 1.50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff919191),
                                width: 0.50,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "AED 2,81,1200",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "120",
                      sub: "Transactions",
                    ),
                    HomeCard(
                      head: '32',
                      sub: "Total Credits",
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
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
                          //  LoyalityCreation
                        },
                        child: FourCard(
                          label: "Manage Payment",
                        )),
                    GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: PaymentLogs(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        },
                        child: FourCard(
                          label: "Payment Logs",
                        )),
                    GestureDetector(
                      onTap: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: LoyalityList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                        //  LoyalityList
                      },
                      child: FourCard(
                        label: "Manage Credit",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: PaymentSetting(),
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Payment Transactions",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PaymentTransactionCard(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 5),
                BottomCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
