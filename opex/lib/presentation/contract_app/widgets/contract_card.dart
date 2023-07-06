import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/contract_app/contract_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class ContractCard extends StatelessWidget {
  const ContractCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(10), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(10), ),
        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
        boxShadow: [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xfff0f1f2),
            ),
            child: SvgPicture.string(ContractSvg().docIcon),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contract Title",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: w/23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5,),
              SizedBox(
                width: w/2,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing ealiquam ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: w/3.5,
                    child: Text(
                      "Status",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: 14,
                      ),
                    ),
                  ),
                   Text(
                      ":",
                      style: GoogleFonts.roboto(
                        color: Color(0xff666161),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),


                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 65,
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.black,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Pending",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ) ,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: w/3.5,
                    child: Text(
                      "Contract Party",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: 14,
                      ),
                    ),
                  ),
                   Text(
                      ":",
                      style: GoogleFonts.roboto(
                        color: Color(0xff666161),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),


                  ),
                  SizedBox(width: 10,),
                Text("Rawabi Market",style: GoogleFonts.roboto(fontWeight: FontWeight.w600),)
                ],
              ),           Row(
                children: [
                  Container(
                    width: w/3.5,
                    child: Text(
                      "Effective From",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: 14,
                      ),
                    ),
                  ),
                   Text(
                      ":",
                      style: GoogleFonts.roboto(
                        color: Color(0xff666161),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),


                  ),
                  SizedBox(width: 10,),
                Text("12 April 2022",style: GoogleFonts.roboto(fontWeight: FontWeight.w600),)
                ],
              ),     Row(
                children: [
                  Container(
                    width: w/3.5,
                    child: Text(
                      "Modified On",
                      style: TextStyle(
                        color: Color(0xff666161),
                        fontSize: 14,
                      ),
                    ),
                  ),
                   Text(
                      ":",
                      style: GoogleFonts.roboto(
                        color: Color(0xff666161),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),


                  ),
                  SizedBox(width: 10,),
                Text("10 April 2022",style: GoogleFonts.roboto(fontWeight: FontWeight.w600),)
                ],
              ),

            ],
          )
        ],
      ),
    );
  }
}
