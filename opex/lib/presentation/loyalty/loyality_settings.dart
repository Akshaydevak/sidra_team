import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/loyalty/widget/toggle_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class LoyalitySetting extends StatelessWidget {
  const LoyalitySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Settings"),
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
                ToggleCard(
                  label: "Enable/Disable Loyality Points",
                ),
                SizedBox(
                  height: 10,
                ),
                ToggleCard(
                  label: "Point Expiry Alert",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormReusable(
                  label: "Maximum Point Range",
                  hint: "Type a number",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormReusable(
                  label: "Loyalty Expire in ",
                  hint: "Type number",
                ),
                const SizedBox(
                  height: 10,
                ), TextFormReusable(
                  label: "Point Expiry Alert Count",
                  hint: "Type number",
                ),
                const SizedBox(
                  height: 10,
                ), TextFormReusable(
                  label: "Alert Before Expiry, Days",
                  hint: "Type number",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormReusable(
                  label: "Alert Text",
                  hint: "Type alert text ...",
                  maxLength: 5,
                ),
                SizedBox(height: 30,),
                GradientButton(
                    onPressed: () {

                    },
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xfffe5762),
                        Color(0xfffe5762),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: const Color(0xfffe5762),
                    child: Text(
                      "Save Change",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
