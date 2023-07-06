import 'package:cluster/presentation/purchase_app/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';

class InvoiceScreen extends StatefulWidget {

   InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool isRecieve=false;
  int ?select;
  void onSelect(index){
    setState(() {
      select=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Invoice", isAction: false),
      ),
      body: Stack(
        children: [
          Container(
            // height: h,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Invoice",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      // fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Check whether the actual product is recieved.",
                    style: TextStyle(
                      color: Color(0xff1b1b1f),
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isRecieve = !isRecieve;
                          });
                        },
                        onDoubleTap:() {
                          setState(() {
                            isRecieve= false;
                          });
                        },
                        child: isRecieve
                            ? Container(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.string(
                              OrderSvg().checkBoxActiveIcon),
                        )
                            : SvgPicture.string(OrderSvg().checkBoxIcon),
                      ),
                      Text(
                        "Select All",
                        style: GoogleFonts.poppins(
                          color: Color(0xff1b1b1f),
                          fontSize: w / 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: true,
                    itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 5,),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        onSelect(index);
                      },
                      child: InvoiceCard(isSelect: select==index,selectAll:isRecieve ,)
                    ),)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16),
            width: w,
            // height: 92,
            color: Color(0xfff9f9f9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w/2.3,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xfffe5762),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Download",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ), Container(
                      width: w/2.3,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xfffe5762),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Share",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
          ))
        ],
      ),
    );
  }
}
