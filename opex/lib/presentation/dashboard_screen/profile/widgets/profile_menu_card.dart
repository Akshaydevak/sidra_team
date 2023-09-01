import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuCard extends StatelessWidget {
  final String? iconSvg;
  final String? title;
  const ProfileMenuCard({super.key, this.iconSvg, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.string(iconSvg?? AppsSvg().languageSvgIcon),
        SizedBox(width: 10,),
        Text(
          title??"",
          style: GoogleFonts.roboto(
            color: Color(0xFF14110F),
            fontSize: 17,
            fontWeight: FontWeight.w400,
            height: 1.11,
          ),
        ),
      ],
    );
  }
}