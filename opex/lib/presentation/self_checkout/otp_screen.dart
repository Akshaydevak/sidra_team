import 'package:cluster/presentation/self_checkout/register_self.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
class OtpScreen extends StatefulWidget {
   OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isResend = true;
int length=0;
  CountdownTimerController controller = CountdownTimerController(endTime: 120);

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void onEnd() {
    print('onEnd');
  }
String?otpPin;
  @override
  void initState() {
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:25,),
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back)),
                const SizedBox(height: 30,),
                Text(
                  "Verify your Mobile Number",
                  style: GoogleFonts.roboto(
                    color: Color(0xff1e232c),
                    fontSize: w/12,

                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "An OTP has been sent to your number",
                  style:  GoogleFonts.roboto(
                    color: Color(0xff8390a1),
                    fontSize: w/25,
                    fontWeight: FontWeight.normal,
                  ),
                ),SizedBox(height: 5,),
                Text(
                  "+91 8606200441",
                  style:  GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w/25,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 10,),
                OTPTextField(
                  width: w/1.2,
                  fieldStyle: FieldStyle.underline,
                  outlineBorderRadius: 3,
                  length: 4,
                  spaceBetween: 5,
                  fieldWidth: w / 8.5,
                  otpFieldStyle: OtpFieldStyle(

                      focusBorderColor: ColorPalette.primary,
                      backgroundColor: ColorPalette.checkoutBackground,
                      borderColor: Color(0x4cafb9d7),
                      disabledBorderColor: Color(0x4cafb9d7),
                      enabledBorderColor:Color(0x4cafb9d7)),
                  style: TextStyle(fontSize: w / 16, color: Colors.black),
                  // textFieldAlignment: MainAxisAlignment.spaceBetween,
                  onChanged: (pin) {
setState(() {
  length=otpPin!.length;
});
                  },
                  onCompleted: (pin) {
                    otpPin = pin;
                  },
                ),
                SizedBox(height: 10,),
                CountdownTimer(
                  widgetBuilder: (context, time) {
                    if (time == null) {
                      return GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Resend Code",
                            style: GoogleFonts.urbanist(
                              color:isResend
                                  ? ColorPalette.black
                                  : Colors.grey,
                              fontSize: 15,

                              fontWeight: FontWeight.w700,
                            ),

                          ));
                    }
                    return Container(
                      // color: Colors.grey,
                      child: Row(
                        children: [
                          Text(
                            'Resend code in ',
                            style: GoogleFonts.urbanist(
                              color: ColorPalette.black,
                              fontSize: 16,

                              fontWeight: FontWeight.normal,
                            ),
                          ),Text(
                            ' ${time.min ?? 0} : ${time.sec} ',
                            style: GoogleFonts.urbanist(
                              color: ColorPalette.black,
                              fontSize: 15,

                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  controller: controller,
                  onEnd: onEnd,
                  endTime: endTime,
                ),
                SizedBox(
                  height: 40,
                ),
                GradientButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: RegisterSelf(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    color:length==4? ColorPalette.primary:Color(0xffe9e8e9),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [length==4?Color(0xffff467a):Color(0xffe9e8e9),
                       length==4?Color(0xff9c0e36):Color(0xffe9e8e9)],
                    ),

                    child: Text(
                      "Verify",
                      style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ]),
        ),
      ),
    );
  }
}
