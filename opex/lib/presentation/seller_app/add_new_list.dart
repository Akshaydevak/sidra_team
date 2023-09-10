import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final String? division, category, subCategory, group, item, uom;
  final int? uomId, itemId;

  const AddNewList(
      {Key? key,
      this.division,
      this.category,
      this.subCategory,
      this.group,
      this.item,
      this.uom,
      this.uomId,
      this.itemId})
      : super(key: key);

  @override
  State<AddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<AddNewList>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int i = 0;
  bool isOther = false;
  TextEditingController varientNameController = TextEditingController();
  TextEditingController searchNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController oldSystemController = TextEditingController();
  TextEditingController identificationController = TextEditingController();

  void onChangeBaseUom(String? val) {
    print("selected base $val");
    base = val ?? "";
    setState(() {});
  }

  void onChangeSalesUom(String? val) {
    print("selected sales $val");
    sales = val ?? "";
    setState(() {});
  }

  void onChangeChannel(String? val) {
    print("selected Channel $val");
    channel = val ?? "";
    setState(() {});
  }

  String? base;
  String? sales;
  String? channel;

  @override
  void initState() {
    print("inside tab screen${widget.itemId}");
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
        child: BackAppBar(
          label: "Add new list",
        ),
      ),
      body: DefaultTabController(
        length: 4,
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
                        labelColor: Colors.black,
                        indicatorColor: ColorPalette.primary,
                        indicatorWeight: 5,
                        unselectedLabelColor: Colors.black,
                        labelPadding: EdgeInsets.only(left: 0),
                        labelStyle: GoogleFonts.roboto(
                          color: Colors.green,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: GoogleFonts.roboto(
                          color: Colors.green,
                          fontSize: w / 26,
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
                                fontSize: w / 24,
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
                                fontSize: w / 24,
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
                              fontSize: w / 24,
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
                              fontSize: w / 24,
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
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ScrollConfiguration(
                        behavior: NoGlow(),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                SegmantFlowCard(
                                  division: widget.division,
                                  category: widget.category,
                                  subCategory: widget.subCategory,
                                  group: widget.group,
                                  item: widget.item,
                                  uom: widget.uom,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GeneralTab(
                                  id: widget.uomId,
                                  varientName: varientNameController,
                                  displayName: displayNameController,
                                  searchName: searchNameController,
                                  description: descriptionController,
                                  oldSystemCode: oldSystemController,
                                  identification: identificationController,
                                  onChangeBaseUom: onChangeBaseUom,
                                  onChangeSalesUom: onChangeSalesUom,
                                  onChangeChannel: onChangeChannel,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ContinueButton(
                                  onTap: () {
                                    print("base$base\n$channel\n$sales.............");
                                    // varientNameController.text != '' &&
                                    //         displayNameController.text != '' &&
                                    //         searchNameController.text != '' &&
                                    //         descriptionController.text != '' &&
                                    //         oldSystemController.text != '' &&
                                    //         identificationController.text !=
                                    //             '' &&
                                    //         base != '' &&
                                    //         base != null &&
                                    //         sales != '' &&
                                    //         sales != null&&
                                    //         channel != '' &&
                                    //     channel != null
                                    //     ?
                                    setState(() {
                                            _controller.index = 1;
                                          });
                                        // : Fluttertoast.showToast(
                                        //     msg: 'Please fill all fields',
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.BOTTOM,
                                        //     backgroundColor: Colors.black,
                                        //     textColor: Colors.white);

                                    print(
                                        "inside continue button${varientNameController.text}\n${displayNameController.text}\n${searchNameController.text}\n${descriptionController.text}\n${oldSystemController.text}");
                                    print("baseUom$base");
                                    print("salesUom$sales");
                                  },
                                ),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ScrollConfiguration(
                        behavior: NoGlow(),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                SegmantFlowCard(
                                  division: widget.division,
                                  category: widget.category,
                                  subCategory: widget.subCategory,
                                  group: widget.group,
                                  item: widget.item,
                                  uom: widget.uom,
                                ),
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
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
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
                              SegmantFlowCard(
                                division: widget.division,
                                category: widget.category,
                                subCategory: widget.subCategory,
                                group: widget.group,
                                item: widget.item,
                                uom: widget.uom,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              VariationsTab(
                                itemId: widget.itemId,
                              ),
                              ContinueButton(
                                onTap: () {
                                  setState(() {
                                    _controller.index = 3;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 60,
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
                                            SegmantFlowCard(
                                              division: widget.division,
                                              category: widget.category,
                                              subCategory: widget.subCategory,
                                              group: widget.group,
                                              item: widget.item,
                                              uom: widget.uom,
                                            ),
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
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: ItemSubmitScreen(),
                                            withNavBar: false,
                                            // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation:
                                                PageTransitionAnimation.fade,
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
                                        child: SegmantFlowCard(
                                          division: widget.division,
                                          category: widget.category,
                                          subCategory: widget.subCategory,
                                          group: widget.group,
                                          item: widget.item,
                                          uom: widget.uom,
                                        )),
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
