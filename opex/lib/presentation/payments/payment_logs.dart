import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/payments/payment_svg.dart';
import 'package:cluster/presentation/payments/payment_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';

class PaymentLogs extends StatefulWidget {

  PaymentLogs({Key? key}) : super(key: key);

  @override
  State<PaymentLogs> createState() => _PaymentLogsState();
}

class _PaymentLogsState extends State<PaymentLogs> {
  var _listGenderText = ["Employees", "Groups"];

  var _tabTextIconIndexSelected = 0;
  int selected=0;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Payment Logs",
          isAction: true,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                FlutterToggleTab(
                  width: w / 4,
                  borderRadius: 10,
                  isShadowEnable: true,

                  marginSelected: EdgeInsets.all(0),
                  // Text(
                  //   "Completed",
                  //   style:
                  // )
                  selectedTextStyle: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  selectedBackgroundColors: [ColorPalette.primary],
                  unSelectedBackgroundColors: [Colors.white],
                  unSelectedTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  labels: _listGenderText,
                  // icons: _listIconTabToggle,
                  selectedIndex: _tabTextIconIndexSelected,
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabTextIconIndexSelected = index;
                    });
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Transactions",
                      style: GoogleFonts.roboto(
                        color: Color(0xff151522),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: SvgPicture.string(PaymentSvg().filterIcon)),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PaymentTransactionCard(),
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          height: 10,
                        ),
                    itemCount: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
   List<String> saleList=["Today’s sale","This week","This month","All Transactions"];
   List<String> transactionList=["Today’s sale","This week","This month","All Transactions"];
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery
              .of(context)
              .size
              .height;
          var w = MediaQuery
              .of(context)
              .size
              .width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.all(16),
                // height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Apply",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffe5762),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Divider(color: ColorPalette.divider,thickness: 1.1,),
                      SizedBox(height: 10,),
                      Text(
                        "Sale for",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
                      ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    setState(() {
                                      selected=index;
                                    });
                                  },
                                  child: selected == index
                                      ? Container(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.string(
                                        OrderSvg()
                                            .checkBoxActiveIcon),
                                  )
                                      : SvgPicture.string(
                                      OrderSvg().checkBoxIcon),
                                ),
                                // CustomRadioButton(
                                //   onTap: () {
                                //     onSelect(index);
                                //     setState(() {});
                                //   },
                                //   isActive: selected == index,
                                // ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  saleList[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Container(
                                height: 10,
                              ),
                          itemCount: saleList.length),
                      Divider(),
                      SizedBox(height: 10,),
                      Text(
                        "Transaction From",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
                      ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    setState(() {
                                      selected=index;
                                    });
                                  },
                                  child: selected == index
                                      ? Container(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.string(
                                        OrderSvg()
                                            .checkBoxActiveIcon),
                                  )
                                      : SvgPicture.string(
                                      OrderSvg().checkBoxIcon),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  transactionList[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Container(
                                height: 10,
                              ),
                          itemCount: transactionList.length),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
