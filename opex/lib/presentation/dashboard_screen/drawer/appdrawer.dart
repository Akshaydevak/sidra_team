import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:cluster/presentation/base/login_page.dart';
import '../profile/profile_bloc/profile_bloc.dart';
import 'drawer_svg.dart';
import '../home_screen/homescreen_widget/list_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(const GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: ColorPalette.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: h / 1.15,
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, state) {
                                print("..................$state");
                                if (state is ProfileSuccess) {
                                  print(state.user.prflImage);
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(
                                            state.user.prflImage ?? ""),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        " ${state.user.fname}",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.black,
                                          fontSize: w / 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        " ${state.user.email}",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.subtextGrey,
                                          fontSize: w / 26,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        " ${state.user.mobile}",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.subtextGrey,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return CircleAvatar(
                                    radius: 35,
                                    child: Image.asset("asset/newprofile.png"));
                              }),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.string(
                                    DrawerSvg().closeIcon,
                                    height: 26,
                                  ))
                            ],
                          ),

                          const SizedBox(
                            height: 0,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       width: w / 2.5,
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             "1245",
                          //             style: GoogleFonts.roboto(
                          //               color: ColorPalette.black,
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 5,
                          //           ),
                          //           const Text(
                          //             "Total Products",
                          //             style: TextStyle(
                          //               color: Color(0xff55636c),
                          //               fontSize: 16,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     Column(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           "10,245",
                          //           style: GoogleFonts.roboto(
                          //             color: ColorPalette.black,
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 5,
                          //         ),
                          //         const Text(
                          //           "Total Unit Sold",
                          //           style: TextStyle(
                          //             color: Color(0xff55636c),
                          //             fontSize: 16,
                          //           ),
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xffE6ECF0),
                      thickness: 1,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const ProfileDetails(),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.sizeUp,
                              );
                            },
                            child: ListTileWidget(
                              label: "Profile Details",
                              svg: DrawerSvg().profileIcon,
                            ),
                          ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          // ListTileWidget(
                          //   label: "Payment Settings",
                          //   svg: DrawerSvg().paymentIcon,
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          // ListTileWidget(
                          //   label: "Pinned Data",
                          //   svg: DrawerSvg().pinnedIcon,
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          // ListTileWidget(
                          //   label: "Reward Corner",
                          //   svg: DrawerSvg().rewardIcon,
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          // ListTileWidget(
                          //   label: "Language Settings",
                          //   svg: DrawerSvg().languageIcon,
                          // ),
                          const SizedBox(
                            height: 16,
                          ),
                          // ListTileWidget(
                          //   label: "Help and Support",
                          //   svg: DrawerSvg().helpIcon,
                          // ),
                          const SizedBox(
                            height: 16,
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
                                          Divider(),
                                          SizedBox(
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
                                          SizedBox(
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0x26000000)
                                                                  .withOpacity(
                                                                      0.05)),
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
                                                              Color(0xffa9a8a8),
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
                                                                builder:
                                                                    (context) =>
                                                                        LoginScreen()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  },
                                                  child: Container(
                                                    width: w / 3.1,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 13),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      gradient: LinearGradient(
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
                                                      textAlign:
                                                          TextAlign.center,
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
                            child: ListTileWidget(
                              label: "Logout",
                              svg: DrawerSvg().logoutSvg,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // ListTileWidget(
                          //   label: "Switch to Sidra Consumer",
                          //   svg: DrawerSvg().switchIcon,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      const Divider(
                        color: Color(0xffE6ECF0),
                        thickness: 1,
                      ),
                      Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "App Version 1.1.0",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.black,
                                  fontSize: w / 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "©2023 sidracart.com All Rights Reserved",
                                style: TextStyle(
                                  color: ColorPalette.subtextGrey,
                                  fontSize: w / 30,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
