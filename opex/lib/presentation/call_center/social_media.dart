import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/call_center/widgets/media_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Register",
          isAction: true,
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
                Text(
                  "Social Media Links",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w / 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam dign.",
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: w / 23,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MediaCard(),
                SizedBox(
                  height: 5,
                ),
                MediaCard(
                  label: "Snapchat",
                ),
                SizedBox(
                  height: 5,
                ),
                MediaCard(
                  label: "Instagram",
                ),
                SizedBox(
                  height: 5,
                ),
                MediaCard(
                  label: "Facebook",
                ),
                SizedBox(
                  height: 50,
                ),
                GradientButton(
                    color: Color(0xfffe5762),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [Color(0xfffe5762), Color(0xfffe5762)]),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
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
