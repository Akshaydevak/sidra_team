import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

class QuickAccesscard extends StatelessWidget {
  String? label;
   QuickAccesscard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w / 2.24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0x0ce30000),
      ),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(TaskSvg().quickaccessIcon),
          // Container(
          //   width: 36,
          //   height: 36,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Color(0xfffd5762),
          //   ),
          // ),
          SizedBox(height: 10,),
          Text(
            label??"Promotion Sale",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: const Color(0xff121113),
              fontSize: w/26,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
