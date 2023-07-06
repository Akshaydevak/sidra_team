import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ImportantDatesCard extends StatelessWidget {
  const ImportantDatesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xffe3e6e7), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0a000000),
            blurRadius: 117,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tax Name",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "If you not ind the taxable country in the table, Just search and add to the table.",
            style: TextStyle(
              color: Color(0xff666161),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "12 Jan 2023",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
