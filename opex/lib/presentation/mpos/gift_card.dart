import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GiftCard extends StatelessWidget {
  final bool isSelect;
  const GiftCard({Key? key,this.isSelect=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/4.65,
      height: 75,
      decoration:isSelect? BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xfffe5762), width: 1, ),
        color: Color(0x0cfe5762),
      ): BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
    );
  }
}
