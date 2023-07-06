import 'package:flutter/cupertino.dart';

class FashionCard extends StatelessWidget {
  const FashionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h =MediaQuery.of(context).size.height;
    return Container(
      height: h/5.5,
      child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 16,right: 16),
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              width: w/2.5,

              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                color: Color(0xfff8f7f5),
              ),child: Image.asset("asset/img_13.png"),
            );
          },
          separatorBuilder: (context, index) =>
              Container(
                width: 10,
              ),
          itemCount: 3),
    );
  }
}
