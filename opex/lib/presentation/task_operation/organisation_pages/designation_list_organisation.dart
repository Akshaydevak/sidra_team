import 'package:avatar_stack/avatar_stack.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/organisation_pages/read_designation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/collection_card.dart';
import '../task_svg.dart';

class DesignationListInOrganisation extends StatefulWidget {
  const DesignationListInOrganisation({super.key});

  @override
  State<DesignationListInOrganisation> createState() => _DesignationListInOrganisationState();
}

class _DesignationListInOrganisationState extends State<DesignationListInOrganisation> {

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
          label: "Level 1",

          isAction: false,
          action: GestureDetector(child:
          Text("+ Add New",
          style: GoogleFonts.roboto(
            color: ColorPalette.primary,
            fontSize: w/24,
            fontWeight: FontWeight.w500
          ),)),
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("2 Designations",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: w/24
                      ),),
                    SizedBox(height: 10,),
                    ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),

                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: ReadDesignationList(),
                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.fade,
                              );
                            },
                              child: CardForListDesignation());
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 5,
                        ),
                        itemCount: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardForListDesignation extends StatelessWidget {
  const CardForListDesignation({super.key});

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffF8F8F8))
          ),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Team Leads",
                style: GoogleFonts.roboto(
                  fontSize: w/24,
                  fontWeight: FontWeight.w500,
                ),),
              SizedBox(height: 5,),
              Row(
                children: [
                  SvgPicture.string(TaskSvg().priorityIcon,color: ColorPalette.inactiveGrey,
                    width:15,height: 15,),
                  SizedBox(width: 5,),
                  Text("vishnuvp@rgcdynamics.com",
                    style: GoogleFonts.roboto(
                        color: ColorPalette.inactiveGrey,
                        fontSize: w/28
                    ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Employees",
                    style: GoogleFonts.roboto(
                        fontSize: w/28,
                        color: ColorPalette.primary
                    ),),
                  Text("  |  ",
                    style: GoogleFonts.roboto(
                        fontSize: w/28,
                        color: ColorPalette.primary
                    ),),
                  Text("Edit Details",
                    style: GoogleFonts.roboto(
                        fontSize: w/28,
                        color: ColorPalette.primary
                    ),),
                  Text("  |  ",
                    style: GoogleFonts.roboto(
                        fontSize: w/28,
                        color: ColorPalette.primary
                    ),),
                  Text("Delete",
                    style: GoogleFonts.roboto(
                        fontSize: w/28,
                        color: ColorPalette.primary
                    ),),
                ],
              )
            ],
          ),

        ),
        Positioned(
          right: 5,top:10,
          child: Container(
            child: AvatarStack(
              height: 35,width: 60,

              avatars: [
                for (var n = 0; n < 10; n++)
                  NetworkImage('https://lionsgate.brightspotcdn.com/1d/90/8fc75de5411e985f3a2def98358d/johnwick4-section-promo-double-home-03.jpg'),
              ],
            ),
          ),)
      ],
    );
  }
}



