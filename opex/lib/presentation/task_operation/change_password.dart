
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../../core/common_snackBar.dart';
import '../authentication/authentication.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String contactNumber = "";
  String? otpPin;
  bool active = false;
  CountdownTimerController controller = CountdownTimerController(endTime: 10);
  int endTime = DateTime.now().millisecondsSinceEpoch + 100 * 120;

  List<String> images = [
    "https://tinyurl.com/popup-banner-image",
    "https://tinyurl.com/popup-banner-image2",
    "https://tinyurl.com/popup-banner-image3",
    "https://tinyurl.com/popup-banner-image4"
  ];
  // void showDefaultPopup() {
  //   PopupBanner(
  //     context: context,
  //     images: images,
  //     onClick: (index) {
  //       debugPrint("CLICKED $index");
  //     },
  //   ).show();
  // }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'OTP Send successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        print("<<<<<<$state");
        if (state is ChangePasswordLoading) {}
        if (state is ChangePasswordSuccess) {
          newPassword.text == newPasswordTwo.text &&
              state.message == "OTP Send successfully"
              ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangePasswordOTP(
                    email: authentication.authenticatedUser.mobile ?? "",
                    newPass: newPassword,
                    currentPass: currentPassword),
              ))
              : Navigator.pop(context);
          state.message == "Password changed successfully"
              ? Navigator.pop(context)
              : showToast();
          // newPassword.text == newPasswordTwo.text &&
          //         state.message == "OTP Send successfully"
          //     ? showDialog(
          //         context: context,
          //         builder: (context) {
          //           controller = CountdownTimerController(
          //             endTime: endTime,
          //           );
          //           Timer? countdownTimer;
          //           Duration myDuration = Duration(seconds: 120);
          //           void stopTimer() {
          //             setState(() => countdownTimer!.cancel());
          //           }
          //
          //           void resetTimer() {
          //             stopTimer();
          //             setState(() => endTime =
          //                 DateTime.now().millisecondsSinceEpoch + 100 * 120);
          //           }
          //
          //           void setCountDown() {
          //             final reduceSecondsBy = 1;
          //             setState(() {
          //               final seconds = myDuration.inSeconds - reduceSecondsBy;
          //               if (seconds < 0) {
          //                 countdownTimer!.cancel();
          //               } else {
          //                 myDuration = Duration(seconds: seconds);
          //               }
          //             });
          //           }
          //
          //           void startTimer() {
          //             countdownTimer = Timer.periodic(
          //                 Duration(seconds: 1), (_) => setCountDown());
          //           }
          //
          //           return CommonAlertDialog(
          //               content: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     "OTP Verification",
          //                     style: GoogleFonts.poppins(
          //                         fontWeight: FontWeight.w500,
          //                         fontSize: w / 26),
          //                   ),
          //                   InkWell(
          //                       onTap: () {
          //                         Navigator.pop(context);
          //                       },
          //                       child: Icon(Icons.close))
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: h / 30,
          //               ),
          //               Container(
          //                 width: w1,
          //                 child: OTPTextField(
          //                   fieldStyle: FieldStyle.box,
          //                   outlineBorderRadius: 3,
          //                   length: 5,
          //                   fieldWidth: w1 / 8.5,
          //                   otpFieldStyle: OtpFieldStyle(
          //                       focusBorderColor: Colors.white,
          //                       backgroundColor: Colors.white.withOpacity(0.1),
          //                       borderColor: Colors.white,
          //                       disabledBorderColor: Colors.white,
          //                       enabledBorderColor:
          //                           Palette.DARK.withOpacity(0.2)),
          //                   style: GoogleFonts.poppins(
          //                       fontSize: w / 18,
          //                       fontWeight: FontWeight.w300,
          //                       color: Colors.black),
          //                   textFieldAlignment: MainAxisAlignment.spaceAround,
          //                   onChanged: (pin) {},
          //                   onCompleted: (pin) {
          //                     otpPin = pin;
          //                   },
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: h / 80,
          //               ),
          //               SizedBox(
          //                 height: 15,
          //               ),
          //               CommonButton(
          //                 label: "Send OTP",
          //                 onPressed: () {
          //                   print("OTP PIN$otpPin");
          //                   BlocProvider.of<SigninBloc>(context).add(
          //                       ChangePasswordEvent(
          //                           current: currentPassword.text,
          //                           userName: authentication
          //                               .authenticatedUser.username
          //                               .toString(),
          //                           newPass: newPasswordTwo.text,
          //                           otp: otpPin ?? ""));
          //                 },
          //               )
          //             ],
          //           ));
          //         })
          //     : Navigator.pop(context);
          // state.message == "Password changed successfully"
          //     ? Navigator.pop(context)
          //     : showToast();
        }
        if (state is ChangePasswordFailed) {
          showSnackBar(
            context,
            message: state.message,
            color: Colors.black,
          );
        }
      },
      child: buildMain(),
    );
  }

  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordTwo = TextEditingController();
  TextEditingController currentPassword = TextEditingController();

  Widget buildMain() {
    double w1 = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double w = w1 > 700 ? 400 : w1;
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
      child: BackAppBar(
        label: "Change password",
        isAction: false,
      ),
    ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    left: w1 > 700 ? 30 : 16,
                    right: w1 > 700 ? 30 : 16,),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const  Icon(Icons.arrow_back_ios_new, color: Palette.DARK),

                      const SizedBox(
                        height: 10,
                      ),
                      TextFormReusable(
                        controller: currentPassword,
                        label: "Current Password",
                        hint: "Enter current password",
                        password: true,
                        isMandatory: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ('Enter Password');
                          }
                          if (value.length < 6) {
                            return ("password requires min 6 digit");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormReusable(
                        controller: newPassword,
                        label: "New Password",
                        hint: "Enter new password",
                        password: true,
                        isMandatory: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ('Enter Password');
                          }
                          if (value.length < 6) {
                            return ("password requires min 6 digit");
                          }
                          if (newPassword.text == currentPassword.text) {
                            return ('both passwords are same');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormReusable(
                        controller: newPasswordTwo,
                        label: "Confirm Password",
                        hint: "Enter new password",
                        password: true,
                        isMandatory: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ('Confirm your password');
                          }
                          if (newPasswordTwo.text != newPassword.text) {
                            return ('passwords does not match');
                          }
                          if (newPasswordTwo.text == currentPassword.text) {
                            return ('both passwords are same');
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: w1 > 700 ? 30 : 40,
                      ),
                      GradientButton(
                          onPressed: () {
                            if (newPassword.text.trim() == "" ||
                                newPasswordTwo.text.trim() == "" ||
                                newPassword.text.trim() ==
                                    currentPassword.text.trim() ||
                                newPasswordTwo.text.trim() ==
                                    currentPassword.text.trim()) {
                              print(newPassword.text.trim() == "");
                              print(newPasswordTwo.text.trim() == "");
                              print(newPassword.text.trim() ==
                                  currentPassword.text.trim());
                              print(newPasswordTwo.text.trim() ==
                                  currentPassword.text.trim());
                              print(newPassword.text);
                              print(currentPassword.text);
                              print(newPasswordTwo.text);
                              Fluttertoast.showToast(
                                  msg: 'Please Check Fields',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black);
                            } else {
                              print(
                                  "new${authentication.authenticatedUser.username.toString()}");
                              newPassword.text == newPasswordTwo.text
                                  ? BlocProvider.of<EmployeeBloc>(context)
                                  .add(ChangePasswordEvent(
                                current: currentPassword.text,
                                userName: authentication
                                    .authenticatedUser.username
                                    .toString(),
                                newPass: newPasswordTwo.text,
                              ))
                                  : Fluttertoast.showToast(
                                  msg: 'Password Does Not Match',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black);
                            }
                          },
                          gradient: const LinearGradient(
                            colors: [ColorPalette.primary, ColorPalette.primary],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: ColorPalette.primary,
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),

                      // GestureDetector(
                      //   onTap: (){
                      //     // showDefaultPopup();
                      //     showDialog(
                      //       context: context,
                      //       builder: (context) =>
                      //           AlertDialog(
                      //             title: Text("title"),
                      //             content: Text("body"),
                      //             actions: [
                      //               ElevatedButton(onPressed: () {
                      //                 Navigator.of(context).pop();
                      //               }, child: Text('OK'),)
                      //
                      //             ],
                      //           )
                      //     );
                      //   },
                      //   child: Container(
                      //     height: 100,
                      //       width: 100,
                      //     color: Colors.green,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class ChangePasswordOTP extends StatefulWidget {
  final String email;
  final TextEditingController currentPass;
  final TextEditingController newPass;

  const ChangePasswordOTP(
      {Key? key,
        required this.email,
        required this.currentPass,
        required this.newPass})
      : super(key: key);

  @override
  _ChangePasswordOTPState createState() => _ChangePasswordOTPState();
}

class _ChangePasswordOTPState extends State<ChangePasswordOTP>
    with CodeAutoFill {
  bool isResend = true;
  CountdownTimerController controller = CountdownTimerController(endTime: 10);
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 240;
  bool reloadTimeUp = false;

  @override
  void codeUpdated() {
    setState(() {});
  }

  void onEnd() {
    setState(() {
      reloadTimeUp = true;
    });
  }

  @override
  void initState() {
    listenOtp();

    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);

    super.initState();
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode();
    print("the app hi");
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  String? otpPin;
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();
  String? codeValue = "";

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            ),
            backgroundColor: ColorPalette.white,
            resizeToAvoidBottomInset: false,
            body: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 25),
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _signInKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("OTP Verification",
                        style: TextStyle(
                            color: ColorPalette.black,
                            fontSize: w / 16,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Enter the OTP sent to ",
                          style: TextStyle(
                              fontSize: w / 24, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          widget.email,
                          style: TextStyle(
                              fontSize: w / 24, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PinFieldAutoFill(
                          cursor: Cursor.disabled(),
                          currentCode: codeValue,
                          decoration: BoxLooseDecoration(
                            textStyle: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            radius: Radius.circular(5),
                            strokeColorBuilder: FixedColorBuilder(
                              Color(0xffD5D9D9),
                            ),
                          ),
                          codeLength: 5,
                          onCodeChanged: (code) {
                            setState(() {
                              codeValue = code;
                              otpPin = code;
                            });
                          },
                          onCodeSubmitted: (value) {
                            otpPin = code;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GradientButton(
                        onPressed: () {
                          BlocProvider.of<EmployeeBloc>(context).add(
                              ChangePasswordEvent(
                                  current: widget.currentPass.text,
                                  userName: authentication
                                      .authenticatedUser.username
                                      .toString(),
                                  newPass: widget.newPass.text,
                                  otp: otpPin ?? ""));
                          // BlocProvider.of<ProfileBloc>(context).add(
                          //     VerifyOtpEvent(
                          //         contact: widget.email, otp: otpPin));
                        },
                        gradient: const LinearGradient(
                          colors: [ColorPalette.primary, ColorPalette.primary],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: ColorPalette.primary,
                        child: const Text(
                          "Submit OTP",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                    SizedBox(
                      height: h / 14,
                    ),
                    Container(
                        width: w,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            reloadTimeUp == false
                                ? CountdownTimer(
                              widgetBuilder: (context, time) {
                                return Text(
                                  '  ${time?.min ?? 0} : ${time?.sec} ',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey),
                                );
                              },
                              controller: controller,
                              onEnd: onEnd,
                              endTime: endTime,
                            )
                                : Container(),
                            reloadTimeUp == true
                                ? Row(
                              children: [
                                Text(
                                  "Don’t receive the OTP ?",
                                  style: GoogleFonts.poppins(
                                      fontSize: w / 27,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: () {
                                    // BlocProvider.of<ProfileBloc>(
                                    //     context)
                                    //     .add(ResendOtpEvent(
                                    //     mobile:
                                    //     "+${authentication.authenticatedUser.mobileCode}${widget.email.split("0")[1]}"));
                                  },
                                  child: Text(
                                    "Resend",
                                    style: GoogleFonts.poppins(
                                        fontSize: w / 27,
                                        fontWeight: FontWeight.w500,
                                        color: ColorPalette.primary),
                                  ),
                                )
                              ],
                            )
                                : Container()
                          ],
                        )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
