import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common_widgets/title_app_bar.dart';
import '../mpos/search_card.dart';
import '../order_app/order_svg.dart';
import '../seller_app/seller_card.dart';

class VendorList extends StatelessWidget {
  const VendorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TitleAppBar(label: "Vendors"),
      ),
      body: ScrollConfiguration(behavior: NoGlow(),
      child: SingleChildScrollView(
        child: Container(padding: EdgeInsets.all(16),child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: w / 1.35, child:  SearchCard()),
                GestureDetector(
                  onTap: () {
                    // _showModalBottomSheet();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffe6ecf0),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 8,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: SvgPicture.string(OrderSvg().moreIcon),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListView.separated(
              primary: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(
                height: 5,
              ),
              itemBuilder: (context, index) => SellerCard(),
            )
          ],
        ),),
      ),),
    );
  }
}
