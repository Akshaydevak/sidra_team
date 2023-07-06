import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../presentation/order_app/order_svg.dart';

class checkBox extends StatefulWidget {
  String? label;

  checkBox({Key? key, this.label}) : super(key: key);

  @override
  State<checkBox> createState() => _checkBoxState();
}

class _checkBoxState extends State<checkBox> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isActive = !isActive;
            });
          },
          child: isActive
              ? Container(
                  padding: EdgeInsets.only(left: 8,bottom: 10,top: 5,right: 8),
                  child: SvgPicture.string(OrderSvg().checkBoxActiveIcon),
                )
              : SvgPicture.string(
                  OrderSvg().checkBoxIcon,
                  height: 35,
                  width: 35,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.label ?? "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
