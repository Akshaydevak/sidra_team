import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../contract_svg.dart';
class LastScreen extends StatelessWidget {
  const LastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  Stack(
      children: [
        Column(
            children: [
              SvgPicture.string(ContractSvg().contractLastIcon),
              Container(
                width: w,
                padding: EdgeInsets.all(16),

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
                ),
                alignment: Alignment.center,
                child: Text(
                  "Contract Title",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: w,
                height: 2479,
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
                ),
                // child: ,
              ),

            ],

        ),
        Positioned(
          bottom: 0,
            right: 0,
            child: Column(children: [],))
      ],
    );
  }
}
