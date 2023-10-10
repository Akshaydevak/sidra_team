import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppHomeCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? svgIcon;
  final String? appTitle;
  final String? appDescription;
  const AppHomeCard(
      {super.key,
      this.onTap,
      this.svgIcon,
      this.appTitle,
      this.appDescription});

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return InkWell(
      onTap: onTap,
      child: Container(
        // color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.string(svgIcon ?? "",
            height: 50,width: 50,),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appTitle ?? "",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: w/1.45,
                  child: Text(
                    appDescription ?? "",
                    style: GoogleFonts.roboto(
                        color: Color(0xFF555555),
                        fontSize: w/28,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
