import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/task_svg.dart';

class UserNewEmployee extends StatelessWidget {
  String? selGender;
  List<String> gender = ["Today’s Report", "Today’s Report", "Today’s Report"];
  String? selectedGender;

  UserNewEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "New Employee",
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
                  label: "Employee ID",
                  hint: "Eg. SEM",
                  maxLength: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "First Name",
                  hint: "Eg. SEM",
                  maxLength: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Last Name",
                  hint: "Eg. SEM",
                  maxLength: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Email Address",
                  hint: "Eg. SEM",
                  maxLength: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Contact Details",
                  hint: "Eg. SEM",
                  maxLength: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: w / 2.3,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //height: 20.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                          child: DropdownButton(
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              underline: Container(),
                              items: gender.map((String items) {
                                return DropdownMenuItem(
                                  enabled: true,
                                  value: items,
                                  child: Text(items,
                                      style: TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              value: selectedGender,
                              onChanged: (dynamic value) {},
                              hint: Text(
                                "-  Select  -",
                                style: TextStyle(
                                  color: Color(0xbf666161),
                                  fontSize: w / 22,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nationality",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: w / 2.3,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //height: 20.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                          child: DropdownButton(
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              underline: Container(),
                              items: gender.map((String items) {
                                return DropdownMenuItem(
                                  enabled: true,
                                  value: items,
                                  child: Text(items,
                                      style: TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                              value: selectedGender,
                              onChanged: (dynamic value) {},
                              hint: Text(
                                "-  Select  -",
                                style: TextStyle(
                                  color: Color(0xbf666161),
                                  fontSize: w / 22,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Organization",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 12),
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
                       Text(
                         "-  Select  -",
                         style: TextStyle(
                           color: Color(0xbf666161),
                           fontSize: w/22,
                         ),
                       ),
                       Icon(Icons.keyboard_arrow_down_outlined,color:  Color(0xff7d7d7d),)
                     ],
                  ),
                ), SizedBox(
                  height: 16,
                ),
                Text(
                  "Department",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 12),
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
                       Text(
                         "-  Select  -",
                         style: TextStyle(
                           color: Color(0xbf666161),
                           fontSize: w/22,
                         ),
                       ),
                       Icon(Icons.keyboard_arrow_down_outlined,color:  Color(0xff7d7d7d),)
                     ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Upload Profile",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 129,
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
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "No file choosen",
                        style: TextStyle(
                          color: Color(0xfffe5762),
                          fontSize: w/24,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {

                      //  PickAndPack
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          ColorPalette.primary,
                          ColorPalette.primary
                        ]),
                    child: Text(
                      "Create New Employee",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
