import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
class ViewSubCard extends StatelessWidget {
  String? label;
  VoidCallback? onTap;
   ViewSubCard({Key? key,this.label,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return  GestureDetector(onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        width: w,
        // height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xfffdf2f2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label??"Basic Details",
              style: TextStyle(
                color:ColorPalette.black,
                fontSize: w/22,
              ),
            ),
            Icon(Icons.arrow_forward_ios_sharp)
          ],
        ),
      ),
    )
    ;
  }
}
