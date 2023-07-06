import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/seller_app/payment_commissions.dart';
import 'package:cluster/presentation/seller_app/seller_card.dart';
import 'package:cluster/presentation/seller_app/seller_quick.dart';
import 'package:cluster/presentation/seller_app/sellers_screen.dart';
import 'package:cluster/presentation/seller_app/slr_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/home_card.dart';
import '../task_operation/task_svg.dart';
import 'applications_card.dart';

class SellerHomePage extends StatefulWidget {
  bool isAdmin;
   SellerHomePage({Key? key,this.isAdmin=false}) : super(key: key);

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  String? selGender;
  List<String> gender = ["Today’s Report", "Today’s Report", "Today’s Report"];
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Seller App"),
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

                    Text(
                      "View Insight",
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: w/22,

                        fontWeight: FontWeight.w500,
                      ),
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
                      sub: "Total Sales",
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
                      sub: "Total Revenue",
                    ),
                    HomeCard(
                      head: '362',
                      sub: "Total Customers",
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
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
                            "Chat with a Seller",
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
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SellersScreen(),
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
                            SvgPicture.string(
                              MposSvg().handIcon  ,
                              color: ColorPalette.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sellers List",
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
                widget.isAdmin==false?Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Applications :",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ApplicationsCard(label: "Setup your\nStore"),
                        GestureDetector(
                          onTap: (){
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PaymentCommissions(),
                              withNavBar: true,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                              PageTransitionAnimation.fade,
                            );
                          //  PaymentCommissions
                          },
                          child: ApplicationsCard(
                            label: "Payment &\nCommissions",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ApplicationsCard(label: "Contracts"),
                        ApplicationsCard(
                          label: "Rebate",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ):Container(),


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
                SellerQuick(isAdmin: widget.isAdmin,),
                SizedBox(
                  height: 26,
                ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     widget.isAdmin?"New Sellers":"New Orders",
                     style: GoogleFonts.roboto(
                       color: Colors.black,
                       fontSize: w/20,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   Text(
                     "View All",
                     style: GoogleFonts.roboto(
                       color: Color(0xfffe5762),
                       fontSize: w/22,
                       fontWeight: FontWeight.w500,
                     ),
                   )
                 ],
               ) ,
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) => widget.isAdmin?SellerCard(): SellerOrderCard(),

                ),
                BottomCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
