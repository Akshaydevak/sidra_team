import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/logistic_app/utils/logistic_svg.dart';
import 'package:cluster/presentation/logistic_app/widget/delivery_to_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'assign_order.dart';

class LogisticOrderView extends StatelessWidget {
  final String? variantName;
  const LogisticOrderView({Key? key, this.variantName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "#611564451",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  margin: EdgeInsets.all(16),
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
                      Divider(
                        color: Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Instruction :",
                              style: GoogleFonts.roboto(
                                color: Color(0xff151522),
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia conseq uat duis enim velit mollit",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 24,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xffE6ECF0),
                  thickness: 1.1,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery To ",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: ColorPalette.inactiveGrey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sbin Sreenivas",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.primary,
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "+91 8606200441",
                                style: TextStyle(
                                  color: ColorPalette.black,
                                  fontSize: w / 25,
                                ),
                              ),
                              Text(
                                "afthaburahman313@gmail.com",
                                style: TextStyle(
                                  color: ColorPalette.black,
                                  fontSize: w / 25,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DeliveryToCard(
                            svg: LogisticSvg().callIcon,
                          ),
                          DeliveryToCard(  svg: LogisticSvg().msgIcon,),
                          DeliveryToCard(  svg: LogisticSvg().locationIcon),
                          DeliveryToCard(  svg: LogisticSvg().docIcon,),
                        ],
                      ),
                      SizedBox(height: 10,)
,                    Text(
                        "Order Details",
                        style: GoogleFonts.roboto(
                          color: Color(0xff151522),
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                      ),
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
                      SizedBox(
                        height: 16,
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
                        child: Row(
                          children: [
                            Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xfff0f1f2),
                              ),
// <<<<<<< HEAD:lib/presentation/logistic_app/order_view.dart
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "15464646545 ",
                                  style: GoogleFonts.roboto(
// =======
//                               Container(
//                                 width: w / 2,
//                                 child: Text(
//                                   variantName??"",
//                                   style: TextStyle(
// >>>>>>> 1afc9b8e9e49f8700c9eb654148555ffbd9bf097:lib/presentation/logistic_app/screens/order_view.dart
                                    color: ColorPalette.black,
                                    fontSize: w / 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: w / 2,
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing ea...",
                                    style: TextStyle(
                                      color: ColorPalette.black,
                                      fontSize: w / 24,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: w / 4.8,
                                      child: Text(
                                        "Brand ",
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
                                      " Specimen",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: w / 4.8,
                                      child: Text(
                                        "Price ",
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
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      " AED 145.50 / Piece",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GradientButton(
                          color: Color(0xffE6ECF0),
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: AssignOrder(),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );
                          },
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: const [Colors.white, Colors.white]),
                          child: Text(
                            "Assign for delivery",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
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
