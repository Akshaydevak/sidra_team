import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/contract_app/subscriptions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/cluster_card.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';

class ContractProfile extends StatelessWidget {
  const ContractProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Profile",isAction: false,),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ClusterCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sbin Sreenivas",
                                    style: GoogleFonts.roboto(
                                      color: Color(0xfffe5762),
                                      fontSize: w / 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: SubscriptionScreen(),
                                    withNavBar: true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation.fade,
                                  );
                                },
                                child: Text(
                                  "Free Plan",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: w/23,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          )),
                      Container(
                        width: w,
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color:   Color(0xffffeff0),
                              ),
                              child: SvgPicture.string(OrderSvg().phoneIcon),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "+91 8606200441",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: w,
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color:  Color(0xffffeff0),
                              ),
                              child: SvgPicture.string(OrderSvg().mailIcon),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "afthaburahman313@gmail.com",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 22,
                              ),
                            ),
                          ],
                        ),
                      ), Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: w,
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffffeff0),
                              ),
                              child: SvgPicture.string(OrderSvg().locationIcon),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: w/1.8,
                              child:   Text(
                                "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 22,
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ClusterCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Website",
                          style: TextStyle(
                            color: ColorPalette.subtextGrey,
                            fontSize: w/25,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "www.dummywebsite.com",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16,),
                        Text(
                          "State",
                          style: TextStyle(
                            color: ColorPalette.subtextGrey,
                            fontSize: w/25,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Lorem ipsum",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16,),
                        Text(
                          "Country",
                          style: TextStyle(
                            color: ColorPalette.subtextGrey,
                            fontSize: w/25,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "United Arab Emirates",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
