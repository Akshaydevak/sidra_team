import 'package:cluster/presentation/inventory/model/create_variant_model.dart';
import 'package:cluster/presentation/inventory/new_list_tab/other_tab.dart';
import 'package:cluster/presentation/product_hub/product_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
class InventoryVendorListCard extends StatefulWidget {
String name,id;
int index;
final TextEditingController? controller;
  InventoryVendorListCard({Key? key,required this.name,required this.id, this.controller,this.index=0}) : super(key: key);

  @override
  State<InventoryVendorListCard> createState() => _VendorListCardState();
}

class _VendorListCardState extends State<InventoryVendorListCard> {
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
                          isActive? "Vendor name":widget.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w/25,
                          ),
                        ),
                      ),

                    isActive?  Container(
                        width: w/3,
                        // height: 41,
                      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                          color: Colors.white,
                        ),
                      child: Text(widget.name,style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/23,
                      ),),
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
                            // height: 41,
                            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              color: Colors.white,
                            ),
                            child: Text(widget.id,style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w/23,
                            ),),
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
                           padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                              color: Colors.white,

                            ),
                            child: TextFormField(
                              controller: widget.controller,
                              onChanged: (val){
                                vendorDetails.setAll(widget.index,[VendorDetails(vendorReferenceCode: val)]);
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(contentPadding: EdgeInsets.zero,
                                border: InputBorder.none
                              ),
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

