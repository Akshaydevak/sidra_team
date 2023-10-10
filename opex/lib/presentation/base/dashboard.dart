import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/profile/new_profile_screen.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/empty_page_communication.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../dashboard_screen/home_screen.dart';

import '../dashboard_screen/profile/profile_screen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dymmy_login_page.dart';

import 'icon_constants.dart';
import 'internet_not_connected.dart';

class DashBoard extends StatefulWidget {
  final int? index;

  const DashBoard({Key? key, this.index}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
   _controller=PersistentTabController(initialIndex:
   widget.index??0);
    context.read<ProfileBloc>().add(const GetProfilePicEvent());
    super.initState();
  }
  int newIndex = 0;
   PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const EmptyPageCommunication(),
       const TaskAndOperation(),
      const NewProfileScreen(),
      // const ProfileScreen(),
      // NewGoogleMap(),
      // const Infinity(),
      // const FavouritesScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            IconConstants().homeIcon,
            color: Color(0xff222222),
          ),
          inactiveIcon: SvgPicture.string(IconConstants().homeIcon,
              color: ColorPalette.inactiveGrey),
          activeColorPrimary:  Color(0xff222222),
          inactiveColorPrimary: ColorPalette.inactiveGrey),
      PersistentBottomNavBarItem( 
          icon: SvgPicture.string(
            IconConstants().chatIcon,
            color: Color(0xff222222),
          ),
          inactiveIcon: SvgPicture.string(IconConstants().chatIcon,
              color: ColorPalette.inactiveGrey),
          activeColorPrimary: Color(0xff222222),
          inactiveColorPrimary: ColorPalette.inactiveGrey),
      PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            IconConstants().taskIcon,
            color:  Color(0xff222222),
          ),
          inactiveIcon: SvgPicture.string(IconConstants().taskIcon,
              color: ColorPalette.inactiveGrey),
          activeColorPrimary:  Color(0xff222222),
          inactiveColorPrimary: ColorPalette.inactiveGrey),
      PersistentBottomNavBarItem(

          icon: SvgPicture.string(
            IconConstants().profileIcon,
            
                      color:  Color(0xff222222),
          ),
          inactiveIcon: SvgPicture.string(IconConstants().profileIcon,
              color: ColorPalette.inactiveGrey),
          activeColorPrimary: Color(0xff222222),
          inactiveColorPrimary: ColorPalette.inactiveGrey),
      // PersistentBottomNavBarItem(
      //     icon: SvgPicture.string(
      //       IconConstants().infinityIcon,color: ColorPalette.primary,
      //     ),
      //     inactiveIcon: SvgPicture.string(
      //         IconConstants().infinityInactiveIcon,color:ColorPalette.inactiveGrey
      //     ),
      //     activeColorPrimary: ColorPalette.primary,
      //     inactiveColorPrimary: ColorPalette.inactiveGrey
      // ),
      // PersistentBottomNavBarItem(
      //     icon: SvgPicture.string(
      //       IconConstants().infinityIcon,color: ColorPalette.primary,
      //     ),
      //     inactiveIcon: SvgPicture.string(
      //         IconConstants().infinityInactiveIcon,color:ColorPalette.inactiveGrey
      //     ),
      //     activeColorPrimary: ColorPalette.primary,
      //     inactiveColorPrimary: ColorPalette.inactiveGrey
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0
      ),
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.zero,
        //   child: AppBar(
        //     elevation: 0,
        //     systemOverlayStyle: const SystemUiOverlayStyle(
        //       systemNavigationBarColor: Colors.white, // Navigation bar
        //       statusBarColor: Colors.white, // Status bar
        //     ),
        //     // brightness: Brightness.light,
        //     backgroundColor: Colors.white,
        //   ),
        // ),
        body: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected
            ? Center(
                child: Column(children: [
                Visibility(
                    visible: Provider.of<InternetConnectionStatus>(context) ==
                        InternetConnectionStatus.disconnected,
                    child: const InternetNotAvailable()),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                )
              ]))
            : DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  // backgroundColor: Color(0xff086DB5),
                  content: Text('Tap back again to leave'),
                ),
                child: PersistentTabView(

                  context,

                  padding: const NavBarPadding.only(left: 10, right: 10),
                  controller: _controller,
                  onItemSelected: (value) {
                    newIndex = _controller.index;
                    if (newIndex == 0 || newIndex == 3) {
                      setState(() {});
                    }
                    else if(newIndex==2){
   context.read<ProfileBloc>().add(GetProfileEvent());

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
                  decoration:  NavBarDecoration( boxShadow: [BoxShadow(
        color: Colors.grey.shade200.withOpacity(0.8),
        blurRadius: 2.0,
        spreadRadius: 1, //New
      )]),
                  popAllScreensOnTapOfSelectedTab: true,
                  popActionScreens: PopActionScreensType.all,
                  itemAnimationProperties: const ItemAnimationProperties(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  navBarStyle: NavBarStyle.style3,
                  screenTransitionAnimation: const ScreenTransitionAnimation(
                    animateTabTransition: false,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 200),
                  ),
                ),
              ),
      ),
    );
  }
}
