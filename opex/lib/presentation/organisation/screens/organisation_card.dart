  import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/organisation/model/org_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'organisation_view.dart';
class OrganisationCard extends StatelessWidget {

  OrgModel? orgModel;
     OrganisationCard({Key? key,this.orgModel}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      var w=MediaQuery.of(context).size.width;
      return GestureDetector(
        onTap: (){
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: OrganisationView(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        },
        child: Container(
          width: w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
            boxShadow: [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 8,
                offset: Offset(1, 1),
              ),
            ],
            color: Colors.white,
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xff1ecac0),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w/1.6,
                    child: Text(
                      orgModel?.name??"RM General Trading",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                     "Joined on 03 January 2020",
                    style: TextStyle(
                      color: Color(0xff7d7d7d),
                      fontSize: w/26,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                   padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Color(0x33fe5762),
                    ),
                    child: Text(
                      "Address",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.subtextGrey,
                        fontSize: w/26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "${orgModel?.addressOne},${orgModel?.landMark}"??"2972 Westheimer Rd.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),Text(
                    "${orgModel?.state},${orgModel?.country?.toUpperCase()}"??"Santa Ana, Illinois 85486 ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
