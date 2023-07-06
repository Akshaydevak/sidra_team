import 'package:cluster/presentation/mpos/mpos_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../core/color_palatte.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
          width: w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.string(MposSvg().creditSuccessIcon),
              Text(
                "Amount added to your\ncredit account successfully!",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/22,

                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: w,


                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0c000000),
                      blurRadius: 10,
                      offset: Offset(3, 1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(radius: 30,),
                            SizedBox(height: 10,),
                            Text(
                              "Sbin Sreenivas",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                                "Thondayadu, Kozhikode",
                                style: TextStyle(
                                  color: Color(0xff666161),
                                  fontSize: w/25,
                                ),
                              ),
                            SizedBox(height: 30,),
                            Text(
                              "AED 1254.25",
                              style: GoogleFonts.roboto(
                                color: Color(0xfffe5762),
                                fontSize: 30,

                                fontWeight: FontWeight.w600,
                              ),
                            ),



                          ],
                        )),
                    Divider(
                      color: Color(0xffE6ECF0),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Credit",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w/22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "AED 2355.50",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w/22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff888686),
                  fontSize: w/25,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Back to Home",
                style: GoogleFonts.roboto(
                  color: Color(0xfffe5762),
                  fontSize: w/22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40,),
              GradientButton(
                  color: ColorPalette.primary,
                  onPressed: () {
                    // PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: InvoiceScreen(),
                    //   withNavBar: false, // OPTIONAL VALUE. True by default.
                    //   pageTransitionAnimation: PageTransitionAnimation.fade,
                    // );
                    //  PickAndPack
                  },
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [
                        ColorPalette.primary,
                        ColorPalette.primary
                      ]),
                  child: Text(
                    "View Invoice",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ],
          )),
    );
  }
}
