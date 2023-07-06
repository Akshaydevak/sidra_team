import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/order_details_card.dart';
import '../widgets/order_history_card.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Details",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                OrderDetialsCard(
                  title: "ORDER NUMBER",
                  data: "25465",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "ORDER DATE",
                  data: "12 Jan 2022",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "ORDER TYPE",
                  data: "Lorem ipsum dolar",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "ORDER TIME",
                  data: "12:45 PM",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "QUOTATION NUMBER",
                  data: "12546",
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Contact Details",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 35,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID 245487",
                            style: GoogleFonts.roboto(
                              color: Color(0xff9b9b9b),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Afthabu Rahman",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "+91 8606200441",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "afthaburahman313@gmail.com",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "TRN Number",
                  data: "25465",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "Emirates",
                  data: "United Arab Emirates",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "Building Name/Room NO.",
                  data: "Lorem ipsum ",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "Street",
                  data: "Ajman",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "Zone",
                  data: "Lorem ipsum dolar",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "City",
                  data: "Ajman",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "Landmark",
                  data: "Lorem ipsum dolar",
                ),
                SizedBox(
                  height: 5,
                ),
                OrderDetialsCard(
                  title: "Area",
                  data: "Ajman",
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Contact Alternatives",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  // height: 168,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ALTERNATIVE PHONE NUMBER",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.subtextGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "+91 8606200441",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
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
                              "Alternative Email ID",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.subtextGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "afthaburahman313@gmail.com",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: w,
            height: 6,
            color: Color(0xfff8f7f5),
          ),
          Container(
            width: w,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order History",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.primary,
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
                    itemBuilder: (context, index) => OrderHistoryCard(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 5)
              ],
            ),
          )
        ],
      ),
    );
  }
}
