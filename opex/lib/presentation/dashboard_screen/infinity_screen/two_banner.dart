import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoBanner extends StatelessWidget {
  const TwoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: w/2.25,

              color: Color(0xfff8f7f5),
              child: Column(
                children: [
                  Image.asset("asset/img_12.png"),
                  SizedBox(height: 8,),
                  Text(
                    "Min 50% Off",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff1c1c1c),
                      fontSize: 18,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "On Mensware",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff7c7c7c),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ),
            Container(
              width: w/2.25,

              color: Color(0xfff8f7f5),
              child: Column(
                children: [
                  Image.asset("asset/img_12.png"),
                  SizedBox(height: 8,),
                  Text(
                    "Min 50% Off",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff1c1c1c),
                      fontSize: 18,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "On Mensware",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff7c7c7c),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: w/2.25,

              color: Color(0xfff8f7f5),
              child: Column(
                children: [
                  Image.asset("asset/img_12.png"),
                  SizedBox(height: 8,),
                  Text(
                    "Min 50% Off",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff1c1c1c),
                      fontSize: 18,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "On Mensware",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff7c7c7c),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ),
            Container(
              width: w/2.25,

              color: Color(0xfff8f7f5),
              child: Column(
                children: [
                  Image.asset("asset/img_12.png"),
                  SizedBox(height: 8,),
                  Text(
                    "Min 50% Off",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff1c1c1c),
                      fontSize: 18,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "On Mensware",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff7c7c7c),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
