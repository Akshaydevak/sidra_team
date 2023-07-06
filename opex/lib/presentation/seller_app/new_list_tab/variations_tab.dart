import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../seller_svg.dart';

class VariationsTab extends StatelessWidget {
   VariationsTab({Key? key}) : super(key: key);
  String? selGender;
  List<String> gender = ["Male", "Female", "Other"];

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Variation Item",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SvgPicture.string(SellerSvg().validationIcon)
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: w ,
          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //height: 20.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
            boxShadow: [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 8,
                offset: Offset(1, 1),
              ),
            ],
            color: Colors.white,
          ),
          child: DropdownButton(
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down_outlined),
              underline: Container(),
              items: gender.map((String items) {
                return DropdownMenuItem(
                  enabled: true,
                  value: items,
                  child: Text(items, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              value: selectedGender,
              onChanged: (dynamic value) {},
              hint: Text(
                "-  Select  -",
                style: TextStyle(
                  color: Color(0xbf666161),
                  fontSize: w/22,
                ),
              )),
        ),
        SizedBox(height: 10,),

        Text(
          "Please choose variation items",
          style: TextStyle(
            color: Color(0xff666161),
            fontSize: w/24,
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "Package Size",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w/22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
