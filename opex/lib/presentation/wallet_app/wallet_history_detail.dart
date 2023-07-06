import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/wallet_app/widget/apply_filter_list.dart';
import 'package:cluster/presentation/wallet_app/widget/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';
import '../payments/payment_svg.dart';

class WalletHistoryDetails extends StatefulWidget {

   WalletHistoryDetails({Key? key}) : super(key: key);

  @override
  State<WalletHistoryDetails> createState() => _WalletHistoryDetailsState();
}

class _WalletHistoryDetailsState extends State<WalletHistoryDetails> {
  int selected=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Wallet History"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                child: Row(
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
                      onTap: (){
                        _showModalBottomSheet();
                      },
                        child: SvgPicture.string(PaymentSvg().filterIcon))
                  ],
                ),
              ),

              ApplyFiltercard(),

              ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => WalletCard(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemCount: 5)
              ],
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
