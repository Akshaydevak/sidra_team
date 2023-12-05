import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../create/create_svg.dart';
import 'evaluation_card.dart';
import 'evaluation_success_page.dart';

class EvaluationQuestionPageTwo extends StatefulWidget {
  EvaluationQuestionPageTwo({super.key});

  @override
  State<EvaluationQuestionPageTwo> createState() =>
      _EvaluationQuestionPageTwoState();
}

class _EvaluationQuestionPageTwoState extends State<EvaluationQuestionPageTwo> {
  PageController page = PageController(initialPage: 0);
  var pageChanged = 1;
  void onAddButtonTapped(int index) {
    // page.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
    // // or this to jump to it without animating
    // // page.jumpToPage(1);
  }

  int tappedTile = 0;

  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }

  List<String> questionCountList = [
    "Question 1 out of 5",
    "Question 2 out of 5",
    "Question 3 out of 5",
    "Question 4 out of 5",
    "Question 5 out of 5",
  ];
  List<String>? options = [
    'Apple',
    'Orange',
    'Grape',
    'Banana',
  ];

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
          label: "Jhon Wick",
          isAction: false,
          action: GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: EvaluationSuccessPAge(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              // onAddButtonTapped(tappedTile);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Next",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: ColorPalette.primary,
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: h / 1.8,
            child: PageView.builder(
              itemCount: 5,
              onPageChanged: (index) {
                setState(() {
                  pageChanged = index;
                });
                print(pageChanged);
              },
              controller: PageController(
                  initialPage: 0, keepPage: true, viewportFraction: 1),
              itemBuilder: (BuildContext context, int itemIndex) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: w1,
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            questionCountList[itemIndex],
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        child: Column(
                          children: [
                            Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ?"),
                            SizedBox(
                              height: 15,
                            ),
                            ListView.separated(
                              padding: const EdgeInsets.only(),
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: options!.length,
                              itemBuilder: (BuildContext context, int i) {
                                return GestureDetector(
                                  onTap: () {
                                    changeTappedTile(i);

                                    // Variable.taskType =
                                    //     taskTypeList[i].id ?? 0;
                                    // taskYype =
                                    //     taskTypeList[i].typeName ?? "";
                                    // Navigator.pop(context);
                                    // setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    color:
                                        // tappedTile==i
                                        //     ? ColorPalette.cardBackground
                                        //     :
                                        ColorPalette.white,
                                    child: Row(
                                      children: [
                                        tappedTile == i
                                            ? SvgPicture.string(
                                                HomeSvg().radioButtonActive)
                                            : SvgPicture.string(
                                                CreateSvg().radioInActiveButton,
                                                height: 20,
                                                width: 20,
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          options?[i] ?? "",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: tappedTile == i
                                                ? FontWeight.w500
                                                : FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                  // margin: EdgeInsets.only(left: 16, right: 16),
                                  color: Color(0xffE6ECF0),
                                  height: 1,
                                  width: w,
                                );
                              },
                            ),
                            TextFormReusable(
                              hint: "drop your comments....",
                              maxLength: 5,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
