import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/seller_admin_app/model_seller_admin/seller_admin_models.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:cluster/presentation/task_operation/create/create_svg.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../common_widgets/title_app_bar.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../authentication/bloc/bloc/auth_bloc.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../mpos/search_card.dart';
import '../order_app/order_svg.dart';
import '../promotion_app/dropdown_card.dart';
import '../task_operation/employee_model/employee_model.dart';
import '../task_operation/home/bloc/job_bloc.dart';
import 'email_check_page.dart';

class RegisterNewUser extends StatefulWidget {
  final bool? edit;
  const RegisterNewUser({super.key, this.edit});

  @override
  State<RegisterNewUser> createState() => _RegisterNewUserState();
}

class _RegisterNewUserState extends State<RegisterNewUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController mobileController=TextEditingController();
  String contactNumber='';
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {

    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
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
                          "Register to account",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: w/14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        TextFormReusableNoLabel(
                          hint: "Enter your name",
                          controller: emailController,
                        ),
                        SizedBox(height: 5,),

                        TextFormReusableNoLabel(
                            hint: "Enter your organization name",
                            controller: passwordController),
                        DropDownCard(
                          isMandatory: true,
                          isLabel: true,
                          selValue: "Select industry",
                          onTap: (){
                            // context.read<SellerAdminBloc>()
                            //     .add(const DepartmentListEvent('',"", ""));
                            // _showModalBottomDepartment(departmentName, onCallBack: (bool val){
                          //     print("clllling back hereeee");
                          //     setState(() {
                          //
                          //     });((){});
                          //   });
                          },
                        ),
                        SizedBox(height: 5,),

                        TextFormReusableNoLabel(
                            hint: "Enter business/organization email",
                            controller: passwordController),
                        SizedBox(height: 5,),
                        IntlPhoneField(
                          initialCountryCode: "IN",
                          controller: mobileController,
                          validator: (text) {
                            if (text == null) {
                              return 'Text is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "eg.8606200441",
                            hintStyle:
                            GoogleFonts.roboto(color: Colors.grey, fontSize: w/24),
                            contentPadding:
                            const EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 10),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffe6ecf0)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffe6ecf0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffe6ecf0), width: 1.0),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                          onChanged: (phone) {
                            contactNumber = phone.completeNumber.toString();
                            mobileController =
                                TextEditingController(text: phone.number);
                          },
                          onCountryChanged: (country) {},
                          cursorColor: Colors.black,
                          dropdownIcon: const Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                          dropdownIconPosition: IconPosition.trailing,
                          flagsButtonMargin: const EdgeInsets.only(left: 10, right: 30),
                          disableLengthCheck: true,
                          showDropdownIcon: false,
                        ),
                        SizedBox(height: 5,),
                        TextFormReusableNoLabel(
                            hint: "Enter password",
                            controller: passwordController),

                        SizedBox(
                          height:30,
                        ),
                        GradientButton(
                            onPressed: () {
                              // _isLoading=true;
                              // context.read<AuthBloc>().add(LoginEvent(
                              //     email: emailController.text,
                              //     password: passwordController.text,
                              //     code: codeController.text));
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: EmailCheckPage(),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.fade,
                              );
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
                              "Register your Account",
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
                        GestureDetector(
                          onTap: (){

                            Navigator.pop(context);
                          },
                          child: Text("Already have an account ?",
                            style: GoogleFonts.roboto(
                                fontSize: w/26,
                                color: ColorPalette.primary
                            ),),
                        )


                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: w/1.2,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: 'By creating an account, ',
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 28,
                                  height: 1.5,
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'You accept to our \n',
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: w / 28,
                                      height: 1.5,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'Terms ',
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
    );
  }

}
