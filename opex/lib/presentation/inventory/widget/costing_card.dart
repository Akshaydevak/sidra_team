import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/inventory/inventory_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class CostingCard extends StatelessWidget {
  const CostingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(10), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(10), ),
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
      width: w,
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xfff0f1f2),
            ),
          ),
          SizedBox(width: 10,),
          Container(
            // color: Colors.grey,
            width: w/1.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing ealiquam ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w/24,
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    SvgPicture.string(InventorySvg().barcodeIcon),
                    SizedBox(width: 5,),
                    Text(
                      "1254875448754",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.subtextGrey,
                        fontSize: w/27,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
