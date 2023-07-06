import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: w,
      // height: 356,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
      ),child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Price Details",
            style: GoogleFonts.inter(
              color: ColorPalette.black,
              fontSize: w/23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10,),
        //
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Selling Price",
                style: TextStyle(
                  fontSize: w/23,
                  color: ColorPalette.subtextGrey
                ),
              ),
              Text(
                "1925.25",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: w/23,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Container(width: w,
        height: 1,
        color: ColorPalette.divider,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: TextStyle(
                  fontSize: w/23,
                    color: ColorPalette.subtextGrey
                ),
              ),
              Text(
                "-125.0",
                style: GoogleFonts.inter(
                  color: ColorPalette.green,
                  fontSize: w/23,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Container(width: w,
        height: 1,
        color: ColorPalette.divider,),   Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping & Packing",
                style: TextStyle(
                  fontSize: w/23,
                    color: ColorPalette.subtextGrey
                ),
              ),
              Text(
                "14.25",
                style: GoogleFonts.inter(
                  color: ColorPalette.black,
                  fontSize: w/23,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Container(width: w,
        height: 1,
        color: ColorPalette.divider,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping Discount",
                style: TextStyle(
                  fontSize: w/23,
                    color: ColorPalette.subtextGrey
                ),
              ),
              Text(
                "-15.25",
                style: GoogleFonts.inter(
                  color: ColorPalette.green,
                  fontSize: w/23,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Container(width: w,
        height: 1,
        color: ColorPalette.divider,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax",
                style: TextStyle(
                  fontSize: w/23,
                    color: ColorPalette.subtextGrey
                ),
              ),
              Text(
                "125.25",
                style: GoogleFonts.inter(
                  color: ColorPalette.black,
                  fontSize: w/23,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Container(width: w,
        height: 1,
        color: ColorPalette.divider,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Promotion ",
                style: TextStyle(
                  fontSize: w/23,
                    color: ColorPalette.subtextGrey
                ),
              ),
              Text(
                "5.25",
                style: GoogleFonts.inter(
                  color: ColorPalette.black,
                  fontSize: w/23,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Container(width: w,
        height: 1,
        color: ColorPalette.divider,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                    fontSize: w/23,
                    color: ColorPalette.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "-25.25",
                style: GoogleFonts.inter(
                  color: ColorPalette.black,
                  fontSize: w/23,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5,)
      ],
    ),
    );
  }
}
