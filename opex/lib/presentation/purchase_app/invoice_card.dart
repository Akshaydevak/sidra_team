import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../order_app/order_svg.dart';

class InvoiceCard extends StatefulWidget {
  bool isSelect,selectAll;
   InvoiceCard({Key? key,this.isSelect=false,this.selectAll=false}) : super(key: key);

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.isSelect||widget.selectAll
                  ? Container(
                padding: EdgeInsets.all(10),
                child: SvgPicture.string(
                    OrderSvg().checkBoxActiveIcon),
              )
                  : SvgPicture.string(OrderSvg().checkBoxIcon),
              Text(
                "Invoice",
                style: GoogleFonts.poppins(
                  color: Color(0xff1b1b1f),
                  fontSize: w / 26,
                  fontWeight: FontWeight.w500,
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Musafir Pure Loium Nahjtu Sodi\num Nasafir Pu..",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "AED 420.50",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
