import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_expansiontile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/variables.dart';
import '../create/model/task_models.dart';
class IndividualPerformance extends StatefulWidget {
  final List<PointsList>? pointList;
  final GetTaskList? taskList;
  final int? totalMark;
  const IndividualPerformance({Key? key, this.pointList, this.taskList, this.totalMark}) : super(key: key);

  @override
  State<IndividualPerformance> createState() => _IndividualPerformanceState();
}

class _IndividualPerformanceState extends State<IndividualPerformance> {
  bool isExpand=false;
  bool isExpand2=false;
  bool isExpand3=false;
  bool isExpand4=false;
  bool isExpand5=false;
  int TotalMark=0;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Employee",
          style: GoogleFonts.roboto(
            color: Color(0xff151522),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16,),
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
              Row(
                children: [
                  CircleAvatar(backgroundColor:  Color(0xffd45050),
                    child: Text(
                      "R",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),),
                  SizedBox(width: 5,),
                  Text(
                    "Afthabu Rahman P P",
                    style: TextStyle(
                      color: Color(0xff151522),
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: (){
                  _showModalBottomSheet();
                },
                child: Text(
                  "Change",
                  style: TextStyle(
                    color: Color(0xffed4e4e),
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 16,),
        Container(
          width: w,
          child: Column(
            children: [
              Container(
                width: 88.64,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                    "https://pps.whatsapp.net/v/t61.24694-24/311789630_1281413702694658_5579894103182886884_n.jpg?ccb=11-4&oh=01_AdTPkfgPISxtj6SouNZ_KDHUDiLPxLeE5pq0L_hmWoDslQ&oe=6380B7F4"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.taskList?.assignToName??"",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.taskList?.assignToEmail??"",
                style: TextStyle(
                  color: Color(0xff6d6d6d),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),


        Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "OVERALL EMPLOYEE PERFORMANCE",
                  style: TextStyle(
                    color: Color(0xff939393),
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 40,right: 40,top: 16,bottom: 16),
                  child: LinearProgressIndicator(
                    value: widget.totalMark!/100,
                    backgroundColor: Color(0xffECECEC),
                    color: Color(0xff198A17),
                    minHeight: 10,

                  ),
                ),
                Text(
                  "(${widget.totalMark}/100)",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
        ),
        SizedBox(height: 16,),
        PerformanceExpansionTile(
          label: "Project Completion",
          pointlist: widget.pointList,tasklist: widget.taskList,
          isExpand: isExpand,
          onTap: () {
            setState(() {
              isExpand = !isExpand;
              Variable.perfomanceName="Project Completion";
              print("das${Variable.perfomanceName}");
            });
          },),
        SizedBox(height: 16,),
        PerformanceExpansionTile(label: "Punctuality",
          pointlist: widget.pointList,
          tasklist: widget.taskList,
          isExpand: isExpand2,
          onTap: () {
            setState(() {
              isExpand2 = !isExpand2;
              Variable.perfomanceName="Punctuality";
              print("das${Variable.perfomanceName}");
            });
          },
        ),
        SizedBox(height: 10,),
        PerformanceExpansionTile(label: "Time Management",pointlist: widget.pointList,tasklist: widget.taskList,
          isExpand: isExpand3,
          onTap: () {
            setState(() {
              isExpand3 = !isExpand3;
              Variable.perfomanceName="Time Management";
              print("das${Variable.perfomanceName}");
            });
          },),
        SizedBox(height: 10,),
        PerformanceExpansionTile(label: "Team Management & Leadership",pointlist: widget.pointList,tasklist: widget.taskList,
          isExpand: isExpand4,
          onTap: () {
            setState(() {
              isExpand4 = !isExpand4;
              Variable.perfomanceName="Team Management & Leadership";
              print("das${Variable.perfomanceName}");
            });
          },),
        SizedBox(height: 10,),
        PerformanceExpansionTile(label: "Attitude",pointlist: widget.pointList,tasklist: widget.taskList,
          isExpand: isExpand5,
          onTap: () {
            setState(() {
              isExpand5 = !isExpand5;
              Variable.perfomanceName="Attitude";
              print("das${Variable.perfomanceName}");
            });
          },),
      ],
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {

          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: 16,),
                    Text(
                      "Choose Employee",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      width: w,
                     padding: EdgeInsets.all(16),
                      color:  ColorPalette.cardBackground,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:  Color(0xffd45050),
                              child: Text(
                                "R",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),),
                              SizedBox(width: 5,),
                              Text(
                                "Afthabu Rahman P P",
                                style: TextStyle(
                                  color: Color(0xff151522),
                                  fontSize: 18,
                                ),
                              )

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:  Color(0xffd45050),
                            child: Text(
                              "R",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),),
                          SizedBox(width: 5,),
                          Text(
                            "Afthabu Rahman P P",
                            style: TextStyle(
                              color: Color(0xff151522),
                              fontSize: 18,
                            ),
                          )

                        ],
                      ),
                    ),
                    Divider(
                      indent: 16,
                      endIndent: 16,thickness: 1.5,
                      color: Color(0xffE6ECF0),
                    ), Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:  Color(0xffd45050),
                            child: Text(
                              "R",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),),
                          SizedBox(width: 5,),
                          Text(
                            "Afthabu Rahman P P",
                            style: TextStyle(
                              color: Color(0xff151522),
                              fontSize: 18,
                            ),
                          )

                        ],
                      ),
                    ),

                  ],
                ),
              );
            },
          );
        });
  }
}
