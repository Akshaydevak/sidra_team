import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/custom_radio_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'callcenter_search.dart';
import 'history_details.dart';
import 'widgets/call_center_order.dart';

class CallCenterHistory extends StatefulWidget {
  const CallCenterHistory({Key? key}) : super(key: key);

  @override
  State<CallCenterHistory> createState() => _CallCenterHistoryState();
}

class _CallCenterHistoryState extends State<CallCenterHistory> {
  int ?selected;
  List<String> productTypeList = [
    'All products',
    'Recently Added',
    'Most Selling',
    'Offer Applied'
  ];

  void onSelect(int val) {
    selected = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Order History",
          isAction: true,
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
                GestureDetector(
                  onTap: (){
                    // PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: CallCenterSearch(),
                    //   withNavBar: true,
                    //   // OPTIONAL VALUE. True by default.
                    //   pageTransitionAnimation:
                    //   PageTransitionAnimation.fade,
                    // );
                  //  CallCenterSearch
                  },
                    child: SearchCard()),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "20 Results",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: w/20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showModalBottomSheet();
                      },
                      child: Text(
                        "Filter",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.primary,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: HistoryDetailsScreen(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );   

                    },
                      child: CallCenterOrder()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 350,

                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                       padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Apply",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffe5762),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 1.5,
                      color: Color(0xffE6ECF0),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              CustomRadioButton(
                                onTap: () {
                                  onSelect(index);
                                  setState(() {});
                                },
                                isActive: selected == index,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                productTypeList[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Container(
                              height: 10,
                            ),
                        itemCount: productTypeList.length),

                  ],
                ));

            },
          );
        });
  }
}
