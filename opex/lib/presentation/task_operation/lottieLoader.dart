import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LottieLoader extends StatefulWidget {
  const LottieLoader({super.key});

  @override
  State<LottieLoader> createState() => _LottieLoaderState();
}

class _LottieLoaderState extends State<LottieLoader> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Container(
      height: h / 2,
      color: Colors.white.withOpacity(0.5),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Lottie.asset(
              'asset/loadingteams.json',
            ),
          Text(
            "Loading...",
            style: GoogleFonts.roboto(
              fontSize: w / 24,
            ),
          )
        ],
      ),
      // Image.asset('asset/Logo'),
      //child: SvgPicture.string(IconConstants().SplashIcon),
    );
  }
}
