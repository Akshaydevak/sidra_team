import 'package:cluster/presentation/comunication_module/chat_screen/search_screen.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:cluster/core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';

class AppBarCommunication extends StatefulWidget {
  final String token;

  const AppBarCommunication({Key? key, required this.token}) : super(key: key);


  @override
  State<AppBarCommunication> createState() => _AppBarCommunicationState();
}

class _AppBarCommunicationState extends State<AppBarCommunication> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top:14,bottom:14,right: 9),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SvgPicture.string(
                        AppsSvg().appbarIcon,
                        height: h/43,
                      ),
                    ),

                  // GestureDetector(
                  //   onTap: () {
                  //     // widget.scaffoldKey.currentState.openDrawer();
                  //   },
                  //   child: Stack(
                  //     children: [
                  //       CircleAvatar(
                  //         radius:23,
                  //         backgroundColor: Colors.transparent,
                  //         child: const CircleAvatar(
                  //           radius: 16,
                  //           backgroundColor: Colors.grey,
                  //           backgroundImage: NetworkImage(
                  //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU4g8xUnnDU4kVOp8_-3f3aPDusw_D2AlyXw&usqp=CAU")
                  //         ),
                  //       ),
                  //       Positioned(
                  //         left: 24,
                  //         bottom: 7,
                  //         child: CircleAvatar(
                  //           radius: 10,
                  //           backgroundColor: Colors.white,
                  //           child:SvgPicture.string(
                  //             CommunicationSvg().menuOpen,
                  //             height:9,
                  //           ),
                  //         ))
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    width:9,
                  ),
                  Text(
                    // "Sidrateams",
                    "Communication",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w / 22,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // GestureDetector(
                  //     onTap: () {
                  //       PersistentNavBarNavigator.pushNewScreen(
                  //         context,
                  //         screen: CmtnSearch(token: widget.token),
                  //         withNavBar: true, // OPTIONAL VALUE. True by default.
                  //         pageTransitionAnimation: PageTransitionAnimation.fade,
                  //       );
                  //     },
                  //     child: SvgPicture.string(
                  //       HomeSvg().searchIcon,
                  //       height: 19,
                  //       width: 19,
                  //       color: Colors.black,
                  //     )),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.string(
                        HomeSvg().addIcon,
                        color: Colors.black,
                        height: h/45,
                        // width: 19,
                      )),
                ],
              ),
            ],
          ),
          Container(
                width: w,
                height: 1.50,
                decoration: const BoxDecoration(
                  color: Color(0xb2e6e6e6),
                ),
              ),
        ],
      ),
    );
  }
}
