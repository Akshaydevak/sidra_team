import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class TaxesAndOperations extends StatelessWidget {
  const TaxesAndOperations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "Tax and Payment Info", isAction: false),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w/2.3,
                      // height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),padding: EdgeInsets.all(10),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "12,250",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w/12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "Monthly Tax",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w/24,
                            ),
                          )
                        ],
                      ),
                    ),  Container(
                      width: w/2.3,
                      // height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),padding: EdgeInsets.all(10),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "11,10,254",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w/12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "Yearly Tax",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w/24,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  width: w,
                  // height: 159,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfffdf2f2),
                  ),
                  child: Column(
                    children: [
                  Container(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                    child: Column(
                      children: [
                        Text(
                        "Total Credit Amount",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                        SizedBox(height: 5,),
                        Text(
                          "AED 2,81,1200",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/12,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                      Divider(
                        color: Color(0xffE6ECF0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,left: 16,right: 16,bottom: 20),
                        child: Text(
                          "Next Payment :  12 April 2022",
                          style: TextStyle(
                            color: Color(0xff7d7d7d),
                            fontSize: 14,
                          ),
                        ),
                      )
                    ])
                ),
                SizedBox(height: 30,),
                Text(
                  "Transaction History",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                  width: w,
                 padding: EdgeInsets.all(16),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Afthabu Rahman",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "25 October 2022, 10:30 AM",
                                style: TextStyle(
                                  color: Color(0xff666161),
                                  fontSize: w/26,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "+2522.25",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Color(0xff149233),
                              fontSize: w/24,

                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                ), separatorBuilder: (context, index) => SizedBox(height: 5,), itemCount: 6)

              ],
            ),
          ),
        ),
      ),
    );
  }
}