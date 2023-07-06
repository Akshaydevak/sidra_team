import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../task_operation/task_svg.dart';
import 'employee_view.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: EmployeeView(),
          withNavBar: true,
          // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      //EmployeeView
      },
      child: Container(

        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffe6ecf0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 8,
              offset: Offset(1, 1),
            ),
          ],
          color: Colors.white,
        ),
        child: Stack(

          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Afthabu Rahman",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "Manager  |  Rawabi Hypermarket",
                        style: GoogleFonts.roboto(
                          color: Color(0xff9b9b9b),
                          fontSize: w/26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "+91 8606200441",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w/26,
                        ),
                      ),
                      Text(
                        "afthaburahman313@gmail.com",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w/26,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: PopupMenuButton(
                icon: Icon(Icons.more_vert,color:Color(0xff7d7d7d)),
                //don't specify icon if you want 3 dot menu
                color: Colors.white,
                elevation: 2,
                padding: EdgeInsets.zero,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      padding: const EdgeInsets.all(0),
                      value: 'a',
                      enabled: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.red.withOpacity(0.2),
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Edit',
                              style: GoogleFonts.poppins(
                                  color: Color(0xffFE5762),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Divider(
                            indent: 30,
                          )
                        ],
                      )),
                  PopupMenuItem(
                      padding: const EdgeInsets.all(0),
                      value: 'a',

                      enabled: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.red.withOpacity(0.2),
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Remove from lis',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),

                        ],
                      ))
                ],
                onSelected: (value) {},
              ),
            ),
            // Icon(Icons.more_vert,color:Color(0xff7d7d7d))
          ],
        ),
      ),
    );
  }
}
