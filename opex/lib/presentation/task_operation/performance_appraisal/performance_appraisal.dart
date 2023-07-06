import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_expansiontile.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/color_palatte.dart';
import 'create_performance.dart';

class PerformanceAppraisal extends StatefulWidget {
  final GetTaskList? tasklist;
  const PerformanceAppraisal({Key? key, this.tasklist}) : super(key: key);

  @override
  State<PerformanceAppraisal> createState() => _PerformanceAppraisalState();
}

class _PerformanceAppraisalState extends State<PerformanceAppraisal> {
  List<PointsList> pointList=[];
  List<PerformanceList> perfomences=[];
  bool isExpand=false;
  bool isExpand2=false;
  bool isExpand3=false;
  bool isExpand4=false;
  bool isExpand5=false;
  int TotalMark=0;
  ReadPerformanceAppraisal? performanceList;
  @override
  void initState() {
    context.read<TaskBloc>().add(
        GetPointsListEvent());
    context.read<TaskBloc>().add(
        GetTotalPerformanceEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
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
        if(state is GetPerformanceListLoading){

        }
        if(state is GetPerformanceListSuccess){
          perfomences=state.performanceList;
          print("ListPerfomence$perfomences");
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
       TotalMark=state.totalMark;
       setState(() {
print(("TOTA$TotalMark"));
       });
     }
      },
    ),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        // print("PERFORMANCE$state");
        if(state is GetReadPerformanceLoading){

        }
        if(state is GetReadPerformanceSuccess){
          performanceList=state.performanceList;
          setState(() {
            print(("PERFORMANCE${performanceList?.performanceList}"));
          });
        }
      },
    ),
  ],
  child: Scaffold(
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
      body: SafeArea(
        child: Column(
          children: [
            TaskAndOperationAppBar(
              label: "Performance Appraisal",
              EndIcon: GestureDetector(
                onTap: (){
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CreatePerformance(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
                child: Container(
                  // width: 110,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorPalette.primary,
                  ),
                  alignment: Alignment.center,

                  child: Text(
                    "Create",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: h/1.3,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
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
                        widget.tasklist?.assignToName??"",
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
                        widget.tasklist?.assignToEmail??"",
                        style: TextStyle(
                          color: Color(0xff6d6d6d),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                  value: TotalMark/100,
                                  backgroundColor: Color(0xffECECEC),
                                  color: Color(0xff198A17),
                                  minHeight: 10,

                                ),
                              ),
                              Text(
                                "(${TotalMark}/100)",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 14,

                                  fontWeight: FontWeight.w500,
                                ),
                              )
                        ]),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState((){

                                  });
                                },
                                child: PerformanceExpansionTile(
                                  label: perfomences[index].name??"",
                                  pointlist: pointList,tasklist: widget.tasklist,
                                  isExpand: isExpand,
                                  onTap: () {
                                    setState(() {
                                      isExpand = !isExpand;
                                      Variable.perfomanceName=perfomences[index].name??"";
                                      // print("das${Variable.perfomanceName}");
                                    });
                                  },),
                              );
                            },
                            separatorBuilder: (context, index) => Container(
                              height: 15,
                            ),
                            itemCount: perfomences.length),
                      ),
                      // PerformanceExpansionTile(
                      //   label: "Project Completion",
                      //   pointlist: pointList,tasklist: widget.tasklist,
                      //   isExpand: isExpand,
                      // onTap: () {
                      //   setState(() {
                      //     isExpand = !isExpand;
                      //     Variable.perfomanceName="Project Completion";
                      //     print("das${Variable.perfomanceName}");
                      //   });
                      // },),
                      // SizedBox(height: 16,),
                      // PerformanceExpansionTile(label: "Punctuality",
                      //     pointlist: pointList,
                      //     tasklist: widget.tasklist,
                      //   isExpand: isExpand2,
                      //   onTap: () {
                      //     setState(() {
                      //       isExpand2 = !isExpand2;
                      //       Variable.perfomanceName="Punctuality";
                      //       print("das${Variable.perfomanceName}");
                      //     });
                      //   },
                      // ),
                      // SizedBox(height: 10,),
                      // PerformanceExpansionTile(label: "Time Management",pointlist: pointList,tasklist: widget.tasklist,
                      //   isExpand: isExpand3,
                      //   onTap: () {
                      //     setState(() {
                      //       isExpand3 = !isExpand3;
                      //       Variable.perfomanceName="Time Management";
                      //       print("das${Variable.perfomanceName}");
                      //     });
                      //   },),
                      // SizedBox(height: 10,),
                      // PerformanceExpansionTile(label: "Team Management & Leadership",pointlist: pointList,tasklist: widget.tasklist,
                      //   isExpand: isExpand4,
                      //   onTap: () {
                      //     setState(() {
                      //       isExpand4 = !isExpand4;
                      //       Variable.perfomanceName="Team Management & Leadership";
                      //       print("das${Variable.perfomanceName}");
                      //     });
                      //   },),
                      // SizedBox(height: 10,),
                      // PerformanceExpansionTile(label: "Attitude",pointlist: pointList,tasklist: widget.tasklist,
                      //   isExpand: isExpand5,
                      //   onTap: () {
                      //     setState(() {
                      //       isExpand5 = !isExpand5;
                      //       Variable.perfomanceName="Attitude";
                      //       print("das${Variable.perfomanceName}");
                      //     });
                      //   },),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
);
  }
}
