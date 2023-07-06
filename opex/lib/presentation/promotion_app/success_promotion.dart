import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';
import '../product_hub/product_hub_card.dart';
import '../seller_app/seller_svg.dart';

class SuccessPromotion extends StatefulWidget {
  SuccessPromotion({Key? key}) : super(key: key);

  @override
  State<SuccessPromotion> createState() => _SuccessPromotionState();
}

class _SuccessPromotionState extends State<SuccessPromotion> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // Navigation bar
              statusBarColor: Color(0xff3aba6f), // Status bar
            ),
          )),
      body: ScrollConfiguration(behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            // height: h,
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Container(
                  width: w,
                  height: h / 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff3aba6f), Color(0xff1e9a51)],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.string(SellerSvg().tickIcon),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Item Submitted successfully !",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w / 22,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xfff0f1f2),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Friday Sale of the day",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "From Jan 21, 2022 to Mar 22, 2022",
                                style: GoogleFonts.roboto(
                                  color: Color(0x99666161),
                                  fontSize: w/25,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClusterCard(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Segment",
                              style: TextStyle(
                                color: Color(0x99666161),
                                fontSize: w/25,
                              ),
                            ),
                            Text(
                              "Life Style",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Promotion Title",
                              style: TextStyle(
                                color: Color(0x99666161),
                                fontSize: w/25,
                              ),
                            ),
                            Text(
                              "Life Style",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                color: Color(0x99666161),
                                fontSize: w/25,
                              ),
                            ),
                            Text(
                              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Offer Based on",
                              style: TextStyle(
                                color: Color(0x99666161),
                                fontSize: w/25,
                              ),
                            ),
                            Text(
                              "Life Style",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Offer Group",
                              style: TextStyle(
                                color: Color(0x99666161),
                                fontSize: w/25,
                              ),
                            ),
                            Text(
                              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        },
                        child: ClusterCard(
                         padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Container(
                                padding: isActive
                                    ? EdgeInsets.fromLTRB(16, 16, 16, 10)
                                    : EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Promotion Applying To",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_outlined)
                                  ],
                                ),
                              ),
                              isActive
                                  ? Container(

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(
                                            color: ColorPalette.divider,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 76,
                                                      height: 76,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                        color: Color(0xfff0f1f2),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Type ID",
                                                          style: GoogleFonts.roboto(
                                                            color: Colors.black,
                                                            fontSize: w/22,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          "#145HGYD",
                                                          style: GoogleFonts.roboto(
                                                            color: Color(0x99666161),
                                                            fontSize: w/25,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: w/24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 16,),
                                                Text(
                                                  "Offer Based on",
                                                  style: TextStyle(
                                                    color: ColorPalette.subtextGrey,
                                                    fontSize: w/25,
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                Text(
                                                  "Life Style",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: w/24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 16,),
                                                Text(
                                                  "Offer Group",
                                                  style: TextStyle(
                                                    color: ColorPalette.subtextGrey,
                                                    fontSize: w/25,
                                                  ),
                                                ),
                                                Text(
                                                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: w/24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )

                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GradientButton(
                          color: ColorPalette.primary,
                          onPressed: () {
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
                            "View all Promotions",
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
        ),
      ),
    );
  }
}
