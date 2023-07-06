import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:cluster/presentation/promotion_app/select_products.dart';
import 'package:cluster/presentation/promotion_app/success_promotion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class NewPromotion2 extends StatefulWidget {
  NewPromotion2({Key? key}) : super(key: key);

  @override
  State<NewPromotion2> createState() => _NewPromotion2State();
}

class _NewPromotion2State extends State<NewPromotion2> {
  String? selGender;
  bool isActive = false;
  bool isSelect = false;
  String? selectedGender;

  List<String> gender = ["Grocery", "Lifestyle", "Bulk"];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "New Promotion"),
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
                SvgPicture.string(PromotionSvg().progressDesign2),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Type Applying",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
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
                        "Select segment ",
                        style: TextStyle(
                          color: Color(0xbf666161),
                          fontSize: w / 24,
                        ),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
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
                        "Select segment ",
                        style: TextStyle(
                          color: Color(0xbf666161),
                          fontSize: w / 22,
                        ),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {

                      isSelect=false;
                    });
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SelectProducts(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  //  SelectProducts
                  },
                  child: Container(
                    width: w,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xfffe5762),
                        width: 1,
                      ),
                      color: Color(0x0cfe5762),
                    ),
                    child: Text(
                      isSelect?"12 Products Selected":"+ Select Product",
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormReusable(
                  label: "Maximum Inventory",
                  hint: "",
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: w,
                    // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //height: 20.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
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
                          "Is_Active",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isActive = !isActive;
                              });
                            },
                            child: SvgPicture.string(isActive
                                ? HomeSvg().toggleActive
                                : HomeSvg().toggleInActive)),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: SuccessPromotion(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    //  SuccessPromotion
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          ColorPalette.primary,
                          ColorPalette.primary
                        ]),
                    child: Text(
                      "Save Promotion",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w/22,
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
