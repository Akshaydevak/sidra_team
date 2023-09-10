import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_palatte.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  double? _ratingValue = 4;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return Container(
      width: w,
      padding: EdgeInsets.only(left: 16,top: 16,bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xffe6ecf0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 63,
                child: FlutterLogo(size: 48),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w / 1.5,
                    child: Text(
                      "Musafir Pure Loium Nahjtu Sodi\num Nasafir Pu..",
                      style: GoogleFonts.roboto(
                        color: Color(0xff6d6d6d),
                        fontSize: w/25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  RatingBar(
                      initialRating: 0,
                      itemSize: 20,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star,
                              color: ColorPalette.primary),
                          half: const Icon(
                            Icons.star_half,
                            color: ColorPalette.primary,
                          ),
                          empty: const Icon(
                            Icons.star,
                            color: Color(0xffF8F7F5),
                          )),
                      onRatingUpdate: (value) {
                        setState(() {
                          _ratingValue = value;
                        });
                      }),
                ],
              )
            ],
          ),
          Divider(
            color: Color(0xffA9A8A8).withOpacity(0.5),
          ),
          Container(
            padding: EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 10),
            child: Text(
              "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam digni ssim volutpat. Purus volutpat, vitae egestas sodales quis enim elemen.",
              style: TextStyle(
                color: Color(0xff1b1b1f),
                fontSize: w/25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
