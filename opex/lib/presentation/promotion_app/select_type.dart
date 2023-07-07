import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupon_form_one.dart';
import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_page_one.dart';
import 'package:cluster/presentation/promotion_app/promotion_sale/promotion_sale.dart';
import 'package:cluster/presentation/promotion_app/promotion_sale/promotion_sale_form.dart';
import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/headline_text.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'buy_more_get_form/buy_more_get_form.dart';
import 'buy_one_get_one/buy_one_get_form.dart';
import 'multy_buy/multy_buy_form.dart';
import 'new_promotion.dart';

class SelectTypeScreen extends StatefulWidget {
  const SelectTypeScreen({Key? key}) : super(key: key);

  @override
  State<SelectTypeScreen> createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  List<String> tile = [
    'Discount',
    // 'Promotion Sale',
    // 'MultiBuy',
    // 'Buy 1 Get 1',
    'Buy More Get More',
    // 'Dynamic Promotion',
    'Coupon',
    // 'Negotiation'
  ]; List<String> icon = [
    PromotionSvg().discountIcon,
    // PromotionSvg().saleIcon,
    // PromotionSvg().multibuyIcon,
    // PromotionSvg().buyIcon,
    PromotionSvg().moreIcon,
    PromotionSvg().promotionIcon,
    // PromotionSvg().promotionIcon,

  ];
  int isSelect = 0;
  String type="Discount";

  void onselect(int index) {
    setState(() {
      isSelect = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Select Type",
            isBack: true,
            isAction: false,
            onTap: (){
              Navigator.pop(context);
            }),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Choose any Type",
                  style: GoogleFonts.roboto(
                    color: const Color(0xff151522),
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: true,
                  shrinkWrap: true,
                  itemCount: tile.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        onselect(index);
                        setState(() {
                          type=tile[index];
                        });
                        },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:isSelect==index?const Color(0xfffd5762) :const Color(0x0ce30000),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 61,
                              height: 61,
                              padding: EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: SvgPicture.string(icon[index]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              tile[index],
                              style: GoogleFonts.roboto(
                                color:isSelect==index?Colors.white :Colors.black,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Amet minim mollit non\n deserunt ullamco est.",
                              textAlign: TextAlign.center,
                               style: TextStyle(
                                color: isSelect==index?Colors.white :const Color(0xff313131),
                                fontSize: w/27,
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                        // color: Colors.green,
                      ),
                      );
                  },
                ),
                const SizedBox(height: 50,),
                GradientButton(
                    color:ColorPalette.primary ,
                    onPressed: () {
                      type=="Coupon"?PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:  CouponFormOne(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      ):
                      type=="Promotion Sale"?PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:  PromotionSaleForm(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      ):type=="MultiBuy"?PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:  MultyBuyFormOne(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      ):type=="Buy 1 Get 1"?
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:  BuyOneGetForm(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      ):type=="Buy More Get More"?
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:  BuyMoreGetForm(editDiscount: false,),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      ):type=="Negotiation"?
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:  NegotiationPageOne(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      ):PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:  NewPromotion(type: type),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );


                    },
                    gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:[ColorPalette.primary, ColorPalette.primary]),
                    child: Text(
                      "Select and Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w/22,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
