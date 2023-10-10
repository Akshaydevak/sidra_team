import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/authentication/bloc/bloc/auth_bloc.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/base/register_new_user.dart';
import 'package:cluster/presentation/order_app/screens/all_order_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/phonenum_field.dart';
import '../dashboard_screen/home_screen/home_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async{
        if (state is LoginSuccess) {
          _isLoading=false;

          String? token;
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
          _isLoading=false;
          setState(() {

          });
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
                          SvgPicture.string(HomeSvg().teamsIcon),

                          Text(
                            "Login to account",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: w/14,
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
                          SizedBox(height: 5,),

                          TextFormReusableNoLabel(
                              hint: "Enter password",
                              controller: passwordController),
                          SizedBox(height: 5,),
                          TextFormReusableNoLabel(
                              hint: "Director/Employee code",
                              onchange: (bb){
                                codeController.value = codeController.value.copyWith(
                                  text: bb.toUpperCase(),
                                  selection: TextSelection.collapsed(offset: bb.length),
                                );
                              },
                              controller: codeController),
                          // PhoneWidget(),
                          SizedBox(
                            height:30,
                          ),
                          GradientButton(
                              onPressed: () {
                                _isLoading=true;
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
                                setState(() {
                                  
                                });
                              },
                              gradient: const LinearGradient(
                                colors: [ColorPalette.primary, ColorPalette.primary],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              color: Colors.transparent,
                              child: _isLoading==true?
                              SpinKitThreeBounce(
                                color: Colors.white,
                                size: 15.0,
                              ):
                              Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: w/24,
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
                          width: w/1.2,
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
