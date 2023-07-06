import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common_widgets/no_glow.dart';
import '../home_svg.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.yellow,
        height: h / 7,
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 16, left: 12, bottom: 0),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0x0ce30000),
                    ),
                  alignment: Alignment.center,
                  child:
                    SvgPicture.string(HomeSvg().categoryIcon)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Invoice",
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: w/24,
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 10,
              );
            },
          ),
        ));

  }
}
