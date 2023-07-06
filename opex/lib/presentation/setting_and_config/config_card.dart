import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
class ConfigurationCard extends StatelessWidget {
  const ConfigurationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0x0ce30000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(
             "Consequat sunt nostrud amet.",
             style: TextStyle(
               color: Colors.black,
               fontSize: 16,
             ),
           ),
           Icon(Icons.arrow_forward_ios_sharp,color: ColorPalette.primary,)
         ],
      ),
    );
  }
}
