import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'designation_create_page.dart';

class HeirarchyPageTwo extends StatefulWidget {
  const HeirarchyPageTwo({super.key});

  @override
  State<HeirarchyPageTwo> createState() => _HeirarchyPageTwoState();
}

class _HeirarchyPageTwoState extends State<HeirarchyPageTwo> {
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Level 1",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: h/6,),
                  Center(child: Container(
                    width: w/1.2,
                    child: Text("Currently, there are no specified designations listed here. Tap and create one",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: ColorPalette.inactiveGrey,
                      fontSize: w/28
                    ),),
                  )),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: CreateDesignationOrganisation(),
                        withNavBar: true,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    child: Container(
                      width: w1/2.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: ColorPalette.primary
                      ),
                      child:
                        Center(child: Text("New designation",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                           fontWeight: FontWeight.w500
                        ),))
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
