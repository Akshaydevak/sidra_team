import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/home_svg.dart';
import 'new_base_uom.dart';

class BaseUomScreen extends StatefulWidget {
  const BaseUomScreen({Key? key}) : super(key: key);

  @override
  State<BaseUomScreen> createState() => _BaseUomScreenState();
}

class _BaseUomScreenState extends State<BaseUomScreen> {
  int ?select;
  void onSelect(index){

    setState(() {
      select=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Base UOM", isAction: false,
          // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You may have able to add a single product into multiple segments ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff666161),
                  fontSize: w / 26,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SearchCard(),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total 156 Lists",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: NewBaseUOM(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    child: Text(
                      "ADD NEW",
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  // itemBuilder: (context, index) {
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amet minim mollit non",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w/22,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                onSelect(index);
                              },
                              child: SvgPicture.string(select==index
                                  ? HomeSvg().radioButtonActive
                                  : HomeSvg().radioInActive),
                            ),
                          ],
                        ),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 5),
              SizedBox(height: 30,),
              GradientButton(
                  onPressed: () {

                  },
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xfffe5762),
                      Color(0xfffe5762),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: const Color(0xfffe5762),
                  child: Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
