import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/application_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThumbnailCard extends StatelessWidget {
   ThumbnailCard({super.key,this.thumbNail,this.share});

  ApplicationModel? thumbNail;
  VoidCallback? share;
  

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Container(
      // color: Colors.cyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(thumbNail?.title??"",style: GoogleFonts.roboto(
                    fontSize: w/26,
                    fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 4,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text(thumbNail?.subTitle??"",style: GoogleFonts.roboto(
                      fontSize: w/30,
                      color: Color(0xff555555)
                    ),)),
              ],
            ),
          ),
          SizedBox(height: 8,),
          Image.network(thumbNail?.image??"",height: 200,fit: BoxFit.cover,width: w1,),

          GestureDetector(
            onTap: share,
            child: Container(
              // color: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Share this video",style: GoogleFonts.roboto(
                    color: ColorPalette.primary,
                    fontSize: w/28
                  ),),
                  Icon(Icons.arrow_forward_ios,size: 20,color: ColorPalette.primary,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
