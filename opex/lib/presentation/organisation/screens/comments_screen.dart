import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../contract_app/comments_view.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Comments",
          isAction: false,
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
                Text(
                  "Recent Chat",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w / 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CommentsView(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );

                      },
                      child: Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: ColorPalette.inactiveGrey,
                                    radius: 20,
                                  ),
                                  Positioned(
                                    right: 0,
                                      child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff079b15),
                                          ),
                                        ),
                                  ))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: w/1.3,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Afthabu Rahman",
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff151522),
                                            fontSize: w/22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "9:04 AM",
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff6d6d6d),
                                            fontSize: w/26,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 3,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "You: Amet minim mollit  dent...",
                                          style: TextStyle(
                                            color: Color(0xff151522),
                                            fontSize: 16,
                                          ),
                                        ),
                                       index<2? Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Color(0xfffe5762),
                                          ),
                                          alignment: Alignment.center,
                                          child:  Text(
                                            "15",
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ):Container()
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 16,
                        ),
                    itemCount: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
