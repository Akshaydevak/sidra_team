import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/new_ordercard.dart';
import '../order_app/order_svg.dart';
import '../order_app/orderapp_card.dart';

class CustomerDetails extends StatefulWidget {
   CustomerDetails({Key? key}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
bool isCredit=false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Afthabu Rahman",isAction: false,),

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
                ClusterCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sbin Sreenivas",
                                    style: GoogleFonts.roboto(
                                      color: Color(0xfffe5762),
                                      fontSize: w / 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.string(OrderSvg().callIcon),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.string(OrderSvg().msgIcon),
                                ],
                              ),
                            ],
                          )),
                      Container(
                        width: w,
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color:  ColorPalette.cardBackground,
                              ),
                              child: SvgPicture.string(OrderSvg().phoneIcon),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "+91 8606200441",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: w,
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.cardBackground,
                              ),
                              child: SvgPicture.string(OrderSvg().mailIcon),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "afthaburahman313@gmail.com",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w / 22,
                              ),
                            ),
                          ],
                        ),
                      ), Container(
                        margin: const EdgeInsets.only(left: 50),
                        width: w,
                        height: 1,
                        color: const Color(0xffE6ECF0),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color:ColorPalette.cardBackground,
                              ),
                              child: SvgPicture.string(OrderSvg().locationIcon),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: w/1.8,
                              child:   Text(
                                "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: w / 22,
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18,),
                Text(
                  "Payment Method",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClusterCard(
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0x7fe6ecf0),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Image.asset("asset/cardicon.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Afthabu Rahman PP",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:  [
                                Text(
                                  "****  ****  **** ",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff1b1b1f),
                                    fontSize: 18,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "5326",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(height: 10,),
                ClusterCard(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w/1.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Credit Option Available",
                            style: GoogleFonts.roboto(
                              color: Color(0xff151522),
                              fontSize: w/20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Eligible for credit option based on transaction.",
                            style: TextStyle(
                              color: Color(0xff676767),
                              fontSize: w/24,
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState((){
                          isCredit =! isCredit;
                        });
                      },
                      child: isCredit
                          ? SvgPicture.string(HomeSvg().toggleActive)
                          : SvgPicture.string(
                          HomeSvg().toggleInActive),
                    )
                  ],
                ),),
                SizedBox(height: 20,),
                Text(
                  "Order History",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/22,

                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewOrderCard(isMpos: true,);
                      },
                      separatorBuilder: (context, index) => Container(
                        height: 10,
                      ),
                      itemCount: 5),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
