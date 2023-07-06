import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/taxes/tax_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class TaxCard extends StatelessWidget {
  const TaxCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return ClusterCard(child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              width: 53,
              height: 53,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xfff0f1f2),
              ),
              child: SvgPicture.string(TaxSvg().taxIcon),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Receipt #000005642",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "12:40 PM",
                  style: TextStyle(
                    color: ColorPalette.subtextGrey,
                    fontSize: w/27,
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x23d8753d),
              ),
              alignment: Alignment.center,
              child: Text(
                "AED",
                style: GoogleFonts.roboto(
                  color: Color(0xffd7743d),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "250.50",
              style: GoogleFonts.roboto(
                color: ColorPalette.black,
                fontSize: w/25,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    ));
  }
}
