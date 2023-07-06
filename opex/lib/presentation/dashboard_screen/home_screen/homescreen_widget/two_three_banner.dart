import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoThreeCard extends StatefulWidget {
  const TwoThreeCard({Key? key}) : super(key: key);

  @override
  State<TwoThreeCard> createState() => _TwoThreeCardState();
}

class _TwoThreeCardState extends State<TwoThreeCard> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      // color: Colors.yellow,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeCard(
                  icon: HomeSvg().insightIcon,
                  head: "Insights",
                  subText: "Sell your products lorem."),
              HomeCard(
                  icon: HomeSvg().orderIcon,
                  head: "Orders",
                  subText: "Sell your products lorem."),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeCard(
                  icon: HomeSvg().insightIcon,
                  head: "Insights",
                  subText: "Sell your products lorem."),
              HomeCard(
                  icon: HomeSvg().orderIcon,
                  head: "Orders",
                  subText: "Sell your products lorem."),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeCard(
                  icon: HomeSvg().insightIcon,
                  head: "Insights",
                  subText: "Sell your products lorem."),
              HomeCard(
                  icon: HomeSvg().orderIcon,
                  head: "Orders",
                  subText: "Sell your products lorem."),
            ],
          ),
          SizedBox(height: 15,),
          Container(
            width: w,
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0x0ce30000),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   "View More ",
                   textAlign: TextAlign.center,
                   style: GoogleFonts.roboto(
                     color: Color(0xfffe5762),
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
                 Icon(Icons.arrow_forward,color: Color(0xfffe5863),)
               ],
            ),
          ),

        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  String? icon, head, subText;

  HomeCard({Key? key, this.icon, this.head, this.subText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(12),
      width: w / 2.3,
      // height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0x0ce30000),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.string(icon ?? ""),
          SizedBox(
            height: 10,
          ),
          Text(
            head ?? "",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subText ?? "",
            style: TextStyle(
              color: Color(0xff636363),
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
