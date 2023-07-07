import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/call_center/call_center_home.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dymmy_login_page.dart';
import 'package:cluster/presentation/organisation/screens/organisation_home.dart';
import 'package:cluster/presentation/self_checkout/onboarding/self_checkout_onboarding.dart';
import 'package:cluster/presentation/self_checkout/self_checkout_home.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:cluster/presentation/logistic_app/screens/logistic_home.dart';
import 'package:cluster/presentation/product_hub/product_hub_home.dart';
import 'package:cluster/presentation/purchase_app/purchase_home.dart';
import 'package:cluster/presentation/user_app/user_home.dart';
import 'package:cluster/presentation/wallet_app/wallet_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../base/bottom_card.dart';
import '../../comunication_module/communication_homescreen.dart';
import '../../contract_app/contract_home.dart';
import '../../inventory/inventory_dashboard.dart';
import '../../loyalty/loyalty_home.dart';
import '../../manufacture/manufacture_home.dart';
import '../../mpos/mpos_homepage.dart';
import '../../payments/payments_home.dart';
import '../../order_app/screens/order_home_page.dart';
import '../../promotion_app/promotion_dashboard.dart';
import '../../sales_app/sales_dashboard.dart';
import '../../seller_app/seller_homepage.dart';
import '../../setting_and_config/setting_home.dart';
import '../../stock_app/stock_home.dart';
import '../../taxes/tax_home.dart';
import '../../vendor_app/vendor_home.dart';
import 'home_svg.dart';
import 'homescreen_widget/application_model.dart';
import 'homescreen_widget/search_bar.dart';

class SegmentScreen extends StatefulWidget {
  const SegmentScreen({Key? key}) : super(key: key);

  @override
  State<SegmentScreen> createState() => _SegmentScreenState();
}

class _SegmentScreenState extends State<SegmentScreen> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Segments",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorPalette.black,
          ),
        ),
        actions: [
          Row(
            children: [
              SvgPicture.string(HomeSvg().msgIcon),
              const SizedBox(
                width: 16,
              ),
              SvgPicture.string(HomeSvg().addIcon),
              const SizedBox(
                width: 16,
              )
            ],
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w,
                height: 1.50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xb2e6e6e6), width: 0.50, ),
                ),
              ),
              SizedBox(height: 16,),
              // const SearchBar(),
              GridView.builder(
                  padding: const EdgeInsets.all(16),
                  physics:const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: applicationList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:1.95/2,
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                  ),
                  // const SliverGridDelegateWithMaxCrossAxisExtent(
                  //     maxCrossAxisExtent: 110,
                  //     childAspectRatio: 2/ 2,
                  //     crossAxisSpacing: 5,
                  //     mainAxisSpacing: 5),

                  itemBuilder: (context, i) {

                    return    GestureDetector(
                        onTap: onTapListTile(i, context),
                        child: Column(
                          children: [
                            Container(
                              height: 105,
                              width: w/3,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(0x0a000000),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SvgPicture.string(
                                    applicationList[i].icon,
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    applicationList[i].name,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Color(0xff32322c),
                                      fontSize: w / 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ));

                  }),
             SizedBox(height: h/7,),

            ],
          ),
        ),
      ),
    );
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
            screen: TaskAndOperation(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;

      case 1:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: LoginDemo(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 2:
        onTap = () {
          //OrderHomePage
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: OrderHomePage(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.Fmpos
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 3:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: MposHomepage(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;

      case 4:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: InventoryDashBoard(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 5:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: PromotionDashBoard(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 6:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SellerHomePage(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
          //SellerHomePage
        };
        break;

      case 7:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SellerHomePage(isAdmin: true),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;

      case 8:
        onTap = () {

        //  SalesDashboard
        };
        break;
      case 9:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SalesDashboard(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
        case 10:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: PurchaseHome(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
        case 11:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ProductHubHomeScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
        case 12:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: UserHomeScreen(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
        case 13:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: LogisticHome(label: "Delivery Management",),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
        case 14:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CallCenterHome(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;

        case 15:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SelfCheckoutOnBoarding(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
        case 16:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: OrganisationHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;   case 17:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ContractHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;case 18:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: TaxHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;case 19:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: LoyaltyHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;case 20:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: VendorHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;case 21:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: StockHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
        case 22:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ManufactureHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;   case 23:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: PaymentsHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;case 24:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: Wallethome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;case 25:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SettingHome(),
            withNavBar: false,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
    }
    return onTap;
  }
}
