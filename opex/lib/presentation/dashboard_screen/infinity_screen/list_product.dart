import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListProductCard extends StatefulWidget {
  const ListProductCard({Key? key}) : super(key: key);

  @override
  State<ListProductCard> createState() => _ListProductCardState();
}

class _ListProductCardState extends State<ListProductCard> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      width: w/2.5,
      margin: EdgeInsets.only(right: 5),
      // padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [
              Container(
                width: w/2.5,
                height: h/6,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('https://cdn.plotch.io/image/upload/C/V/CV-36662-MSANG55126722810-1593518556-Craftsvilla_1.jpg')
                      ,fit: BoxFit.fill),

                ),
              ),
              Positioned(
                bottom: 5,
                  right: 5,
                  child:Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: Color(0xff1b1b1f),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "+",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 30,

                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ) )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15,left: 5,bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Musafir Pure Low\nSodium Natural W...",
                  style: TextStyle(
                    color: Color(0xff1b1b1f),
                    fontSize: w/24,
                  ),
                ),
                SizedBox(height: 5,),
                Row(children: [
                  Text(
                    "AED ",
                    style: GoogleFonts.poppins(
                      color:Colors.black,
                      fontSize: w/29,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "1899.00",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: w/21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "3125.50",
                    style: GoogleFonts.poppins(
                        color: Color(0xff6d6d6d),
                        fontSize: w/30,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough
                    ),

                  ),
                ],),
SizedBox(height: 5,),
                Text(
                  "10+ Pieces/AED.1700",
                  style: TextStyle(
                    color: Color(0xfffe5762),
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),



        ],
      ),
    );
  }
}