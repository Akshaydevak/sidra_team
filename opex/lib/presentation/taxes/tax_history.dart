import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/taxes/widgets/tax_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import '../order_app/order_svg.dart';

class TaxHistory extends StatelessWidget {
  const TaxHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Tax History",
          isAction: false,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
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
                SizedBox(height: 16,),
                Text(
                  "Total 120 Transactions",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                ListView.separated(
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) => TaxCard(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
