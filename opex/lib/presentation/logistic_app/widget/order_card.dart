import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../seller_app/seller_svg.dart';
import '../utils/logistic_svg.dart';

class OrderCard extends StatelessWidget {
  final String? date;
  final String? phoneNumber;
  final String? name;
  final String? address;
  const OrderCard({Key? key, this.date, this.phoneNumber, this.name, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffe6ecf0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.string(
                      LogisticSvg().clockIcon,
                      color: ColorPalette.inactiveGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      date??"",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.string(
                      LogisticSvg().docIcon,
                      color: ColorPalette.inactiveGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "61843643545",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sidra App",
                          style: GoogleFonts.roboto(
                            color: Color(0xff676767),
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.string(
                      LogisticSvg().personIcon,
                      color: ColorPalette.inactiveGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      name??"",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.string(
                      LogisticSvg().locationIcon,
                      color: ColorPalette.inactiveGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: w / 1.5,
                      child: Text(
                        address??"",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          Positioned(
              top: 10,
              right: 0,
              child: Container(
                width: 106,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color(0xff3fb44b),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.string(SellerSvg().deliveryIcon),
                    const SizedBox(width: 5,),
                    Text(
                      "Delivered",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15,

                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
