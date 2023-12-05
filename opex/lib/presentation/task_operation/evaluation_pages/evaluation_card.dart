import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';

class UserCardEvaluation extends StatelessWidget {
  const UserCardEvaluation({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffE6ECF0))),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.loudegg.com/wp-content/uploads/2020/10/Mickey-Mouse.jpg"),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shifas Mehar N K",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: w / 24),
                ),
                Text(
                  "shifas@rgcdynamics.com",
                  style: GoogleFonts.roboto(fontSize: w / 26),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: w1 > 700?w1/5:w1 / 4,
            height: w1 > 700?35:30,
            child: GradientButton(
                onPressed: onTap,
                gradient: const LinearGradient(
                  colors: [
                    ColorPalette.primary,
                    ColorPalette.primary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: ColorPalette.primary,
                child: Text(
                  "Evaluate",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: w / 26,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class UserCardEvaluationTLs extends StatelessWidget {
  const UserCardEvaluationTLs({super.key, this.onTap, this.isStart = false});

  final VoidCallback? onTap;
  final bool? isStart;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffE6ECF0))),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://lionsgate.brightspotcdn.com/1d/90/8fc75de5411e985f3a2def98358d/johnwick4-section-promo-double-home-03.jpg"),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John wick",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: w / 24),
                ),
                Text(
                  "jhonwick@rgcdynamics.com",
                  style: GoogleFonts.roboto(fontSize: w / 26),
                ),
              ],
            ),
          ),
          Spacer(),
          isStart == true
              ? Container(
                  width: w1 / 5,
                  height: 30,
                  child: GradientButton(
                      onPressed: onTap,
                      gradient: const LinearGradient(
                        colors: [
                          ColorPalette.primary,
                          ColorPalette.primary,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: ColorPalette.primary,
                      child: Text(
                        "Start",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w / 26,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                )
              : Container()
        ],
      ),
    );
  }
}

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, this.onTap, this.isStart = false});

  final VoidCallback? onTap;
  final bool? isStart;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffE6ECF0))),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://lionsgate.brightspotcdn.com/1d/90/8fc75de5411e985f3a2def98358d/johnwick4-section-promo-double-home-03.jpg"),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John wick",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: w / 24),
                ),
                Text(
                  "jhonwick@rgcdynamics.com",
                  style: GoogleFonts.roboto(fontSize: w / 26),
                ),
                SizedBox(height: 5,),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,itemSize: 20,
                  // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("96 Points",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: w/26
                    ),),
                    Text(" | "),
                    Text("Outstanding Performance",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: w/26
                      ),),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
