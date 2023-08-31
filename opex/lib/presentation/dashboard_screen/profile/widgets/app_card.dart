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
    var w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        // color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.string(svgIcon ?? ""),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: w/1.4,
                  child: Text(
                    appDescription ?? "",
                    style: GoogleFonts.roboto(
                        color: Color(0xFF555555),
                        fontSize: 14,
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
