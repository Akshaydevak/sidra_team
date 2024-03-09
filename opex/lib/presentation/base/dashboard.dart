import 'dart:async';
import 'dart:io';
import 'package:cluster/common_widgets/switch.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/platform_check.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/dashboard_screen/profile/new_profile_screen.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:upgrader/upgrader.dart';
import 'dart:developer' as developer;
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/cart_screen/cart_svg.dart';
import '../dashboard_screen/drawer/appdrawer.dart';
import '../dashboard_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/create/task_bloc/task_bloc.dart';
import '../task_operation/task_title.dart';
import 'icon_constants.dart';

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

  String oldmessageId = "";

  var data;

  bool soketReady = false;

  String _previousConnectionState = 'Unknown';

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;

    if (data['Sidra_teams_key'] == "task_and_operation") {
      context
          .read<TaskBloc>()
          .add(GetTaskReadListEvent(int.tryParse(data['chat_id']) ?? 0));

      PersistentNavBarNavigator.pushNewScreen(
        context,

        screen: TaskTitle(),

        withNavBar: true, // OPTIONAL VALUE. True by default.

        pageTransitionAnimation: PageTransitionAnimation.fade,
      );

      setState(() {});
    } else if (data['Sidra_teams_key'] == "comment") {
      print("else condition");

      pref = await SharedPreferences.getInstance();

      token = pref!.getString("token");

      logingrpuserId = pref!.getString("logingrpuserid");

      print("else condition.. $token $logingrpuserId");

// if(!Navigator.canPop(context)){

      context.read<ChatBloc>().add(ChatScreenGetEvent(
          token: token.toString(),
          pageNo: 1,
          chatId: "",
          grpchatId: data['chat_id'],
          userId: logingrpuserId ?? ""));

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              token: token,
              loginUserId: logingrpuserId,
              socket: socketCon1,
              grpchatid: data['chat_id'],
              cmntgrpchatname: data['title'] ?? "",
              isGroup: true,
            ),
          ));

// }

      setState(() {});
    } else {
      print("else condition");

      pref = await SharedPreferences.getInstance();

      token = pref!.getString("token");

      loginuserId = pref!.getString("loginuserid");

      print("else condition.. $token $loginuserId");

// if(!Navigator.canPop(context)){

      print("background the notifaction");

      context.read<ChatBloc>().add(ChatScreenGetEvent(
          token: token.toString(),
          pageNo: 1,
          chatId: data['chat_id'],
          grpchatId: "",
          userId: loginuserId ?? ""));

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              token: token,
              loginUserId: loginuserId,
              socket: socketCon,
              redirectchatid: data['chat_id'],
              redirectchatname: data['title'] ?? "",
              redirectionsenduserId: data['to_user_id'],
              isGroup: data['is_group_chat'] == "true" ? true : false,
            ),
          ));

// }

      setState(() {});
    }
  }

  Future<void> setupInteractedMessage(BuildContext context) async {
    final FlutterLocalNotificationsPlugin flutterlocalnotificationplugins =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidinitializationsettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidinitializationsettings,
            iOS: darwinInitializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'messages', 'Messages',
        description: "This is for flutter firebase",
        importance: Importance.max,playSound: true,enableVibration: true,ledColor:Colors.white);

    flutterlocalnotificationplugins.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
if(Platform.isAndroid){
//    print("notification dict");
   FirebaseMessaging.onMessage.listen((event) async {
final notification = event.notification;
      final android = event.notification?.android;

      data = event.data;

// print("notification dict${data?}");

// print("notification dict${data}");

      print("notification dict$data");

      if (data != null) {
        flutterlocalnotificationplugins.show(
          data.hashCode,
          data['title'],
          data['body'],
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,playSound: true,priority: Priority.high

// icon: android.

                  ),
              // iOS: DarwinNotificationDetails(threadIdentifier: channel.id,
              // presentSound: true,
              // presentAlert: true
              // )
),
        );
      }
    });

}

// if(lifecycleEventHandler.inBackground==2){

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('Message opened while the app was in the background: $message');

      data = message.data;

// Navigator.pushNamed(context,"/${data['Sidra_teams_key']}" , arguments: {

// 'uid': data["uid"] ,

// 'serviceUid': data["serviceUid"] ,

// });

      String id = data['chat_id'];

      print(
          "hahaha${message.messageId} $id ..... ${message.notification?.title}");

      if (message.messageId != oldmessageId) {
        if (data['Sidra_teams_key'] == "task_and_operation") {
          oldmessageId = message.messageId!;

          context
              .read<TaskBloc>()
              .add(GetTaskReadListEvent(int.tryParse(id) ?? 0));

          PersistentNavBarNavigator.pushNewScreen(
            context,

            screen: TaskTitle(),

            withNavBar: true, // OPTIONAL VALUE. True by default.

            pageTransitionAnimation: PageTransitionAnimation.fade,
          );

          setState(() {});
        } else if (data['Sidra_teams_key'] == "comment") {
          oldmessageId = message.messageId!;

          print("background the notifaction comment");

          print("else condition");

          pref = await SharedPreferences.getInstance();

          token = pref!.getString("token");

          logingrpuserId = pref!.getString("logingrpuserid");

          print("else condition.. $token $logingrpuserId");

// if(!Navigator.canPop(context)){

          context.read<ChatBloc>().add(ChatScreenGetEvent(
              token: token.toString(),
              pageNo: 1,
              chatId: "",
              grpchatId: id,
              userId: logingrpuserId ?? ""));

// PersistentNavBarNavigator.pushNewScreen(

// context,

// screen: ChatScreen(

// token: token,

// loginUserId: logingrpuserId,

// socket: socketCon1,

// grpchatid: id,

// cmntgrpchatname:

// message.notification?.title??"",

// isGroup: true,

// ),

// withNavBar: true, // OPTIONAL VALUE. True by default.

// pageTransitionAnimation: PageTransitionAnimation.fade,

// );

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  token: token,
                  loginUserId: logingrpuserId,
                  socket: socketCon1,
                  grpchatid: id,
                  cmntgrpchatname: message.notification?.title ?? "",
                  isGroup: true,
                ),
              ));

// }

          setState(() {});
        } else {
          print("else condition");

          oldmessageId = message.messageId!;

          pref = await SharedPreferences.getInstance();

          token = pref!.getString("token");

          loginuserId = pref!.getString("loginuserid");

          print("else condition.. $token $loginuserId");

// if(!Navigator.canPop(context)){

          print("background the notifaction");

          context.read<ChatBloc>().add(ChatScreenGetEvent(
              token: token.toString(),
              pageNo: 1,
              chatId: id,
              grpchatId: "",
              userId: loginuserId ?? ""));

// PersistentNavBarNavigator.pushNewScreen(

// context,

// screen: ChatScreen(

// token: token,

// loginUserId: loginuserId,

// socket: socketCon,

// redirectchatid: id,

// redirectchatname:

// message.notification?.title??"",

// isGroup: data['is_group_chat']=="true"?true:false,

// ),

// withNavBar: true, // OPTIONAL VALUE. True by default.

// pageTransitionAnimation: PageTransitionAnimation.fade,

// );

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  token: token,
                  loginUserId: loginuserId,
                  socket: socketCon,
                  redirectchatid: id,
                  redirectchatname: message.notification?.title ?? "",
                  redirectionsenduserId: data['to_user_id'],
                  isGroup: data['is_group_chat'] == "true" ? true : false,
                ),
              ));

// }

          setState(() {});
        }
      }
    });

// }

    if (lifecycleEventHandler.inBackground == 4) {
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) async {
        print("bfore msg open");

        print('Message opened whilee the app was in the background: $message');

        data = message?.data;

        String id = data['chat_id'];

// print("hahaha${message?.messageId} $id ..... ${message?.notification?.title}");

// if(message?.messageId != oldmessageId){

        if (data['Sidra_teams_key'] == "task_and_operation") {
          // Fluttertoast.showToast(
          //     msg: 'T & A',
          //     backgroundColor: Colors.white,
          //     textColor: Colors.black);

// oldmessageId = message?.messageId??"";

          context
              .read<TaskBloc>()
              .add(GetTaskReadListEvent(int.tryParse(id) ?? 0));

          PersistentNavBarNavigator.pushNewScreen(
            context,

            screen: TaskTitle(),

            withNavBar: false, // OPTIONAL VALUE. True by default.

            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        } else if (data['Sidra_teams_key'] == "comment") {
          // Fluttertoast.showToast(
          //     msg: 'COME TAS',
          //     backgroundColor: Colors.white,
          //     textColor: Colors.black);

// oldmessageId = message?.messageId??"";

          print("background the notifaction comment");

          print("else condition");
pref = await SharedPreferences.getInstance();
          token = pref!.getString("token");
          logingrpuserId = pref!.getString("logingrpuserid");

          print("else condition.. $token $logingrpuserId");

// if(!Navigator.canPop(context)){

          context.read<ChatBloc>().add(ChatScreenGetEvent(
              token: token.toString(),
              pageNo: 1,
              chatId: "",
              grpchatId: id,
              userId: logingrpuserId ?? ""));

          PersistentNavBarNavigator.pushNewScreen(
            context,

            screen: ChatScreen(
              token: token,
              loginUserId: logingrpuserId,
              socket: socketCon1,
              grpchatid: id,
              cmntgrpchatname: data['title'] ?? "",
              isGroup: true,
            ),

            withNavBar: false, // OPTIONAL VALUE. True by default.

            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        } else {
          // Fluttertoast.showToast(
          //     msg: 'COMMU',
          //     backgroundColor: Colors.white,
          //     textColor: Colors.black);

          print("else condition");

// oldmessageId = message?.messageId??"";

pref = await SharedPreferences.getInstance();

          token = pref!.getString("token");

          loginuserId = pref!.getString("loginuserid");

          print("else condition.. $token $loginuserId");

// if(!Navigator.canPop(context)){

          print("background the notifaction");

          context.read<ChatBloc>().add(ChatScreenGetEvent(
              token: token.toString(),
              pageNo: 1,
              chatId: id,
              grpchatId: "",
              userId: loginuserId ?? ""));

          PersistentNavBarNavigator.pushNewScreen(
            context,

            screen: ChatScreen(
              token: token,
              loginUserId: loginuserId,
              socket: socketCon,
              redirectchatid: id,
              redirectchatname: data['title'] ?? "",
              redirectionsenduserId: data['to_user_id'],
              isGroup: data['is_group_chat'] == "true" ? true : false,
            ),

            withNavBar: false, // OPTIONAL VALUE. True by default.

            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        }
      });
    }
  }



  StreamController<String> connectionStatusController =
      StreamController<String>.broadcast();

  Future<void> initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    updateConnectionStatus(connectivityResult);
  }

  void socketconnnect() async {
    final socketProvider = context.read<scoketProvider>();

    final socketgrpProvider = context.read<scoketgrpProvider>();

    pref = await SharedPreferences.getInstance();

    token = pref!.getString("token");
    

    print("socket token $token");

    setState(() {});

    socketProvider.connect(token.toString());

    socketgrpProvider.connect(token.toString());
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
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       print("app in resumed");
  //       break;
  //     case AppLifecycleState.inactive:
  //       print("app in inactive");
  //       break;
  //     case AppLifecycleState.paused:
  //       print("app in paused");
  //       break;
  //     case AppLifecycleState.detached:
  //       print("app in detached");
  //       break;
  //   }
  // }

// @override

// void didChangeAppLifecycleState(AppLifecycleState state) {

// switch (state) {

// case AppLifecycleState.resumed:

// print("app in resumed");

// break;

// case AppLifecycleState.inactive:

// print("app in inactive");

// break;

// case AppLifecycleState.paused:

// print("app in paused");

// break;

// case AppLifecycleState.detached:

// print("app in detached");

// break;

// }

// }

  Future _showNotificationWithDefaultSound() async {
// if (!lifecycleEventHandler.inBackground){

// return;

// }

    print("shifas${lifecycleEventHandler.inBackground}");

//otherwise show a notification
  }

  @override
  void initState() {
    _showNotificationWithDefaultSound();

    setupInteractedMessage(context);

    newIndex = widget.index ?? 0;

    setState(() {});

    initConnectivity();

    Connectivity().onConnectivityChanged.listen(updateConnectionStatus);

    _controller = PersistentTabController(initialIndex: widget.index ?? 0);

    context.read<ProfileBloc>().add(GetProfileEvent());

    context.read<ProfileBloc>().add(const GetProfilePicEvent());
    super.initState();
  }

  @override
  void dispose() {
    connectionStatusController.close();

// WidgetsBinding.instance.removeObserver();

    super.dispose();
  }


  int newIndex = 0;

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
       // HomeScreen(homeTap: (){
       //     _controller.jumpToTab(1);
       // },taskTap: (){
       //  print("tapppppeeyyy");
       // _controller.jumpToTab(2);
       //  // setState(() {
       //
       //  // });
       // },),
      CommunicationModule(),
      const TaskAndOperation(),
      const NewProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      // PersistentBottomNavBarItem(
      //     icon: SvgPicture.string(
      //       IconConstants().homeIcon,
      //       color: Color(0xff222222),
      //     ),
      //     inactiveIcon: SvgPicture.string(IconConstants().homeIcon,
      //         color: ColorPalette.inactiveGrey),
      //     activeColorPrimary: Color(0xff222222),
      //     inactiveColorPrimary: ColorPalette.inactiveGrey),

      PersistentBottomNavBarItem(
          icon: SvgPicture.string(
            IconConstants().chatIcon,
            color: Color(0xff222222),
          ),
          inactiveIcon: SvgPicture.string(IconConstants().chatIcon,
              color: ColorPalette.inactiveGrey),
          activeColorPrimary: Color(0xff222222),
          inactiveColorPrimary: ColorPalette.inactiveGrey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/', defaultTitle: "communication")),

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

// icon: SvgPicture.string(

// IconConstants().infinityIcon,color: ColorPalette.primary,

// ),

// inactiveIcon: SvgPicture.string(

// IconConstants().infinityInactiveIcon,color:ColorPalette.inactiveGrey

// ),

// activeColorPrimary: ColorPalette.primary,

// inactiveColorPrimary: ColorPalette.inactiveGrey

// ),

// PersistentBottomNavBarItem(

// icon: SvgPicture.string(

// IconConstants().infinityIcon,color: ColorPalette.primary,

// ),

// inactiveIcon: SvgPicture.string(

// IconConstants().infinityInactiveIcon,color:ColorPalette.inactiveGrey

// ),

// activeColorPrimary: ColorPalette.primary,

// inactiveColorPrimary: ColorPalette.inactiveGrey

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
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final socketpro = context.watch<scoketProvider>();

    socketCon = socketpro.socket;

    final socketpro1 = context.watch<scoketgrpProvider>();

    socketCon1 = socketpro1.socket;

    double w1 = MediaQuery.of(context).size.width;

    double w = w1 > 700 ? 400 : w1;

    return StreamBuilder(
        stream: connectionStatusController.stream,
        initialData: 'Unknown',
        builder: (context, snapshot) {
          print("enthaayiii ${snapshot.data}");

          _previousConnectionState = snapshot.data.toString();

          if (_previousConnectionState != 'WiFi' &&
              _previousConnectionState != 'Mobile data' &&
              (snapshot.data == 'WiFi' || snapshot.data == 'Mobile data')) {
// Trigger event to connect to the socket only if there was no internet connection before

// context.read<DummyLoginBloc>().add(TokenCreationCommunicationEvent());

            socketconnnect();
          }

// context.read<DummyLoginBloc>().add(TokenCreationCommunicationEvent());

          return snapshot.data == "WiFi" || snapshot.data == "Mobile data"
              ? MultiBlocListener(
                  listeners: [
                    BlocListener<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is ProfileSuccess) {
                          Variable.profilePic =
                              state.user.userMete?.profile ?? "";

                          print("profile vannu${Variable.profilePic}");

                          setState(() {});
                        }

// TODO: implement listener
                      },
                    ),
                  ],
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
                          backgroundColor:Color(0xffF0F2F5),
                          key: scaffoldKey,
                          appBar: PreferredSize(
                            preferredSize: const Size.fromHeight(58),
                            child: AppBarScreen(
                              scaffoldKey: scaffoldKey,
                              label: newIndex==0?"Sidra Teams":newIndex==1?"Communication":newIndex==2?"Task & Operation":newIndex==3?"My Profile":"",

                            ),
                          ),
                          drawer: isMobile? AppDrawer(
                           ):Container(),
                          body: isMobile?
                          Container(
                            // margin: isMobile?null:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4.5),

                            child:
                            PersistentTabView(

                              context,
                              padding:
                                  const NavBarPadding.only(left: 100, right: 100),
                              controller: _controller,
                                screens: _buildScreens(),
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
                                ),

                              ],

                              ),
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
                          ):  Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                              color: ColorPalette.webBagroundClr.withOpacity(.3),

                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/4.7, child:      HomeScreen(homeTap: (){
                                  _controller.jumpToTab(0);
                                },taskTap: (){
                                  print("tapppppeeyyy");
                                  _controller.jumpToTab(1);
                                  // setState(() {

                                  // });
                                },),

                                )  ,
                                Flexible(
                                  flex: 3, child:Container(
                                  margin: isMobile?null:EdgeInsets.symmetric(horizontal: 10),

                                  child:ValueListenableBuilder<Widget>(
                                    valueListenable: screenNotifier,
                                    builder: (BuildContext context, Widget value,child) {
                                      return value;
                                        // widgetList[value];
                                    },
                                  ),
                                  // PersistentTabView(
                                  //
                                  //   context,
                                  //   padding:
                                  //   const NavBarPadding.only(left: 100, right: 100),
                                  //   controller: _controller,
                                  //   screens: _buildScreens(),
                                  //   onItemSelected: (value) {
                                  //
                                  //     newIndex = value;
                                  //
                                  //     setState(() {});
                                  //
                                  //     print("llllll$newIndex");
                                  //
                                  //     if (newIndex == 0 || newIndex == 3) {
                                  //       setState(() {});
                                  //     } else if (newIndex == 2) {
                                  //       context
                                  //           .read<ProfileBloc>()
                                  //           .add(GetProfileEvent());
                                  //     }
                                  //   },
                                  //
                                  //   items: _navBarsItems(),
                                  //   confineInSafeArea: true,
                                  //   hideNavigationBarWhenKeyboardShows: true,
                                  //   backgroundColor: ColorPalette.white,
                                  //   handleAndroidBackButtonPress: true,
                                  //   resizeToAvoidBottomInset: true,
                                  //   stateManagement: false,
                                  //   decoration: NavBarDecoration(boxShadow: [
                                  //     BoxShadow(
                                  //       color: Colors.grey.shade200.withOpacity(0.8),
                                  //
                                  //       blurRadius: 2.0,
                                  //
                                  //       spreadRadius: 1, //New
                                  //     ),
                                  //
                                  //   ],
                                  //
                                  //   ),
                                  //   popAllScreensOnTapOfSelectedTab: true,
                                  //   popActionScreens: PopActionScreensType.all,
                                  //   itemAnimationProperties:
                                  //   const ItemAnimationProperties(
                                  //     duration: Duration(milliseconds: 200),
                                  //     curve: Curves.ease,
                                  //   ),
                                  //   navBarStyle: NavBarStyle.style3,
                                  //   screenTransitionAnimation:
                                  //   const ScreenTransitionAnimation(
                                  //     animateTabTransition: false,
                                  //     curve: Curves.ease,
                                  //     duration: Duration(milliseconds: 200),
                                  //   ),
                                  // ),
                                ),

                                ), Container(
                                  width: MediaQuery.of(context).size.width/4.7,
                              child:NewProfileScreen(),

                                ),
                              ],
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

                                  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => DashBoard(index: 0,)), (route) => false);

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

final lifecycleEventHandler = LifecycleEventHandler._();

class LifecycleEventHandler extends WidgetsBindingObserver {
  var inBackground = 0;

  LifecycleEventHandler._();

  init() {
    WidgetsBinding.instance.addObserver(lifecycleEventHandler);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        inBackground = 2;

        print("shifas app in resumed${lifecycleEventHandler.inBackground}");

        break;

      case AppLifecycleState.inactive:
        inBackground = 2;

        print("shifas app in inactive${lifecycleEventHandler.inBackground}");

        break;

      case AppLifecycleState.paused:
        inBackground = 2;

        print("shifas app in paused${lifecycleEventHandler.inBackground}");

        break;

      case AppLifecycleState.detached:
        inBackground = 4;

        print("shifas app in detached${lifecycleEventHandler.inBackground}");

        break;

      case AppLifecycleState.hidden:
        inBackground = 2;

        print("shifas app in hidden${lifecycleEventHandler.inBackground}");

        break;
    }

// switch (state) {

// case AppLifecycleState.resumed:

// inBackground = true;

// print('in foreground');

// break;

// case AppLifecycleState.inactive:

// case AppLifecycleState.paused:

// case AppLifecycleState.detached:

// inBackground = false;

// print('in background');

// break;

// }
  }
}
