import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/purchase_app/invoice_screen.dart';
import 'package:cluster/presentation/purchase_app/recieving_product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class RecievingViewScreen extends StatelessWidget {
  const RecievingViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Purchase Receiving", isAction: false),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Purchase Recieving",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Check whether the actual product is recieved or not also their quantity",
                style: TextStyle(
                  color: Color(0xff1b1b1f),
                  fontSize: w / 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                itemCount: 4,
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => RecievingProductCard(),
                separatorBuilder: (context, index) => SizedBox(height: 5,),
              ),
              SizedBox(height: 10,),
              GradientButton(
                  color:ColorPalette.primary ,
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: InvoiceScreen(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                    // InvoiceScreen
                  },
                  gradient:  LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:[
                        ColorPalette.primary,
                        ColorPalette.primary
                      ]),
                  child: Text(
                    "Move to Invoice",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              SizedBox(height: 10,),
              GradientButton(
                  color:ColorPalette.primary ,
                  onPressed: () {

                    // Navigator.pop(context);
                  },
                  gradient:  LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:[
                        Colors.white,
                        Colors.white,

                      ]),
                  child: Text(
                    "Generate order on pending Items",
                    style: TextStyle(
                      color: Color(0xfffe5762),
                      fontSize: 16,
                    ),
                  )
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
