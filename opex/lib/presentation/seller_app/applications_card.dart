import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationsCard extends StatelessWidget {
  String ? label;
   ApplicationsCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(
      width: w1/2.2,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffe6e6f2),
      ),
      child: Row(
         children: [
           // Container(
           //   width: 35,
           //   height: 35,
           //   decoration: BoxDecoration(
           //     borderRadius: BorderRadius.circular(6),
           //     color: Colors.white,
           //   ),
           //   child: SvgPicture.string(HomeSvg().appIconSeller,height: 20,width: 20,)
           // ),
           SizedBox(width: 5,),
           Text(
             label??"",
             style: GoogleFonts.roboto(
               color: Colors.black,
               fontSize: w/26,

               fontWeight: FontWeight.w500,
             ),
           )
         ],
      ),
    );
  }
}
