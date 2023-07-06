import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OrderDetialsCard extends StatelessWidget {
  String? title,data;
   OrderDetialsCard({Key? key,this.data,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title??"ORDER NUMBER",
            style: GoogleFonts.roboto(
              color: Color(0xff9b9b9b),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            data??"25465",
            textAlign: TextAlign.right,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
