import 'package:cluster/presentation/comunication_module/chat_screen/search_screen.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
    return Container(
      // color: Colors.green,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [


              GestureDetector(
                onTap: () {
                  // widget.scaffoldKey.currentState.openDrawer();
                },
                child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU4g8xUnnDU4kVOp8_-3f3aPDusw_D2AlyXw&usqp=CAU")),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "Sidrateams",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: CmtnSearch(token: widget.token),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: SvgPicture.string(
                    HomeSvg().searchIcon,
                    height: 19,
                    width: 19,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                  onTap: () {},
                  child: SvgPicture.string(
                    HomeSvg().addIcon,
                    height: 19,
                    width: 19,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
