import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerOrderCard extends StatelessWidget {
  const SellerOrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: w,
          padding: EdgeInsets.all(16),
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
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.string(SellerSvg().clockIcon),
                  SizedBox(width: 8,),
                  Text(
                    "12 Jan 2022, 10:25 AM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SvgPicture.string(SellerSvg().docIcon),
                  SizedBox(width: 8,),
                  Row(
                    children: [
                      Text(
                        "61843643545",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        "Sidra App",
                        style: GoogleFonts.roboto(
                          color: Color(0xff676767),
                          fontSize: 16,

                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SvgPicture.string(SellerSvg().personIcon),
                  SizedBox(width: 8,),
                  Text(
                    "Afthabu Rahman P P",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.string(SellerSvg().mapIcon),
                  SizedBox(width: 8,),
                  Text(
                    "Pookattu Purayil House, Avilora P.O,\nKoduvally VIA, Pin: 673572",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
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
              width: 103,
              height: 28,
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
    );
  }
}
