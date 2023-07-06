import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_expansiontile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../create/create_svg.dart';
import '../create/model/task_models.dart';
import '../create/task_bloc/task_bloc.dart';
import '../task_operation_appbar.dart';
import 'critirea_performance.dart';
import 'individual_performance.dart';

class CreatePerformance extends StatefulWidget {
  final GetTaskList? taskList;
  const CreatePerformance({Key? key, this.taskList}) : super(key: key);

  @override
  State<CreatePerformance> createState() => _CreatePerformanceState();
}

class _CreatePerformanceState extends State<CreatePerformance> {
  bool isIndividual= true;
  bool isCritiria= false;
  List<PointsList> pointList=[];
  int totalMark=0;
  @override
  void initState() {
    context.read<TaskBloc>().add(GetPointsListEvent());
    context.read<TaskBloc>().add(GetTotalPerformanceEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<TaskBloc, TaskState>(
  listener: (context, state) {
    if(state is GetPointListLoading){

    }
    if(state is GetPointListSuccess){
      pointList=state.pointList;
      print("FAS$pointList");
      setState(() {

      });
    }
  },
),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if(state is GetTotalPerformanceLoading){

        }
        if(state is GetTotalPerformanceSuccess){
          totalMark=state.totalMark;
          setState(() {
            print(("TOTA$totalMark"));
          });
        }
      },
    ),
  ],
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.white, // Status bar
          ),

          elevation: 0,

        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            TaskAndOperationAppBar(
              label: "Performance Appraisal",
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  "Choose One",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:(){
                        setState((){isCritiria=true;
                        isIndividual=false;});
                      },
                      child: Container(
                        width: w/2.3,
                       padding: EdgeInsets.all(10),
                        decoration: isCritiria? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color:  ColorPalette.cardBackground,
                        ):BoxDecoration(
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
                          children: [
                            SvgPicture.string(isCritiria?CreateSvg().radioActiveButton:CreateSvg().radioInActiveButton),
                            SizedBox(width: 10,),
                            Text(
                              "Criteria",
                              style: GoogleFonts.roboto(
                                color: Color(0xff151522),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),  GestureDetector(
                      onTap: (){
                        setState((){
                          isIndividual=true;
                          isCritiria=false;
                        });
                      },
                      child: Container(
                        width: w/2.3,
                       padding: EdgeInsets.all(10),
                        decoration: isIndividual? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color:  ColorPalette.cardBackground,
                        ):BoxDecoration(
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
                          children: [
                            SvgPicture.string(isIndividual?CreateSvg().radioActiveButton:CreateSvg().radioInActiveButton),
                            SizedBox(width: 10,),
                            Text(
                              "Individual",
                              style: GoogleFonts.roboto(
                                color: Color(0xff151522),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                  SizedBox(height: 16,),
                  isIndividual? IndividualPerformance(pointList: pointList,taskList: widget.taskList,totalMark: totalMark,):Container(),
                  isCritiria? CritireaPerformance():Container(),
              ],),
            )

          ]),
        ),
      ),
    ),
);
  }

}
