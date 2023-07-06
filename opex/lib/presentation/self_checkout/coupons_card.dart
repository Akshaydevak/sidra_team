import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouponsCard extends StatelessWidget {
  const CouponsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 187,
          // height: 58,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            color: Color(0xff0a0a0a),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                  radius: 25, backgroundColor: Color(0xffe3ce10)),
              SizedBox(
                width: 5,
              ),
              Text(
                "Geton 50",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Container(
          width: 187,
         padding: EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x3f000000),
                blurRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "25% Off",
                style: GoogleFonts.inter(
                  color: Color(0xff0a0a0a),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Valid until 02 jan 2022",
                style: GoogleFonts.inter(
                  color: Color(0x99151522),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
