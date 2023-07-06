import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/logistic_app/widget/assign_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';

import '../utils/logistic_svg.dart';

class AssignOrder extends StatefulWidget {
  const AssignOrder({Key? key}) : super(key: key);

  @override
  State<AssignOrder> createState() => _AssignOrderState();
}

class _AssignOrderState extends State<AssignOrder> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Assign Order",
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
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffeef3f6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "4164636454",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _showModalBottomSheet();
                        },
                        child: Text(
                          "Details",
                          style: GoogleFonts.roboto(
                            color: Color(0xfffe5762),
                            fontSize: w/25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(
                    "120 Result",
                    style: GoogleFonts.roboto(
                      color: Color(0xff151522),
                      fontSize: w/22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Filter",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: w/22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],),
                SizedBox(height: 10,),
            ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AssignOrderCard(

                  );
                },
                separatorBuilder: (context, index) => Container(
                  height: 10,
                ),
                itemCount: 5),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                // height: 350,
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      width: w,
                      // height: 363,
                      // padding: EdgeInsets.all(16),
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.string(LogisticSvg().statusIcon),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rancho Santa Margarita, CA",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Jun 09, 13:40 EST",
                                      style: TextStyle(
                                        color: Color(0xff666161),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "Baja California, CA ",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Jun 10, 10:40 EST",
                                      style: TextStyle(
                                        color: Color(0xff666161),
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: w,
                            height: 1,
                            color: ColorPalette.divider,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Details",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff151522),
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w / 3.5,
                                      child: Text(
                                        "Delivery Type",
                                        style: TextStyle(
                                          color: ColorPalette.subtextGrey,
                                          fontSize: w / 24,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        color: Color(0xff666161),
                                        fontSize: w / 24,
                                      ),
                                    ),
                                    Text(
                                      " Instant Delivery",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        fontSize: w / 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w / 3.5,
                                      child: Text(
                                        "Total Weight",
                                        style: TextStyle(
                                          color: ColorPalette.subtextGrey,
                                          fontSize: w / 24,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        color: Color(0xff666161),
                                        fontSize: w / 24,
                                      ),
                                    ),
                                    Text(
                                      " 5 Kg",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        fontSize: w / 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w / 3.5,
                                      child: Text(
                                        "Total Price",
                                        style: TextStyle(
                                          color: ColorPalette.subtextGrey,
                                          fontSize: w / 24,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        color: Color(0xff666161),
                                        fontSize: w / 24,
                                      ),
                                    ),
                                    Text(
                                      " AED 145.50",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        fontSize: w / 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w / 3.5,
                                      child: Text(
                                        "Delivery Time",
                                        style: TextStyle(
                                          color: ColorPalette.subtextGrey,
                                          fontSize: w / 24,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        color: Color(0xff666161),
                                        fontSize: w / 24,
                                      ),
                                    ),
                                    Text(
                                      " 12 Jan 2022, 10:25 AM",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        fontSize: w / 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
