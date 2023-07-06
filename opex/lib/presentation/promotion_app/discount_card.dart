import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';
import '../task_operation/task_svg.dart';
class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,

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
      child:
      Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [

       Container(
         padding: EdgeInsets.all(16),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xfff0f1f2),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Black Friday",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "164654354331133",
                  style: TextStyle(
                    color: Color(0xff9b9b9b),
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: w/2,
                  child: Text(
                    "Amet minim mollit non deserunt ullamcoest sit aliqua dolor do amet sint.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),


          ],
      ),
       ),
          Positioned(
            top: 0,
            right: 0,
            child:  PopupMenuButton(
            icon: Icon(Icons.more_vert),
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

                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                              color: ColorPalette.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ), const Divider(indent: 30,),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Remove from list',
                          style: GoogleFonts.poppins(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ))

            ],
            onSelected: (value) {},
          ),)
    ])
    );
  }
}
