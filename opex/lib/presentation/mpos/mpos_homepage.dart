import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/mpos/quick_access_card.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/mpos/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/headline_text.dart';
import '../dashboard_screen/cart_screen/cart_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

import '../order_app/new_ordercard.dart';
import '../task_operation/home_card.dart';
import 'order_view.dart';

class MposHomepage extends StatefulWidget {
  const MposHomepage({Key? key}) : super(key: key);

  @override
  State<MposHomepage> createState() => _MposHomepageState();
}

class _MposHomepageState extends State<MposHomepage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "POS"),
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
                    Container(width: w / 1.35, child: SearchCard()),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xffe6ecf0),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: SvgPicture.string(MposSvg().scannerIcon),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "120",
                      sub: "Today’s Sale",
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
                      sub: "Product Sold",
                    ),
                    HomeCard(
                      head: '362',
                      sub: "Cash Collected",
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: w,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x0cfe5762),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Check a product status by",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatusCard(
                            svg: MposSvg().scannerIcon,
                            label: "SCAN PRODUCT",
                          ),
                          StatusCard(
                            svg: MposSvg().collectIcon,
                            label: "VIEW COLLECTIONS",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                HeadlineText(headText: "Quick access to :"),
                QuickAccessCard(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Orders",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: OrderViewScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
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
                const SizedBox(
                  height: 14,
                ),
                Container(
                  child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewOrderCard(isMpos: true,);
                      },
                      separatorBuilder: (context, index) => Container(
                            height: 10,
                          ),
                      itemCount: 5),
                ),
                const BottomCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
