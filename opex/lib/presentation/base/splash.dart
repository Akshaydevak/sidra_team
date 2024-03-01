import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/base/onboarding.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/task_operation/task_title.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../task_operation/employee_bloc/employee_bloc.dart';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  SharedPreferences? pref;
  String token="";
  data() async {

    await Firebase.initializeApp();
    print("log data");
    final _firebaseMessaging=FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission( alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    final fcmToken=await _firebaseMessaging.getToken();
    print("FCM TOKEN.....$fcmToken");
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString("fcm", fcmToken.toString());

    context.read<EmployeeBloc>().add( FcmTokenRegisterEvent(fcmToken.toString()??""));
    print("after fcm");

  }
  @override
  void initState() {
    data();
    super.initState();
    Timer(
        const Duration(seconds: 2),
            () {
          authentication.isAuthenticated
              ?socketconnnect():
          null;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  // HomePage()
                  authentication.isAuthenticated
                      ? const DashBoard()
                      : const OnBoarding())
          );
        }
    );

  }
  void socketconnnect() async {
    final socketProvider = context.read<scoketProvider>();

    final socketgrpProvider = context.read<scoketgrpProvider>();

    pref = await SharedPreferences.getInstance();

    token = pref!.getString("token")!;

    Fluttertoast.showToast(
        msg: 'token kitty monea$token',
        backgroundColor: Colors.white,
        textColor: Colors.black);

    print("socket token $token");

    setState(() {});

    socketProvider.connect(token.toString());

    socketgrpProvider.connect(token.toString());
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.width;
    debugPrint("${authentication.authenticatedUser.token}customer_CODE");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: PageView(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: h / 2,
                  alignment: Alignment.center,
                  child: Lottie.asset('asset/Logo.json'),
                  // Image.asset('asset/Logo'),
                  //child: SvgPicture.string(IconConstants().SplashIcon),
                )
              ]),
        ]),
      ),
    );
  }

}