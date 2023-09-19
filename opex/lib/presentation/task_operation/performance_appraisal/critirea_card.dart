import 'package:cluster/core/color_palatte.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../create/model/task_models.dart';

class CritiriaCard extends StatefulWidget {
  String label;
  List<Punchuality> list=[];
   CritiriaCard({Key? key,required this.list,this.label=""}) : super(key: key);

  @override
  State<CritiriaCard> createState() => _CritiriaCardState();
}

class _CritiriaCardState extends State<CritiriaCard> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/1.1,
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
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
              fontSize: w/24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),


              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ColorPalette.cardBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // employeeList?.profile==""?
                        TextAvatar(
                          shape: Shape.Circular,
                          size: 35,
                          numberLetters: 2,
                          fontSize: w/22,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w500,
                          text:"${widget.list[index]?.name.toString().toUpperCase()}" ,
                        ),
                        //     :
                        // CircleAvatar(
                        //   radius: 20,
                        //   backgroundImage: NetworkImage(employeeList?.profile??"",),
                        // ),
                        SizedBox(width: 8,),
                        SizedBox(
                          width: w/1.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w/1.5,
                                // color: Colors.yellow,
                                child: Text(
                                  "${widget.list[index].name.toString()}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Container(
                                width: w/1.5,
                                // color: Colors.red,

                                child: Text(
                                  widget.list[index]?.email??"",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                    color: Colors.black,
                                    fontSize: w/26,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2,),
                              Container(
                                width: w/1.5,
                                // color: Colors.red,

                                child: Text(
                                  "Points : ${widget.list[index]?.points.toString()}" ??"",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: w/26,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(
                    //       width: w/2,
                    //       child: Text(
                    //         "${index+1}.${widget.list?[index].name}",
                    //         style: GoogleFonts.roboto(
                    //           color: Colors.white,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //     Text(
                    //       "${widget.list?[index].points} Point",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 12,
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ) ,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 5,),
                  itemCount: widget.list!.length<=5?widget.list!.length:5),



            ],
          )

        ],
      ),
    );
  }
}
