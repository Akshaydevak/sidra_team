import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/common_widgets/title_app_bar.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../seller_app/new_list_tab/textfield_tab.dart';

class AddVarient extends StatelessWidget {
  const AddVarient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Add Variant", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormReusable(
                label: "Name",
                hint: "Eg. SEM",
              ),
              SizedBox(
                height: 10,
              ),
              TextFormReusable(
                label: "Description",
                hint:
                    "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Amet minim mollit non deserunt ullamco est sit aliqua dolor.",
                maxLength: 5,
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Attribute Name",
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
                      GestureDetector(
                        onTap: () {
                          bool isActive = false;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: Container(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            height: 50,
                                            width: w,
                                            padding: EdgeInsets.all(16),
                                            color: Color(0xff4D4D4D),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Create New Attribute",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: w / 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              children: [
                                                TextFormReusable(
                                                  label: "Name",
                                                  hint: "Eg. SEM",
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormReusable(
                                                  label: "Description",
                                                  hint: "Eg. SEM",
                                                  maxLength: 3,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                    width: w,
                                                    // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                    //height: 20.0,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 14.0,
                                                            vertical: 14),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xffe6ecf0),
                                                        width: 1,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x05000000),
                                                          blurRadius: 8,
                                                          offset: Offset(1, 1),
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Is_Active",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: Colors.black,
                                                            fontSize: w / 24,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                isActive =
                                                                    !isActive;
                                                              });
                                                            },
                                                            child: SvgPicture
                                                                .string(isActive
                                                                    ? HomeSvg()
                                                                        .toggleActive
                                                                    : HomeSvg()
                                                                        .toggleInActive)),
                                                      ],
                                                    )),
                                                SizedBox(height: 50,),
                                                GradientButton(
                                                    color:ColorPalette.primary ,
                                                    onPressed: () {
                                                      // InvoiceScreen
                                                    },
                                                    gradient:  LinearGradient(
                                                        begin: Alignment.topCenter,
                                                        end: Alignment.bottomCenter,
                                                        colors:[
                                                          ColorPalette.primary,
                                                          ColorPalette.primary
                                                        ]),
                                                    child: Text(
                                                      "Create",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              });
                        },
                        child: Text(
                          "ADD NEW ATTRIBUTE",
                          style: GoogleFonts.roboto(
                            color: Color(0xfffe5762),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      scrollPadding: EdgeInsets.all(10),
                      cursorColor: Colors.black,
                      // obscureText: show,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                      keyboardType: TextInputType.emailAddress,
                      decoration: loginInputDecoration(
                        hintText: "-  Select  -",
                        ('Username'),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldTab(
                label: "Attribute Type",
                hint: "-  Select  -",
              ),
              SizedBox(
                height: 50,
              ),
              GradientButton(
                  color: ColorPalette.primary,
                  onPressed: () {
                    // InvoiceScreen
                  },
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [ColorPalette.primary, ColorPalette.primary]),
                  child: Text(
                    "Save",
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
    );
  }

  InputDecoration loginInputDecoration(
    String label, {
    String? hintText,
    Widget? leading,
    Widget? suffix,
  }) =>
      InputDecoration(
        // suffixIcon: suffix,
        suffix: suffix,
        errorMaxLines: 2,
        counterText: "",
        labelStyle:
            TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.8)),
        // labelText: "  " + label,
        hintText: hintText,
        contentPadding:
            EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 10),
        hintStyle: TextStyle(
          color: Color(0x7f666161),
          fontSize: 16,
        ),
        alignLabelWithHint: true,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE6ECF0)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe6ecf0)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        isDense: false,
        helperStyle: TextStyle(fontSize: 8),

        helperMaxLines: 15,
      );
}
