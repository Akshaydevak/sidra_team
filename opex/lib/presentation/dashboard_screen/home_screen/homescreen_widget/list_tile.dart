import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/drawer/drawer_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileWidget extends StatelessWidget {
  final String? svg,label;

  ListTileWidget({Key? key, this.svg,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Row(
      children: [
        SvgPicture.string(svg ?? DrawerSvg().profileIcon),
        const SizedBox(
          width: 16,
        ),
                  Text(
                  label??"",
                    style: GoogleFonts.roboto(
                      color: Color(0xff32322c),
                      fontSize: w/22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
      ],
    );
  }
}
