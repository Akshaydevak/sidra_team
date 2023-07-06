import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

class AddNewHub extends StatelessWidget {
  const AddNewHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            label: "Add New Hub",
            isAction: false,
            action: SvgPicture.string(
              TaskSvg().notificationIcon,
              color: Colors.black,
            ),
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
                  TextFormReusable(
                    label: "Delivery Hub Name",
                    hint: "Eg. SEM",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Time",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: w,
                    // height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "From ",
                              style: TextStyle(
                                  color: ColorPalette.primary,
                                  fontSize: w / 21,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "06:33 AM",
                              style: TextStyle(
                                  color: ColorPalette.primary,
                                  fontSize: w / 21,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "To ",
                              style: TextStyle(
                                  color: ColorPalette.primary,
                                  fontSize: w / 21,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "06:33 PM",
                              style: TextStyle(
                                  color: ColorPalette.primary,
                                  fontSize: w / 21,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Address on Map",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: w,
                    // height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      color: Colors.white,
                    ),
                    child: Text(
                      "Select Hub Location",
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: w / 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormReusable(
                    label: "Address",
                    hint: "Eg. Lorem ipsum dolar sit amet.",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Upload Profile",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: w,
                      // height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: w / 3,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: Color(0xfffe5762),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Choose File",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 23,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No file choosen",
                            style: TextStyle(
                              color: ColorPalette.primary,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                        ],
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                      color: ColorPalette.primary,
                      onPressed: () {},
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorPalette.primary,
                            ColorPalette.primary
                          ]),
                      child: Text(
                        "Add",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
