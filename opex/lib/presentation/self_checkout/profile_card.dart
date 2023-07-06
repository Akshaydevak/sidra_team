import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {
  String ?label;
   ProfileCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(16),
      width: w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x05000000),
                      blurRadius: 8,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Color(0x19ff487c),
                ),
              ),
              SizedBox(width: 16,),
              Text(
                label??"My Reciept",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Icon(Icons.arrow_forward_ios_sharp,color: ColorPalette.inactiveGrey,)
        ],
      ),
    );
  }
}
