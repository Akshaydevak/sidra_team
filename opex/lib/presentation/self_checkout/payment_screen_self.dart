

import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/self_checkout/self_svg.dart';
import 'package:cluster/presentation/self_checkout/success_screen.dart';
import 'package:cluster/presentation/self_checkout/widget/self_checkout_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/datefield.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../product_hub/new_list/success_screen.dart';

class PaymentScreenSelf extends StatefulWidget {

   PaymentScreenSelf({Key? key}) : super(key: key);

  @override
  State<PaymentScreenSelf> createState() => _PaymentScreenSelfState();
}

class _PaymentScreenSelfState extends State<PaymentScreenSelf> {
  int select=0;

  List<String> icon=[SelfSvg().upiIcon,SelfSvg().scanQrIcon,SelfSvg().cardIcon];

  List<String> head=["UPI payment","Scan QR code","Card payment"];
  String? finalDate;

  final TextEditingController dateController = TextEditingController();

  final TextEditingController monthController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPalette.checkoutBackground,
      appBar: AppBar(
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0.5,
        leading: Icon(
          Icons.arrow_back_ios,
          color: ColorPalette.black,
        ),
        title: Text(
          "Payment",
          style: TextStyle(
            color: ColorPalette.black,
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
                  width: 382,
                  // height: 72,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount payable",
                            style: GoogleFonts.inter(
                              color: Color(0xff0a0a0a),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.string(SelfSvg().pointIcon),
                              SizedBox(width: 5,),
                              Text(
                                "6 Products",
                                style: GoogleFonts.inter(
                                  color: ColorPalette.subtextGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Text(
                        "AED 250.50",
                        style: GoogleFonts.inter(
                          color: Color(0xff0a0a0a),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  "Choose your payment method",
                  style: GoogleFonts.inter(
                    color: ColorPalette.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      // onTap: (){
                        onTap:onTapListTile(index,context),
                      // setState(() {
                      //   select=index;
                      // });

                    // },
                      child: Container(
                  width: 382,
                  // height: 93,
                  padding: EdgeInsets.all(16),
                  decoration: select==index? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0x7feb3a6c), width: 1.50, ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Color(0x19ff487c),
                  ):BoxDecoration(
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
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Color(0x19ff487c),
                              ),
                              child: SvgPicture.string(icon[index]),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  head[index],
                                  style: GoogleFonts.inter(
                                    color: Color(0xff0a0a0a),
                                    fontSize: w/22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "Can carry upto 2 big products",
                                  style: TextStyle(
                                    color: Color(0x99151522),
                                    fontSize: 13,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                ),
                    ), separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: 3),
                SizedBox(height: 20,),
                Container(
                  width: w,
                  child:   SvgPicture.string(SelfSvg().paymentImage),
                ),
                SizedBox(height: 40 ),
                SelfCheckoutBtn(label: "Continue",onTap: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: SelfSuccessScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },),

              ],
            ),
          ),
        ),
      ),
    );
  }
  VoidCallback onTapListTile(int i, BuildContext context) {
    // String email = Variables.emailfield;
    VoidCallback onTap;
    onTap = () {};
    switch (i) {
      case 0:
        onTap = () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: CallCenterRegister(),
          //   withNavBar: true,
          //   // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation:
          //   PageTransitionAnimation.fade,
          // );

        };
        break;

      case 1:
        onTap = () {

          //CallCenterHistory
        };
        break;
      case 2:
        onTap = () {
          _showModalBottomSheet();

          // //  DeliveryHub
        };
        break;



    }
    return onTap;
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
              return ScrollConfiguration(behavior: NoGlow(), child:
                SingleChildScrollView(
                child: Container(
                  // height: 350,
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Add  new card",
                        style: GoogleFonts.inter(
                          color: Color(0xff1b1b1f),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormReusable(
                        label: "Name on card",
                        hint: "eg.afthabu rahman",
                      ),
                      SizedBox(height: 10,),
                      TextFormReusable(
                        label: "Card number",
                        hint: "eg.123456789",
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               "Expiry date",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 0),
                                  height: 40,
                                  width: w/2.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Color(0x190a0a0a), width: 1, ),
                                    color: Color(0x7fffffff),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: DateInputField(
                                    onChangeDate: (val) {
                                      if (int.parse(val) >= 31) {
                                        dateController.text = "31";
                                      }

                                      setState(() {});
                                    },
                                    onChangeMonth: (val) {
                                      if (int.parse(val) >= 12) {
                                        monthController.text = "12";
                                      }

                                      setState(() {});
                                    },
                                    dateController: dateController,
                                    monthController: monthController,
                                    yearController: yearController,
                                    keyboardType: TextInputType.phone,
                                    dateTitle: "DD",
                                    monthTitle: "MM",
                                    yearTitle: "YYYY",
                                  )

                              ),
                            ],
                          ),
                          Container(
                            width: w/2.3,
                            child: TextFormReusable(
                              label: "CVV",
                              hint: "986",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          SvgPicture.string(SelfSvg().checkboxIcon),
                          SizedBox(width: 5,),
                          Text(
                            "Save card details",
                            style: GoogleFonts.inter(
                              color: ColorPalette.black,
                              fontSize: w/26,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 40,),
                      SelfCheckoutBtn(),
                    ],
                  ),
                ),
              ));
            },
          );
        });
  }
}
