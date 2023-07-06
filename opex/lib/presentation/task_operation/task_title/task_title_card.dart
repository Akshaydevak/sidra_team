import 'package:flutter/cupertino.dart';

class TaskTitleCard extends StatelessWidget {
  Widget ?widget;
  EdgeInsets ?paddingg;
   TaskTitleCard({Key? key,this.widget,this.paddingg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
   padding:paddingg,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
        color: Color(0xfff8f7f5),
      ),
      child: widget,
    );
  }
}
