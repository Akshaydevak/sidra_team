import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../order_app/order_svg.dart';
import '../seller_svg.dart';
import 'other_card.dart';

class OtherTab extends StatefulWidget {
  OtherTab({Key? key}) : super(key: key);

  @override
  State<OtherTab> createState() => _OtherTabState();
}

class _OtherTabState extends State<OtherTab> {
bool isGift=false;
bool isNoLogistic=false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Variant Weight",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.string(SellerSvg().validationIcon)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [OtherCard(), OtherCard()],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Variant Volume",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.string(SellerSvg().validationIcon)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              OtherCard(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Variant Height",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.string(SellerSvg().validationIcon)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              OtherCard(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xffE6ECF0),
          thickness: 1.1,
        ),
        SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState((
                          ){
                        isGift =! isGift;

                      });
                    },
                      child: isGift?Container(
                        padding: EdgeInsets.all(10),
                          child: SvgPicture.string(OrderSvg().checkBoxActiveIcon)):SvgPicture.string(OrderSvg().checkBoxIcon)),
                  Container(
                    width: w/1.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gift option available",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w/20,
                          ),
                        ),
                        const Text(
                          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ",
                          style: TextStyle(
                            color: Color(0xff666161),
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState((
                          ){
                        isGift =! isGift;

                      });
                    },
                      child: isGift?Container(
                        padding: EdgeInsets.all(10),
                          child: SvgPicture.string(OrderSvg().checkBoxActiveIcon)):SvgPicture.string(OrderSvg().checkBoxIcon)),
                  Container(
                    width: w/1.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wrap option available",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w/20,
                          ),
                        ),
                        const Text(
                          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ",
                          style: TextStyle(
                            color: Color(0xff666161),
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
        const Divider(
          color: Color(0xffE6ECF0),
          thickness: 1.1,
        ),
        SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose Logistic Details",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/22,

                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {

                        isNoLogistic=true;
                      });
                    },
                      child:isNoLogistic?  SvgPicture.string(HomeSvg().radioButtonActive): SvgPicture.string(HomeSvg().radioInActive)),
                  SizedBox(width: 10,),
                  Text(
                    "Ship by myself",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w/20,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {

                        isNoLogistic=false;
                      });
                    },
                      child:isNoLogistic?  SvgPicture.string(HomeSvg().radioInActive): SvgPicture.string(HomeSvg().radioButtonActive)),
                  SizedBox(width: 10,),
                  Container(
                    width: w/1.3,
                    child: Text(
                      "I dont have any logistic option. So i need cluster logistic option ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: w/20,
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}
