import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../profile/help_screen.dart';
import '../home_svg.dart';

class SearchBarDashboard extends StatelessWidget {
  const SearchBarDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.only(left: 18, right: 18),
      width: w,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(49),
        border: Border.all(
          color: Color(0x11000000),
          width: 0.30,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0x14000000).withOpacity(0.08),
        //     blurRadius: 30,
        //     offset: Offset(1, 1),
        //   ),
        // ],
        color: Color(0xffF7F7F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: w / 1.6,
            child: TextFormField(
              onTap: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: HelpScreen(autoFocus: true),
                  withNavBar: false,
                  // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.slideUp,
                );
              },
              cursorColor: Colors.black,readOnly: true,
              decoration: InputDecoration(
                hintText: "Search..",
                hintStyle: GoogleFonts.roboto(
                  color: Color(0xffbdbdbd),
                  fontSize: w / 28,
                  fontWeight: FontWeight.w400,
                ),

                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 1,
                height: 30,
                color: Color(0xffE7E7E7),
              ),
              SizedBox(
                width: 13,
              ),
              SvgPicture.string(
                HomeSvg().searchIcon,
                color: Color(0xff222222),
                height: 17,
                width: 17,
              ),
              SizedBox(
                width: 2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
