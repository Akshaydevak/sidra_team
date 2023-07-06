import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'employee_card.dart';

class USerEmployeeList extends StatelessWidget {
   USerEmployeeList({Key? key}) : super(key: key);
  String? selGender;
  List<String> gender = ["Today’s Report", "Today’s Report", "Today’s Report"];
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Employees",
          isAction: false,
          // action: SvgPicture.string(
          //   TaskSvg().notificationIcon,
          //   color: Colors.black,
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: w / 1.35, child: SearchCard()),
                  Container(
                    padding: EdgeInsets.all(14),
                    width: 50,
                    height: 50,
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
                    child: SvgPicture.string(
                      MposSvg().filterIcon,
                      color: Color(0xff969090),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Total 120 Employees",
                    style: GoogleFonts.roboto(
                      color: Color(0xff151522),
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: w/2.8,
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
                          "Rawabi Market",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),

                ],
              ),
              SizedBox(height: 16,),
              ListView.separated(
                primary: true,
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, index) => const EmployeeCard(),
                separatorBuilder: (context, index) => const SizedBox(height: 10,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
