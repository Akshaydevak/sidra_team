import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../mpos/mpos_svg.dart';
import '../product_svg.dart';

class TableCard extends StatelessWidget {
  String ?title1,title2,content1,content2,head;
   TableCard({Key? key,this.content1,this.content2,this.title1,this.title2,this.head}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              head??"Technical Information",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: w / 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                          Container(
                          width: w,
                          height: 53,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0), ),
                            color: Color(0xff4c4c4c),
                          ),

                                padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 10),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Edit Info",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: w/24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.close,color: Colors.white,)
                                  ],
                                )
                            ),
                            Container(
                              width: w,
                              // height: 227,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Technical Information",
                                      hintStyle:  GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w/24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Color(0xffe6ecf0)
                                          )
                                        ), focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Color(0xffe6ecf0)
                                          )
                                        ),enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: Color(0xffe6ecf0)
                                          )
                                        ),
                                      
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
Navigator.pop(context);
                                      },
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: const [
                                            ColorPalette.primary,
                                            ColorPalette.primary
                                          ]),
                                      child: Text(
                                        "Update",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w/22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ],
                              ) ,
                            )




                          ],
                        ),
                      );
                    });
              },
                child: SvgPicture.string(ProductSvg().editIcon))
          ],
        ),
        SizedBox(height: 14,),
        Container(
          width: w,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                width: w/2.5,
                child: Text(
                  title1??"Technical name",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: ColorPalette.divider,
              ),
              SizedBox(width: 10,),
              Container(
                width: w/3,
                child: Text(
                  title2??"Details",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: w,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
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
          child: Row(
             children: [
               Container(

                 width: w/2.5,
                 child:  Text(
                   content1??"Enter Technical name",
                   style: TextStyle(
                     color: Color(0x7f666161),
                     fontSize: w/24,
                   ),
                 ),
               ),
               Container(
                 width: 1,
                 height: 60,
                 color: ColorPalette.divider,
               ),
               SizedBox(width: 10,),
               Container(
                 width: w/3,
                 child: Text(
                   content2??"Enter details",
                   style: TextStyle(
                     color: Color(0x7f666161),
                     fontSize: w/24,
                   ),
                 ),
               ),
             ],
          ),
        ),
        SizedBox(height: 5,),
        Text(
          "+ Add New Raw",
          style: GoogleFonts.roboto(
            color: ColorPalette.primary,
            fontSize: w/24,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
