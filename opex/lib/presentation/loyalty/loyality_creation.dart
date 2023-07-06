import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/loyalty/widget/previous_historycard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'widget/creation_card.dart';

class LoyalityCreation extends StatelessWidget {
  const LoyalityCreation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Loyality Creation"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreationCard(
                      label: "Choose Segment",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CreationCard(
                      label: "Choose Product Group",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CreationCard(
                      label: "Choose Customer Type",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h / 8,
              ),
              Container(
                width: w,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xffffeff0), Color(0x00ffeff0)],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w / 3.5,
                          height: 1,
                          color: Color(0xffFE5762).withOpacity(0.2),
                        ),
                        Text(
                          "ADD LOYALITY",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          width: w / 3.5,
                          height: 1,
                          color: Color(0xffFE5762).withOpacity(0.2),
                        ),
                      ],
                    ),
                    GradientButton(
                        color: Color(0xffe6ecf0),
                        onPressed: () {},
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [Colors.white, Colors.white]),
                        child: Text(
                          "Enter amount",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Color(0x99666161),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(
                      height: 6,
                    ),
                    GradientButton(
                        color: Color(0xffe6ecf0),
                        onPressed: () {},
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [Colors.white, Colors.white]),
                        child: Text(
                          "Enter corresponding points",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Color(0x99666161),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    GradientButton(
                        color: ColorPalette.primary,
                        onPressed: () {},
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [
                              Color(0xfffe5762),
                              Color(0xfffe5762)
                            ]),
                        child: Text(
                          "Enter corresponding points",
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
              Container(
                width: w,
                height: 6,
                color: Color(0xffffeeee),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Previous History",
                      style: GoogleFonts.poppins(
                        color: ColorPalette.black,
                        fontSize: w / 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (
                            context, index) => PreviousHistoryCard(),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 4,
                            ),
                        itemCount: 6),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
