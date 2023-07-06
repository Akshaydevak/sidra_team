import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../order_app/order_svg.dart';
class SelectProductCard extends StatefulWidget {

   SelectProductCard({Key? key}) : super(key: key);

  @override
  State<SelectProductCard> createState() => _SelectProductCardState();
}

class _SelectProductCardState extends State<SelectProductCard> {
  bool isActive=false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
setState(() {
  isActive=!isActive;
});
      },
      child: Container(
        padding: EdgeInsets.all( 16),
        decoration: isActive?BoxDecoration(
          color: Color(0xfffdf2f2),
        ):BoxDecoration(),
        child: Row(
          children: [
            isActive
                ? Container(
              padding: EdgeInsets.all(10),
              child: SvgPicture.string(
                  OrderSvg().checkBoxActiveIcon),
            )
                : SvgPicture.string(OrderSvg().checkBoxIcon),
            SizedBox(width: 6,),
            Container(
              width: 54,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xffe2e2e2), width: 1, ),
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "15464646545 ",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: w/2,
                  height: 37,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consetur adipiscing ea...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
