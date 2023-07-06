import 'package:flutter/material.dart';

class OtherCard extends StatelessWidget {
  OtherCard({Key? key}) : super(key: key);
  String? selGender;
  List<String> gender = ["Male", "Female", "Other"];

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w / 2.25,
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
              width: w / 3.5,
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                decoration: InputDecoration(border: InputBorder.none),
              )),
          Container(
            height: 60,
            width: 1,
            color: Color(0xffE6ECF0),
          ),
          Container(
            width: w / 7,
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //height: 20.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
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
                  "kg",
                  style: TextStyle(
                    color: Color(0xbf666161),
                    fontSize: 13,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
