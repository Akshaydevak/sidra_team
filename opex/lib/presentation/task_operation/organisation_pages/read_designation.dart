import 'package:cluster/presentation/task_operation/organisation_pages/user_profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'add_user_page_organisation.dart';
import 'designation_list_organisation.dart';

class ReadDesignationList extends StatefulWidget {
  const ReadDesignationList({super.key});

  @override
  State<ReadDesignationList> createState() => _ReadDesignationListState();
}

class _ReadDesignationListState extends State<ReadDesignationList> {
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
          label: "Team Leads",

          isAction: false,
          action: GestureDetector(
            onTap: (){
              PersistentNavBarNavigator.pushNewScreen(

                context,
                screen: AddUserInOrganisation(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
              child:
          Text("+ Add User",
            style: GoogleFonts.roboto(
                color: ColorPalette.primary,
                fontSize: w/24,
                fontWeight: FontWeight.w500
            ),)),
          onTap: () {

          },
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
                    Text("10 Members",
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
                                  screen: UserProfileView(),
                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );


                              },
                              child: UsersCardDesignation());
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

class UsersCardDesignation extends StatelessWidget {
  const UsersCardDesignation({super.key});

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: w1,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffE6ECF0),
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Afthab Rahman",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: w/24
                  ),),
                  Text("afthabrahman@gmail.com",
                  style: GoogleFonts.roboto(
                    fontSize: w/26,

                  ),),
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          Text("Compensation and benefit programs | Bond agrment process | Develop employee development plans | Dev..  +33 More",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleFonts.roboto(
            fontSize: w/28,
            color: Color(0xff6D6D6D)
          ),)
        ],
      ),
    );
  }
}

