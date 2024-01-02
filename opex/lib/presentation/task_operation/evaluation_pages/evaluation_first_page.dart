import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'evaluation_card.dart';
import 'evaluation_questions_page_two.dart';


class EvaluationFirstPage extends StatelessWidget {
  const EvaluationFirstPage({super.key});

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
          label: "Evaluation",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: EvaluationQuestionPageTwo(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                    child: UserCardEvaluationTLs(isStart: true)),
                SizedBox(height: 25,),
                Center(
                  child: Text("Flutter Developer",
                  style: GoogleFonts.roboto(
                    fontSize: w/24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),),
                ),
                SizedBox(height: 20,),
                Text("Title",
                style: GoogleFonts.roboto(
                  fontSize: w/30,
                  color: Color(0xff555555)
                ),),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ?",
                style: GoogleFonts.roboto(
                  fontSize: w/26,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 15,),
                Text("Review within",
                  style: GoogleFonts.roboto(
                      fontSize: w/30,
                      color: Color(0xff555555)
                  ),),
                Text("2 Weeks",
                  style: GoogleFonts.roboto(
                      fontSize: w/26,
                      fontWeight: FontWeight.w500
                  ),),
                SizedBox(height: 15,),
                Text("Notes",
                  style: GoogleFonts.roboto(
                      fontSize: w/30,
                      color: Color(0xff555555)
                  ),),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ?Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ?",
                  style: GoogleFonts.roboto(
                      fontSize: w/26,
                      fontWeight: FontWeight.w500
                  ),),
                SizedBox(height: 15,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
