import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dymmy_login_page.dart';
import 'package:cluster/presentation/dashboard_screen/drawer/appdrawer.dart';
import 'package:cluster/presentation/dashboard_screen/profile/help_screen.dart';
import 'package:cluster/presentation/dashboard_screen/profile/widgets/app_card.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../common_widgets/headline_text.dart';
import '../../common_widgets/no_glow.dart';
import '../mpos/mpos_homepage.dart';
import '../order_app/screens/order_home_page.dart';
import '../promotion_app/promotion_dashboard.dart';
import '../sales_app/sales_dashboard.dart';
import '../seller_app/seller_homepage.dart';
import '../task_operation/home/bloc/job_bloc.dart';
import 'home_screen/homescreen_widget/appbar.dart';
import 'home_screen/homescreen_widget/apps_svg.dart';

import 'home_screen/homescreen_widget/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<JobBloc>().add(const GetNewJobListEvent('', '', ''));
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalette.white,
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarScreen(
          scaffoldKey: scaffoldKey,
        ),
      ),
      drawer: const AppDrawer(),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: w,
                  alignment: Alignment.center,
                  child: Text(
                    "A big business start from",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: w / 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: HelpScreen(autoFocus: true),
                      withNavBar: false,
                      // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                    child: SearchBarDashboard()),
                Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                    width: w,
                    child: HeadlineText(headText: "Quick Access to : ")),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: AppHomeCard(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: DashBoard(
                            index: 1,
                          ),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                        //   CommunicationModule(
                        //     token: authentication.authenticatedUser.token ?? "",
                        //   ),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      },
                      appTitle: "Communication App",
                      appDescription:
                          "Amet minim mollit not ulla lorem ipsum dolar sit amet",
                      svgIcon: AppsSvg().communicationSvgIcon,
                    )),
                SizedBox(
                  height: 40,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: AppHomeCard(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const DashBoard(index: 2),
                          withNavBar: false,
                          // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      appTitle: "Task & Operations",
                      appDescription:
                          "Amet minim mollit not ulla lorem ipsum dolar sit amet",
                      svgIcon: AppsSvg().taskOpSvgIcon,
                    )),

                SizedBox(
                  height: h / 3.5,
                ),
                Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.string(
                      AppsSvg().careIcon,
                      height: 10,width: 10,
                    ),
                    SizedBox(width: 5,),
                    Text("all rights reserved to sidrateams",
                    style: GoogleFonts.roboto(
                      fontSize: w/32,
                      color: Color(0xff555555),
                    ),),
                  ],
                ))
                // GridView.builder(
                //     padding:
                //         const EdgeInsets.only(left: 10, right: 10, top: 14),
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount:
                //         applicationList.length > 9 ? 9 : applicationList.length,
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 3,
                //             crossAxisSpacing: 5,
                //             childAspectRatio: 2 / 2.1,
                //             mainAxisSpacing: 5),
                //     itemBuilder: (context, i) {
                //       if (i == 8) {
                //         return GestureDetector(
                //             onTap: () {
                //               PersistentNavBarNavigator.pushNewScreen(
                //                 context,
                //                 screen: const SegmentScreen(),
                //                 withNavBar: true,
                //                 // OPTIONAL VALUE. True by default.
                //                 pageTransitionAnimation:
                //                     PageTransitionAnimation.fade,
                //               );
                //             },
                //             child: Column(
                //               children: [
                //                 Container(
                //                   height: 105,
                //                   width: 105,
                //                   padding: const EdgeInsets.all(8),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(20),
                //                     border: Border.all(
                //                       color: const Color(0x0a000000),
                //                       width: 1,
                //                     ),
                //                     boxShadow: [
                //                       const BoxShadow(
                //                         color: Color(0x05000000),
                //                         blurRadius: 8,
                //                         offset: Offset(1, 1),
                //                       ),
                //                     ],
                //                     color: ColorPalette.white,
                //                   ),
                //                   alignment: Alignment.center,
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: [
                //                       const SizedBox(
                //                         height: 5,
                //                       ),
                //                       SvgPicture.string(
                //                         AppsSvg().moreAppIcon,
                //                         height: 40,
                //                         width: 40,
                //                       ),
                //                       const SizedBox(
                //                         height: 5,
                //                       ),
                //                       Text(
                //                         "More",
                //                         style: GoogleFonts.roboto(
                //                           color: const Color(0xff32322c),
                //                           fontSize: w / 30,
                //                           fontWeight: FontWeight.w500,
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             )
                //             // Image.asset("asset/img_1.png")
                //             );
                //       }
                //       return GestureDetector(
                //           onTap: onTapListTile(i, context),
                //           child: Column(
                //             children: [
                //               Container(
                //                 height: 105,
                //                 width: 105,
                //                 decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(10),
                //                     border: Border.all(
                //                       color: const Color(0xffe6ecf0),
                //                       width: 1,
                //                     ),
                //                     boxShadow: [
                //                       const BoxShadow(
                //                         color: Color(0x05000000),
                //                         blurRadius: 8,
                //                         offset: Offset(1, 1),
                //                       ),
                //                     ],
                //                     color: Colors.white,
                //                     image: DecorationImage(
                //                         image:
                //                             AssetImage(applicationList[i].icon),
                //                         fit: BoxFit.fill)),
                //                 // padding: EdgeInsets.all(8),
                //                 // decoration: BoxDecoration(
                //                 //   borderRadius: BorderRadius.circular(20),
                //                 //   border: Border.all(
                //                 //     color: Color(0x0a000000),
                //                 //     width: 1,
                //                 //   ),
                //                 //   boxShadow: [
                //                 //     BoxShadow(
                //                 //       color: Color(0x05000000),
                //                 //       blurRadius: 8,
                //                 //       offset: Offset(1, 1),
                //                 //     ),
                //                 //   ],
                //                 //   color: ColorPalette.white,
                //                 // ),
                //                 // alignment: Alignment.center,
                //                 // child: Image.asset(  ,fit: BoxFit.fill,
                //                 //    ),
                //               ),
                //             ],
                //           ));
                //     }),
                // const SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       //       Container(
                //       //         padding: const EdgeInsets.only(left: 16),
                //       //         child: HeadlineText(headText: "Quick access to :"),
                //       //       ),
                //       //       const SizedBox(
                //       //         height: 14,
                //       //       ),
                //       //       const QuickAccess(),
                //       //       CarouselSliderHome(),
                //       //       const SizedBox(
                //       //         height: 16,
                //       //       ),
                //       //       Container(
                //       //         width: w,
                //       //         height: 6,
                //       //         color: const Color(0xfff8f7f5),
                //       //       ),
                //       //       const SizedBox(
                //       //         height: 16,
                //       //       ),
                //       //       AppList(),
                //       //       const SizedBox(
                //       //         height: 16,
                //       //       ),
                //       //       TwoThreeCard(),
                //       //
                //       //       CarouselSliderHome(),
                //       //       SizedBox(height: 30,),
                //       //       Container(
                //       //         width: w,
                //       //         height: 6,
                //       //         color: Color(0xfff8f7f5),
                //       //       ),
                //       //       Container(
                //       //         padding: const EdgeInsets.only(left: 16, top: 0),
                //       //         child: HeadlineText(headText: "Categories :"),
                //       //       ),
                //       //
                //       //       const CategoriesCard(),
                //       //       Container(
                //       //         padding: const EdgeInsets.only(left: 16, top: 0),
                //       //         child: HeadlineText(headText: "Brands :"),
                //       //       ),
                //       //       // Container(
                //       //       //   padding: const EdgeInsets.only(left: 16, top: 16),
                //       //       //   child:
                //       //       //
                //       //       //   Text(
                //       //       //     "Brands",
                //       //       //     style: GoogleFonts.roboto(
                //       //       //       color: ColorPalette.black,
                //       //       //       fontSize: w / 20,
                //       //       //       fontWeight: FontWeight.w500,
                //       //       //     ),
                //       //       //   ),
                //       //       // ),
                //       //
                //       //       const BrandsCard(),

                //       InkWell(
                //         onTap: () {
                //           PersistentNavBarNavigator.pushNewScreen(
                //             context,
                //             screen: const LoginDemo(
                //                 // isDashboard: false,
                //                 ),
                //             withNavBar: true,
                //             // OPTIONAL VALUE. True by default.
                //             pageTransitionAnimation:
                //                 PageTransitionAnimation.fade,
                //           );
                //         },
                //         child: Container(
                //             // color: Colors.black,
                //             padding: const EdgeInsets.all(14),
                //             alignment: Alignment.topLeft,
                //             child: Image.asset(
                //               "asset/img_5.png",
                //               width: w,
                //             )),
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       // Container(
                //       //   padding: const EdgeInsets.all(16),
                //       //   child: ClusterCard(
                //       //     padding: EdgeInsets.zero,
                //       //     child: Column(
                //       //       children: [
                //       //         Container(
                //       //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                //       //           child: Text(
                //       //             "Feedback",
                //       //             style: GoogleFonts.roboto(
                //       //               color: ColorPalette.black,
                //       //               fontSize: w / 22,
                //       //               fontWeight: FontWeight.w500,
                //       //             ),
                //       //           ),
                //       //         ),
                //       //         Container(
                //       //           width: w,
                //       //           height: 1,
                //       //           color: ColorPalette.divider,
                //       //         ),
                //       //         Container(
                //       //           padding: const EdgeInsets.all(14),
                //       //           child: Text(
                //       //             "FAQ",
                //       //             style: GoogleFonts.roboto(
                //       //               color: ColorPalette.black,
                //       //               fontSize: w / 22,
                //       //               fontWeight: FontWeight.w500,
                //       //             ),
                //       //           ),
                //       //         ),
                //       //         Container(
                //       //           width: w,
                //       //           height: 1,
                //       //           color: ColorPalette.divider,
                //       //         ),
                //       //         Container(
                //       //           padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                //       //           child: Text(
                //       //             "Settings",
                //       //             style: GoogleFonts.roboto(
                //       //               color: ColorPalette.black,
                //       //               fontSize: w / 22,
                //       //               fontWeight: FontWeight.w500,
                //       //             ),
                //       //           ),
                //       //         ),
                //       //       ],
                //       //     ),
                //       //   ),
                //       // ),

                //       const BottomCard(),
                //     ],
                //   ),
                // ),
              ],
            ),
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
            screen: const TaskAndOperation(),
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
            screen: const LoginDemo(
                // isDashboard: false,
                ),
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
            screen: const OrderHomePage(),
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
            screen: const MposHomepage(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;

      case 4:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: const InventoryDashBoard(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );
        };
        break;
      case 5:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const PromotionDashBoard(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 6:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: SellerHomePage(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );
          //SellerHomePage
        };
        break;

      case 7:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: SellerHomePage(isAdmin: true),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.fade,
          // );
        };
        break;

      case 8:
        onTap = () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const SalesDashboard(),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        };
        break;
      case 9:
        onTap = () {};
        break;
    }
    return onTap;
  }
}
