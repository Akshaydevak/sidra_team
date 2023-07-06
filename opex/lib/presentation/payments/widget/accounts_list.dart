import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AccountsList extends StatelessWidget {
  const AccountsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.width;
    return SizedBox(
      height: 150,
      child: ListView.separated(
        itemCount:5,
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 16,left: 16,top: 5,bottom: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return Container(
            width: 235,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/cardbackground.png"),fit: BoxFit.fill
              )
            ),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Color(0x7fc3acac), width: 1, ),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 26,),
                      Text(
                        "ICICI Bank - XX56",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "XXXX XX65",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.subtextGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),

                Positioned(
                  top:5,
                    right: 7,
                    child: Container(
                  width: 69,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(8), bottomLeft: Radius.circular(2), bottomRight: Radius.circular(0), ),
                    color: Color(0xfffd5762),
                  ),
                      alignment: Alignment.center,
                      child: Text(
                        "PRIMARY",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ))
              ],
            ),
          );
        }), separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 6,); },),
    );
  }
}
