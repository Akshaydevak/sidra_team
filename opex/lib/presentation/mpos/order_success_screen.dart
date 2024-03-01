import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import 'invoice.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: w,
            padding: EdgeInsets.only(left: 16,right: 16),
            // height: h,
            // alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: w/1.5,
                    height: h/1.6,
                    child: SvgPicture.string(MposSvg().orderSuccessIcon)),
                SizedBox(height: 40,),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: InvoiceScreen(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      //  PickAndPack
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          ColorPalette.primary,
                          ColorPalette.primary
                        ]),
                    child: Text(
                      "View Invoice",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                     Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => DashBoard(index: 0,)), (route) => false);
                  },
                  child: Text(
                    "Back to home",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/22,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
