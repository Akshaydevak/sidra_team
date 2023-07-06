import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ApplyFiltercard extends StatelessWidget {
  const ApplyFiltercard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.width;
    return SizedBox(
      height: h / 8,
      child: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return Container(
            width: 124,
            height: 34,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color:Color(0x0ce30000),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lorem ipsum",
                  style: GoogleFonts.poppins(
                    color: Color(0xff1b1b1f),
                    fontSize: 12,

                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.close)
              ],
            ),
          );
        }),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 6,
          );
        },
      ),
    );
  }
}
