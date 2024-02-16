import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/base/bottom_card.dart';
import 'package:cluster/presentation/base/login_page.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_details.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/color_palatte.dart';

import '../../authentication/authentication.dart';
import 'help_screen.dart';
import 'language_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const GetProfileEvent());
    context.read<ProfileBloc>().add(const GetProfilePicEvent());
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("https://sidrabazar.com/#/privacyPolicy"))) {
      throw Exception('Could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: ColorPalette.primary, // Status bar
          ),
          elevation: 0,
        ),
      ),
      body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: w,
                  height: 156,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(0),
                    ),
                    color: Color(0xfffe5762),
                  ),
                ),
                Container(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                  print("..................$state");
                                  if (state is ProfileSuccess) {
                                    // print(state.user.prflImage);
                                    return Container(
                                      width: 68,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  state.user.userMete?.profile ?? ""),
                                              fit: BoxFit.fill)),
                                    );
                                  }
                                  return Container(
                                    width: 68,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        ),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "asset/newprofile.png"),
                                            fit: BoxFit.fill)),
                                  );
                                  // Image.asset("asset/img_6.png");
                                }),
                                const SizedBox(
                                  width: 10,
                                ),
                                BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                  if (state is ProfileSuccess) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        "${state.user.fname}",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }
                                  return Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      "${authentication.authenticatedUser.fname.toString()}",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: w / 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                            // SvgPicture.string(ProfileSvg().editIcon)
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          // height: 80,
                          width: w,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xffe6ecf0),
                              width: 1,
                            ),
                            boxShadow:const [
                               BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 16, bottom: 10, right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const ProfileDetails(),
                                      withNavBar: true,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.sizeUp,
                                    );
                                    //  ProfileDetails
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xffffc800),
                                        ),
                                        child: Center(
                                          child: SvgPicture.string(
                                              ProfileSvg().personIcon),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Profile Details",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                indent: 70,
                              ),
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //       top: 10, left: 16, bottom: 20, right: 10),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: 28,
                              //         height: 28,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //           color: const Color(0xff007bff),
                              //         ),
                              //         child: Center(
                              //           child: SvgPicture.string(
                              //               ProfileSvg().bussinessIcon),
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 15,
                              //       ),
                              //       Text(
                              //         "Business  Accounts",
                              //         style: GoogleFonts.roboto(
                              //           color: Colors.black,
                              //           fontSize: w / 22,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Operations",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: 80,
                          width: w,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xffe6ecf0),
                              width: 1,
                            ),
                            boxShadow: [
                              const BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 16, bottom: 10, right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const LanguageScreen(),
                                      withNavBar: true,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xff33C658),
                                        ),
                                        child: Center(
                                          child: SvgPicture.string(
                                              ProfileSvg().languageIcon),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Language",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                indent: 70,
                              ),
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //       top: 10, left: 16, bottom: 10, right: 10),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: 28,
                              //         height: 28,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //           color: const Color(0xffFC3B3D),
                              //         ),
                              //         child: Center(
                              //           child: SvgPicture.string(
                              //               ProfileSvg().taskIcon),
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 15,
                              //       ),
                              //       Text(
                              //         "Task and Activities",
                              //         style: GoogleFonts.roboto(
                              //           color: Colors.black,
                              //           fontSize: w / 22,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // const Divider(
                              //   indent: 70,
                              // ),
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //       top: 10, left: 16, bottom: 20, right: 10),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: 28,
                              //         height: 28,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //           color: const Color(0xffAD51E0),
                              //         ),
                              //         child: Center(
                              //           child: SvgPicture.string(
                              //               ProfileSvg().sidraIcon),
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 15,
                              //       ),
                              //       Text(
                              //         "Switch to Sidra Consumer",
                              //         style: GoogleFonts.roboto(
                              //           color: Colors.black,
                              //           fontSize: w / 22,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "More about",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: 80,
                          width: w,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xffe6ecf0),
                              width: 1,
                            ),
                            boxShadow:const [
                               BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _launchUrl,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 16, bottom: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xff007BFD),
                                        ),
                                        child: Center(
                                          child: SvgPicture.string(
                                              ProfileSvg().settingsIcon),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Privacy And Policies",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // const Divider(
                              //   indent: 70,
                              // ),
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //       top: 10, left: 16, bottom: 10, right: 10),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: 28,
                              //         height: 28,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //           color: const Color(0xffFF2552),
                              //         ),
                              //         child: Center(
                              //           child: SvgPicture.string(
                              //               ProfileSvg().notificationIcon),
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 15,
                              //       ),
                              //       Text(
                              //         "Notification Alert",
                              //         style: GoogleFonts.roboto(
                              //           color: Colors.black,
                              //           fontSize: w / 22,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // const Divider(
                              //   indent: 70,
                              // ),
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //       top: 10, left: 16, bottom: 20, right: 10),
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       PersistentNavBarNavigator.pushNewScreen(
                              //         context,
                              //         screen: const HelpScreen(),
                              //         withNavBar: true,
                              //         // OPTIONAL VALUE. True by default.
                              //         pageTransitionAnimation:
                              //             PageTransitionAnimation.fade,
                              //       );
                              //       //  HelpScreen
                              //     },
                              //     child: Row(
                              //       children: [
                              //         Container(
                              //           width: 28,
                              //           height: 28,
                              //           decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.circular(10),
                              //             color: const Color(0xff33A9DB),
                              //           ),
                              //           child: Center(
                              //             child: SvgPicture.string(
                              //                 ProfileSvg().helpIcon),
                              //           ),
                              //         ),
                              //         const SizedBox(
                              //           width: 15,
                              //         ),
                              //         Text(
                              //           "Help & Support",
                              //           style: GoogleFonts.roboto(
                              //             color: Colors.black,
                              //             fontSize: w / 22,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
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
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: const Color(0x26000000)
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
                                                        color:
                                                            const Color(0xffa9a8a8),
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
                                                  authentication
                                                      .clearAuthenticatedTokens();

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
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 13),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    gradient: const LinearGradient(
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
                          child: Container(
                            width: w,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xffe6ecf0),
                                width: 1,
                              ),
                              boxShadow: [
                                const BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const BottomCard()
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
