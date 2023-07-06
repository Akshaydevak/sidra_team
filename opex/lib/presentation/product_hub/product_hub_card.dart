import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductHubCard extends StatelessWidget {
  bool isVerified;
   ProductHubCard({Key? key,this.isVerified=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      // height: 176,
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
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xfff0f1f2),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "15464646545 ",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: w / 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: w / 1.7,
                      // height: 45,
                      child: Text(
                        "Lorem ipsum dolor sit amet, conse ctetur lorem ipsum...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w / 22,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 6,
                          child: Text(
                            "Quantity",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 25,
                            ),
                          ),
                        ),
                        Text(
                          ":  24",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 6,
                          child: Text(
                            "Brand",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 25,
                            ),
                          ),
                        ),
                        Text(
                          ":  Specimen",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: w / 6,
                          child: Text(
                            "Price",
                            style: TextStyle(
                              color: Color(0xff666161),
                              fontSize: w / 25,
                            ),
                          ),
                        ),
                        Text(
                          ":  AED 145.50",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 10,
              child: isVerified?Container(
                width: 75,
                height: 22,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color(0xff4ca109),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Verified",
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: w / 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ):Container())
        ],
      ),
    );
  }
}
