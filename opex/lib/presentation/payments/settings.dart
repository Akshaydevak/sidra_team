import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/payments/payment_screen.dart';
import 'package:cluster/presentation/payments/payment_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class PaymentSetting extends StatefulWidget {
  const PaymentSetting({Key? key}) : super(key: key);

  @override
  State<PaymentSetting> createState() => _PaymentSettingState();
}

class _PaymentSettingState extends State<PaymentSetting> {
  bool isActive=false;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Settings",
          isAction: true,
          action: Icon(Icons.edit),
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
                  child: Column(
                    children: [
                    Text(
                      "Afthabu Rahman",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "afthaburahman313@gmail.com",
                      style:  GoogleFonts.roboto(
                        color: Color(0xff7d7d7d),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],),
                ),

                ClusterCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 16,top: 20,bottom: 10,right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff33c658),
                              ),
                              child: SvgPicture.string(PaymentSvg().profileIcon),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Profile Info",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(indent: 60,),
                      GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: PaymentScreen(),
                            withNavBar: true,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:Color(0xfffc3b3d),
                                ),
                                child: SvgPicture.string(PaymentSvg().paymentIcon),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "Payment",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),Divider(indent: 60,),
                      Container(
                        padding: EdgeInsets.only(left: 16,top: 10,bottom: 20,right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Color(0xffad51e0),
                              ),
                              child: SvgPicture.string(PaymentSvg().securityIcon),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Security Code",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  "More about",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                ClusterCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 16,top: 20,bottom: 10,right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff007bfd),
                              ),
                              child: SvgPicture.string(PaymentSvg().faqIcon),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "FAQs",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(indent: 60,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0xffFF2552),
                                  ),
                                  child: SvgPicture.string(PaymentSvg().notificationIcon),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Notification Alert",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isActive=!isActive;
                                });
                              },
                              child: isActive
                                  ? SvgPicture.string(HomeSvg().toggleActive)
                                  : SvgPicture.string(HomeSvg().toggleInActive),
                            )
                          ],
                        ),
                      ),Divider(indent: 60,),
                      Container(
                        padding: EdgeInsets.only(left: 16,top: 10,bottom: 20,right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Color(0xffFC3B3D),
                              ),
                              child: SvgPicture.string(PaymentSvg().logoutIcon),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
