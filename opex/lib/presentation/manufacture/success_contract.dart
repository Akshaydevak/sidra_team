import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/manufacture/manufacture_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class SuccessContract extends StatelessWidget {
  const SuccessContract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor:Color(0xff3ABA6F), // Status bar
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: h/4,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  width: w,
                  color: Color(0xff3ABA6F),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.string(ManufactureSvg().successIcon),
                      SizedBox(height: 10,),
                      Text(
                        "You have successfully signed the contract!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\nAliqua id fugiat nostrud irure ex duis ea quis id qu is ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. \n",
                        style: TextStyle(
                          color: Color(0xff1b1b1f),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "CONTRACT ID",
                        style: TextStyle(
                          color: ColorPalette.subtextGrey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "130215421",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(
                        "SELLER NAME",
                        style: TextStyle(
                          color: ColorPalette.subtextGrey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Lorem ipsum seller name",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
