import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/order_app/insight_screen.dart';
import 'package:cluster/presentation/promotion_app/coupons/coupons_form.dart';
import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_page_one.dart';
import 'package:cluster/presentation/promotion_app/select_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../task_operation/task_svg.dart';
import 'buy_more_get_form/buy_more_list.dart';
import 'coupons/coupon_form_one.dart';
import 'coupons/coupon_list.dart';
import 'discount_screen.dart';
import 'negotiation_screens/negotiation_list.dart';

class PromotionQuickAccess extends StatelessWidget {
  PromotionQuickAccess({Key? key}) : super(key: key);
  List<String> quickData=['New Promotion','Coupon','Discount','Buy More Get More',
    // "Negotiation"
  ];
  // 'Insight'

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(
      // margin: const EdgeInsets.only(left: 12),
      // height: MediaQuery.of(context).size.height / 3.5,
        width: w1,
        child: GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1.6 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, i) {
              return GestureDetector(
                 onTap: onTapListTile(i, context),
                child: Container(
                  width: 88,
                  height: 100,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x0ce30000),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.string(TaskSvg().quickaccessIcon,height: 30,),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        quickData[i],
                        style: TextStyle(
                          color: ColorPalette.black,
                          fontSize: w/26,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }));
  }
  VoidCallback onTapListTile(int i, BuildContext context) {
    // String email = Variables.emailfield;
    VoidCallback onTap;
    onTap = () {};
    switch (i) {
      case 0:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SelectTypeScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
        };
        break;

      case 1:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CouponListScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: InsightScreen(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation:
          //   PageTransitionAnimation.fade,
          // );
        };
        break;
      case 2:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DiscountScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
          //  DiscountScreen
        };
        break;
      case 3:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: BuyMoreListScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
          //  DiscountScreen
        };
        break;
        case 4:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: NegotiationListPage(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
          //  DiscountScreen
        };
        break;


    }
    return onTap;
  }
}
