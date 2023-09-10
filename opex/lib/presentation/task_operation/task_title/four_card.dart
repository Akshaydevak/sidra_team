import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FourCard extends StatelessWidget {
  String ?label,svg;
  FourCard({Key? key,this.label,this.svg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Column(
      children: [
        Container(
          width: w1/6,
          height: 60,
          padding: EdgeInsets.all(20),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey,width: 0.1),
            color: Color(0x0ffFFFFFF),
          ),
          child: SvgPicture.string(svg??TaskSvg().deleteBox),
        ),
        SizedBox(height: 5,),
        Text(
          label??"Employees",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorPalette.black,
            fontSize: w/30,

          ),
        )
      ],
    );
  }
}
