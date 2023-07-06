import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common_widgets/no_glow.dart';
import '../dashboard_screen/cart_screen/cart_svg.dart';

class AddNewItem extends StatelessWidget {
  const AddNewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back,color:Colors.black ,),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: w-85,
                      height: 50,
                      padding: EdgeInsets.only(left: 16,right: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(0), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(0), ),

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
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          suffixIcon:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [ SvgPicture.string(PromotionSvg().closeIcon),],
                          ),

                          border: InputBorder.none
                        ),
                      )
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(8), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(8), ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Color(0xfffd5762),
                      ),
                      alignment: Alignment.center,
                      child:  SvgPicture.string(CartSvg().searchIcon),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  width: w,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Color(0xfff6f6f6),
                  ),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Apple car Amet minim mollit non deserunt ulla\nmconlorem ipsum dolkar sit",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: 5),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
