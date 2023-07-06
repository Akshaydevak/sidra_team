import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PinnedProfile extends StatelessWidget {
  const PinnedProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w,
      height: 75,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: 10, left: 10),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              // onTap: onTapListTile(i, context),
              child: Container(
                  // width: 226,
                 padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffe6ecf0),
                      width: 1,
                    ),
                    boxShadow: [
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(width: w/3,
                          child:  Text(
                            "Muhammed Gassali",
                            style: GoogleFonts.roboto(
                              color: Color(0xff151522),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ) ,),


                        ],
                      ),
                      SvgPicture.string(CommunicationSvg().pinnedIcon)
                    ],
                  )));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 5,
          );
        },
      ),
    );
  }
}
