import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/bottom_card.dart';

import 'package:cluster/presentation/stock_app/stock_management.dart';
import 'package:cluster/presentation/stock_app/today_sale.dart';
import 'package:cluster/presentation/stock_app/virtual_stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../loyalty/widget/loyality_card.dart';
import '../mpos/mpos_svg.dart';
import '../task_operation/home_card.dart';
import '../task_operation/task_svg.dart';
import '../task_operation/task_title/four_card.dart';
import 'out_stock_card.dart';

class StockHome extends StatelessWidget {
  String? selGender;
  List<String> gender = ["Today’s Report", "Today’s Report", "Today’s Report"];
  String? selectedGender;
   StockHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Stock App"),
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
                  width: w / 2.3,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: DropdownButton(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      underline: Container(),
                      items: gender.map((String items) {
                        return DropdownMenuItem(
                          enabled: true,
                          value: items,
                          child: Text(items,
                              style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      value: selectedGender,
                      onChanged: (dynamic value) {},
                      hint: Text(
                        " Today’s Report",
                        style:TextStyle(
                          color: Colors.black,
                          fontSize: w/22,
                        ),
                      )),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "120",
                      sub: "Stock App",
                    ),
                    HomeCard(
                      head: '32',
                      sub: "Sold stock Today",
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
                      sub: "Out of stock items",
                      color: ColorPalette.primary,
                    ),
                    HomeCard(
                      head: '362',
                      sub: "Pending Products",
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: TodaySaleScreen(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                    // TodaySaleScreen
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
                            SvgPicture.string(
                              HomeSvg().chatGroupIcon,
                              color: ColorPalette.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sold of this day",
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
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    // PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: VendorList(),
                    //   withNavBar: true, // OPTIONAL VALUE. True by default.
                    //   pageTransitionAnimation: PageTransitionAnimation.fade,
                    // );

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
                            SvgPicture.string(
                              MposSvg().handIcon  ,
                              color: ColorPalette.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "View out of stock Items",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
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
                  height: 20,
                ),
                Text(
                  "Quick access to :",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: VirtualStock(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                          //  LoyalityCreation
                        },
                        child: FourCard(
                          label: "Virtual Stock",
                        )),
                    GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: StockManagement(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                        child: FourCard(
                      label: "Stock Manage",
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
                        label: "Manage Products",
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: LoyalitySetting(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                        //  LoyalitySetting
                      },
                      child: FourCard(
                        label: "Insight",
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Out of stock items",
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
                    itemBuilder: (context, index) => OutStockCard(),
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
