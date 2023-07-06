import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CreateCard extends StatelessWidget {
  String? label;
  Color ?color;
   CreateCard({Key? key,this.label,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
     padding: EdgeInsets.all(6),
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
          Row(
            children: [
              Container(
                width: 5,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color:color?? Color(0xff33c658),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color??Color(0xff33c658),
                ),
              ),
              SizedBox(width: 10,),
              Text(
               label?? "Sent Message",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/22,

                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Icon(Icons.arrow_forward_ios_sharp)
        ],
      ),
    );
  }
}
