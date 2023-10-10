import 'package:flutter/cupertino.dart';

class TaskTitleCard extends StatelessWidget {
  Widget ?widget;
  EdgeInsets ?paddingg;
   TaskTitleCard({Key? key,this.widget,this.paddingg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(
      width: w1,
   padding:paddingg,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
        color: Color(0xfff8f7f5),
      ),
      child: widget,
    );
  }
}
