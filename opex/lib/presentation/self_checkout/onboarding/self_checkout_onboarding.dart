
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../login_screen.dart';
import 'onboarding1.dart';
import 'onboarding2.dart';
import 'onboarding3.dart';

class SelfCheckoutOnBoarding extends StatefulWidget {
  SelfCheckoutOnBoarding({Key? key}) : super(key: key);

  @override
  State<SelfCheckoutOnBoarding> createState() => _SelfCheckoutOnBoardingState();
}

class _SelfCheckoutOnBoardingState extends State<SelfCheckoutOnBoarding> {
  PageController? controller = PageController();
  int? currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: h/1.2,
                child: ScrollConfiguration(
                  behavior: NoGlow(),
                  child:  PageView(
                    onPageChanged: (val) {
                      setState(() {
                        currentPage = val;
                      });
                    },
                    children: [
                      OnBoarding1(),
                      OnBoarding2(),
                      OnBoarding3(),
                    ],
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                  ),
                ),
              ),

               Container(
                 width: w,
                   padding: EdgeInsets.only(right: 20),
                   // alignment: Alignment.topRight,
                   child: currentPage==2?GestureDetector(
                     onTap: (){
                       PersistentNavBarNavigator.pushNewScreen(
                         context,
                         screen: LoginSelf(),
                         withNavBar: true,
                         // OPTIONAL VALUE. True by default.
                         pageTransitionAnimation: PageTransitionAnimation.fade,
                       );
                     },
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                         Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                       ],
                     ),
                   ):Container()),
               Container(
                  width: w,
                  alignment: Alignment.center,
                  child: CarouselIndicator(
                    color: Color(0xffA9A8A8),
                    activeColor:  ColorPalette.black,
                    count: 3,
                    height: 5,
                    width: 5,
                    index: currentPage,
                  ),
                ),

            ],
          )
         ),
    );
  }
}
