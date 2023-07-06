import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwoCard extends StatelessWidget {
  String ?label;
   TwoCard({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/1.1,
      padding: EdgeInsets.all(12),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0x0ce30000),
      ),
      child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xfffd5762),
              child: Text(
                "+",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfffcfcfc),
                  fontSize: 29,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              label??"Create New Group",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff121113),
                fontSize: 13,
              ),
            )
          ],
      ),
    );
  }
}
