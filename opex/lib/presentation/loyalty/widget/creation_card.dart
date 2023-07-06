import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CreationCard extends StatelessWidget {
  String? label;
   CreationCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffe0e3e5), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Color(0xfff7f7f7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label??"Choose Segment",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w/22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(Icons.keyboard_arrow_down_outlined)
        ],
      ),
    );
  }
}
