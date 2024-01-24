import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/base/onboarding.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
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
    print("splash");
    final _firebaseMessaging=FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission( alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    final fcmToken=await _firebaseMessaging.getToken();
    print("FCM TOKENE.....$fcmToken");

    context.read<EmployeeBloc>().add( FcmTokenRegisterEvent(fcmToken.toString()??""));
    print("after fcm");

  }



  @override
  void initState() {
    data();
    print("splash init");
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
    Timer(
        const Duration(seconds: 2),
        () { 
           authentication.isAuthenticated
                        ?context.read<DummyLoginBloc>().add(TokenCreationCommunicationEvent()):null;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    // HomePage()
                    authentication.isAuthenticated
                        ? const DashBoard()
                        : const OnBoarding())
                        );}
                        );
                        
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
