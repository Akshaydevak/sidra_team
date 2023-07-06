import 'package:cluster/presentation/taxes/state_tax.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'category_tax.dart';

class CountryDetailScreen extends StatelessWidget {
  const CountryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "India",
          isAction: false,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: w,
                    height: 5,
                    color: Color(0xfff8f7f5),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  // padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          labelColor: Colors.black,
                          indicatorColor: ColorPalette.primary,
                          indicatorWeight: 5,
                          unselectedLabelColor: Colors.black,
                          labelStyle: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          tabs: const [
                            Tab(text: "State wise Tax"),
                            Tab(text: "Category wise Tax"),

                          ]),
                    ],
                  ),
                ),

              ],
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [

                      StateTax(),
                      CategoryTax(),

                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
