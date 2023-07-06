import 'package:flutter/cupertino.dart';

class CommentImgCard extends StatelessWidget {
  const CommentImgCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    return SizedBox(
      height: h / 8,
      child: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.only(right: 16,left: 0,top: 5,bottom: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return Image.asset("asset/img_9.png") ;
        }), separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 6,); },),
    );
  }
}
