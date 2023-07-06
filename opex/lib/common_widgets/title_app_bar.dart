import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleAppBar extends StatelessWidget {
  String? label;
   TitleAppBar({Key? key,this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.arrow_back)),
                SizedBox(width: 16,),
                Text(
                  label??"",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w/16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: w,
            height: 1.50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xb2e6e6e6),
                width: 0.50,
              ),
            ),
          ),

        ],
      ),

    );
  }
}
