import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/seller_app/seller_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/title_app_bar.dart';
import '../task_operation/task_svg.dart';
import 'new_outlet.dart';

class Outlet extends StatelessWidget {
   Outlet({Key? key}) : super(key: key);
List<String> outletName=['Pharmacy','Fashion','Fresh Market','Hypermarket','Pharmacy','Fashion','Fashion','Health and Beauty','Fresh Market'];
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: TitleAppBar(label: "New Outlet"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Category",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/20,

                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam.",
                  style: TextStyle(
                    color: Color(0xff1b1b1f),
                    fontSize: w/24,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10,),
                GridView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: outletName.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1.7 / 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 8),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: (){

                        },
                        // onTap: onTapListTile(i, context),
                        child: Container(
                          width: 121,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               SvgPicture.string(SellerSvg().pharmacyIcon),
                              const SizedBox(
                                height: 5,
                              ),
                               Text(
                                outletName[i],
                                style: TextStyle(
                                  color: Color(0xff121113),
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 60,),
                GradientButton(
                    color:Color(0xfffe5762),
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: NewOutlet(),
                        withNavBar: true,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                        PageTransitionAnimation.fade,
                      );
                    },
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfffe5762),
                          Color(0xfffe5762)
                        ]
                    ),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
