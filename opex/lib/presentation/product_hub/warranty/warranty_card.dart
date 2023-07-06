import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../seller_app/new_list_tab/textfield_tab.dart';

class WarrantyCard extends StatefulWidget {
  String? label;
  WarrantyCard({Key? key,this.label}) : super(key: key);

  @override
  State<WarrantyCard> createState() => _WarrantyCardState();
}

class _WarrantyCardState extends State<WarrantyCard> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label??"ADDITIONAL WARRANTY",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w / 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpand = !isExpand;
                    });
                  },
                  child: isExpand
                      ? Icon(
                          Icons.remove,
                          color: ColorPalette.primary,
                        )
                      : Icon(Icons.add))
            ],
          ),
          isExpand
              ? Column(
                  children: [
                    SizedBox(height: 10,),
                    TextFieldTab(
                      label: "Description",
                      hint: "Eg. SEM",
                    ),
                    SizedBox(height: 16,),
                    TextFormReusable(
                      hint: "Eg. Lorem ipsum dolar sit amet.",
                      label: "Duration"  ,
                    ),
                    SizedBox(height: 16,),
                    TextFieldTab(
                      label: "Maximum Occurrence",
                      hint: "Eg. SEM",
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
