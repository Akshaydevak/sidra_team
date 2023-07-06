import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../dashboard_screen/home_screen/home_svg.dart';
class ToggleCard extends StatefulWidget {
  String ?label;
   ToggleCard({Key? key,this.label}) : super(key: key);

  @override
  State<ToggleCard> createState() => _ToggleCardState();
}

class _ToggleCardState extends State<ToggleCard> {
  bool isSelect=false;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label??"Enable/Disable Loaylity Points",
            style: TextStyle(
              color: Colors.black,
              fontSize: w/22,
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                isSelect=!isSelect;
              });
            },
            child: SvgPicture.string(
                isSelect?HomeSvg().toggleActive:HomeSvg().toggleInActive),
          ),
        ],
      ),
    );
  }
}
