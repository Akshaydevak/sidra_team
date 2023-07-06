import 'package:flutter/cupertino.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return    Container(
      height: h / 6,
      width: w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 0, left: 0),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int i) {
          return
            Image.asset("asset/img_8.png",height: h/10,width: 100,);
        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 5,); },
      ),
    );
  }
}
