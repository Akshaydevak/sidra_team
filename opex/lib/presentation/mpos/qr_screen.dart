import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../order_app/orderapp_card.dart';
import 'mpos_svg.dart';
import 'order_success_screen.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                ClusterCard(
                    child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0x7fe6ecf0),
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
                      child: Image.asset("asset/cardicon.png"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Afthabu Rahman PP",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "****  ****  **** ",
                              style: GoogleFonts.roboto(
                                color: Color(0xff1b1b1f),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "5326",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffe6ecf0),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 60,
                        offset: Offset(3, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                          child: SvgPicture.string(MposSvg().barcode)),
                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new OrderSuccessScreen()));
                          // PersistentNavBarNavigator.pushNewScreen(
                          //   context,
                          //   screen: OrderSuccessScreen(),
                          //   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation: PageTransitionAnimation.fade,
                          // );
                        },
                          child:
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Image.asset("asset/img_15.png"),
                      )),
                      Divider(),
                      Container(
                        width: w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 16),
                        child: Text(
                          "AED 125.50",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Scan and Pay",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Color(0xff6d6d6d),
                    fontSize: w / 25,
                    fontWeight: FontWeight.w600,
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
