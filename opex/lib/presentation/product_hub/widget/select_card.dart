import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/home_svg.dart';
class SelectCard extends StatefulWidget {
String ?label;
   SelectCard({Key? key,this.label}) : super(key: key);

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  bool isActive=false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/2.25,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33fe5762), width: 1, ),
        color: Color(0x0cfe5762),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label??"Sales Block",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w/27,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                isActive=!isActive;
              });
            },
            child: isActive
                ? SvgPicture.string(HomeSvg().toggleActive)
                : SvgPicture.string(HomeSvg().toggleInActive),
          )
        ],
      ),
    );
  }
}
