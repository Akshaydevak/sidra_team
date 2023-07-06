import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CritiriaCard extends StatefulWidget {
  String label;
   CritiriaCard({Key? key,this.label=""}) : super(key: key);

  @override
  State<CritiriaCard> createState() => _CritiriaCardState();
}

class _CritiriaCardState extends State<CritiriaCard> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      padding: EdgeInsets.all(16),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff198a17),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1.Afthabu Rahman PP",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "5 Point",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xfff8f7f5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "2.Afthabu Rahman PP",
                      style: TextStyle(
                        color: Color(0xff151522),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "5 Point",
                      style: TextStyle(
                        color: Color(0xff939393),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xfff8f7f5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "3.Afthabu Rahman PP",
                      style: TextStyle(
                        color: Color(0xff151522),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "15 Point",
                      style: TextStyle(
                        color: Color(0xff939393),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xfff8f7f5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "4.Afthabu Rahman PP",
                      style: TextStyle(
                        color: Color(0xff151522),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "20 Point",
                      style: TextStyle(
                        color: Color(0xff939393),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
