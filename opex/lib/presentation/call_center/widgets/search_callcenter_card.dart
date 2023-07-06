import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'field_card.dart';
class SearchCallCenterCard extends StatefulWidget {
   SearchCallCenterCard({Key? key}) : super(key: key);

  @override
  State<SearchCallCenterCard> createState() => _SearchCallCenterCardState();
}

class _SearchCallCenterCardState extends State<SearchCallCenterCard> {
bool isOpen=false;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        setState(() {
          isOpen=!isOpen;
        });
      },
      child: Column(
        children: [
          Container(
            width: w,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xfff0f1f2),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "15464646545 ",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: w / 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: w / 1.7,
                      // height: 45,
                      child: Text(
                        "Lorem ipsum dolor sit amet, conse ctetur lorem ipsum...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w / 22,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 6,
                          child: Text(
                            "Quantity",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 25,
                            ),
                          ),
                        ),
                        Text(
                          ":  24",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 6,
                          child: Text(
                            "Brand",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 25,
                            ),
                          ),
                        ),
                        Text(
                          ":  Specimen",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 6,
                          child: Text(
                            "Price",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 25,
                            ),
                          ),
                        ),
                        Text(
                          ":  AED 145.50",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          isOpen?Container(
            width: w,
            // height: 401,
            color: Color(0x33d9d9d9),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FieldCard(),
                    FieldCard(label: "UOM",),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FieldCard(label: "DISCOUNT (%)",),
                    FieldCard(label: "VATABLE (%)",),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w/2.3,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "TOTAL  125421",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: w/2.3,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xfffe5762),
                      ),
                      alignment: Alignment.center,
                      child:Text(
                        "Add to List",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Amet minim mollit non deserunt ullamco est sit aliqua.",
                  style: TextStyle(
                    color: Color(0xff666161),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ):Container(),
         isOpen? Container(
           padding: EdgeInsets.all(16),
            width: w,
            // height: 83,
            color: Color(0xfff6e2e2),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 width: w/2.3,
                 height: 50,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                   color: Colors.white,
                 ),
                 alignment: Alignment.center,
                 child: Text(
                   "Customer History",
                   style: GoogleFonts.roboto(
                     color: Colors.black,
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
               ),
               Container(
                 width: w/2.2,
                 height: 50,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                   color: Colors.white,
                 ),
                 alignment: Alignment.center,
                 child: Text(
                   "All Customer History",
                   style: GoogleFonts.roboto(
                     color: Colors.black,
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
               ),
             ],
           ),
          ):Container()
        ],
      ),
    );
  }
}
