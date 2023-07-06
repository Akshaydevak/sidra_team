import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
class OutStockCard extends StatelessWidget {
  bool isStock;
   OutStockCard({Key? key,this.isStock=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(16),
      width: w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(10), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(10), ),
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
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xfff0f1f2),
            ),
          ),
          SizedBox(width: 16,),
          Container(
            width: w/1.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing ealiquam ...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w/24,
                    ),

                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      isStock?"Quantity:": "Status:",
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorPalette.subtextGrey
                      ),
                    ), Text(
                      isStock?"105":" Out of stock",
                      style: TextStyle(
                        fontSize: 14,
                     color: ColorPalette.black,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
