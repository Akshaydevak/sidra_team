import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class QuantityCard extends StatelessWidget {
 final String label,count;
  const QuantityCard({Key? key,this.label="",this.count=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  Container(
      width: w/2.25,
      // height: 70,
      padding: EdgeInsets.all(10),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label??"Cancelled Qty:",
            style: TextStyle(
              color: Colors.black,
              fontSize: w/25,
            ),
          ),
          Container(    width: w/2.3,alignment: Alignment.bottomRight,
            child: Text(
              count??"105",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w/22,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
