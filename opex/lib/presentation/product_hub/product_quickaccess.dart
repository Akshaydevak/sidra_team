import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../task_operation/task_svg.dart';
class ProductQuickAccess extends StatelessWidget {
   ProductQuickAccess({Key? key}) : super(key: key);
  List<String> quickData=['Add Item','Add Variant','View All Prdoduct','Assigning','Plans','Variant Verification','Categories','Settings'];

  @override
  Widget build(BuildContext context) {
    return Container(

        width: MediaQuery
            .of(context)
            .size
            .width,
        child: GridView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 8),
            itemBuilder: (context, i) {
              return GestureDetector(
                // onTap: isAdmin ? onTapListTileAdmin(i, context) : onTapListTile(
                //     i, context),
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  width: 88,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x0ce30000),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.string(TaskSvg().quickaccessIcon),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        quickData[i],
                        style: TextStyle(
                          color: Color(0xff121113),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
