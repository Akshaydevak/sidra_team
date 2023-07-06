import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/taxes/tax_quick.dart';
import 'package:cluster/presentation/taxes/widgets/tax_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/home_card.dart';
import '../task_operation/task_svg.dart';

class TaxHome extends StatelessWidget {
  const TaxHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Tax"),
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
                Container(
                  width: w,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfffae2e2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "12,05,254",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "This month income",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w/24,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "20,052",
                      sub: "TAX Payable",
                    ),
                    HomeCard(
                      head: '3,64,542',
                      sub: "Tax due",
                    )
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    //  ContractList
                  },
                  child: Container(
                    width: w,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    // height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffdf2f2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TAX Configuration",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w / 20,
                          ),
                        ),
                        SvgPicture.string(TaskSvg().arrowIcon)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Quick access to :",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                  TaxQuick(),
                SizedBox(
                  height: 26,
                ),
                Text(
                  "Recent Transactions",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ) ,
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
                  itemBuilder: (context, index) => TaxCard(),
                ),
                BottomCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
