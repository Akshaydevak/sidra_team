import 'package:flutter/material.dart';
class ResponseCard extends StatelessWidget {
  String ?label;
   ResponseCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
     padding: EdgeInsets.all(16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label??"Business Messages",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Icon(Icons.arrow_forward_ios_sharp,color: Color(0xff7d7d7d),)
        ],
      ),
    );
  }
}
