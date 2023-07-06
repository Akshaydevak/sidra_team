import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/no_glow.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class ContractDetails extends StatelessWidget {
  const ContractDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Contract Details",
          isAction: false,
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
                  padding: EdgeInsets.all(16),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
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
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Contract Date :",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: w / 23,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "12 April, 2012 ",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 23,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Expired on 12 July 2022 ",
                              style: TextStyle(
                                color: Color(0xfffe5762),
                                fontSize: w / 26,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
              
                  padding: EdgeInsets.all(16),
                    
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(
                      "Signature",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                      SizedBox(height: 10,),
                      Image.asset("asset/img_16.png",height: 118,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
