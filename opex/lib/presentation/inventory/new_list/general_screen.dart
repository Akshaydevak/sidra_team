import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';

import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/seller_app/new_list_tab/textfield_tab.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'baseuom_screen.dart';


class InventoryGeneralScreen extends StatefulWidget {
  InventoryGeneralScreen({Key? key}) : super(key: key);

  @override
  State<InventoryGeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<InventoryGeneralScreen> {
  String? selGender;

  bool isActive=false;

  List<String> gender = ["Male", "Female", "Other"];

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
      behavior: NoGlow(),
      child: SingleChildScrollView(
        child: Container(
           padding: EdgeInsets.symmetric(vertical:    16),
          // color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldTab(
                label: "Item Name",
                hint: "Eg. SEM",
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldTab(
                label: "Search Name",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldTab(
                label: "Display Name",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldTab(
                label: "Old System Code",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Base UOM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.string(SellerSvg().validationIcon)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: InventoryBaseUomScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
                child: Container(
                  width: w ,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0x33fe5762), width: 1, ),
                    color: Color(0x0cfe5762),
                  ),
                  child: Text(
                    "-  Select  -",
                    style: TextStyle(
                      color: Color(0xfffe5762),
                      fontSize: w/22,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Please choose any UOM",
                style: TextStyle(
                  color: Color(0xff666161),
                  fontSize: w/24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldTab(
                label: "Identification",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w ,
                // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                //height: 20.0,
                padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Is_Active",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState((){
                          isActive=!isActive;
                        });
                      },
                        child: SvgPicture.string(isActive?HomeSvg().toggleActive:HomeSvg().toggleInActive)),
                  ],
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
