import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../seller_app/new_list_tab/textfield_tab.dart';
import '../product_svg.dart';
import '../widget/dropdown_textcard.dart';
import '../widget/select_card.dart';
import 'create_varient_three.dart';

class CreatevarientTwo extends StatelessWidget {
  const CreatevarientTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
                  SvgPicture.string(ProductSvg().varientTwoIcon),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "PRICE DETAILS",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Base Price",
                          hint: "Eg.123 ",
                        ),
                      ),
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Base Cost",
                          hint: "Eg.123 ",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Landing Cost",
                          hint: "Eg.123 ",
                        ),
                      ),
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Actual Cost",
                          hint: "Eg.123 ",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Unit Cost",
                          hint: "Eg.123 ",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "ADDITIONAL INFORMATIONS",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Net Weight",
                          hint: "Eg.123 ",
                        ),
                      ),
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Safety Stock",
                          hint: "Eg.123 ",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Min.Order Limit",
                          hint: "Eg.123 ",
                        ),
                      ),
                      Container(
                        width: w / 2.3,
                        child: TextFieldTab(
                          label: "Max.Order Limit",
                          hint: "Eg.123 ",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    label: "Sibling ID",
                    hint: "Eg.123 ",
                  ),SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    label: "Gross Weight",
                    hint: "Eg.123 ",
                  ),SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    label: "Return Type",
                    hint: "Eg.123 ",
                  ),SizedBox(
                    height: 16,
                  ),
                  TextFieldTab(
                    label: "Return Days",
                    hint: "Eg.123 ",
                  ),
                  SizedBox(height: 16,),
                  DropDownTextCard(),
                  SizedBox(height: 16,),
                  DropDownTextCard(label: "Height"),
                  SizedBox(height: 16,),
                  DropDownTextCard(label: "Weight"),
                  SizedBox(height: 16,),
                  DropDownTextCard(label: "Width"),

                  SizedBox(height: 16,),
                  DropDownTextCard(label: "Length"),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectCard(label: "Sales Block"),
                      SelectCard(label: "Stock Warning"),
                    ],
                  ),  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SelectCard(label: "Purchase Block"),
                      SelectCard(label: "Item Image"),
                    ],
                  ),
                  SizedBox(height: 16,),
                  SelectCard(label: "Is_Active",),
                  SizedBox(height: 50),

                  GradientButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreatevarientThree(),
                          withNavBar: true,
                          // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      gradient:  LinearGradient(
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
                  SizedBox(height: 30,)
                ],
              ),
            ),
          )),
    );
  }
}
