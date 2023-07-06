import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class VarientCard extends StatelessWidget {
  int ?index,finalIndex;
   VarientCard({Key? key,this.index,required this.finalIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  Container(
      width: w,
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius:index==0? BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5), ):finalIndex==index? BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0), )
          :BorderRadius.circular(5),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "12454874",
                style: GoogleFonts.poppins(
                  color: Color(0xff1b1b1f),
                  fontSize: 13,

                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5,),
              SizedBox(
                width: w/2,
                // height: 40,
                child: Text(
                  "Musafir Pure Loium Nahjtu Sodium Nasafir Pu..",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),

            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "12\nPack",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                "420.50",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/22,

                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
