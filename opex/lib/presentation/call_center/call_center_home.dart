import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:cluster/presentation/call_center/search_screen.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../task_operation/home_card.dart';
import '../task_operation/task_svg.dart';
import 'callcenter_search.dart';
import 'widgets/call_center_order.dart';
import 'widgets/call_center_quick.dart';
import 'widgets/gp_card.dart';

class CallCenterHome extends StatelessWidget {
  const CallCenterHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Call Center App",
          isAction: true,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchCard(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeCard(
                          head: "120",
                          sub: "Today Sales",
                        ),
                        HomeCard(
                          head: '32',
                          sub: "Total Orders",
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
                          head: "3200",
                          sub: "Total Holdings",
                        ),
                        HomeCard(
                          head: '362',
                          sub: "Product Sold",
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w,
                      height: 133,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfffe5762),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "YOU WILL NEED TO CREATE NEW ORDER",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 23,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: (){
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: SearchScreen(),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                              );

                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Start New Order",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GpCard(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick access to :",
                      style: GoogleFonts.roboto(
                        color: Color(0xff151522),
                        fontSize: w / 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CallCenterQuickAccess(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfffdf2f2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pending for Approval",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w/22,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "25",
                                style: GoogleFonts.roboto(
                                  color: Color(0xfffd5762),
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10,),
                              SvgPicture.string(TaskSvg().arrowIcon),
                            ],
                          )
                        ],
                      ),
                    ) ,SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfffdf2f2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment History",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w/22,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "205",
                                style: GoogleFonts.roboto(
                                  color: Color(0xfffd5762),
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10,),
                              SvgPicture.string(TaskSvg().arrowIcon),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "New Orders",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      primary: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemBuilder: (context, index) => CallCenterOrder(),
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
