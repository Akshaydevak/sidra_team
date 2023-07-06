import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealsCard extends StatelessWidget {
  const DealsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/3.5,
      height: 127,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
        color: Colors.white,
      ),
      child: Image.asset("asset/img_13.png"),
    );
  }
}
