import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DeliveryAddressCard extends StatelessWidget {
  bool isSelect;
   DeliveryAddressCard({Key? key,this.isSelect=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      decoration:isSelect? BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xfffe5762), width: 1, ),
        color: Color(0x0cfe5762),
      ):BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Al Rashidiyyah, Ajman",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w/23,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "MP Tower, Thondayad bypass,\nKozhikode, 673572",
            style: GoogleFonts.roboto(
              color: ColorPalette.subtextGrey,
              fontSize: w/23,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
