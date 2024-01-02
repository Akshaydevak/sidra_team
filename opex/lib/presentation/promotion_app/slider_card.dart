import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderCard extends StatefulWidget {
  const SliderCard({Key? key}) : super(key: key);

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  int pageIndex = 1;
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: h/3.3,
          // padding: EdgeInsets.only(left: 16,right: 16),
          child: CarouselSlider.builder(
              itemCount: 5,

              slideBuilder: (int index) {
                return  Container(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
                  child: Column(
                    children: const[
                      CardScreen(),
                      SizedBox(height: 10,),
                      CardScreen()
                    ],
                  ),
                );
              },
              slideTransform: DefaultTransform(),
              slideIndicator: CircularSlideIndicator(
                padding: EdgeInsets.only(bottom: 8, left: 0),
                  alignment: Alignment.bottomCenter,
                  indicatorBorderWidth: 0.1,
                  indicatorRadius: 3,

                  itemSpacing: 10,
                  currentIndicatorColor: Color(0xff6D6D6D),
                  indicatorBackgroundColor: Color(0xffD9D9D9))
          ),
        ),


      ],
    );
  }
}
class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      height: 95,
      padding: EdgeInsets.symmetric(vertical:10,horizontal: 10 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xfffdf2f2), width: 1.50, ),
        boxShadow: const [
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "3200",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Products",
                    style:  GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/24,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Text(
                "Most Products Sold by Discount",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: w/26,
                ),
              )
            ],
          ),
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xfff0f1f2),
            ),
          )
        ],
      ),
    );
  }
}
