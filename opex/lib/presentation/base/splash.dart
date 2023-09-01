
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/base/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'dashboard.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>
                // HomePage()
                    authentication.isAuthenticated?const DashBoard() :const OnBoarding()

                )
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.width;
    debugPrint("${authentication.authenticatedUser.token}customer_CODE");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: PageView(
            children:[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                     height: h/2,
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

