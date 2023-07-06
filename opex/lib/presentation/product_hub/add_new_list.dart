import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/seller_app/new_list_tab/profiling_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/title_app_bar.dart';
import '../seller_app/continue_btn.dart';
import '../seller_app/new_list_tab/general_tab.dart';
import '../seller_app/new_list_tab/other_tab.dart';

import 'new_list/general_screen.dart';
import 'new_list/profiling_screen.dart';
import 'new_list/success_screen.dart';
import 'new_list/varient_screen.dart';


class AddNewList extends StatefulWidget {
  const AddNewList({Key? key}) : super(key: key);

  @override
  State<AddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<AddNewList>  with SingleTickerProviderStateMixin{
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
        child:  BackAppBar(
          label: "Add new list", isAction: false,

          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
        // TitleAppBar(label: "Add new list",),
      ),
      body: DefaultTabController(
        length: 2,
        child: ScrollConfiguration(
          behavior: NoGlow(),
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
                          // physics: const NeverScrollableScrollPhysics(),
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


                                GeneralScreen(),
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
                                const ProfilingScreen(),
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
                                VarientScreen(),
                                ContinueButton(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen:  SuccessScreen(),
                                      withNavBar: true, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.fade,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),






                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}