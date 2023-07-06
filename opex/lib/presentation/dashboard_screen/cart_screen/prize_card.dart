import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrizeCard extends StatelessWidget {
  const PrizeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 10),
      width: w,
      color: ColorPalette.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price Details",
            style: GoogleFonts.roboto(
              color: ColorPalette.black,
              fontSize: w/20,

              fontWeight: FontWeight.w500,
            ),
          ),SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal ",
                style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: w/20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "1925.25",
                    style: GoogleFonts.roboto(
                      color:ColorPalette.black,
                      fontSize: w/20,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "AED ",
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: w/27,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: w/20,
                ),
              ),
              Text(
                "-25.25",
                style: GoogleFonts.roboto(
                  color: Color(0xff079b15),
                  fontSize: w/20,

                  fontWeight: FontWeight.w500,
                ),
              )

            ],
          ), SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Charge",
                style: TextStyle(
                  color: Color(0xff676767),
                  fontSize: w/20,
                ),
              ),
              Text(
                "FREE",
                style: GoogleFonts.roboto(
                  color: Color(0xff079b15),
                  fontSize: w/20,

                  fontWeight: FontWeight.w500,
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}
