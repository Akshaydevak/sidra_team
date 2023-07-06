import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';

class BrandsCard extends StatelessWidget {
  const BrandsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Container(
        height: h / 6.5,
      // color: Colors.yellow,
      alignment: Alignment.topLeft,
      child:ScrollConfiguration(
        behavior: NoGlow(),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 16, left: 12, bottom: 5),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            clipBehavior: Clip.antiAlias,
            itemCount: 10,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Image.asset("asset/img_4.png", height: h / 9)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Invoice",
                    style: TextStyle(
                      color: Color(0xff121113),
                      fontSize: 16,
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
        ),


        );
  }

}
