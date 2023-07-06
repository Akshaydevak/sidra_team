import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: ColorPalette.pink,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: ColorPalette.pink, // Status bar
        ),
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container( padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 10),
                  child: Text(
                    "INVOICE NUMBER: HJGVF6514GH",
                    style: GoogleFonts.jetBrainsMono(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Image.asset("asset/invoice.png"),
                // SizedBox(height: 30,),
                Container( 
                  padding: EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w/2.3,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffe8e8e8),
                        ),
                        alignment:Alignment.center,
                        child: Text(
                          "Share",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),Container(
                        width: w/2.3,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xffff467a), Color(0xff9c0e36)], ),
                        ),
                        alignment:Alignment.center,
                        child: Text(
                          "Download",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
