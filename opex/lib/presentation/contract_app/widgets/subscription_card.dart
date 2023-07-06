import 'package:flutter/material.dart';
class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  Column(
      children: [
        Container(
          width: w,
          height: 124,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            color: Color(0xff3f63c4),
          ),
        ),
        Container(
          width: w,
          height: 324,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
