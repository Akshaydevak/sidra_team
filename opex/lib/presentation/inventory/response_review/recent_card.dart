import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class RecentCard extends StatelessWidget {
  const RecentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          CircleAvatar(
            radius: 20,
          ),
          SizedBox(width: 10,),
          Container(
            width: w/1.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Afthabu Rahman",
                      style: GoogleFonts.roboto(
                        color: Color(0xff151522),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "9:04 AM",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Text(
                    "Amet minim mollit non deserunt ullamcoest sit aliqua dolor do amet sint. ",
                    style: TextStyle(
                      color: Color(0xff151522),
                      fontSize: 15,
                    ),
                  ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
