import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'critirea_card.dart';

class CritireaPerformance extends StatefulWidget {
  const CritireaPerformance({Key? key}) : super(key: key);

  @override
  State<CritireaPerformance> createState() => _CritireaPerformanceState();
}

class _CritireaPerformanceState extends State<CritireaPerformance> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose",
          style: GoogleFonts.roboto(
            color: Color(0xff151522),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: w,
          padding: EdgeInsets.all(16),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Task Name 1",
                style: TextStyle(
                  color: Color(0xff151522),
                  fontSize: 18,
                ),
              ),
              Text(
                "Change",
                style: TextStyle(
                  color: Color(0xffed4e4e),
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 16,),
        CritiriaCard(label: "Overall point",),SizedBox(height: 10,),
        CritiriaCard(label: "Punctuality",),
        SizedBox(height: 10,),
        CritiriaCard(label: "Time Management",),
        SizedBox(height: 10,),
        CritiriaCard(label: "Team Management & Leadership",),
        SizedBox(height: 10,),
      ],
    );
  }
}
