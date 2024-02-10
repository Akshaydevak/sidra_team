import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/dashboard_screen/profile/new_profile_screen.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/task_operation/create/create_job.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:upgrader/upgrader.dart';
import 'dart:developer' as developer;
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/cart_screen/cart_svg.dart';
import '../dashboard_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dashboard_screen/profile/profile_screen.dart';

import '../task_operation/create/task_bloc/task_bloc.dart';
import '../task_operation/task_title.dart';
import 'icon_constants.dart';
import 'internet_not_connected.dart';

class DashBoard extends StatefulWidget {
  final int? index;

  const DashBoard({Key? key, this.index}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? token = '';
  IO.Socket? socketCon;
  IO.Socket? socketCon1;
  String? loginuserId;
  String? logingrpuserId;
  SharedPreferences? pref;

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("onBackgroundMessage: $message");
  }

  Future<void> getPage() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    _firebaseMessaging.requestPermission();

    final initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((messages) {
      var data = messages.data;
      var message = messages.data;
      var size = MediaQuery.sizeOf(context);
      String? titleText = messages.notification?.title;
      String? descrption = messages.notification?.body;

      Flushbar(
        onTap: (flushbar) async {
          print("jjijij: ${data['title']}");
          print("jjijij: ${data['Sidra_teams_key']}");
          print("wow message: ${messages.notification?.title}");
          print("wow message: ${messages.notification?.body}");
          print("wow message: ${data['is_group_chat']}");
          print("wow message: ${data['chat_id']}");
          // Navigator.pushNamed(context,"/${data['Sidra_teams_key']}" , arguments: {
          //   'uid': data["uid"] ,
          //   'serviceUid': data["serviceUid"] ,
          // });
          String id = data['chat_id'];
          if (data['Sidra_teams_key'] == "task_and_operation") {
            print("if condition");
            context
                .read<TaskBloc>()
                .add(GetTaskReadListEvent(int.tryParse(id) ?? 0));
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: TaskTitle(),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
          } else if (data['Sidra_teams_key'] == "comment") {
            print("else condition");
            pref = await SharedPreferences.getInstance();
            token = pref!.getString("token");
            logingrpuserId = pref!.getString("logingrpuserid");
            print("else condition.. $token $loginuserId");
            context.read<ChatBloc>().add(ChatScreenGetEvent(
                token: token.toString(), pageNo: 1, chatId: "", grpchatId: id));
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: ChatScreen(
                token: token,
                loginUserId: logingrpuserId,
                socket: socketCon1,
                grpchatid: id,
                cmntgrpchatname: messages.notification?.title ?? "",
                isGroup: true,
              ),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
          } else {
            print("else condition");
            pref = await SharedPreferences.getInstance();
            token = pref!.getString("token");
            loginuserId = pref!.getString("loginuserid");
            print("else condition.. $token $loginuserId");
            context.read<ChatBloc>().add(ChatScreenGetEvent(
                token: token.toString(), pageNo: 1, chatId: id, grpchatId: ""));
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: ChatScreen(
                token: token,
                loginUserId: loginuserId,
                socket: socketCon,
                redirectchatid: id,
                redirectchatname: messages.notification?.title ?? "",
                isGroup: data['is_group_chat'] == "true" ? true : false,
              ),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
          }
        },
        backgroundColor: Colors.black,
        titleColor: Colors.black,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        titleText: Container(
          child: Row(
            children: [
              // Padding(
              //     padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              //     child: SizedBox(
              //       height: size.height*.05,
              //       child: Image(
              //         image:
              //         AssetImage("assets/images/logos/logowithbg.png"),
              //       ),
              //     )),
              Text(
                titleText == null ? "New Notification Received" : titleText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),

        flushbarPosition: FlushbarPosition.TOP, // Set position to top
        message: descrption,
        duration: Duration(seconds: 2),
      )..show(context);
    });

    // Handle message when the app is opened from the background
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('Message opened while the app was in the background: $message');
      var data = message.data;
      // Navigator.pushNamed(context,"/${data['Sidra_teams_key']}" , arguments: {
      //   'uid': data["uid"] ,
      //   'serviceUid': data["serviceUid"] ,
      // });
      String id = data['chat_id'];
      print("hahaha$id ..... ${message.notification?.title}");
      if (data['Sidra_teams_key'] == "task_and_operation") {
        context
            .read<TaskBloc>()
            .add(GetTaskReadListEvent(int.tryParse(id) ?? 0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TaskTitle(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      } else if (data['Sidra_teams_key'] == "comment") {
        print("else condition");
        pref = await SharedPreferences.getInstance();
        token = pref!.getString("token");
        logingrpuserId = pref!.getString("logingrpuserid");
        print("else condition.. $token $logingrpuserId");
        context.read<ChatBloc>().add(ChatScreenGetEvent(
            token: token.toString(), pageNo: 1, chatId: "", grpchatId: id));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ChatScreen(
            token: token,
            loginUserId: logingrpuserId,
            socket: socketCon1,
            grpchatid: id,
            cmntgrpchatname: message.notification?.title ?? "",
            isGroup: true,
          ),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      } else {
        print("else condition");
        pref = await SharedPreferences.getInstance();
        token = pref!.getString("token");
        loginuserId = pref!.getString("loginuserid");
        print("else condition.. $token $loginuserId");
        context.read<ChatBloc>().add(ChatScreenGetEvent(
            token: token.toString(), pageNo: 1, chatId: id, grpchatId: ""));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ChatScreen(
            token: token,
            loginUserId: loginuserId,
            socket: socketCon,
            redirectchatid: id,
            redirectchatname: message.notification?.title ?? "",
            isGroup: data['is_group_chat'] == "true" ? true : false,
          ),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      }
    });
  }

  StreamController<String> connectionStatusController =
      StreamController<String>.broadcast();
  Future<void> initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    updateConnectionStatus(connectivityResult);
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.mobile) {
      connectionStatusController.add('Mobile data');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      connectionStatusController.add('WiFi');
    } else {
      connectionStatusController.add('No internet connection');
    }
  }

  @override
  void initState() {
    initConnectivity();
    Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
    _controller = PersistentTabController(initialIndex: widget.index ?? 0);
    context.read<ProfileBloc>().add(const GetProfilePicEvent());
    getPage();

    super.initState();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //
    //   print("onMessage%%%%: ${message.notification?.android?.clickAction}");
    //   _handleNotificationClick(7);
    //   if (message.notification?.android?.clickAction == "/your_route") {
    //     print("onMessage%%%%: lala $message");
    //     int yourId = int.tryParse(message.data["id"]) ?? 0;
    //     _handleNotificationClick(yourId);
    //   }
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //
    //   print("onMessageOpenedApp: $message");
    //
    //   if (message.data["Sidra_teams_key"] == "communication") {
    //     int _yourId = int.tryParse(message.data["id"]) ?? 0;
    //     _handleNotificationClick(_yourId);
    //   }
    // });
  }

  @override
  void dispose() {
    connectionStatusController.close();
    super.dispose();
  }

  int newIndex = 0;

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

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

  bool _doubleBackToExitPressedOnce = false;
  Future<bool> _onWillPop() async {
    print("new index $newIndex");
    if (_doubleBackToExitPressedOnce) {
      print("new index $newIndex");
      return true;
    }
    _doubleBackToExitPressedOnce = true;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Press back again to exit the app.')),
    );

    Timer(const Duration(seconds: 2), () {
      _doubleBackToExitPressedOnce = false;
    });

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final socketpro = context.watch<scoketProvider>();
    socketCon = socketpro.socket;
    final socketpro1 = context.watch<scoketgrpProvider>();
    socketCon1 = socketpro.socket;
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return StreamBuilder(
        stream: connectionStatusController.stream,
        initialData: 'Unknown',
        builder: (context, snapshot) {
          print("enthaayiii ${snapshot.data}");
          return snapshot.data == "WiFi" || snapshot.data == "Mobile data"
              ? BlocListener<DummyLoginBloc, DummyLoginState>(
                  listener: (context, state) async {
                    final socketProvider = context.read<scoketProvider>();
                    final socketgrpProvider = context.read<scoketgrpProvider>();
                    if (state is TokenCreationCommunicationSuccess) {
                      pref = await SharedPreferences.getInstance();
                      await pref!.setString("token", state.token);

                      print("socket token $token");
                      setState(() {});

                      socketProvider.connect(state.token.toString());
                      socketgrpProvider.connect(state.token.toString());
                    } else if (state is TokenCreationCommunicationFailed) {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: HomeScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    }
                  },
                  child: UpgradeAlert(
                    child: MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: WillPopScope(
                        onWillPop: newIndex != 0
                            ? () async {
                                newIndex = 0;
                                setState(() {});
                                return true;
                              }
                            : _onWillPop,
                        child: Scaffold(
                          body: PersistentTabView(
                            context,
                            padding:
                                const NavBarPadding.only(left: 10, right: 10),
                            controller: _controller,
                            onItemSelected: (value) {
                              newIndex = value;
                              setState(() {});
                              print("llllll$newIndex");
                              if (newIndex == 0 || newIndex == 3) {
                                setState(() {});
                              } else if (newIndex == 2) {
                                context
                                    .read<ProfileBloc>()
                                    .add(GetProfileEvent());
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
                            itemAnimationProperties:
                                const ItemAnimationProperties(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease,
                            ),
                            navBarStyle: NavBarStyle.style3,
                            screenTransitionAnimation:
                                const ScreenTransitionAnimation(
                              animateTabTransition: false,
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 200),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: Container(
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
                                context
                                    .read<DummyLoginBloc>()
                                    .add(TokenCreationCommunicationEvent());
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: DashBoard(),
                                  withNavBar:
                                      false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                                setState(() {});
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
                  ),
                );
        });
  }
}
