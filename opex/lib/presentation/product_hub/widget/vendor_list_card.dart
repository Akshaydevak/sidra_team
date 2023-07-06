import 'package:cluster/presentation/product_hub/product_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
class VendorListCard extends StatefulWidget {

   VendorListCard({Key? key}) : super(key: key);

  @override
  State<VendorListCard> createState() => _VendorListCardState();
}

class _VendorListCardState extends State<VendorListCard> {
  bool isActive=false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding:EdgeInsets.symmetric(horizontal: 4,vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: isActive?CrossAxisAlignment.start:CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    isActive=!isActive;
                  });
                },
                  child: SvgPicture.string(isActive?ProductSvg().minusIcon:ProductSvg().plusIcon)),
              SizedBox(width: 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    children: [
                      Container(
                        width: w/3,
                        child: Text(
                          "Vendor name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w/25,
                          ),
                        ),
                      ),

                    isActive?  Container(
                        width: w/3,
                        height: 41,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                          color: Colors.white,
                        ),
                      ):Container()
                    ],
                  ),
                 isActive? Column(
                    children: [
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: w/3,
                            child: Text(
                              "Vendor Id",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w/25,
                              ),
                            ),
                          ),

                          Container(
                            width: w/3,
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: w/3,
                            child: Text(
                              "Vendor Ref. code",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w/25,
                              ),
                            ),
                          ),
                          Container(
                            width: w/3,
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ):Container(),

                ],
              ),

            ],
          ),

        ],
      ),
    );
  }
}

