import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class WalletSetting extends StatelessWidget {
  bool isEnable = false;

  WalletSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
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
              children: [
                ClusterCard(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enable/Disable Wallet Purchase",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    isEnable
                        ? SvgPicture.string(HomeSvg().toggleActive)
                        : SvgPicture.string(HomeSvg().toggleInActive),
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                ClusterCard(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Wallet Payments",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    isEnable
                        ? SvgPicture.string(HomeSvg().toggleActive)
                        : SvgPicture.string(HomeSvg().toggleInActive),
                  ],
                )),
                SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Minimum Purchase Required",
                  hint: "Type a number",
                ),
                SizedBox(height: 10,),
                TextFormReusable(
                  label: "Wallet Currancy",
                  hint: "Type number",
                ),
                SizedBox(height: h/2.8,),
                GradientButton(
                    color: Color(0xfffe5762),
                    onPressed: () {},
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xfffe5762), Color(0xfffe5762)]),
                    child: Text(
                      "Save Changes",
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
