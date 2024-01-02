import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_svg.dart';

class EvaluationUserView extends StatelessWidget {
  EvaluationUserView({super.key});

  String evaluationStatus =
      // 'Not Started';
      'On Progress';
  // 'Completed';
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
          label: "",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: CircleAvatar(
                  radius: 50,
                      backgroundImage: NetworkImage(
                          "https://www.loudegg.com/wp-content/uploads/2020/10/Mickey-Mouse.jpg"),
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Shifas Mehar N K",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: w / 24),
                ),
                Text(
                  "shifas@rgcdynamics.com",
                  style: GoogleFonts.roboto(fontSize: w / 26),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: w1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.string(
                        TaskSvg().chatmsgIcon,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Chat Now",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: w / 28,
                            color: ColorPalette.primary),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: w1,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                evaluationStatus == "Not Started"
                    ? Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: w1 / 3.5,
                                height: h / 7,
                                decoration: BoxDecoration(
                                    color: Color(0xff3284CA).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
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
                      )
                    : evaluationStatus == "On Progress"
                        ? Container(
                            child: Column(
                              children: [
                                evaluationStatus == "On Progress"?Container(
                                  width: w1,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Color(0xff2871AF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text("Evaluation on progress...")),
                                ):Container(
                                  width: w1,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  child: GradientButton(
                                      onPressed: () {
                                      },
                                      gradient: const LinearGradient(
                                        colors: [
                                          ColorPalette.primary,
                                          ColorPalette.primary,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      color: ColorPalette.primary,
                                      child: Text(
                                        "Submit evaluation",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w/24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Color(0xffE6ECF0))),
                                  child: ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      separatorBuilder:
                                          (BuildContext cxt, int i) {
                                        return const Divider(
                                          height: 1,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, top: 5, bottom: 5),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                      width: w1 / 1.8,
                                                      child: Text("CEO")),
                                                  Spacer(),
                                                  evaluationStatus=="Completed"?
                                                  Container(
                                                    child: Text(
                                                      "Completed",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: w / 30,
                                                        color: Colors.green
                                                      ),
                                                    ),
                                                  ):Row(
                                                    children: [
                                                      Text(
                                                        "Pending",
                                                        style: GoogleFonts.roboto(
                                                          fontSize: w / 30,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(Icons
                                                          .notifications_active,
                                                        size: 20,
                                                        color: ColorPalette.primary,)
                                                    ],
                                                  )

                                                ],
                                              )),
                                        );
                                      },
                                      itemCount: 5),
                                ),
                              ],
                            ),
                          )
                            : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w1 / 3.5,
                          height: h / 7,
                          decoration: BoxDecoration(
                              color: Color(0xff3284CA).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                  "20/40",
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
