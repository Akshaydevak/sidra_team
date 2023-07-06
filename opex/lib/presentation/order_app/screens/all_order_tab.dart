import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/order_app/order_tabs/assignment_tab.dart';
import 'package:cluster/presentation/order_app/order_tabs/packing_tab.dart';
import 'package:cluster/presentation/order_app/order_tabs/picking_tab.dart';
import 'package:cluster/presentation/order_app/order_tabs/orders_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class AllOrderTab extends StatefulWidget {
  final int index;
  // bool isPicking
  const AllOrderTab({Key? key, this.index = 0}) : super(key: key);

  @override
  State<AllOrderTab> createState() => _AllOrderTabState();
}

class _AllOrderTabState extends State<AllOrderTab> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "All Orders",isAction: false,),
      ),
      body: DefaultTabController(
        initialIndex: widget.index,
        length: 4,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: w,
                  // padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                          TabBar(
                              physics: ScrollPhysics(),
                              labelColor: Colors.black,
                              indicatorColor: ColorPalette.primary,
                              indicatorWeight: 5,
                              unselectedLabelColor: Colors.black,
                              labelPadding: EdgeInsets.all(01),
                              labelStyle: GoogleFonts.roboto(
                                color: Color(0xff1b1b1f),
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelStyle: GoogleFonts.roboto(
                                color: Color(0xff1b1b1f),
                                fontSize: w / 24,
                              ),
                              tabs: [
                                Tab(text: "Order List"),
                                const Tab(text: "Picking"),
                                const Tab(text: "Packing"),
                                const Tab(text: "Assignment  "),
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          TabPage(),
                          PickingTab(
                            isPicking: true,
                          ),
                          PackingTab(isPicking: true, isPacking: true),
                          AssignmentTab(),
                        ]),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
