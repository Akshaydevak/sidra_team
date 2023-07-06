import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/contract_app/contract_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/gradient_button.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../mpos/search_card.dart';
import '../task_operation/task_svg.dart';
import 'contract_screen/first_screen.dart';
import 'contract_screen/last_screen.dart';
import 'contract_screen/second_screen.dart';

class NewContract extends StatefulWidget {

   NewContract({Key? key}) : super(key: key);

  @override
  State<NewContract> createState() => _NewContractState();
}

class _NewContractState extends State<NewContract> {
  bool isFirst=true;
  bool isSecond=false;
  bool isLast=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "New Contract",
          isAction: false,
          action: PopupMenuButton(
            icon: SvgPicture.string(TaskSvg().moreIcon),
            //don't specify icon if you want 3 dot menu
            color: Colors.white,
            elevation: 2,
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            itemBuilder: (context) => [
              PopupMenuItem(
                  padding: const EdgeInsets.all(0),
                  value: 'a',
                  enabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            SvgPicture.string(ContractSvg().commentIcon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Comment',
                              style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            SvgPicture.string(ContractSvg().printIcon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Print Contract',
                              style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            SvgPicture.string(ContractSvg().printIcon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Share this Contract',
                              style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            SvgPicture.string(ContractSvg().pinIcon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pin',
                              style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
            onSelected: (value) {},
          ),
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
                isFirst?  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstScreen(),
                    SizedBox(
                      height: 30,
                    ),
                    GradientButton(
                        color: Color(0xfffe5762),
                        onPressed: () {
setState(() {

  isFirst=false;
  isSecond=true;
  isLast=false;
});
                        },
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [Color(0xfffe5762), Color(0xfffe5762)]),
                        child: Text(
                          "Save and Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ):isSecond?Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SecondScreen(),
                    SizedBox(
                      height: 30,
                    ),

                    GradientButton(
                        color: Color(0xfffe5762),
                        onPressed: () {
                          setState(() {

                            isFirst=false;
                            isSecond=false;
                            isLast=true;
                          });
                        },
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [Color(0xfffe5762), Color(0xfffe5762)]),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(height: 5,),
                    GradientButton(
                        color: Color(0xfffe5762),
                        onPressed: () {
                          setState(() {

                            isFirst=false;
                            isSecond=false;
                            isLast=true;
                          });
                        },
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [Colors.white, Colors.white]),
                        child: Text(
                          "Skip and Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),

                  ],
                ):isLast?Column(
                  children: [
                    LastScreen(),

                  ],
                ):Container(),

              ],
            ),
          ),
        ),
      ),


    );
  }


}
