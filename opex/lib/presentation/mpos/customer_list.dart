import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'customer_list_card.dart';

class CostomerList extends StatelessWidget {
  const CostomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Customer List",isAction: false,),

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
                SearchCard(),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total 20 Orders",
                      style: GoogleFonts.roboto(
                        color: Color(0xff151522),
                        fontSize: w/20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "New",
                      style: GoogleFonts.roboto(
                        color: Color(0xff151522),
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomerListCard(

                        );
                      },
                      separatorBuilder: (context, index) => Container(
                        height: 10,
                      ),
                      itemCount: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
