import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 96,
            height: 128,

            decoration: BoxDecoration(
                color: ColorPalette.inactiveGrey,
                borderRadius: BorderRadius.circular(8)),
            // child: FlutterLogo(size: 96),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: w / 1.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Musafir Pure Low Sodium Natural Wow Sodiu",
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontSize: w / 24,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "AED ",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: w / 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "1899.00",
                      style: GoogleFonts.poppins(
                        color: ColorPalette.black,
                        fontSize: w / 22,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Unit: KG",
                  style: TextStyle(
                    color: ColorPalette.subtextGrey,
                    fontSize: w/27,
                  ),
                ),
                Text(
                  "Origin: PHILIPPINES",
                  style: TextStyle(
                    color:  ColorPalette.subtextGrey,
                    fontSize: w/27,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
