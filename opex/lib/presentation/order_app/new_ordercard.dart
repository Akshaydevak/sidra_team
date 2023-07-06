import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../mpos/mpos_order_view.dart';
import 'order_svg.dart';
import 'screens/order_view.dart';

class NewOrderCard extends StatelessWidget {
  final String? price;
  final int? lineCount;
  final VoidCallback? onTap;
  final String? orderId;
  final String? paymentType;
  final String? created;
  final String? status;
  bool isSelect,isMpos;
  bool selected;
  final VoidCallback? onTapCheckBox;
  NewOrderCard({Key? key,this.isSelect=false,  this.onTapCheckBox,this.selected=false,this.isMpos=false, this.orderId, this.created, this.status, this.onTap, this.lineCount, this.price, this.paymentType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap:onTap,
      //  (){
      //   isMpos?  PersistentNavBarNavigator.pushNewScreen(
      //     context,
      //     screen: MposOrderView(),
      //     withNavBar: true, // OPTIONAL VALUE. True by default.
      //     pageTransitionAnimation: PageTransitionAnimation.fade,
      // ):PersistentNavBarNavigator.pushNewScreen(
      //   context,
      //   screen: OrderView(),
      //   withNavBar: true, // OPTIONAL VALUE. True by default.
      //   pageTransitionAnimation: PageTransitionAnimation.fade,
      // );
      // },
      child: Container(
          width: w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(10),
            ),
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
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // isMpos==false?  InkWell(
                      //     onTap: onTapCheckBox,
                      //     child: isSelect||selected?Container(
                      //         padding: EdgeInsets.all(10),
                      //         child: SvgPicture.string(
                      //             OrderSvg().checkBoxActiveIcon)): SvgPicture.string(OrderSvg().checkBoxIcon),
                      //   ):Text(""),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Order ",
                                style: TextStyle(
                                  fontSize: w/22,
                                ),
                              ),
                              Text(
                                orderId.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: w/22,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Ordered on ${created?.split("T")[0]}",
                            style: GoogleFonts.roboto(
                              color: Color(0xff7d7d7d),
                              fontSize: w/25,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  isMpos?Container(): Container(
                    width: 67,
                    height: 22.33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0xfffff3d4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      status??"",
                      style: TextStyle(
                        color: Color(0xffe7ad18),
                        fontSize: w/25,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: w,
              padding: EdgeInsets.all(16),
              decoration: isSelect? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0x33fe5762), width: 1, ),
                color: Color(0x0cfe5762),
              ):BoxDecoration(
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
                color: Color(0xfff7f7f7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$lineCount Items  |  AED $price  |  $paymentType",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  isMpos?Container():  Row(
                    children: [
                      Text(
                        "Invoice",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/22,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(width: 10,),
                      SvgPicture.string(OrderSvg().downloadIcon)
                    ],
                  )
                ],
              ),
            )
          ])),
    );
  }
}