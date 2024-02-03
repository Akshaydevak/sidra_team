import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/base/onboarding.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/task_operation/task_title.dart';
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
                        ?context.read<DummyLoginBloc>().add(TokenCreationCommunicationEvent()):null;
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

  @override
  Widget build(BuildContext context) {


    var h = MediaQuery.of(context).size.width;
    debugPrint("${authentication.authenticatedUser.token}customer_CODE");

    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print("=====shifas");
    //
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => TaskTitle(),
    //     ),
    //   );
    // });
    // // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //
    //   print('FCM Message Received: ${message.data['Sidra_teams_key']}');
    //   print('FCM Message Received: ${message.data['chat_id']}');
    //   print('FCM Message Received: ${message.data['click_action']}');
    //   print('FCM Message Received: ${message.data['is_group_chat']}');
    //   if (message.data.isNotEmpty) {
    //     // configureFirebaseMessaging(context);
    //     print("object");
    //     // Access payload data as needed
    //     // String routeName = message.data['route'];
    //
    //     // Navigate to the relevant screen based on the payload data
    //     // if (message.data['Sidra_teams_key'] == "communication") {
    //     // Navigator.push(
    //     //   context,
    //     //   MaterialPageRoute(
    //     //     builder: (context) => TaskTitle(),
    //     //   ),
    //     // );
    //     // }
    //   }
    // });
    //
    //


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

