import 'package:flutter/material.dart';
class ReadOnlyCard extends StatelessWidget {
  final String? label;
  const ReadOnlyCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${label}",
            style:TextStyle(color: Colors.black, fontSize: w/26)
          ),
          // Icon(Icons.keyboard_arrow_down_outlined,
          //     color: Color(0x7f666161))
        ],
      ),
    );
  }
}
