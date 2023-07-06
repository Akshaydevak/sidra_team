import 'package:cluster/common_widgets/no_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../core/color_palatte.dart';
import '../base/bottom_card.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../task_operation/home_card.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/task_svg.dart';
import 'widgets/contract_card.dart';
import 'contract_list.dart';
import 'widgets/contract_quick.dart';

class ContractHome extends StatelessWidget {
  const ContractHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Contract App"),
      ),
      body:ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "120",
                      sub: "Contract Created",
                    ),
                    HomeCard(
                      head: '32',
                      sub: "Approved",
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeCard(
                      head: "3200",
                      sub: "Comments",
                    ),
                    HomeCard(
                      head: '362',
                      sub: "Collabrators",
                    )
                  ],
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ContractList(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  //  ContractList
                  },
                  child: Container(
                    width: w,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    // height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffdf2f2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Contract List",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w / 20,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "525",
                              style: GoogleFonts.roboto(
                                color: Color(0xfffd5762),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10,),
                            SvgPicture.string(TaskSvg().arrowIcon),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  // height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfffdf2f2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pending for Approvals",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w / 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "2,054",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffd5762),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10,),
                          SvgPicture.string(TaskSvg().arrowIcon),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Quick access to :",
                  style: GoogleFonts.roboto(
                    color: Color(0xff151522),
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ContractQuick(),
                SizedBox(
                  height: 26,
                ),
                Text(
                  "New Contracts",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/20,
                    fontWeight: FontWeight.w500,
                  ),
                ) ,
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) => ContractCard(),
                ),
                BottomCard()
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
