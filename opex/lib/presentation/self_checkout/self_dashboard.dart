import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/self_checkout/self_checkout_home.dart';
import 'package:cluster/presentation/self_checkout/self_profile_screen.dart';
import 'package:cluster/presentation/self_checkout/self_svg.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../base/icon_constants.dart';
import '../comunication_module/communication_homescreen.dart';
import '../dashboard_screen/home_screen.dart';
import '../dashboard_screen/cart_screen.dart';

import '../dashboard_screen/infinity.dart';
import '../dashboard_screen/profile/profile_screen.dart';
import 'list_screen.dart';


class SelfDashBoard extends StatefulWidget {
  const SelfDashBoard({Key? key}) : super(key: key);

  @override
  @override
  State<SelfDashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<SelfDashBoard> {

  int newIndex = 0;
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
       SelfCheckoutHome(),
       SelfCheckoutHome(),
      SelfProfileScreen(),
      ListScreen(),


    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            SelfSvg().homeIcon,color: ColorPalette.black,
          ),
          inactiveIcon: SvgPicture.string(
              SelfSvg ().homeIcon,color:ColorPalette.inactiveGrey
          ),
          activeColorPrimary: ColorPalette.black,
          inactiveColorPrimary: ColorPalette.inactiveGrey
      ),
      PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            SelfSvg().scanIcon,color: ColorPalette.black,
          ),
          inactiveIcon: SvgPicture.string(
              SelfSvg().scanIcon ,color:ColorPalette.inactiveGrey
          ),
          activeColorPrimary: ColorPalette.black  ,
          inactiveColorPrimary: ColorPalette.inactiveGrey
      ),   PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            SelfSvg().profileIcon,color: ColorPalette.black,
          ),
          inactiveIcon: SvgPicture.string(
              SelfSvg().profileIcon ,color:ColorPalette.inactiveGrey
          ),
          activeColorPrimary: ColorPalette.black  ,
          inactiveColorPrimary: ColorPalette.inactiveGrey
      ),PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            SelfSvg().listIcon,color: ColorPalette.black,
          ),
          inactiveIcon: SvgPicture.string(
              SelfSvg().listIcon ,color:ColorPalette.inactiveGrey
          ),
          activeColorPrimary: ColorPalette.black  ,
          inactiveColorPrimary: ColorPalette.inactiveGrey
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.zero,
        //   child: AppBar(
        //     elevation: 0,
        //     // brightness: Brightness.light,
        //     backgroundColor: Colors.white,
        //   ),
        // ),
        body:PersistentTabView(
            context,
            padding: const NavBarPadding.only(left: 10,right: 10),
            controller: _controller,
            onItemSelected: (value) {
              newIndex = _controller.index;
              if (newIndex == 0 || newIndex == 3) {
                setState(() {});
              }
            },
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            hideNavigationBarWhenKeyboardShows: true,
            backgroundColor: ColorPalette.white,
            handleAndroidBackButtonPress: true,

            resizeToAvoidBottomInset: true,
            stateManagement: false,
            decoration: const NavBarDecoration(),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            navBarStyle: NavBarStyle.style2,
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: false,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
          ),
      )
    );
  }
}
