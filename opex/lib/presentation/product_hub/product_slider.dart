import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class ProductSlider extends StatelessWidget {
  ProductSlider({Key? key}) : super(key: key);

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
          height: h / 5,
          // padding: EdgeInsets.only(left: 16,right: 16),
          child: CarouselSlider.builder(
              itemCount: imageList.length,
              slideBuilder: (int index) {
                return Image.network(imageList[index],fit: BoxFit.fill,);
              },
              slideTransform: DefaultTransform(),
              enableAutoSlider: true,
              unlimitedMode: true,
              slideIndicator: CircularSlideIndicator(

                  padding: EdgeInsets.only(bottom: 10, left: 0),
                  alignment: Alignment.bottomCenter,
                  indicatorBorderWidth: 0.2,
                  indicatorRadius: 3.5,
                  itemSpacing: 10,
                  currentIndicatorColor: Colors.white,
                  indicatorBackgroundColor: Color(0xffE5E5E5))),
        ),
      ],
    );
  }
}
