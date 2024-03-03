import 'dart:io';

import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/profile_text_field.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_svg.dart';
import 'package:cluster/presentation/dashboard_screen/profile/widgets/profile_menu_card.dart';
import 'package:cluster/presentation/task_operation/change_password.dart';
import 'package:cluster/presentation/task_operation/profile_group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/common_snackBar.dart';
import '../../authentication/authentication.dart';
import '../../base/login_page.dart';
import '../../seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import '../../task_operation/employee_bloc/employee_bloc.dart';
import '../../task_operation/employee_model/employee_model.dart';
import '../../task_operation/profile_organisation_details.dart';
import '../../task_operation/profile_user_list.dart';
import '../../task_operation/task_title/new_job_list.dart';
import '../home_screen/home_svg.dart';
import 'help_screen.dart';
import 'my_profile_details.dart';

class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({super.key});

  @override
  State<NewProfileScreen> createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends State<NewProfileScreen> {
  List<bool> readOnly = [true, true, true];
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String profilePic = '';
  dynamic imageId = 0;
  SharedPreferences? pref;
  String token='';
  String fcm='';
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    tokenFuction();
    super.initState();
  }
  tokenFuction()async{
    print("token maari$token");
    pref=await SharedPreferences.getInstance();
    token = pref?.getString("token")??"";
    print("token maari$token");
  }

  final picker = ImagePicker();
  File? cropImage;
  List<String> nationalityList = [];
  bool _cropped = false;
  bool activeTextfield = false;
  bool isToggle = false;
  bool focus = false;
  FocusNode myfocus = FocusNode();
  FocusNode myfocus1 = FocusNode();
  FocusNode myfocus2 = FocusNode();
  GetEmployeeList? readEmployee;
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UpdateProfilePicSuccess) {
              showSnackBar(context,
                  message: state.success, color: ColorPalette.green);
              context.read<ProfileBloc>().add(UpdateProfilePicCommunicationEvent(pic: profilePic,userCode: authentication.authenticatedUser.code,
              token: token));
            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is UpdateEmployeeSuccess) {
              showSnackBar(context,
                  message: state.user, color: ColorPalette.green);
            }
            if (state is UpdateEmployeeFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.green);
            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is PicOnlyProfileSuccess) {
              print("Inside Success${state.data}\t${state.url}");
              setState(() {
                imageId = state.data;
                profilePic = state.url;
                context
                    .read<ProfileBloc>()
                    .add(UpdateProfilePicEvent(pic: profilePic));
              });
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              readEmployee = state.user;
              nameController = TextEditingController(text: state.user.fname);
              mobileController =
                  TextEditingController(text: "${state.user.primaryMobile}");
              emailController = TextEditingController(text: state.user.email);
              profilePic = state.user.userMete?.profile ?? '';
              imageId = state.user.userMete?.profile ?? '';
              Variable.profilePic = state.user.userMete?.profile ?? '';

              setState(() {});
            }
          },
        ),
      ],
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorPalette.white,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(60),
        //   child: Column(
        //     children: [
        //       AppBar(
        //         systemOverlayStyle: const SystemUiOverlayStyle(
        //           systemNavigationBarColor: Colors.white, // Navigation bar
        //           statusBarColor: Colors.white, // Status bar
        //         ),
        //         elevation: 0,
        //         backgroundColor: Colors.white,
        //         surfaceTintColor: Colors.white,
        //         centerTitle: false,
        //         title: Text(
        //           "My Profile",
        //           style: TextStyle(color: Colors.black, fontSize: w / 22),
        //         ),
        //         titleSpacing: 10,
        //         leading: Padding(
        //           padding: const EdgeInsets.only(left: 10),
        //           child: SvgPicture.string(
        //             AppsSvg().appbarIcon,
        //           ),
        //         ),
        //         leadingWidth: 28,
        //         actions: [
        //           // Padding(
        //           //   padding: const EdgeInsets.only(top: 20, left: 16),
        //           //   child: InkWell(
        //           //     onTap: () {
        //           //       if (activeTextfield == true) {
        //           //         context.read<ProfileBloc>().add(UpdateProfileEvent(
        //           //               mobile: mobileController.text,
        //           //               lname: "",
        //           //               fname: nameController.text,
        //           //               dob: "",
        //           //               email: emailController.text,
        //           //             ));
        //           //       } else {
        //           //         Future.delayed(Duration(seconds: 0), () {
        //           //           myfocus
        //           //               .requestFocus(); //auto focus on second text field.
        //           //         });
        //           //
        //           //         setState(() {
        //           //           focus = true;
        //           //           print("focusss$focus");
        //           //         });
        //           //         // activeTextfield=false;
        //           //       }
        //           //       myfocus.unfocus();
        //           //       myfocus1.unfocus();
        //           //       myfocus2.unfocus();
        //           //       activeTextfield = false;
        //           //     },
        //           //     child: Text(
        //           //       activeTextfield == true ? "Save" : "Edit Profile",
        //           //       style: GoogleFonts.roboto(
        //           //         color:
        //           //             // activeTextfield==true?
        //           //             Color(0xFF2871AF),
        //           //         // :Color(0xFFD3D3D3),
        //           //         fontSize: w / 26,
        //           //         fontWeight: FontWeight.w500,
        //           //       ),
        //           //     ),
        //           //   ),
        //           // ),
        //
        //           // SvgPicture.string(HomeSvg().msgIcon),
        //           //         const SizedBox(
        //           //           width: 16,
        //           //         ),
        //           //         GestureDetector(
        //           //           onTap: widget.onTap,
        //           //             child: SvgPicture.string(HomeSvg().addIcon)),
        //
        //           const SizedBox(
        //             width: 16,
        //           )
        //         ],
        //       ),
        //       Container(
        //         width: w1,
        //         height: 1.50,
        //         decoration: const BoxDecoration(
        //           color: Color(0xb2e6e6e6),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w1 > 700 ? 365 : 140),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          // color: Colors.yellow,
                          child: Stack(
                            children: [
                              profilePic != ""
                                  ? Container(
                                      width: 80,
                                      // height: 181,
                                      decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(profilePic ?? ""),
                                            fit: BoxFit.cover),
                                        // border: Border.all(
                                        //   color: Colors.white,
                                        //   width: 3,
                                        // ),
                                      ),
                                    )
                                  : Container(
                                      width: 80,
                                      // height: 181,
                                      padding: EdgeInsets.all(15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          // color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xffD3D3D3)
                                              .withOpacity(0.5)),
                                      child: SvgPicture.string(
                                        ProfileSvg().profileSvg,
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                              // Image.asset("asset/newprofile.png"),

                              Positioned(
                                  bottom: 7,
                                  right: 0,
                                  // left: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                    },
                                    child: SvgPicture.string(
                                      ProfileSvg().editProfileIcon,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        // SizedBox(width: 10,),
                        // GestureDetector(
                        //   onTap: () {
                        //     Future.delayed(Duration(seconds: 0),(){
                        //       myfocus.requestFocus(); //auto focus on second text field.
                        //     });
                        //
                        //     setState(() {
                        //
                        //       focus=true;
                        //       print("focusss$focus");
                        //     });
                        //   },
                        //   child: Container(
                        //       child: Text("Edit Profile",
                        //       style: GoogleFonts.roboto(
                        //         color: ColorPalette.primary,
                        //         fontSize: w/26,
                        //         fontWeight: FontWeight.w500
                        //       ),)),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        ProfileTextFormField(
                          myfocus: myfocus,
                          // onTap: () {
                          //   readOnly[0] = !readOnly[0];
                          //   setState(() {});
                          // },
                          readOnly: true,
                          // suffixIcon: Icon(Icons.edit,size: 15,color: Color(0xff555555),),
                          controller: nameController,
                          onChanege: (sa) {
                            activeTextfield = true;
                            setState(() {});
                          },
                        ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        ProfileTextFormField(
                          // onTap: () {
                          //   readOnly[1] = !readOnly[1];
                          //   setState(() {});
                          // },
                          readOnly: true,
                          myfocus: myfocus1,
                          controller: mobileController,
                          onChanege: (sa) {
                            activeTextfield = true;
                            setState(() {});
                          },
                        ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        ProfileTextFormField(
                          // onTap: () {
                          //   readOnly[2] = !readOnly[2];
                          //   setState(() {});
                          // },
                          readOnly: true,
                          myfocus: myfocus2,
                          controller: emailController,
                          onChanege: (sa) {
                            activeTextfield = true;
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  authentication.isAdmin == true ||
                          authentication.isAssociateAdmin
                      ? Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          // color: Colors.yellow,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Manage",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: MyProfileDetailsScreen(),
                                          withNavBar: false,
                                          // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.fade,
                                        );
                                      },
                                      child: ProfileMenuCard(
                                        iconSvg: AppsSvg().profileIconSvg,
                                        title: "Profile Details",
                                        // suffixIcon: Text("English",
                                        //   style: GoogleFonts.roboto(
                                        //     fontSize: w/24,
                                        //     color: Color(0xff555555),
                                        //   ),)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                width: w1,
                                color: Colors.grey.shade200,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              authentication.isAssociateAdmin
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              PersistentNavBarNavigator
                                                  .pushNewScreen(
                                                context,
                                                screen: ProfileOrganisation(),
                                                withNavBar: false,
                                                // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .fade,
                                              );
                                            },
                                            child: ProfileMenuCard(
                                              iconSvg: AppsSvg().orgIcon,
                                              title: "Your Organization",
                                              // suffixIcon: Text("English",
                                              //   style: GoogleFonts.roboto(
                                              //     fontSize: w/24,
                                              //     color: Color(0xff555555),
                                              //   ),)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              authentication.isAssociateAdmin
                                  ? Container()
                                  : SizedBox(
                                      height: 10,
                                    ),
                              authentication.isAssociateAdmin
                                  ? Container()
                                  : Container(
                                      height: 1,
                                      width: w1,
                                      color: Colors.grey.shade200,
                                    ),
                              authentication.isAssociateAdmin
                                  ? Container()
                                  : SizedBox(
                                      height: 10,
                                    ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: ProfileUserList(),
                                    withNavBar: false,
                                    // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                },
                                child: ProfileMenuCard(
                                    iconSvg: AppsSvg().userIcon,
                                    title: "Users Info"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                width: w1,
                                color: Colors.grey.shade200,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: ProfileGroupList(),
                                    withNavBar: false,
                                    // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ProfileMenuCard(
                                        iconSvg: AppsSvg().groupIcon,
                                        title: "Groups",
                                        // suffixIcon: isToggle?SvgPicture.string(
                                        //   HomeSvg().toggleActive,height: 25,width: 25,)
                                        //     : SvgPicture.string(
                                        //   HomeSvg().toggleInActive,height: 25,width: 25,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    // color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "More About",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfileMenuCard(
                                  iconSvg: AppsSvg().languageSvgIcon,
                                  title: "Language",
                                  suffixIcon: Text(
                                    "English",
                                    style: GoogleFonts.roboto(
                                      fontSize: w / 24,
                                      color: Color(0xff555555),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: w1,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const NewJobList(),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            );
                          },
                          child: ProfileMenuCard(
                              iconSvg: AppsSvg().taskProfileIcon,
                              title: "Task and Activities"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: w1,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            isToggle = !isToggle;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProfileMenuCard(
                                  iconSvg: HomeSvg().notiIcon,
                                  title: "Notification Alert",
                                  suffixIcon: isToggle
                                      ? SvgPicture.string(
                                          HomeSvg().toggleActive,
                                          height: 25,
                                          width: 25,
                                        )
                                      : SvgPicture.string(
                                          HomeSvg().toggleInActive,
                                          height: 25,
                                          width: 25,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: w1,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: HelpScreen(autoFocus: false),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.slideUp,
                            );
                          },
                          child: ProfileMenuCard(
                              iconSvg: AppsSvg().helpandsupportIconProfile,
                              title: "Help & Support"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: w1,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: ChangePasswordScreen(),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.slideUp,
                            );
                          },
                          child: ProfileMenuCard(
                              iconSvg: AppsSvg().chagePassword,
                              title: "Change Password"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: w1,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            String email =
                                Uri.encodeComponent("care@sidrateams.com");
                            String subject =
                                Uri.encodeComponent("Share feedback");
                            String body = Uri.encodeComponent("Hi,");
                            print(subject); //output: Hello%20Flutter
                            Uri mail = Uri.parse(
                                "mailto:$email?subject=$subject&body=$body");
                            if (await launchUrl(mail)) {
                            } else {}
                          },
                          child: ProfileMenuCard(
                              iconSvg: AppsSvg().sharefeed,
                              title: "Share feedback"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: w1,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async{
                            pref=await SharedPreferences.getInstance();
                            fcm = pref!.getString("fcm")!;
                            print("SHIFAS FCM$fcm");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    surfaceTintColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          width: w,
                                          // height: h/7,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Confirm",
                                            style: GoogleFonts.roboto(
                                              color: ColorPalette.black,
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Are you sure you want to logout from this application ?",
                                          style: GoogleFonts.roboto(
                                            color: ColorPalette.black,
                                            fontSize: w / 28,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  width: w / 3.3,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: const Color(
                                                                0x26000000)
                                                            .withOpacity(0.05)),
                                                    // boxShadow: [
                                                    //   BoxShadow(
                                                    //     color: Color(0x26000000),
                                                    //     blurRadius: 0,
                                                    //     offset: Offset(0, 0),
                                                    //   ),
                                                    // ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Cancel",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xffa9a8a8),
                                                        fontSize: w / 26,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  final socketProvider = context
                                                      .read<scoketProvider>();
                                                  socketProvider.disconnect();
                                                  authentication
                                                      .clearAuthenticatedTokens();
                                                  Variable.profilePic='';
                                                  context.read<EmployeeBloc>().add( FcmTokenLogOutEvent(fcm.toString()??""));
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const LoginScreen()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                },
                                                child: Container(
                                                  width: w / 3.1,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 13),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    gradient:
                                                        const LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        ColorPalette.primary,
                                                        ColorPalette.primary,
                                                      ],
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Logout",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white,
                                                      fontSize: w / 26,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                        SizedBox(
                                          height: h / 80,
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: ProfileMenuCard(
                              iconSvg: AppsSvg().logoutProfileIcon,
                              title: "Logout"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h / 10,
              ),
              Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                    AppsSvg().careIcon,
                    height: 10,
                    width: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "all rights reserved to sidrateams",
                    style: GoogleFonts.roboto(
                      fontSize: w / 32,
                      color: Color(0xff555555),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: h / 20,
              ),
            ],
          ),
        ),
      )),
    );
  }

  // Future<void> getImage(source) async {
  //   try {
  //     final pickedFile =
  //         await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);
  //
  //     cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;
  //     print(cropImage);
  //     if (cropImage != null) {
  //       context
  //           .read<ProfileBloc>()
  //           .add(UpdateProfilePicEvent(profilePic: cropImage!));
  //
  //     }
  //     setState(() {
  //       _cropped = true;
  //     });
  //
  //   } catch (e) {}
  // }

  Future<void> getImage(source) async {
    try {
      // final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom,
      //   allowedExtensions: ['jpg', ],);
      // // print("pickk pathhhhhhh${pickedFile?.}");
      // // Variable.imageTyp=pickedFile?.files.first.name??"";
      // Uint8List? bytes;

      final pickedFile = await picker.pickImage(
        source: source,
        // imageQuality: 20,

        // maxHeight: 2000, maxWidth: 2000,
      );

      if (pickedFile != null) {
        // Check if the image needs to be cropped
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1), // Adjust aspect ratio if needed
          compressFormat: ImageCompressFormat.png, // Adjust format if needed
          cropStyle: CropStyle
              .rectangle, // Adjust crop style as needed (e.g., rectangle, circle)
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
              statusBarColor: Colors.white,
            ),
            WebUiSettings(
              context: context,
              presentStyle: CropperPresentStyle.dialog,
              boundary: CroppieBoundary(
                width: 420,
                height: 420,
              ),
              viewPort:
                  CroppieViewPort(width: 420, height: 420, type: 'circle'),
              enableExif: true,
              enableZoom: true,
              showZoomer: true,
            )
          ],

          // Adjust compress quality if needed (0 - 100)
          // iosUiSettings: IOSUiSettings(),
        );
        print("croped file$croppedFile");

        if (croppedFile != null) {
          // try {
          //   Uint8List uint8List = await croppedFileToUint8List(croppedFile);
          //   print("searching uni$uint8List");
          //   // Now you have the Uint8List representation of the cropped file.
          //   BlocProvider.of<InventoryBloc>(context).add(PicEvent(bytes: imageBytes!,));
          // } catch (error) {
          //   print('Error: $error');
          // }
          // Convert CroppedFile to File
          final File file = File(croppedFile.path);
          print("croppedFile.openRead()${file}");

          // Do something with the File, e.g., update your UI
          setState(() {
            cropImage = file;
            _cropped = true;
          });

          // Uint8List imageBytes = await croppedFile.readAsBytes();
          // Variable.imageTyp=pickedFile?.name??"";

          BlocProvider.of<EmployeeBloc>(context).add(PostImageOnlyProfileEvent(file));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
