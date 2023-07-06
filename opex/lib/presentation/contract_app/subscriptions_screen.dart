import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/contract_app/contract_svg.dart';
import 'package:cluster/presentation/contract_app/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  PageController? controller = PageController();
  int? currentPage = 0;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Subscription Plan",
          isAction: false,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            width: w,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CHOOSE YOUR PLAN",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Start with ',
                          style: GoogleFonts.roboto(
                            color: ColorPalette.subtextGrey,
                            fontSize: w / 25,
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            TextSpan(
                              text: '14 days free trail. ',
                              style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontSize: w / 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' upgrade or downgrade anytime',
                              style: GoogleFonts.roboto(
                                color: ColorPalette.subtextGrey,
                                fontSize: w / 25,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ])),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  height: h/1.6,
                  child: ScrollConfiguration(
                    behavior: NoGlow(),
                    child:  PageView(
                      onPageChanged: (val) {
                        setState(() {
                          currentPage = val;
                        });
                      },
                      children:  [
                          Image.asset("asset/img_21.png"),
                          Text("hgj"),
                          Text("hgj"),
                      ],
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                    ),
                  ),
                ),
                Container(
                  width: w,
                  alignment: Alignment.center,
                  child: CarouselIndicator(
                    color: Color(0xffA9A8A8),
                    activeColor:  ColorPalette.black,
                    count: 3,
                    height: 5,
                    width: 5,
                    index: currentPage,
                  ),
                ),
                // SubscriptionCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
