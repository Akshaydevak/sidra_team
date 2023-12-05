import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class EvaluationSuccessPAge extends StatefulWidget {
  const EvaluationSuccessPAge({super.key});

  @override
  State<EvaluationSuccessPAge> createState() => _EvaluationSuccessPAgeState();
}

class _EvaluationSuccessPAgeState extends State<EvaluationSuccessPAge> {
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: h/5,),
                SvgPicture.string(TaskSvg().thankYouIcon),
                SizedBox(height: 10,),
                Text("Thank you",style: GoogleFonts.roboto(
                  fontSize: w/12,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 20,),
                Text("Your involvement in the evaluation process is highly valued.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                  fontSize: w/26,
                  // fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 20,),
            Container(
              width: w1/2,
              child: GradientButton(
                  onPressed: (){},
                  gradient:  LinearGradient(
                    colors: [
                      ColorPalette.primary,
                      ColorPalette.primary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: ColorPalette.primary,
                  child: Text(
                    "Back to Home",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: w/26,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
