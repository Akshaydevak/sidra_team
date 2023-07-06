import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_palatte.dart';
class TaxHistoryCard extends StatelessWidget {
  const TaxHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: w,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border.all(
              color: Color(0xffe3e6e7),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x0a000000),
                blurRadius: 117,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tax Name",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount" ,style: GoogleFonts.roboto(
                      color: ColorPalette.subtextGrey
                  ),),Text(
                    "AED 235.50" ,style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w600
                  ),),

                ],
              ),  SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date" ,style: GoogleFonts.roboto(
                      color: ColorPalette.subtextGrey
                  ),),Text(
                    "Date 12 Jan 2023" ,style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w600
                  ),),

                ],
              ),

            ],
          ),
        ),
        Container(
          width: w,
          height: 49,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: Color(0xfffe5762),
          ),
          child: Center(
            child: Text(
              "PAY DUE",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
