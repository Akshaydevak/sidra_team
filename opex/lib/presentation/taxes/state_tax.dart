import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StateTax extends StatelessWidget {
  const StateTax({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "If you not ind the taxable country in the table, Just search and add to the table. if you are not well known about the tax info check with a profession. for more details check here.",
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "States/Emirates",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Container(
              width: w,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
                color: Color(0xff373737),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    width: w / 2.5,
                    child: Text(
                      "Name",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: ColorPalette.divider,
                  ),
                  Container(
                    width: w / 4.5,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Code",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: ColorPalette.divider,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Tax Type",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )),
          Container(
              width: w,
              // height: 218,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
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
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            width: w / 2.5,
                            child: Text(
                              "Andaman Nicobar",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: ColorPalette.divider,
                          ),
                          Container(
                            width: w / 4.5,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "AN",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: ColorPalette.divider,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "GST, SGST",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.more_horiz_outlined)
                            ],
                          )
                        ],
                      ),
                  separatorBuilder: (context, index) => Container(
                        width: w,
                        height: 1,
                        color: ColorPalette.divider,
                      ),
                  itemCount: 5)),
          SizedBox(height: 10,),
          Text(
            "+ Add more states",
            style: GoogleFonts.roboto(
              color: ColorPalette.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
