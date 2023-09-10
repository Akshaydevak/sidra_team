import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  String? head,sub;
  Color ?color;
  Color ?colorContainer;
  HomeCard({Key? key,this.head,this.sub,this.color=Colors.black,this.colorContainer=Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(
      padding: EdgeInsets.all(10),
      width: w1>700?w1/2.1:w1/3.4,
      // height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: colorContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head??"",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w/12,

              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            sub??"",
            style: TextStyle(
              color: color,
              fontSize: w/25,
            ),
          )
        ],
      ),
    );
  }
}
