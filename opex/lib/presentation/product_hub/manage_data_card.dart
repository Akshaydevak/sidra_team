import 'package:flutter/material.dart';
class ManageDataCard extends StatelessWidget {
  Widget ?child;
  EdgeInsets ? padding;
   ManageDataCard({Key? key,this.child,this.padding=const EdgeInsets.all(16)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding:padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffe0e3e5), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
        color: Color(0xfff7f7f7),
      ),
      child: child,
    );
  }
}
