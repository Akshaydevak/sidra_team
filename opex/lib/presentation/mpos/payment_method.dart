import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:cluster/presentation/mpos/qr_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'credit_screen.dart';
import 'order_success_screen.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
         child: SafeArea(
           child: Column(
             children: [
               Container(
                 padding: EdgeInsets.all(16),
                 child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 16,),
                      Text(
                        "Payment Method",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                 ),
               ),
               Container(
                 width: w,
                 height: 1.50,
                 decoration: BoxDecoration(
                   border: Border.all(
                     color: Color(0xb2e6e6e6),
                     width: 0.50,
                   ),
                 ),
               ),

             ],
           ),
         ),
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(16),
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose a Payment Method",
              style: GoogleFonts.roboto(
                color: Color(0xff151522),
                fontSize: w/20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Hey! Please note that Sidracart or its emplyee will never ask you to disclose.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: CreditScreen(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  //
                  },
                  child: Container(
                    width: w/3.5,
                    height: 157,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xfffff6f7),
                          ),
                          child: SvgPicture.string(MposSvg().creditIcon),
                        ),
                        SizedBox(height: 16,),
                        Text(
                          "Credit User",
                          style: GoogleFonts.roboto(
                            color: Color(0xff151522),
                            fontSize: 16,

                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),  GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: QrScreen(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  //  QrScreen
                  },
                  child: Container(
                    width: w/3.5,
                    height: 157,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xfffff6f7),
                          ),
                          child: SvgPicture.string(MposSvg().qrIcon),
                        ),
                        SizedBox(height: 16,),
                        Text(
                          "Generate QR Code",
                          style: GoogleFonts.roboto(
                            color: Color(0xff151522),
                            fontSize: 16,

                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),  GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 10),
                                    child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: OrderSuccessScreen(),
                                          withNavBar: true, // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation: PageTransitionAnimation.fade,
                                        );
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorPalette.cardBackground,
                                        ),
                                        child: SvgPicture.string(MposSvg().handIcon),
                                      ),
                                    ),
                                    SizedBox(width: 30,),
                                    Text(
                                      "CASH ON HAND",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )),
                                Divider(indent: 16,),
                                GestureDetector(
                                  onTap: (){
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: OrderSuccessScreen(),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorPalette.cardBackground,
                                          ),
                                          child: SvgPicture.string(MposSvg().cardIcon),
                                        ),
                                        SizedBox(width: 30,),
                                        Text(
                                          "CASH ON CARD",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: w/3.5,
                    height: 157,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xfffff6f7),
                          ),
                          child: SvgPicture.string(MposSvg().cardIcon),
                        ),
                        SizedBox(height: 16,),
                        Text(
                          "Pay on Delivery",
                          style: GoogleFonts.roboto(
                            color: Color(0xff151522),
                            fontSize: 16,

                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
