import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/promotion_app/select_product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';

class SelectProducts extends StatelessWidget {
  bool isSelectAll = false;

  SelectProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Select Product"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 10),
                    child: SearchCard()),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Row(
                    children: [
                      isSelectAll
                          ? Container(
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.string(
                                  OrderSvg().checkBoxActiveIcon),
                            )
                          : SvgPicture.string(OrderSvg().checkBoxIcon),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select All",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => SelectProductCard(),
                    separatorBuilder: (context, index) => Container(
                      width: w,
                      height: 1,
                      color: ColorPalette.divider,
                    ),
                    itemCount: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
