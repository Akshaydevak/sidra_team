import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DropDownCard extends StatelessWidget {
   DropDownCard({Key? key,this.label,this.onTap}) : super(key: key);
  String? selGender,label;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         label?? "Select Segment",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: w/24,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5,),
        GestureDetector(
          onTap:onTap ,
          child: Container(
            width: w ,
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //height: 20.0,
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x05000000),
                  blurRadius: 8,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white,
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "-  Select  -",
                  style: TextStyle(
                    color: Color(0xbf666161),
                    fontSize: w/22,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_outlined),
              ],
            )
            //
            // DropdownButton(
            //     isExpanded: true,
            //     icon: Icon(Icons.keyboard_arrow_down_outlined),
            //     underline: Container(),
            //     items: gender.map((String items) {
            //       return DropdownMenuItem(
            //         enabled: true,
            //         value: items,
            //         child: Text(items, style: TextStyle(color: Colors.black)),
            //       );
            //     }).toList(),
            //     value: selectedGender,
            //     onChanged: (dynamic value) {},
            //     hint:),
          ),
        ),
      ],
    );
  }
}
