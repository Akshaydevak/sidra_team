import 'dart:async';

import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/dashboard_screen/profile/new_profile_screen.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:developer' as developer;
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/cart_screen/cart_svg.dart';
import '../dashboard_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dashboard_screen/profile/profile_screen.dart';

import 'icon_constants.dart';
import 'internet_not_connected.dart';

class DashBoard extends StatefulWidget {
  final int? index;

  const DashBoard({Key? key, this.index}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  String? token ='';
  IO.Socket? socketCon;
  SharedPreferences? pref;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: widget.index ?? 0);
    context.read<ProfileBloc>().add(const GetProfilePicEvent());
   
    super.initState();
  }

  int newIndex = 0;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      CommunicationModule(),
      const TaskAndOperation(),
      const NewProfileScreen(),
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
          activeColorPrimary: Color(0xff222222),
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
            color: Color(0xff222222),
          ),
          inactiveIcon: SvgPicture.string(IconConstants().taskIcon,
              color: ColorPalette.inactiveGrey),
          activeColorPrimary: Color(0xff222222),
          inactiveColorPrimary: ColorPalette.inactiveGrey),
      PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            IconConstants().profileIcon,
            color: Color(0xff222222),
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
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return BlocListener<DummyLoginBloc, DummyLoginState>(
      listener: (context, state)  async {
        final socketProvider = context.read<scoketProvider>();
        if (state is TokenCreationCommunicationLoading) {
        } else if (state is TokenCreationCommunicationSuccess) {
          pref= await SharedPreferences.getInstance();
          await pref!.setString("token", state.token);
    
            print("socket token $token");
                    setState(()  {
                      });
            
            socketProvider.connect(state.token.toString());
    
          }
          else if (state is TokenCreationCommunicationFailed) {
            
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: HomeScreen(),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
          }
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
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
                    margin: const EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.string(
                          CartSvg().cartEmptyIcon,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Network missing",
                          style: GoogleFonts.roboto(
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "You’re not connecting to the internet. try reconnecting to WiFi or switch to mobile data.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: w / 28,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff6D6D6D)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: w1 / 3.5,
                          child: GradientButton(
                              border: 30,
                              onPressed: () {
                                _connectivitySubscription = _connectivity
                                    .onConnectivityChanged
                                    .listen(_updateConnectionStatus);
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: DashBoard(),
                                  withNavBar:
                                      false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                                setState(() {
                                });
                              },
                              gradient: const LinearGradient(
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              color: ColorPalette.primary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Retry",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
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
                      } else if (newIndex == 2) {
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
                    decoration: NavBarDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200.withOpacity(0.8),
                        blurRadius: 2.0,
                        spreadRadius: 1, //New
                      )
                    ]),
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
      ),
    );
  }
}
