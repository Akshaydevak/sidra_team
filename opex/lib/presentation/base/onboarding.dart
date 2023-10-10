import 'package:cluster/common_widgets/button_text.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/base/icon_constants.dart';
// import 'package:cluster/presentation/base/login_screen.dart';
import 'package:cluster/presentation/base/login_page.dart';
import 'package:cluster/presentation/order_app/screens/all_order_tab.dart';
// import 'package:cluster/presentation/self_checkout/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../authentication/authentication.dart';
import 'dashboard.dart';

import '../dashboard_screen/home_screen.dart';



class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w1,

              // height: h/2,
                padding: const EdgeInsets.only(left: 50,right: 50,top: 50),
                child: SvgPicture.string(IconConstants().onBoardingSvg)),
            Container(
              width: w1,
              // color: Colors.pink,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.center,
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Come and",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: w/10,

                      fontWeight: FontWeight.w700
                    ),),
                    Text("work anytime.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: w/10,

                          fontWeight: FontWeight.w700
                      ),),
                    SizedBox(height: 15,),
                    Text("Plan, Track and organize with Task & operation environment full of hustlers around you.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: w/26,
                          fontWeight: FontWeight.w400,
                        color: Color(0xff6A6E77).withOpacity(0.5)
                      ),),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
            ),

            Container(

              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: (){
                  //     PersistentNavBarNavigator.pushNewScreen(
                  //       context,
                  //       screen: const DashBoard(),
                  //       withNavBar: true, // OPTIONAL VALUE. True by default.
                  //       pageTransitionAnimation: PageTransitionAnimation.fade,
                  //     );
                  //   },
                  //   child: Container(
                  //       width: w/2.3,
                  //       height: 54,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: const Color(0x0a000000), width: 1, ),
                  //         boxShadow: const [
                  //           BoxShadow(
                  //             color: Color(0x05000000),
                  //             blurRadius: 8,
                  //             offset: Offset(1, 1),
                  //           ),
                  //         ],
                  //         color: Colors.white,
                  //       ),
                  //       alignment: Alignment.center,
                  //       child:
                  //       ButtonText(label: "Register",
                  //         color: Colors.black,)

                  //   ),
                  // ),
                  GestureDetector(
                    onTap: (){


                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: LoginScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );


                    },
                    child: Container(
                        width: w/2.3,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff2871AF),
                        ),
                        alignment: Alignment.center,
                        child:ButtonText(label: "Login",
                          color: Colors.white,)

                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30,),


          ],
        ),
      ),
    );
  }
}
