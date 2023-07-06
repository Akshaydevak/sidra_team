import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/cluster_card.dart';
import 'order_svg.dart';
import 'orderapp_card.dart';

class OrderView extends StatefulWidget {
bool isSales;
   OrderView({Key? key,this.isSales=false}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int select=0;
  void onselect(Intex){
    setState(() {
      select=Intex;
    });
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: Colors.white, // Status bar
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: w / 1.1,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0x4ca9a8a8),
                              width: 1,
                            ),
                            color: Color(0xfff8f7f5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Order ID",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff1b1b1f),
                                      fontSize: w / 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "#OTHG3514",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff1b1b1f),
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Order Date",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff1b1b1f),
                                      fontSize: w / 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " 15 Jan, 2022",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff1b1b1f),
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xffe6ecf0),
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
                          child: SvgPicture.string(OrderSvg().qrIcon),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                                color:ColorPalette.cardBackground,
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
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.cardBackground,
                              ),
                              child: SvgPicture.string(OrderSvg().phoneIcon),
                            ),
                            SizedBox(
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Delivery Details",
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
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: const [
                              Text(
                                "Delivery on ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "12 Jun 2022",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )),
                      Container(
                        width: w,
                        margin: EdgeInsets.only(left: 50),
                        height: 1,
                        color: Color(0xffE6ECF0),
                      ),
                      Container(
                        width: w,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Note :",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                          children: const [
                            Text(
                              "****  ****  **** ",
                              style: TextStyle(
                                color: Color(0xff1b1b1f),
                                fontSize: 18,
                                fontFamily: "Poppins",
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
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Order Lines (3)",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>  ClusterCard(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 65,
                                width: 65,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Image.asset("asset/img_9.png"),
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: SvgPicture.string(
                                            OrderSvg().checkBoxIcon))
                                  ],
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#15464646545 ",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                    width: w / 1.8,
                                    child: Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    )),
                                Row(
                                  children: [
                                    Text(
                                      "Quantity\nPrice ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "24\nAED 145.50",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w/24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            )
                          ],
                        )), separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: 3),

                SizedBox(height: 16,),
                widget.isSales? Container() :Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Choose assign partner",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: w,
                      // height: 301,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(10), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(10), ),
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
                            padding:EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                SvgPicture.string(HomeSvg().radioButtonActive),
                                const         SizedBox(width: 10,),
                                Text(
                                  "Own organization",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: w/24,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1.1,
                          ),
                          ListView.separated(itemCount: 5,
                            primary: true,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: 10),
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) => Container(
                              padding:EdgeInsets.symmetric(vertical: 5) ,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      onselect(index);
                                    },
                                    child: SvgPicture.string(select==index
                                        ? HomeSvg().radioButtonActive
                                        : HomeSvg().radioInActive),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "Logistic partner list 1",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: w/24,
                                    ),
                                  )
                                ],
                              ),
                            ),)
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                ClusterCard(
                  child: Center(
                    child: Text(
                      "Add to Picking",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
