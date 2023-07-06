import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/presentation/product_hub/product_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/mandatory_textfield.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../seller_app/new_list_tab/textfield_tab.dart';
import 'create_varient_two.dart';

class CreateVarient extends StatelessWidget {
  const CreateVarient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Create Variant", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SvgPicture.string(ProductSvg().varientOneIcon),
          SizedBox(
            height: 16,
          ),
          Text(
            "GENERAL DETAILS",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: w / 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16,),
          TextFieldTab(
            label: "Variant Name",
            hint: "Eg. SEM",
          ),
          SizedBox(height: 16,),
          TextFieldTab(
            label: "Search Name",
            hint: "Eg. SEM",
          ), SizedBox(height: 16,),
          TextFieldTab(
            label: "Display Name",
            hint: "Eg. SEM",
          ),
          SizedBox(height: 16,),
          TextFormReusable(
            label: "Display Name",
            hint: "Eg. SEM",
            maxLength: 5,
          ), SizedBox(height: 16,),
          TextFormReusable(
            label: "Arabic Discription",
            hint: "Eg. SEM",
            maxLength: 5,
          ), SizedBox(height: 16,),
          TextFormReusable(
            label: "Additional Discription",
            hint: "Eg. SEM",
            maxLength: 5,
          ),
          SizedBox(height: 16,),
          RichText(
            text: TextSpan(
              text:
              'We are implementing some guidelines for your product image,  ',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 25,
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: 'View Guideline',
                  style: GoogleFonts.roboto(
                    color: ColorPalette.primary,
                    fontSize: w / 25,
                    fontWeight: FontWeight.w500,
                  ),
                )])),
                    SizedBox(height: 16,),
                    TextFieldTab(
                      label: "Barcode",
                      hint: "Eg. SEM",
                    ), SizedBox(height: 16,),
                    TextFieldTab(
                      label: "Old System Code",
                      hint: "Eg. SEM",
                    ),SizedBox(height: 16,),
                    TextFieldTab(
                      label: "Video URL",
                      hint: "Eg. SEM",
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w/2.3,
                          child: TextFieldTab(
                            label: "Re-Order Point",
                            hint: "",
                          ),
                        ),Container(
                          width: w/2.3,
                          child: TextFieldTab(
                            label: "Re-Order Quantity",
                            hint: "Eg.123 ",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    TextFieldTab(
                      label: "Sales UOM",
                      hint: "Eg. SEM",
                      child: Text(
                        "Add New",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.primary,
                          fontSize: w/24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ),SizedBox(height: 16,),
                    TextFieldTab(
                      label: "Purchase UOM",
                      hint: "Eg. SEM",
                      child: Text(
                        "Add New",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.primary,
                          fontSize: w/24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),SizedBox(height: 16,),
                    TextFieldTab(
                      label: "Linked Item",
                      hint: "Eg. SEM",

                    ),
                    SizedBox(height: 30,),
                    GradientButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: CreatevarientTwo(),
                            withNavBar: true,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.fade,
                          );
                          //OtpScreen
                        },
                        gradient: const LinearGradient(
                          colors: [
                            ColorPalette.primary, ColorPalette.primary
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color:  Colors.transparent,
                        child: Text(
                          "Save and  Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
