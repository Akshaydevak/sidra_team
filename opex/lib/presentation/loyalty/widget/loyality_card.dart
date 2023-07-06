import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LoyalityCard extends StatelessWidget {
  const LoyalityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
     padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "REDMI 10 (Pacific Blue, 64GB)",
                style: GoogleFonts.roboto(
                  color: ColorPalette.subtextGrey,
                  fontSize: w/25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "Credited on 01 October 2022",
                style: TextStyle(
                  color: Color(0xff7d7d7d),
                  fontSize: 13,
                ),
              )
            ],
          ),
          Text(
            "+30",
            style: GoogleFonts.roboto(
              color: Color(0xff3ab746),
              fontSize: w/24,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
