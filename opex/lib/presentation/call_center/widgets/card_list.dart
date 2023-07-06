import 'package:cluster/presentation/call_center/call_center_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CardList extends StatefulWidget {

   CardList({Key? key}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  int select=0;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h / 4,
      child: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        // padding: EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                select=index;
              });
            },
            child: Card(
              isSelect: select==index,
            ),
          );
        }),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 6,
          );
        },
      ),
    );
  }

}

class Card extends StatelessWidget {
  bool isSelect;
   Card({Key? key,this.isSelect=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/2.5,
      height: 172,
      decoration:isSelect? BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xfffe5762),
          width: 1,
        ),
        color: Color(0x0cfe5762),
      ):BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 1, ),
              color: Colors.white,
              boxShadow: const [
              BoxShadow(
                blurStyle: BlurStyle.inner,
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset.infinite

              )]
            ),

          ),
          const SizedBox(height: 10,),
          const Text(
            "Card Payment 1",
            style: TextStyle(
              color: Color(0xff151522),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16,),
          Container(
            width: 114,
            height: 34,
            decoration:isSelect? BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              color: Color(0xfffdfdfd),
            ):BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              color: Color(0xfffff6f7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Share Link",
                  style: GoogleFonts.roboto(
                    color: Color(0xfffe5762),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5,),
                SvgPicture.string(CallCenterSvg().shareIcon)
              ],
            ),
          )
        ],
      ),
    );
  }
}
