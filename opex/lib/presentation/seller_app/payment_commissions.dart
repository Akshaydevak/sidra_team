import 'package:cluster/presentation/seller_app/transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/title_app_bar.dart';

class PaymentCommissions extends StatefulWidget {
  const PaymentCommissions({Key? key}) : super(key: key);

  @override
  State<PaymentCommissions> createState() => _PaymentCommissionsState();
}

class _PaymentCommissionsState extends State<PaymentCommissions> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TitleAppBar(label: "Payment & Commissions"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xfffdf2f2),
                    width: 1.50,
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
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(children: [
                        Text(
                          "Credited Amount of this day",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w / 22,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "AED 2,81,1200",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                    const Divider(
                      color: Color(0xfffdf2f2),
                      thickness: 1,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 16),
                      alignment: Alignment.center,
                      child: const Text(
                        "Next Payment :  12 April 2022",
                        style: TextStyle(
                          color: Color(0xff7d7d7d),
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last Transactions",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "View All",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
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
                  boxShadow: const [
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
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "12 March 2022",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          ),
                          Text(
                            "AED 22,052",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xfffdf2f2),
                      thickness: 1,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "12 February 2022",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          ),
                          Text(
                            "AED 1,052",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xfffdf2f2),
                      thickness: 1,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "12 January 2022",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w / 22,
                            ),
                          ),
                          Text(
                            "AED 42,052",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Transactions",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "View All",
                    style: GoogleFonts.roboto(
                      color: Color(0xfffe5762),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              ListView.separated(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  primary: true,
                  itemBuilder: (context, index) => TransactionCard(),
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                  itemCount: 8)
            ],
          ),
        ),
      ),
    );
  }
}
