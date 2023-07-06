
import 'package:cluster/presentation/manufacture/manufacture_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';

class ManufactureContractCard extends StatelessWidget {
  const ManufactureContractCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      // height: 174,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffe6ecf0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0f000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "C.ID : 130215421",
                      style: TextStyle(
                        color: Color(0xff7d7d7d),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Seller Name",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Approved by seller on ",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff7D7D7D)),
                        ),
                        Text(
                          "12 July 2020",
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorPalette.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: w,height: 1,
                color: ColorPalette.divider,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SvgPicture.string(ManufactureSvg().emailIcon),
                      Text(
                        "E-MAIL",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.subtextGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
                    width: 1,
                    color: ColorPalette.divider,
                  ),
                  Row(
                    children: [
                      SvgPicture.string(ManufactureSvg().shareIcon),
                      SizedBox(width: 10,),
                      Text(
                        "SHARE",
                        style: GoogleFonts.roboto(
                          color:  ColorPalette.subtextGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )

                ],
              )
            ],
          ),
          Positioned(
              top: 10,
              right: 0,
              child: Container(
                width: 99,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color(0x33189c3d),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Approved",
                  style: GoogleFonts.roboto(
                    color: Color(0xff199c3e),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
