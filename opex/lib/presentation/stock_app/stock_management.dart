import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/stock_app/stock_card_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'out_stock_card.dart';

class StockManagement extends StatelessWidget {
  const StockManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Stock Manage"),
      ),
      body: ScrollConfiguration(behavior: NoGlow(),
      child: SingleChildScrollView(
        child: Container(padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchCard(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total 105 Products",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w/22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 147,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xff8ca6b6), width: 1, ),
                    color: Color(0xffeef3f6),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(height: 10,),
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: StockCardView(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                    child: OutStockCard(isStock:true)),
                separatorBuilder: (context, index) => SizedBox(height: 10,),
                itemCount: 6)
          ],
        ),),
      ),),
    );
  }
}
