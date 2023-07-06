import 'package:cluster/presentation/purchase_app/purchase_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PdfCard extends StatelessWidget {
  const PdfCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xfffdf2f2),
          width: 1.50,
        ),
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
              SvgPicture.string(PurchaseSvg().pdfIcon),
              SizedBox(width: 10,),
              Text(
                "Newfile.pdf",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/24,

                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SvgPicture.string(PurchaseSvg().pdfdownloadIcon),
        ],
      ),
    );
  }
}
