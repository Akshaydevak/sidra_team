import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_svg.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.only(left: 18, right: 18),
      width: w,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(49),
        border: Border.all(
          color: Color(0x11000000),
          width: 0.30,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000).withOpacity(0.08),
            blurRadius: 30,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: w / 1.6,
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Seach  Services and business apps..",
                hintStyle: GoogleFonts.roboto(
                  color: Color(0xffbdbdbd),
                  fontSize: w / 26,
                  fontWeight: FontWeight.w400,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 1,
                height: 30,
                color: Color(0xffE7E7E7),
              ),
              SizedBox(
                width: 13,
              ),
              SvgPicture.string(
                HomeSvg().searchIcon,
                color: Color(0xff222222),
                height: 17,
                width: 17,
              ),
              SizedBox(
                width: 2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
