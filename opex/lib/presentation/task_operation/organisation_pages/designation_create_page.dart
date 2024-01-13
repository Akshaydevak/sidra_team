import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'designation_users_screen.dart';

class CreateDesignationOrganisation extends StatefulWidget {
  const CreateDesignationOrganisation({super.key});

  @override
  State<CreateDesignationOrganisation> createState() =>
      _CreateDesignationOrganisationState();
}

class _CreateDesignationOrganisationState
    extends State<CreateDesignationOrganisation> {
  int count = 6;
  List<String>? departmentJob = [
    "Company policies and strategies",
    "Compensation and benefits programs",
    "Bond agreement processes",
    "Company policies and strategies",
    "Compensation and benefits programs",
    "Bond agreement processes",
  ];
  List<String>? headList = [
    "HR Department",
    "Sales and Marketing Department",
    "HR Department",
    "Sales and Marketing Department",
  ];
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
          label: "New Designation",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: h/1.1,
                      padding: EdgeInsets.only(bottom: 35),
                      margin: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFormReusableNoLabel(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Set Privileges",
                                        style: GoogleFonts.roboto(
                        fontSize: w / 24, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      for(int? j=0;j!<headList!.length;j++)...{
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                        children: [
                          Container(
                            width: 600,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffE6ECF0),

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Table(
                                border: TableBorder.all(
                                    color: ColorPalette.inactiveGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                columnWidths: {
                                  0: FlexColumnWidth(6.0),
                                  1: FlexColumnWidth(2.6),
                                  2: FlexColumnWidth(2.6),
                                  3: FlexColumnWidth(2.75),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          color: Color(0xffE6ECF0),
                                          child: Center(
                                            child: Text(
                                              headList?[j]??"",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: w / 28),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          color: Color(0xffE6ECF0),
                                          child: Center(
                                            child: CustomCheckBox(
                                              key: UniqueKey(),
                                              value: false,
                                              // uomCodeList
                                              //     .contains(state.inventory?[index].uomCode),
                                              onChange: (p0) {},
                                              isWidget: true,
                                              widget: Text(
                                                'Read',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: w / 28),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          color: Color(0xffE6ECF0),
                                          child: Center(
                                            child: CustomCheckBox(
                                              key: UniqueKey(),
                                              value: false,
                                              // uomCodeList
                                              //     .contains(state.inventory?[index].uomCode),
                                              onChange: (p0) {},
                                              isWidget: true,
                                              widget: Text(
                                                'Write',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: w / 28),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          color: Color(0xffE6ECF0),
                                          child: Center(
                                            child: CustomCheckBox(
                                              key: UniqueKey(),
                                              value: false,
                                              // uomCodeList
                                              //     .contains(state.inventory?[index].uomCode),
                                              onChange: (p0) {},
                                              isWidget: true,
                                              widget: Text(
                                                'Delete',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: w / 28),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (int i = 0; i < departmentJob!.length; i++)
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: Color(0xffE6ECF0),
                                            child: Center(
                                              child: Text(departmentJob?[i]??"",
                                                textAlign: TextAlign.center,),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: Color(0xffE6ECF0),
                                            child: Center(
                                              child: CustomCheckBox(
                                                  key: UniqueKey(),
                                                  value: false,
                                                  // uomCodeList
                                                  //     .contains(state.inventory?[index].uomCode),
                                                  onChange: (p0) {}),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: Color(0xffE6ECF0),
                                            child: Center(
                                              child: CustomCheckBox(
                                                  key: UniqueKey(),
                                                  value: false,
                                                  // uomCodeList
                                                  //     .contains(state.inventory?[index].uomCode),
                                                  onChange: (p0) {}),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: Color(0xffE6ECF0),
                                            child: Center(
                                              child: CustomCheckBox(
                                                  key: UniqueKey(),
                                                  value: false,
                                                  // uomCodeList
                                                  //     .contains(state.inventory?[index].uomCode),
                                                  onChange: (p0) {}),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          // Add more containers as needed
                        ],
                                          ),
                                        ),
                                      }

                                    ],
                        ),
                      ),
                    ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GradientButton(
                      color: ColorPalette.primary,
                      onPressed: () {
                        // Navigator.pop(context);
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: UsersListUnderDesignation(),
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
                ),
              )
            ],
          )),
    );
  }
}
