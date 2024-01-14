import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'evaluation_card.dart';

class EvaluatioReadPageCeo extends StatefulWidget {
  const EvaluatioReadPageCeo({super.key});

  @override
  State<EvaluatioReadPageCeo> createState() => _EvaluatioReadPageCeoState();
}

class _EvaluatioReadPageCeoState extends State<EvaluatioReadPageCeo> {
  int selectIndex = 0;
  void onselect(int index) {
    setState(() {
      selectIndex = index;
    });
  }
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
          label: "John Wick",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                UserReviewCard(
                  onTap: () {
                    // _showModalBottomSheetNew(context,false);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: w1,
                  // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Color(0xff2871AF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Text(
                        "YOUR SCORE",
                        style: GoogleFonts.roboto(
                            fontSize: w / 22, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "90/100",
                        style: GoogleFonts.roboto(
                            fontSize: w / 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Last evaluated on 21-Jan-2023",
                        style: GoogleFonts.roboto(
                            fontSize: w / 28,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff6D6D6D)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w1 / 3.5,
                        height: h / 7,
                        decoration: BoxDecoration(
                            color: Color(0xff3284CA).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Code Wise\nEvaluation",
                              style: GoogleFonts.roboto(
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "30/40",
                                style: GoogleFonts.roboto(
                                    fontSize: w / 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: w1 / 3.5,
                        height: h / 7,
                        decoration: BoxDecoration(
                            color: Color(0xffE599C6).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Communication",
                              style: GoogleFonts.roboto(
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "20/30",
                                style: GoogleFonts.roboto(
                                    fontSize: w / 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: w1 / 3.5,
                        height: h / 7,
                        decoration: BoxDecoration(
                            color: Color(0xff99E5C0).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Behavioural\Pattern",
                              style: GoogleFonts.roboto(
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "20/30",
                                style: GoogleFonts.roboto(
                                    fontSize: w / 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE6ECF0)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Code wise Evaluation",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500, fontSize: w / 22),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffE6ECF0)),
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                SvgPicture.string(
                                  TaskSvg().starSvg,
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "23/40 Points",
                                  style: GoogleFonts.roboto(
                                      fontSize: w / 24,
                                      color: Color(0xffFF7E07),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 100,
                        child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: new BoxDecoration(
                                      color: ColorPalette.fillGrey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.string(TaskSvg().starSvg),
                                        Text("23/40",
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontSize: w/28
                                        ),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Text("Task Completion",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      fontSize: w/26,
                                      fontWeight: FontWeight.w500
                                    ),),
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => Container(
                              width: 5,
                            ),
                            itemCount: 5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),

                ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  ExaminationCard(

                      );
                    },
                    separatorBuilder: (context, index) =>
                        Container(height: 5),
                    itemCount: 3),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExaminationCard extends StatelessWidget {
  const ExaminationCard({super.key});

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: new BoxDecoration(
          color: ColorPalette.fillGrey,
          borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorPalette.borderGrey)
      ),
      width: w1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1.Timeliness",
                style: GoogleFonts.roboto(
                  fontSize: w/26,
                  fontWeight: FontWeight.w500
                ),),
                Text("23/40 Points",
                  style: GoogleFonts.roboto(
                      color: Color(0xffFF7E07),
                      fontWeight: FontWeight.w500
                  ),),
              ],
            ),
          ),
          Divider(height: 1,color: ColorPalette.borderGrey,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Evaluated By :"),
                Text("Afthab rahman",
                  style: GoogleFonts.roboto(
                      fontSize: w/26,
                      fontWeight: FontWeight.w500
                  ),),
              ],
            ),
          ),
          Divider(height: 1,color: ColorPalette.borderGrey,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color(0xff2871AF).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                ),
                child: Text("MESSAGE",
                  style: GoogleFonts.roboto(
                      fontSize: w/32,
                      fontWeight: FontWeight.w500
                  ),)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Text("Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id es"),
          ),
        ],
      ),
    );
  }
}

