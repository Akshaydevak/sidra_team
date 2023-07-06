import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationsCard extends StatelessWidget {
  String ? label;
   ApplicationsCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var w= MediaQuery.of(context).size.width;
    return Container(
      width: w/2.3,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffe6e6f2),
      ),
      child: Row(
         children: [
           Container(
             width: 42,
             height: 42,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(6),
               color: Colors.white,
             ),
           ),
           SizedBox(width: 5,),
           Text(
             label??"",
             style: GoogleFonts.roboto(
               color: Colors.black,
               fontSize: w/25,

               fontWeight: FontWeight.w500,
             ),
           )
         ],
      ),
    );
  }
}
