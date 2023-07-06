import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCard extends StatefulWidget {
  const HelpCard({Key? key}) : super(key: key);

  @override
  State<HelpCard> createState() => _HelpCardState();
}

class _HelpCardState extends State<HelpCard> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        padding: EdgeInsets.only(left: 10, right: 10),
        color: isSelect ? Color(0xfffff6f7) : Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(right: 0),
            childrenPadding: EdgeInsets.only(bottom: 10),
            onExpansionChanged: (bool isExpand) {
              setState(() {
                isSelect = isExpand;
              });
              print(".............$isExpand");
            },
            // collapsedIconColor: ColorPalette.primary,
             iconColor: ColorPalette.primary,
            expandedAlignment: Alignment.topLeft,
            title: Text(
              "Neww",
              style: isSelect
                  ? GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )
                  : TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
            ),
            children: [
              Text(
                "ewasrtdyugoijpk[",
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal, height: 1.5),
                textAlign: TextAlign.justify,
              ),

              // SizedBox()
            ],
          ),
        ));
  }
}
