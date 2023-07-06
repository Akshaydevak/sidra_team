import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/logistic_app/utils/logistic_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
class AssignOrderCard extends StatefulWidget {
  const AssignOrderCard({Key? key}) : super(key: key);

  @override
  State<AssignOrderCard> createState() => _AssignOrderCardState();
}

class _AssignOrderCardState extends State<AssignOrderCard> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        _showModalBottomSheet();
      },
      child: Container(
        width: w,
        // height: 151,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: ColorPalette.inactiveGrey,),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Afthabu Rahman P P",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: w/2,
                        child: Text(
                          "Pookattu Purayil House, Avilora P.O,Koduvally VIA, Pin: 673572",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w/24,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: w,
              height: 1,color: ColorPalette.divider,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "4 Wheeler ",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(height: 41,width: 1,color: ColorPalette.divider,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                      child: SvgPicture.string(LogisticSvg().callIcon)),
                  Container(height: 41,width: 1,color: ColorPalette.divider,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: SvgPicture.string(LogisticSvg().msgIcon)),
                ],
              )
            ],)
          ],
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    GradientButton(
                        onPressed: () {
                          // PersistentNavBarNavigator.pushNewScreen(
                          //   context,
                          //   screen: const AddNewList(),
                          //   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation: PageTransitionAnimation.fade,
                          // );
                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: const Color(0xfffe5762),
                        child: Text(
                          "Assign to this order",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    SizedBox(height: 5,),
                    Text(
                      "Amet minim mollit non deserunt ullamco est sitaliq ua dolor do amet sint. ",
                      style: TextStyle(
                        color: ColorPalette.subtextGrey,
                        fontSize: w/23,
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


