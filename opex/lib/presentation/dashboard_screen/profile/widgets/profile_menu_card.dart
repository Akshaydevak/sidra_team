import 'package:cluster/core/utils/platform_check.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuCard extends StatelessWidget {
  final String? iconSvg;
  final Widget? suffixIcon;
  final String? title;
  final bool isWidth;
  const ProfileMenuCard({super.key, this.iconSvg, this.suffixIcon, this.title,this.isWidth=true});

  @override
  Widget build(BuildContext context) {

    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return isWidth?Container(
      width: isMobile?w/1.15:w1/5.35,color: Colors.white,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(iconSvg?? AppsSvg().languageSvgIcon,height: 30,width: 30,),
          SizedBox(width: 10,),
          Text(
            title??"",
            style: GoogleFonts.roboto(
              color: Color(0xFF14110F),
              fontSize:isMobile? w/22:w/24,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          suffixIcon??Container(),

        ],
      ),
    ):Expanded(
      // width: w/1.15,color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(iconSvg?? AppsSvg().languageSvgIcon,height: 30,width: 30,),
          SizedBox(width: 10,),
          Text(
            title??"",
            style: GoogleFonts.roboto(
              color: Color(0xFF14110F),
              fontSize: w/22,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          suffixIcon??Container(),

        ],
      ),
    );
  }
}