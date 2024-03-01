import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/authentication/bloc/bloc/auth_bloc.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/base/register_new_user.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/order_app/screens/all_order_tab.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/phonenum_field.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../task_operation/employee_bloc/employee_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool _isLoading = false;
  SharedPreferences? pref;
  void createChannel(AndroidNotificationChannel channel) async {
    final FlutterLocalNotificationsPlugin plugin =
        FlutterLocalNotificationsPlugin();
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  data() async {
    await Firebase.initializeApp();
    print("log data");
    final _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM TOKEN.....$fcmToken");
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString("fcm", fcmToken.toString());

    context
        .read<EmployeeBloc>()
        .add(FcmTokenRegisterEvent(fcmToken.toString() ?? ""));
    print("after fcm");
  }

  @override
  void initState() {
    print("login init");
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
        importance: Importance.max);
    createChannel(channel);
    flutterlocalnotificationplugins.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((event) async {
      // await ftts.setLanguage("en-US");
      // await ftts.setSpeechRate(0.5);
      // await ftts.setVolume(1.0);
      // await ftts.setPitch(1);
      //
      // //play text to sp
      // var result = await ftts.speak(
      // "${event.notification?.title ?? ""} ${event.notification?.body}");
      // if (result == 1) {
      //
      // //speaking
      // } else {
      // //not speaking
      // }
      final notification = event.notification;
      final android = event.notification?.android;
      if (notification != null && android != null) {
        flutterlocalnotificationplugins.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: android.smallIcon)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is LoginSuccess) {
              data();
              _isLoading = false;
              context
                  .read<DummyLoginBloc>()
                  .add(TokenCreationCommunicationEvent());
              
            } else if (state is LoginFailed) {
              showSnackBar(context,
                  message: "Enter Valid Credentials",
                  color: Colors.red,
                  // icon: HomeSvg().SnackbarIcon,
                  autoDismiss: true);
              _isLoading = false;
              setState(() {});
            }
          },
        ),
            BlocListener<DummyLoginBloc, DummyLoginState>(
                      listener: (context, state) async {

                        if (state is TokenCreationCommunicationSuccess) {
                          final socketProvider = context.read<scoketProvider>();

    final socketgrpProvider = context.read<scoketgrpProvider>();
                          pref = await SharedPreferences.getInstance();

                          await pref!.setString("token", state.token);


                          print("socket token $state.token");
                               socketProvider.connect(state.token.toString());

    socketgrpProvider.connect(state.token.toString());
            
                           Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => DashBoard(index: 0,)), (route) => false);

                          setState(() {});
                        } else if (state is TokenCreationCommunicationFailed) {
                          showSnackBar(context,
                  message: "Enter Valid Credentials",
                  color: Colors.red,
                  // icon: HomeSvg().SnackbarIcon,
                  autoDismiss: true);
              _isLoading = false;
              setState(() {});
                        }
                      },
                    ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorPalette.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.white, // Navigation bar
                statusBarColor: Colors.white, // Status bar
              ),
              elevation: 0,
            )),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: SafeArea(
                child: Container(
              height: h / 1.1,
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              // padding: EdgeInsets.only(top: h / 7, left: 10,right: h/7),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.string(HomeSvg().teamsIcon),

                      Text(
                        "Login to account",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: w / 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Text(
                      //   "Login to your account",
                      //   style: TextStyle(
                      //     color: ColorPalette.subtextGrey,
                      //     fontSize: w/22,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormReusableNoLabel(
                        hint: "Enter business/organization email",
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      TextFormReusableNoLabel(
                          hint: "Enter password",
                          password: true,
                          controller: passwordController),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormReusableNoLabel(
                          hint: "Director/Employee code",
                          onchange: (bb) {
                            codeController.value =
                                codeController.value.copyWith(
                              text: bb.toUpperCase(),
                              selection:
                                  TextSelection.collapsed(offset: bb.length),
                            );
                          },
                          controller: codeController),
                      // PhoneWidget(),
                      SizedBox(
                        height: 30,
                      ),
                      GradientButton(
                          onPressed: () {
                            _isLoading = true;
                            context.read<AuthBloc>().add(LoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                code: codeController.text));
                            setState(() {});
                          },
                          gradient: const LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: Colors.transparent,
                          child: _isLoading == true
                              ? SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 15.0,
                                )
                              : Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w / 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                      SizedBox(
                        height: 30,
                      ),
                      // GestureDetector(
                      //   onTap: (){
                      //        PersistentNavBarNavigator.pushNewScreen(
                      //       context,
                      //       screen: RegisterNewUser(),
                      //       withNavBar: true,
                      //       // OPTIONAL VALUE. True by default.
                      //       pageTransitionAnimation: PageTransitionAnimation.fade,
                      //     );
                      //   },
                      //   child: Text("Register your organization",
                      //   style: GoogleFonts.roboto(
                      //     fontSize: w/26,
                      //     color: ColorPalette.primary
                      //   ),),
                      // )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: w / 1.2,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'By logging in, ',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 28,
                                height: 1.5,
                                fontWeight: FontWeight.normal,
                              ),
                              children: [
                                TextSpan(
                                  text: 'You accept to our',
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 28,
                                    height: 1.5,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                    text: 'Terms \n',
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.primary,
                                      fontSize: w / 28,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    )),
                                TextSpan(
                                    text: 'and ',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 28,
                                      height: 1.5,
                                      fontWeight: FontWeight.normal,
                                    )),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.primary,
                                    fontSize: w / 28,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ])),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
