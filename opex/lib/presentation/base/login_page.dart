import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/authentication/bloc/bloc/auth_bloc.dart';
// import 'package:cluster/presentation/authentication/authenticate.dart';
// import 'package:cluster/presentation/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/order_app/screens/all_order_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/phonenum_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async{

        if (state is LoginSuccess) {

          String? token;
          //
          // print("shifas${state.logData?.email}");
          // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          // sharedPreferences.setString('token',state.logData?.token??"");
          // sharedPreferences.setString('code',state.logData?.employeeCode??"");
          // sharedPreferences.setString('legalEntry',state.logData?.legalEntry??"");
          // sharedPreferences.setString('organizationCode',state.logData?.orgCode??"");
          // token = sharedPreferences.getString('token');

          print("token${authentication.authenticatedUser.token}");
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DashBoard(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        }
        else if(state is LoginFailed){
          showSnackBar(context,
              message: "Enter Valid Credentials",
              color: Colors.red,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }
      },
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
                  height: h/1.1,
                  padding: EdgeInsets.only(top: 30, left: 20,right: 20),
                  // padding: EdgeInsets.only(top: h / 7, left: 10,right: h/7),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            "Login",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: w/11,
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
                          TextFormReusable(
                            label: "Email",
                            hint: "eg.example@email.com",
                            controller: emailController,
                          ),
                          SizedBox(height: 16,),

                          TextFormReusable(
                              label: "Password",
                              hint: "atleast 8 characters",
                              controller: passwordController),
                          SizedBox(height: 16,),
                          TextFormReusable(
                              label: "Employee Code",
                              hint: "eg.EMPY000",
                              onchange: (bb){
                                codeController.value = codeController.value.copyWith(
                                  text: bb.toUpperCase(),
                                  selection: TextSelection.collapsed(offset: bb.length),
                                );
                              },
                              controller: codeController),
                          // PhoneWidget(),
                          SizedBox(
                            height:40,
                          ),
                          GradientButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    code: codeController.text));
                                // PersistentNavBarNavigator.pushNewScreen(
                                //   context,
                                //   screen: OtpScreen(),
                                //   withNavBar: true,
                                //   // OPTIONAL VALUE. True by default.
                                //   pageTransitionAnimation: PageTransitionAnimation.fade,
                                // );
                                //OtpScreen
                              },
                              gradient: const LinearGradient(
                                colors: [ColorPalette.primary, ColorPalette.primary],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              color: Colors.transparent,
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),

                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: w/1.14,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'By clicking, I accept the ',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 27,
                                    height: 1.5,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Terms & Condition ',
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        decoration: TextDecoration.underline,
                                        fontSize: w / 27,
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                        text: 'and ',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 27,
                                          height: 1.5,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        decoration: TextDecoration.underline,
                                        fontSize: w / 27,
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
