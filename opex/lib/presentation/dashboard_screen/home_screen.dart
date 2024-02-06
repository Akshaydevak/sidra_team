import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dymmy_login_page.dart';
import 'package:cluster/presentation/dashboard_screen/drawer/appdrawer.dart';
import 'package:cluster/presentation/dashboard_screen/profile/help_screen.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
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
import '../sidra_learning/sidra_learning_home_page.dart';
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
    context.read<ProfileBloc>().add(const GetProfilePicEvent());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
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
                          screen:
                          // EmptyPageCommunication(),
                          DashBoard(
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
                      appTitle: "Communication",
                      appDescription:
                          "This app tailored for efficient internal communication within organization.",
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
                          "For seamless internal organization task assign and team collaboration.",
                      svgIcon: AppsSvg().taskOpSvgIcon,
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
                          screen: const SidraLearningHomePage(),
                          withNavBar: false,
                          // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.slideUp,
                        );
                      },
                      appTitle: "Sidra Learning",
                      appDescription:
                      "Get the skills you need to succeed by watching video clips, anytime, anywhere.",
                      svgIcon: AppsSvg().sidraLearningIcon,
                    )),

                SizedBox(
                  height: h / 5,
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

        };
        break;
      case 9:
        onTap = () {};
        break;
    }
    return onTap;
  }
}
