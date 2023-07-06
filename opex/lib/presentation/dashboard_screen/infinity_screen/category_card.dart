import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h =MediaQuery.of(context).size.height;
    return Container(
      height: h/6.5,
      child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 16,right: 16),
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              width: w/4,
              child: Column(
                children: [
                  Image.asset("asset/img_14.png",height: h/9,),
                  Text(
                    "Fruits and Vegetables",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 14,

                      fontWeight: FontWeight.w600,
                    ),

                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              Container(
                width: 10,
              ),
          itemCount: 5),
    );
  }
}
