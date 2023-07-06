import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/reusable_textfield.dart';
import '../contract_svg.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int? selectedGender;

  List<int> gender = [1, 2, 3];

  int index = 1;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.string(ContractSvg().contractSecondIcon),
          SizedBox(
            height: 10,
          ),
          TextFormReusable(
            label: "Workflow Name",
            hint: "eg.HR Management",
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Number of Levels ",
            style: GoogleFonts.roboto(
              color: ColorPalette.black,
              fontSize: w / 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: w / 3,
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //height: 20.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xffe6ecf0),
                width: 1,
              ),
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
                icon: Icon(Icons.keyboard_arrow_down),
                underline: Container(),
                items: gender.map((int items) {
                  return DropdownMenuItem(
                    enabled: true,
                    value: items,
                    child: Text(items.toString(),
                        style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
                value: selectedGender,
                onChanged: (dynamic value) {
                  setState(() {
                    index = value;
                  });

                  print("..........." + value.toString());
                },
                hint: Text(
                  "1",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),
                )
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Level 1",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: w,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0x4ca9a8a8),
                            width: 1,
                          ),
                          color: Color(0xfff8f7f5),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorPalette.inactiveGrey,
                              radius: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Afthaburahman111@gmail.com",
                              style: TextStyle(
                                color: ColorPalette.black,
                                fontSize: w / 22,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: w,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0x4ca9a8a8),
                            width: 1,
                          ),
                          color: Color(0xfff8f7f5),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorPalette.primary,
                              radius: 15,
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w / 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add Another Person",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: index),
        ],
      ),
    );
  }
}
