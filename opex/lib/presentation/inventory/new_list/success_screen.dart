import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/product_hub/product_hub_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../seller_app/seller_svg.dart';

class InventorySuccessScreen extends StatelessWidget {
  const InventorySuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // Navigation bar
              statusBarColor: Color(0xff3aba6f), // Status bar
            ),
          )),
      body: Container(
        height: h,
        child: Stack(
          children: [
            Container(
              width: w,
              height: h / 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff3aba6f), Color(0xff1e9a51)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.string(SellerSvg().tickIcon),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Item Submitted successfully !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w / 22,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: h / 4.8,
                child: Container(
                  width: w, padding: EdgeInsets.all(16),
                  // height: h,
                  //  color: Colors.yellow,
                  child: Column(
                    children: [
                      ProductHubCard(
                        isVerified: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ",
                        style: TextStyle(
                          color: Color(0xff666161),
                          fontSize: w / 26,
                        ),
                      ),
                      SizedBox(
                        height: h / 4,
                      ),
                      GradientButton(
                          color: Color(0xfffe5762),
                          onPressed: () {},
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xfffe5762), Color(0xfffe5762)]),
                          child: Text(
                            "Save and Continue",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      GradientButton(
                          color: Color(0xffe6ecf0),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Leave this page ?",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff151522),
                                            fontSize: w/20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16,),
                                        Text(
                                          "While leaving changes you made may not be saved",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xff6d6d6d),
                                            fontSize: w/27,
                                          ),
                                        ),


                                        SizedBox(height: 16,),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  width: w / 3.5,
                                                  padding:
                                                  EdgeInsets.symmetric(vertical: 10),

                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(color: Color(0xffed4e4e), width: 1, ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Leave Page",
                                                    style: TextStyle(
                                                      color: ColorPalette.primary,
                                                      fontSize: w/22,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              GestureDetector(
                                                onTap: () {

                                                },
                                                child: Container(
                                                    width: w / 3.5,
                                                    padding:
                                                    EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Color(0xffed4e4e),
                                                    ),

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        // SvgPicture.string(PurchaseSvg().approveIcon),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Stay Here",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: w/22,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ])
                                      ],
                                    ),
                                  );
                                });
                          },
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Colors.white,
                                // Color(0xfffe5762)
                              ]),
                          child: Text(
                            "Back to Home",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: ColorPalette.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
