import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/inventory/search_order_view.dart';
import 'package:cluster/presentation/self_checkout/self_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../mpos/mpos_svg.dart';
import '../mpos/search_card.dart';
import 'inventory_svg.dart';

class InventorySearchScreen extends StatelessWidget {
  const InventorySearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return SafeArea(child:
      Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlow(
        ),
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start ,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width:w/1.35,child: SearchCard(hint: "Search an order ...",)),
                      GestureDetector(
                        onTap: (){
                          // _showModalBottomSheet();

                        },child: Container(
                        padding: EdgeInsets.all(13),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                        child:  SvgPicture.string(InventorySvg().scannerIcon,color: Colors.black,),
                      ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: ColorPalette.divider,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: SearchOrderView(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );

                      },
                      child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consect etur",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w/22,
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(color: ColorPalette.divider),
                    itemCount: 5)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
