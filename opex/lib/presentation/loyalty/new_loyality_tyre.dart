import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class NewLoyalityTyre extends StatelessWidget {
  const NewLoyalityTyre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "New Loyality Tyres"),
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
                TextFormReusable(
                  label: "Loyalty Tyre Name",
                  hint: "Type a number",
                ),
                SizedBox(height: 10,),
                TextFormReusable(
                  label: "Description",
                  hint: "Add description ...",
                  maxLength: 5,
                ),
                SizedBox(height: 10,),
                Text(
                 "Upload Icon",
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
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 129,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Color(0xfffe5762),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Choose File",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "No file choosen",
                        style: TextStyle(
                          color: ColorPalette.primary,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                TextFormReusable(
                  label: "Purchase Point",
                  hint: "Enter ...",

                ),
                SizedBox(height: 10,),
                TextFormReusable(
                  label: "Loyalty Tyre Expire in ",
                  hint: "Type number",
                ),
                SizedBox(height: 50,),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      // PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen: const NewPromotion(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );
                    },
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [ColorPalette.primary, ColorPalette.primary]),
                    child: Text(
                      "Add Loyalty Tyre",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w / 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
