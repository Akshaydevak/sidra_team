import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'create_heirarchy_page_one.dart';

class OrganisationChartScreen extends StatefulWidget {
  const OrganisationChartScreen({super.key});

  @override
  State<OrganisationChartScreen> createState() =>
      _OrganisationChartScreenState();
}



class _OrganisationChartScreenState extends State<OrganisationChartScreen> {
  List<String> basedOn = ['Level 1', 'Level 2','Level 3'];
  String? basedOnVal;
  List<String> insertList = ['above', 'below'];
  String? insertVal;
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Organisation Chart",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  "Dashboard",
                  style: GoogleFonts.roboto(
                      fontSize: w / 24, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 130,
                // color: Colors.green,
                child: ListView.separated(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              // isSelect = index;
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: w1 / 1.5,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0x0c000000),
                                    width: 1,
                                  ),
                                  color: Color(0xff2871AF).withOpacity(0.2),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "10",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontSize: w / 14),
                                        ),
                                        Icon(
                                          Icons.group,
                                          color: ColorPalette.primary,
                                        )
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Total Hierarchy Levels"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 0,
                        ),
                    itemCount: 5),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Hierarchy",
                          style: GoogleFonts.roboto(
                              fontSize: w / 24, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showModalBottomSheetBased(context);
                          },
                          child: Text(
                            "Create new",
                            style: GoogleFonts.roboto(
                                fontSize: w / 24,
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  // isSelect = index;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    // width: w1,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0x0c000000),
                                        width: 1,
                                      ),
                                      color: Color(0xffE6ECF0).withOpacity(0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: w1 / 1.33,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "CEO & MD",
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "1 Designation & 02 Privileges ",
                                                style: GoogleFonts.roboto(
                                                    color: Color(0xff2871AF),
                                                    fontSize: w / 30),
                                              ),
                                              Text(
                                                "Reporting to CEO",
                                                style: GoogleFonts.roboto(
                                                    fontSize: w / 30),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CircleAvatar()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                        itemCount: 5),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showModalBottomSheetBased(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    height: h / 2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: h / 180,
                            ),
                            Container(
                              width: w / 5.3,
                              height: h / 160,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h / 40,
                            ),
                            Text(
                              "Add Hierarchy",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: h / 2.4,
                              // color: Colors.amber,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: h / 40,
                                    ),
                                    Container(
                                      child: TextFormReusable(
                                        label: "",
                                        hint:
                                            "Total levels in organization is 02",
                                        numField: true,
                                        onchange: (dd) {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Insert to?",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: w/24
                                    ),),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: w1 / 3.5,
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                            color: Color(0xffE6ECF0),
                                          ),
                                          child: DropdownButton(
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black),
                                              elevation: 1,
                                              underline: Container(),
                                              value: insertVal,
                                              items:
                                                  insertList?.map((String items) {
                                                return DropdownMenuItem(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  enabled: true,
                                                  value: items,
                                                  child: Row(
                                                    children: [
                                                      // Icon(Icons.percent),
                                                      Text(items,
                                                          style: GoogleFonts.roboto(
                                                              color:
                                                                  ColorPalette
                                                                      .black)),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (dynamic value) {
                                                setState(() {
                                                  insertVal = value;
                                                });
                                              },
                                              hint: Row(
                                                children: [
                                                  // Icon(Icons.percent),
                                                  Text(
                                                    insertVal ?? "Select",
                                                    style: TextStyle(
                                                      color: Color(0xbf666161),
                                                      fontSize: w / 24,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        // Spacer(),
                                        Container(
                                          width: w1 / 1.8,
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                            color: Color(0xffE6ECF0),
                                          ),
                                          child: DropdownButton(
                                              isExpanded: true,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black),
                                              elevation: 1,
                                              underline: Container(),
                                              value: basedOnVal,
                                              items:
                                                  basedOn?.map((String items) {
                                                return DropdownMenuItem(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  enabled: true,
                                                  value: items,
                                                  child: Row(
                                                    children: [
                                                      // Icon(Icons.percent),
                                                      Text(items,
                                                          style: GoogleFonts.roboto(
                                                              color:
                                                                  ColorPalette
                                                                      .black)),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (dynamic value) {
                                                setState(() {
                                                  basedOnVal = value;
                                                });
                                              },
                                              hint: Row(
                                                children: [
                                                  // Icon(Icons.percent),
                                                  Text(
                                                    basedOnVal ?? "Select",
                                                    style: TextStyle(
                                                      color: Color(0xbf666161),
                                                      fontSize: w / 24,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lab.",
                                    style: GoogleFonts.roboto(
                                      color: Color(0xff949494)
                                    ),),
                                    SizedBox(
                                      height: h / 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: GradientButton(
                              color: ColorPalette.primary,
                              onPressed: () {
                                Navigator.pop(context);
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: CreateHeirarchyPageOne(),
                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );

                                setState(() {});
                              },
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ColorPalette.primary,
                                    ColorPalette.primary
                                  ]),
                              child: Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
