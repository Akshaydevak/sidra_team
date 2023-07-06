import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/manufacture/success_contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class ContactVendor extends StatelessWidget {
  const ContactVendor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Contracts",
          isAction: true,
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
                Container(
                  width: w,
                  height: 60,
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
                  alignment: Alignment.center,
                  child: Text(
                    "E Commerce Vendor Agreement",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: w,

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "To : afthaburahman313@gmail.com",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        color: ColorPalette.divider,
                        width: w,
                        height: 1.1,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. "),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Whereseas",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("1."),
                                Container(
                                    width: w / 1.28,
                                    child: Text(
                                        "Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi."))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("2."),
                                Container(
                                    width: w / 1.28,
                                    child: Text(
                                        "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. "))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("3."),
                                Container(
                                    width: w / 1.28,
                                    child: Text(
                                        "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. "))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("4."),
                                Container(
                                    width: w / 1.28,
                                    child: Text(
                                        "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. "))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Aliqua id fugiat nostrud irure ex duis ea quis id qui s ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. ",
                                style: GoogleFonts.roboto()),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. ",
                              style: GoogleFonts.roboto(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Upload Signature",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
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
                  child: Row(children: [
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
                        color: ColorPalette.primary,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Choose File",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "No file choosen",
                      style: TextStyle(
                        color: ColorPalette.primary,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ]),
                ),
                SizedBox(height: 30,),
                GradientButton(
                    color:Color(0xfffe5762) ,
                    onPressed: () {

                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: SuccessContract(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Color(0xfffe5762),  Color(0xfffe5762)]),
                    child: Text(
                      "Issue Contract",
                      textAlign: TextAlign.center,
                      style:  GoogleFonts.roboto(
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
