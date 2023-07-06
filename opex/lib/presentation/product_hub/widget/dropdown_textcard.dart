import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownTextCard extends StatelessWidget {
  String ?label;
  DropDownTextCard({Key? key,this.label}) : super(key: key);
  String? selGender;
  List<String> gender = ["Report", "Today’s", "Report"];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: w/5.5,
          child: Text(
            label??"Shelf Life",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: w / 1.45,
          height: 60,
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
          child: Row(
            children: [
              Container(
                width: w / 3,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    underline: Container(),
                    items: gender.map((String items) {
                      return DropdownMenuItem(
                        enabled: true,
                        value: items,
                        child:
                            Text(items, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    value: selectedGender,
                    onChanged: (dynamic value) {},
                    hint: Text(
                      "Select type",
                      style: TextStyle(
                        color: Color(0x7f666161),
                        fontSize: w / 24,
                      ),
                    )),
              ),
              Container(
                height: 60,
                width: 1,
                color: ColorPalette.divider,
              ),
              Container(
                width: w / 3,
                padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter value",
                    helperStyle: TextStyle(
                      color: Color(0x7f666161),
                      fontSize: w/25,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE6ECF0)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE6ECF0)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE6ECF0)),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
