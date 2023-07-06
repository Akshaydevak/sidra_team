import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bussiness_card.dart';

class BussinessCart extends StatefulWidget {
  const BussinessCart({Key? key}) : super(key: key);

  @override
  State<BussinessCart> createState() => _BussinessCartState();
}

class _BussinessCartState extends State<BussinessCart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => BussinessCard(),
              separatorBuilder: (context, index) => Divider(
                    color: Color(0x33a9a8a8),
                thickness: 2,
                  ),
              itemCount: 10)
        ],
      ),
    );
  }

}
