import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/no_glow.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../create/create_svg.dart';
import 'evaluation_card.dart';

class EvaluatioReadPageCeo extends StatefulWidget {
  const EvaluatioReadPageCeo({super.key});

  @override
  State<EvaluatioReadPageCeo> createState() => _EvaluatioReadPageCeoState();
}

class _EvaluatioReadPageCeoState extends State<EvaluatioReadPageCeo> {
  List<String>? typelist=[
    'Appreciated',
    'Promoted',
    'Salary Increment',
    'Reviewed',
    'Warning',
    'Performance Improvement Letter'
  ];
  int selectIndex = 0;
  void onselect(int index) {
    setState(() {
      selectIndex = index;
    });
  }
  int tappedTile=0;
  String actionName='';
  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }
  List<ShareModel> shareList=[
    ShareModel(
      color: "0xffECF4FB",
      svg: TaskSvg().teamsMsg,
      text: "Message"
    ),
    ShareModel(
        color: "0xffFAEBF4",
        svg: TaskSvg().callSvg,
        text: "Call"
    ),
    ShareModel(
        color: "0xffE1F8ED",
        svg: TaskSvg().emailSvg,
        text: "E-Mail"
    ),
    ShareModel(
        color: "0xffF8F4E1",
        svg: TaskSvg().videoCallSvg,
        text: "Teams"
    ),


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
                    _showModalBottomSheetAction(context, typelist ?? [],actionName);

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
  _showModalBottomSheetAction(
      BuildContext context, List<String> taskTypeList,String type) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          var h = MediaQuery.of(context).size.height;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Actions",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Container(
                          height: h / 2.8,
                          // color: Colors.lightBlueAccent,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.separated(
                                      padding: const EdgeInsets.only(),
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: taskTypeList.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return GestureDetector(
                                          onTap: () {
                                            changeTappedTile(i);
                                            actionName=taskTypeList[i];
                                            type=taskTypeList[i];

                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            color: type ==
                                                taskTypeList[i]
                                                ? ColorPalette.cardBackground
                                                : ColorPalette.white,
                                            child: Row(
                                              children: [
                                                type == taskTypeList[i]
                                                    ? SvgPicture.string(
                                                  HomeSvg()
                                                      .radioButtonActive,
                                                  // color: ColorPalette
                                                  //     .primary,
                                                )
                                                    : SvgPicture.string(
                                                    CreateSvg()
                                                        .radioInActiveButton),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  taskTypeList[i] ??
                                                      "",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: w / 24,
                                                    // fontWeight: FontWeight.w500,
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        type==""?Container():Divider(height: 1,color: ColorPalette.borderGrey,),
                        type==""?Container():Container(
                          width: w1,
                          // color: Colors.deepOrange,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text("Choose a medium for action",
                              style: GoogleFonts.roboto(
                                fontSize: w/28,
                                fontWeight: FontWeight.w500
                              ),),
                              SizedBox(height: 10,),
                              Row(
                                children: [

                                  Container(
                                    height: 80,
                                    child: ListView.separated(
                                        primary: true,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics: AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            ShareCard(
                                              color: shareList[index].color??"",
                                              text: shareList[index].text??"",
                                              svg: shareList[index].svg??"",
                                            ),
                                        separatorBuilder:
                                            (context, index) => Container(width: 5,),
                                        itemCount: shareList.length),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              // refresh();
                              Navigator.pop(context);
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
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

class ShareModel {
  final String? text;
  final String? color;
  final String? svg;
  ShareModel({this.svg, this.color, this.text});
}
