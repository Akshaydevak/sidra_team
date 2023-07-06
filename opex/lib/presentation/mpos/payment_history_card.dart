import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentHostoryCard extends StatelessWidget {
  const PaymentHostoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      width: w,

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
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
             children: [
               CircleAvatar(radius: 30,),
               SizedBox(width: 5,),
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "Afthabu Rahman",
                     style: GoogleFonts.roboto(
                       color: Colors.black,
                       fontSize: w/22,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   SizedBox(height: 5,),
                   Text(
                     "25 October 2022, 10:30 AM",
                     style: TextStyle(
                       color: Color(0xff666161),
                       fontSize: w/26,
                     ),
                   )
                 ],
               )
             ],
          ),
          Text(
            "+2522.25",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Color(0xff149233),
              fontSize: w/22,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      )
    );
  }
}
