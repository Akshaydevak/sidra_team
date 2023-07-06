import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/title_app_bar.dart';
import '../../core/color_palatte.dart';
import 'continue_btn.dart';
import 'item_submit_screen.dart';
import 'new_list_tab/general_tab.dart';
import 'new_list_tab/other_tab.dart';
import 'new_list_tab/profiling_tab.dart';
import 'new_list_tab/segmant_flow_card.dart';
import 'new_list_tab/variations_tab.dart';

class AddNewList extends StatefulWidget {
  const AddNewList({Key? key}) : super(key: key);

  @override
  State<AddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<AddNewList>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int i = 0;
  bool isOther = false;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),

        child: BackAppBar (label: "Add new list"),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              // padding: EdgeInsets.only(left: 10, right: 10),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: w,
                      height: 5,
                      color: Color(0xfff8f7f5),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: TabBar(
                        isScrollable: false,
                        controller: _controller,
                        // onTap: (index){
                        // // _controller.index = _controller.previousIndex;
                        // print("object$index");},
                        // physics: const NeverScrollabledasdasScrollPhysics(),
                        labelColor: Colors.black,
                        indicatorColor: ColorPalette.primary,
                        indicatorWeight: 5,
                        unselectedLabelColor: Colors.black,
                        labelStyle: GoogleFonts.roboto(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: GoogleFonts.roboto(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                        tabs: [
                          Tab(
                            // text: "",

                            child: Text(
                              "General",
                              style: GoogleFonts.roboto(
                                color: _controller.index.toInt() > 0
                                    ? ColorPalette.primary
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Profiling",
                              style: GoogleFonts.roboto(
                                color: _controller.index.toInt() > 1
                                    ? ColorPalette.primary
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: _controller.index.toInt() < 1
                                    ? FontWeight.normal
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          Tab(
                              child: Text(
                            "Variations",
                            style: GoogleFonts.roboto(
                              color: _controller.index.toInt() > 2
                                  ? ColorPalette.primary
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: _controller.index.toInt() < 2
                                  ? FontWeight.normal
                                  : FontWeight.w600,
                            ),
                          )),
                          Tab(
                              child: Text(
                            "Others",
                            style: GoogleFonts.roboto(
                              color:
                                  isOther ? ColorPalette.primary : Colors.black,
                              fontSize: 16,
                              fontWeight: _controller.index.toInt() < 2
                                  ? FontWeight.normal
                                  : FontWeight.w600,
                            ),
                          )),
                        ]),
                  ),
                ],
              ),
            ),

            // SizedBox(height:
            //   14,),

            // const SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              SegmantFlowCard(),
                              SizedBox(
                                height: 10,
                              ),
                              GeneralTab(),
                              ContinueButton(
                                onTap: () {
                                  setState(() {
                                    _controller.index = 1;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              SegmantFlowCard(),
                              SizedBox(
                                height: 16,
                              ),
                              ProfilingTab(),
                              ContinueButton(
                                onTap: () {
                                  setState(() {
                                    _controller.index = 2;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              SegmantFlowCard(),
                              SizedBox(
                                height: 16,
                              ),
                              VariationsTab(),
                              ContinueButton(
                                onTap: () {
                                  setState(() {
                                    _controller.index = 3;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      isOther
                          ? SingleChildScrollView(
                              child: Container(
                                // color: Colors.grey,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                        // color: Colors.grey,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          children: [
                                            const SegmantFlowCard(),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            GeneralTab(),
                                            ProfilingTab(),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            VariationsTab(),
                                          ],
                                        )),


                                    OtherTab(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: ContinueButton(
                                        label: "Continue and Add",
                                        onTap: () {
                                          PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: ItemSubmitScreen(),
                                            withNavBar: false, // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation: PageTransitionAnimation.fade,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Container(
                                // padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: const SegmantFlowCard()),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    OtherTab(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: ContinueButton(
                                        label: "Save",
                                        onTap: () {
                                          setState(() {
                                            isOther = true;
                                            _controller.index = 3;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                            )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
