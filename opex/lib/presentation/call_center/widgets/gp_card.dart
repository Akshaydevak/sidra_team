import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../task_operation/task_svg.dart';
class GpCard extends StatelessWidget {
  const GpCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w,
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: 10, left: 16),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            // onTap: onTapListTile(i, context),
              child: Container(
                width: w/4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x05000000),
                      blurRadius: 8,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.string(TaskSvg().quickaccessIcon),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "32,200",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Quarterly GP",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: w/28,
                      ),
                    )
                  ],
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 5,
          );
        },
      ),
    );
  }
}