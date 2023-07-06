import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/logistic_app/widget/driver_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import '../../seller_app/new_list_tab/other_card.dart';
import '../utils/logistic_svg.dart';

class AddDelivery extends StatelessWidget {
  String? selGender;
  List<String> gender = ["Male", "Female", "Other"];
  String? selectedGender;
   AddDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Add a Driver",
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DriverCard(isSelect: true,svg: LogisticSvg().bikeIcon,),
                      DriverCard(svg: LogisticSvg().bikeIcon,),
                      DriverCard(svg: LogisticSvg().bikeIcon,),
                      DriverCard(svg: LogisticSvg().bikeIcon,),
                    ]),
                SizedBox(
                  height: 20,
                ),
                TextFormReusable(
                  label: "Full Name",
                  hint: "Eg. SEM",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormReusable(
                  label: "Address",
                  hint: "Eg. SEM",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormReusable(
                  label: "Email Address",
                  hint: "Eg. SEM",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Phone Number",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                IntlPhoneField(
                  initialCountryCode: "IN",
                  // controller: emailphonecontroller,
                  validator: (text) {
                    if (text == null) {
                      return 'Text is empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon:TextButton(
                      onPressed: (){},
                      child: Text(
                        "Update",
                        style: GoogleFonts.roboto(
                          color: Color(0xfffe5762),
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    hintText: "eg.8606200441",
                    hintStyle:
                    GoogleFonts.roboto(color: Colors.grey, fontSize: 14),
                    contentPadding:
                    const EdgeInsets.only(left: 10, top: 10, bottom: 10,right: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffe6ecf0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffe6ecf0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xffe6ecf0), width: 1.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                  onChanged: (phone) {
                    // contactNumber = phone.completeNumber.toString();
                    // emailphonecontroller =
                    //     TextEditingController(text: phone.number);
                  },
                  onCountryChanged: (country) {},
                  cursorColor: Colors.black,
                  dropdownIcon: const Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  dropdownIconPosition: IconPosition.trailing,
                  flagsButtonMargin: const EdgeInsets.only(left: 10, right: 30),
                  disableLengthCheck: false,
                  showDropdownIcon: false,
                ),
                SizedBox(height: 10,),
                Container(
                  width: w /2.5,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                  child: DropdownButton(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      underline: Container(),
                      items: gender.map((String items) {
                        return DropdownMenuItem(
                          enabled: true,
                          value: items,
                          child: Text(items, style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      value: selectedGender,
                      onChanged: (dynamic value) {},
                      hint: Text(
                        "Select One",
                        style: TextStyle(
                          color: Color(0xbf666161),
                          fontSize: w/22,
                        ),
                      )),
                ),
                SizedBox(height: 10,),
                TextFormReusable(
                  label: "Vehicle ID",
                  hint: "Eg. SEM",
                ),
                const SizedBox(
                  height: 10,
                ),TextFormReusable(
                  label: "Driving Liscence Number",
                  hint: "Eg. SEM",
                ),
                const SizedBox(
                  height: 10,
                ),TextFormReusable(
                  label: "Total Capacity of Vehicle",
                  hint: "Eg. SEM",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Available Space in Cm",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OtherCard(),
                    OtherCard(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Upload Driving Liscence",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                  child:  Row(
                    children: [
                      Container(
                        width: w/3,
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
                      SizedBox(width: 10,),Text(
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
                      // PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen: PickAndPack(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );
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
                      "Add",
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
