import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common_widgets/no_glow.dart';
import '../../core/color_palatte.dart';
import '../mpos/product_card.dart';
import '../mpos/search_card.dart';
import 'widget/Inventory_product_card.dart';
import 'inventory_svg.dart';

class SearchOrderView extends StatelessWidget {
  const SearchOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ScrollConfiguration(
              behavior: NoGlow(),
              child: SingleChildScrollView(
                  child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: w / 1.35,
                                child: SearchCard(
                                  hint: "Search an order ...",
                                )),
                            GestureDetector(
                              onTap: () {
                                // _showModalBottomSheet();
                              },
                              child: Container(
                                padding: EdgeInsets.all(13),
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
                                child: SvgPicture.string(
                                  InventorySvg().scannerIcon,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffeef3f6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Could not see in this list ?",
                                    style: TextStyle(
                                        fontSize: w / 24, color: Colors.black),
                                  ),
                                  Text(
                                    " Create new list",
                                    style: TextStyle(
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w600,
                                        color: ColorPalette.primary),
                                  )
                                ],
                              ),
                            ),
                            // ListView.separated(
                            //     physics: NeverScrollableScrollPhysics(),
                            //     padding: EdgeInsets.only(top: 20),
                            //     shrinkWrap: true,
                            //     itemBuilder: (context, index) => InventoryProductCard(),
                            //     separatorBuilder: (context, index) => SizedBox(
                            //           height: 10,
                            //         ),
                            //     itemCount: 5)
                          ],
                        ),
                      )
                    ]),
              )))),
    );
  }
}
