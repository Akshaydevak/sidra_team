import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:cluster/presentation/product_hub/product_hub_card.dart';
import 'package:cluster/presentation/product_hub/product_quickaccess.dart';
import 'package:cluster/presentation/product_hub/product_slider.dart';
import 'package:cluster/presentation/product_hub/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/home_card.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import '../mpos/mpos_svg.dart';
import '../seller_app/seller_quick.dart';
import 'manage_data.dart';

class ProductHubHomeScreen extends StatelessWidget {
  const ProductHubHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Product Hub",isAction: false,
        action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ProductSlider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeCard(
                            head: "120",
                            sub: "Newly Added",
                          ),
                          HomeCard(
                            head: '32',
                            sub: "Pending Items",
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
                            sub: "Approved Products",
                          ),
                          HomeCard(
                            head: '362',
                            sub: "Total Products",
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen:  ManageData(),
                            withNavBar: true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                        //  ProductScreen
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
                                    "Manage Data",
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
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen:  ProductScreen(isVerified: true,),
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
                                    "View Products",
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
                      SizedBox(height: 16,),
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
                      ProductQuickAccess(),
                      SizedBox(
                        height: 26,
                      ),
                      Container(
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Newly Added Products",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen:  ProductScreen(),
                                  withNavBar: true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                              },
                              child: Text(
                                "View All",
                                style: GoogleFonts.roboto(
                                  color: Color(0xfffe5762),
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),])),
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
                              itemBuilder: (context, index) => ProductHubCard(isVerified: true,),
                            )
                          ],
                        ),
                      ) ,
                BottomCard()
                    ],
                  ),
                )
        ),
      ),
    );
  }
}
