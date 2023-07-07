import 'package:cluster/presentation/promotion_app/models_promotion/discount_models/model_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../task_operation/task_svg.dart';
class DiscountCard extends StatelessWidget {
  final DiscountList? listDiscount;
  const DiscountCard({Key? key, this.listDiscount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,

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
      child:
      Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [

       Container(
         padding: EdgeInsets.all(16),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xfff0f1f2),
              ),
              child: Image.network(listDiscount?.image??"",fit: BoxFit.cover,),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listDiscount?.title??"",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  listDiscount?.discountCode??"",
                  style: TextStyle(
                    color: Color(0xff9b9b9b),
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: w/2,
                  child: Text(
                    "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),


          ],
      ),
       ),
          Positioned(
            top: 0,
            right: 0,
            child:  PopupMenuButton(
            icon: Icon(Icons.more_vert),
            //don't specify icon if you want 3 dot menu
            color: Colors.white,
            elevation: 2,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            itemBuilder: (context) => [
              PopupMenuItem(
                  padding: const EdgeInsets.all(0),
                  value: 'a',
                  enabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(

                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                              color: ColorPalette.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ), const Divider(indent: 30,),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Remove from list',
                          style: GoogleFonts.poppins(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ))

            ],
            onSelected: (value) {},
          ),)
    ])
    );
  }
}

class BuyMoreCard extends StatelessWidget {
  final BuyMoreList? buyMoreList;
  const BuyMoreCard({Key? key, this.buyMoreList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
        width: w,

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
        child:
        Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xfff0f1f2),
                      ),
                      child: Image.network(buyMoreList?.image??"",fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          buyMoreList?.title??"",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          buyMoreList?.buyMoreCode??"",
                          style: TextStyle(
                            color: Color(0xff9b9b9b),
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: w/2,
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child:  PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  //don't specify icon if you want 3 dot menu
                  color: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        value: 'a',
                        enabled: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(

                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Edit',
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ), const Divider(indent: 30,),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Remove from list',
                                style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ))

                  ],
                  onSelected: (value) {},
                ),)
            ])
    );
  }
}

class CouponCard extends StatelessWidget {
  final CouponList? couponList;
  const CouponCard({Key? key, this.couponList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
        width: w,

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
        child:
        Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xfff0f1f2),
                      ),
                      child: Image.network(couponList?.image??"",fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          couponList?.name??"",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          couponList?.couponCode??"",
                          style: TextStyle(
                            color: Color(0xff9b9b9b),
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: w/2,
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child:  PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  //don't specify icon if you want 3 dot menu
                  color: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        value: 'a',
                        enabled: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(

                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Edit',
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ), const Divider(indent: 30,),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Remove from list',
                                style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ))

                  ],
                  onSelected: (value) {},
                ),)
            ])
    );
  }
}


class NegotiationCard extends StatelessWidget {
  final NegotiationList? buyMoreList;
  const NegotiationCard({Key? key, this.buyMoreList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
        width: w,

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
        child:
        Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xfff0f1f2),
                      ),
                      child: Image.network(buyMoreList?.image??"",fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          buyMoreList?.name??"",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          buyMoreList?.negotiationCode??"",
                          style: TextStyle(
                            color: Color(0xff9b9b9b),
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: w/2,
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),


                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child:  PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  //don't specify icon if you want 3 dot menu
                  color: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        padding: const EdgeInsets.all(0),
                        value: 'a',
                        enabled: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(

                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Edit',
                                style: GoogleFonts.poppins(
                                    color: ColorPalette.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ), const Divider(indent: 30,),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Remove from list',
                                style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ))

                  ],
                  onSelected: (value) {},
                ),)
            ])
    );
  }
}