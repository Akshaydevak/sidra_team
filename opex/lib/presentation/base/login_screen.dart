import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/phonenum_field.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalette.checkoutBackground,
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: h / 7, left: 20,right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your\nMobile Number",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "Login to your account",
                  style: TextStyle(
                    color: ColorPalette.subtextGrey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20,),
                PhoneWidget(),
                SizedBox(height: h/9,),
                GradientButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: DashBoard(),
                        withNavBar: true,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      //OtpScreen
                    },
                    gradient: const LinearGradient(
                      colors: [
                        ColorPalette.primary, ColorPalette.primary
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color:  Colors.transparent,
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(height: 10,),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                        'By clicking, I accept the ',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 26,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms & Condition ',
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              decoration: TextDecoration.underline,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                              text:
                              'and ',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 26,
                                fontWeight: FontWeight.normal,
                              )),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              decoration: TextDecoration.underline,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ])),

              ],
            ),
          )),
    );
  }
}

