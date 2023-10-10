import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/authentication/bloc/bloc/auth_bloc.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/base/register_new_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/home_svg.dart';

class EmailCheckPage extends StatefulWidget {
  const EmailCheckPage({Key? key}) : super(key: key);

  @override
  State<EmailCheckPage> createState() => _EmailCheckPageState();
}

class _EmailCheckPageState extends State<EmailCheckPage> {
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
        backgroundColor: ColorPalette.primary,
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
            physics: NeverScrollableScrollPhysics(),
            child: SafeArea(
                child: Container(
                  height: h,
                  width: w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff308BC9),
                        const Color(0xff2772B0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // begin: const FractionalOffset(0.0, 0.0),
                      // end: const FractionalOffset(1.0, 0.0),
                      // stops: [0.0, 1.0],
                      // tileMode: TileMode.clamp
                    ),
                  ),
                  padding: EdgeInsets.only(top: 30, left: 20,right: 20),
                  // padding: EdgeInsets.only(top: h / 7, left: 10,right: h/7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      Text("Check your email!",
                      style: GoogleFonts.roboto(
                        fontSize: w/20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 100,),
                      Lottie.asset(
                        repeat: false,

                        'asset/email.json',
                      ),
                      SizedBox(height: 15,),
                      Text("After verification, we have sent the credentials to your account",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: w/24,
                            color: Colors.white,
                        ),),
                      SizedBox(height: 15,),
                      Container(
                        width: w/2.5,
                        child: GradientButton(
                            onPressed: () {
                              const url = 'https://mail.google.com/mail';
                              // com.google.android.gm
                              Uri mail = Uri.parse(url);
                              launchUrl(mail);
                              setState(() {

                              });
                            },
                            gradient: const LinearGradient(
                              colors: [ColorPalette.primary, ColorPalette.primary],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            color: Colors.white,
                            child:
                            Text(
                              "CHECK NOW",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w/24,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ),
                      SizedBox(height: 100,),
                      Text("Already have an account?",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w/24,
                          fontWeight: FontWeight.w400,
                        ),),
                      Text("Login",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w/24,
                          fontWeight: FontWeight.w500,
                        ),),


                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
