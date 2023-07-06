import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CartCard extends StatelessWidget {
  const CartCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      // height: 152,
      padding: EdgeInsets.all(16),
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
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
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
          SizedBox(width: 5,),
          Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "15464646545 ",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: w/1.8,
                child: Text(
                  "Lorem ipsum dolor sit amet, conse ctetur lorem ipsum...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width: 128,
                    // height: 37,
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                         width: 30,
                         height: 30,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(4),
                           color: Color(0xfff0f1f2),
                         ),
                           alignment: Alignment.center,
                           child:  Text(
                             "-",
                             textAlign: TextAlign.center,
                             style: GoogleFonts.roboto(
                               color: Colors.black,
                               fontSize: 30,
                               fontWeight: FontWeight.w300,
                             ),

                           ),
                         ),
                             Container(
                               width: 30,
                               height: 30,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(4),
                                 gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xffff467a), Color(0xff9c0e36)], ),
                               ),
                               alignment: Alignment.center,
                               child: Text(
                                 "+",
                                 textAlign: TextAlign.center,
                                 style: GoogleFonts.roboto(
                                   color: Colors.white,
                                   fontSize: 30,
                                   fontWeight: FontWeight.w300,
                                 ),
                               ),
                             ) 
                       ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "AED 145.50",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
