import 'package:cluster/presentation/purchase_app/purchase_svg.dart';
import 'package:cluster/presentation/purchase_app/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class BasicDetailsScreen extends StatelessWidget {
  const BasicDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Request Information",
          isAction: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basic Details",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  // margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(160.0),
                    border: TableBorder.all(
                        color: Color(0xffE6ECF0),
                        borderRadius: BorderRadius.circular(10),
                        style: BorderStyle.solid,
                        width: 2),
                    children: [
                      TableRow(children: [
                        TableTitle(
                          label: "Order ID",
                        ),
                        SubTextCard(
                          label: "ORD1542BG22",
                        ),
                      ]),
                      TableRow(children: [
                        TableTitle(
                          label: "Order Type",
                        ),
                        SubTextCard(
                          label: "Quotation",
                        ),
                      ]),
                      TableRow(children: [
                        TableTitle(
                          label: "Order From",
                        ),
                        SubTextCard(
                          label: "Call Center",
                        ),
                      ]),
                      TableRow(children: [
                        TableTitle(
                          label: "Branch ID",
                        ),
                        SubTextCard(
                          label: "123254",
                        ),
                      ]),
                      TableRow(children: [
                        TableTitle(
                          label: "Payment ID",
                        ),
                        SubTextCard(
                          label: "5156435132114",
                        ),

                      ]),
                      TableRow(children: [
                        TableTitle(
                          label: "Payment Status",
                        ),
                        SubTextCard(
                          label: "5156435132114",
                        ),

                      ]),
                      TableRow(children: [
                        TableTitle(
                          label: "Payment Status",
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(6),
                             width: 86,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0x33199c3e),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.string(PurchaseSvg().approveIcon,color:  Color(0xff199c3e),),
                                SizedBox(width: 5,),
                                Text(
                                  "Paid",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff199c3e),
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )

                          )
                        ],),


                      ]),TableRow(children: [
                        TableTitle(
                          label: "Reciept Date",
                        ),

                        SubTextCard(
                          label: "12 January 2022",
                        ),

                      ]),TableRow(children: [
                        TableTitle(
                          label: "Planned Receipt Date",
                        ),

                        SubTextCard(
                          label: "16 January 2022",
                        ),

                      ]),
                      TableRow(children: [
                        TableTitle(
                          label: "Expected Reciept Date",
                        ),

                        SubTextCard(
                          label: "22 January 2022",
                        ),

                      ]),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
