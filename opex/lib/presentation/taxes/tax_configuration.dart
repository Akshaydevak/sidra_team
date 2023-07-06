import 'package:cluster/presentation/taxes/widgets/config_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/no_glow.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class TaxConfiguration extends StatelessWidget {
  const TaxConfiguration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            label: "Tax Calculator",
            isAction: false,
          ),
        ),
        body: ScrollConfiguration(
            behavior: NoGlow(), child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConfigCard(),
                SizedBox(height: 10,),
                ConfigCard(label: "Calculate Tax based on :",
                subHead: "Customer shipping address"),
                SizedBox(height: 16,),
                ConfigCard(label: "Shipping tax class based on,",
                subHead: "Cart Items"),
                SizedBox(height: 16,),
                ConfigCard(label: "Display prices in the shop",
                subHead: "Including Tax"),
                SizedBox(height: 16,),
                ConfigCard(label: "Display prices during Cart & Checkout",
                subHead: "Including Tax"),
                SizedBox(height: 50,),
                GradientButton(
                    color:Color(0xfffe5762) ,
                    onPressed: () {
                      // PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen:  NewContract(),
                      //   withNavBar: false, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );

                    },
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Color(0xfffe5762),  Color(0xfffe5762)]),
                    child: Text(
                      "Apply",
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
        )));
  }
}
