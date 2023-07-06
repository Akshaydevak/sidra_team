import 'package:cluster/presentation/purchase_app/purchase_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

class OrderCard extends StatelessWidget {
  String ?label,icon;
  VoidCallback ?onTap;
   OrderCard({Key? key,this.label,this.icon,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        // height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xfffdf2f2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.string(
                 icon?? PurchaseSvg().orderIcon,
                  color: ColorPalette.primary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label??"Purchase Orders",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w / 20,
                  ),
                ),
              ],
            ),
            SvgPicture.string(TaskSvg().arrowIcon)
          ],
        ),
      ),
    );
  }
}
