import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/promotion_app/discount_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/mpos_svg.dart';
import '../mpos/search_card.dart';
import '../product_hub/product_hub_card.dart';
import 'discount_card.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Discount"),
      ),
      body: ScrollConfiguration(behavior: NoGlow(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width:w/1.35,child: SearchCard()),
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
                    child: SvgPicture.string(MposSvg().filterIcon,color: ColorPalette.subtextGrey,),
                  ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "20 Results",
                    style: TextStyle(
                      color: Color(0xff151522),
                      fontSize: 18,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                      "+ Add New",
                      style: TextStyle(
                        color: Color(0xfffe5762),
                        fontSize: 16,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),

                  )
                ],
              ),
              SizedBox(height: 10,),
              ListView.separated(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>GestureDetector(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: DiscountView(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                      child: DiscountCard()) , separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: 5)
            ],
          ),
        ),
      ),),
    );
  }
}
