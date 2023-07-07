import 'package:flutter/material.dart';

class OtherCard extends StatelessWidget {
  final TextEditingController? controller;
  List<String>? measure;
  final String ?hint;
  FocusNode ?focusNode;
  OtherCard({Key? key,this.controller,this.measure,this.hint,this.focusNode}) : super(key: key);
  String? selGender;


  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w / 2.25,
      height: 45,
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
              width: w / 3.8,
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                focusNode: focusNode,
                controller:controller ,
                keyboardType:TextInputType.number ,
                decoration: InputDecoration(border: InputBorder.none),
              )),
          Container(
            height: 60,
            width: 1,
            color: Color(0xffE6ECF0),
          ),
          Container(
            width: w / 6,
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //height: 20.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.transparent,

            ),
            child: DropdownButton(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                underline: Container(),
                items: measure?.map((String items) {
                  return DropdownMenuItem(
                    enabled: true,
                    value: items,
                    child: Text(items, style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
                value: selectedGender,
                onChanged: (dynamic value) {},
                hint: Text(
                  hint??"",
                  style: TextStyle(
                    color: Color(0xbf666161),
                    fontSize: 13,
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
