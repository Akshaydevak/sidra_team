import 'package:cluster/common_widgets/phonenum_field.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/self_checkout/self_checkout_home.dart';
import 'package:cluster/presentation/self_checkout/self_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';

class RegisterSelf extends StatelessWidget {
  String? selGender;
  List<String> gender = ["Male", "Female", "Other"];
  String? selectedGender;
   RegisterSelf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPalette.checkoutBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: ColorPalette.checkoutBackground,
            // Navigation bar
            statusBarColor: Colors.white, // Status bar
          ),
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Register",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: w / 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                TextFormReusable(label: "Your Name",hint: "eg.example@email.com",),
                SizedBox(height: 16,),
                TextFormReusable(label: "Email Address",hint: "eg.example@email.com",),
                SizedBox(height: 16,),
                Text(
                 "Phone Number",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                PhoneWidget(),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: w / 2.3,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //height: 20.0,
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0x190a0a0a), width: 1, ),
                            color: Color(0x7fffffff),
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
                                "Male",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 22,
                                ),
                              )),
                        ),
                      ],
                    ), Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nationality",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: w / 2.3,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //height: 20.0,
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0x190a0a0a), width: 1, ),
                            color: Color(0x7fffffff),
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
                                "UAE",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 22,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                TextFormReusable(label: "Password",hint: "eg.example@email.com",),
                SizedBox(height: 30,),
                GradientButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const SelfDashBoard(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffE9E9E9),
                        Color(0xffE9E9E9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: const Color(0xffE9E9E9),
                    child: Text(
                      "Register",
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
                          fontSize: w / 25,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms & Condition ',
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              decoration: TextDecoration.underline,
                              fontSize: w / 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                              text:
                              'and ',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 25,
                                fontWeight: FontWeight.normal,
                              )),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              decoration: TextDecoration.underline,
                              fontSize: w / 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
