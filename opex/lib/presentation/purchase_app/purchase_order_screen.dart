import 'package:cluster/presentation/purchase_app/purchase_ordercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import '../order_app/order_svg.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Purchase Orders"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width:w/1.35,child: SearchCard()),
                  GestureDetector(
                    onTap: () {
                      // _showModalBottomSheet();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(14),
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
                      child: SvgPicture.string(OrderSvg().moreIcon),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16,),
              Text(
                "124 Orders",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              ListView.separated(
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => PurchaseOrdercard(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
