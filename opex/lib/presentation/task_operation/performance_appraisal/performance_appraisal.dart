import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_expansiontile.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../../core/color_palatte.dart';
import '../../../common_widgets/loading.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../promotion_app/blocs/discount_bloc/discount_bloc.dart';
import '../../promotion_app/dropdown_card.dart';
import '../home/bloc/job_bloc.dart';
import 'create_performance.dart';

class PerformanceAppraisal extends StatefulWidget {
  final GetTaskList? tasklist;
  const PerformanceAppraisal({Key? key, this.tasklist}) : super(key: key);

  @override
  State<PerformanceAppraisal> createState() => _PerformanceAppraisalState();
}

class _PerformanceAppraisalState extends State<PerformanceAppraisal> {
  List<PointsList> pointList = [];
  List<PerformanceList> perfomences = [];
  bool isExpand = false;
  bool isExpand2 = false;
  bool isExpand3 = false;
  bool isExpand4 = false;
  bool isExpand5 = false;
  int TotalMark = 0;
  ReadPerformanceAppraisal? performanceList;
  void grpVal(bool val) {
    loadingBool = val;
    setState(() {});
    print("uuu$loadingBool");
  }
  @override
  void initState() {
    context.read<TaskBloc>().add(GetPointsListEvent());
    context.read<TaskBloc>().add(GetTotalPerformanceEvent(employeeCode: widget.tasklist?.assigningCode??"",widget.tasklist?.id??0));
    super.initState();
  }
  int? offerperiodId;
  String? offerPeriodName;

  bool isSelected=false;
  bool loadingBool=true;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is GetPointListLoading) {}
            if (state is GetPointListSuccess) {
              pointList = state.pointList;
              print("FAS$pointList");
              setState(() {});
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {

            if (state is GetPerformanceListLoading) {}
            if (state is GetPerformanceListSuccess) {
              perfomences = state.performanceList;
              print("ListPerfomence$perfomences");
              setState(() {});
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            print("mark state$state");
            if (state is GetTotalPerformanceLoading) {
              loadingBool=true;
            }
            if (state is GetTotalPerformanceSuccess) {
              TotalMark = state.totalMark;
              loadingBool=false;
              setState(() {
                print(("total Appraisal$TotalMark"));
              });
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            // print("PERFORMANCE$state");
            if (state is GetReadPerformanceLoading) {}
            if (state is GetReadPerformanceSuccess) {
              performanceList = state.performanceList;
              setState(() {
                print(("PERFORMANCE${performanceList?.performanceList}"));
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            isAction: false,
            label: "Individual",

          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
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
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.tasklist?.assignToName ?? "",
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
                        widget.tasklist?.assignToEmail ?? "",
                        style: TextStyle(
                          color: Color(0xff6d6d6d),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      loadingBool==true?Container(
                          height: 100,
                          width: w,
                          alignment: Alignment.center,
                          child: LoadingAnimationWidget.threeRotatingDots(
                            color: Colors.red,
                            size: 30,
                          )):Container(
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
                                style: GoogleFonts.roboto(
                                  color: Color(0xff939393),
                                  fontSize: w/26,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 16, bottom: 16),
                                child: LinearProgressIndicator(
                                  value: TotalMark / 100,
                                  backgroundColor: Color(0xffECECEC),
                                  color: Color(0xff198A17),
                                  minHeight: 10,
                                ),
                              ),
                              Text(
                                "($TotalMark/100)",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Container(
                      //   child: ListView.separated(
                      //       shrinkWrap: true,
                      //       primary: false,
                      //       physics: NeverScrollableScrollPhysics(),
                      //       itemBuilder: (context, index) {
                      //         return GestureDetector(
                      //           onTap: () {
                      //             setState(() {});
                      //           },
                      //           child: PerformanceExpansionTile(
                      //             label: perfomences[index].name ?? "",
                      //             pointlist: pointList,
                      //             tasklist: widget.tasklist,
                      //             isExpand: isExpand,
                      //             onTap: () {
                      //               setState(() {
                      //                 isExpand = !isExpand;
                      //                 Variable.perfomanceName =
                      //                     perfomences[index].name ?? "";
                      //                 // print("das${Variable.perfomanceName}");
                      //               });
                      //             },
                      //           ),
                      //         );
                      //       },
                      //       separatorBuilder: (context, index) => Container(
                      //             height: 15,
                      //           ),
                      //       itemCount: perfomences.length),
                      // ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Project Completion",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand,
                        onTap: () {
                          setState(() {
                            isExpand = !isExpand;
                            Variable.perfomanceName = "Project Completion";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Punctuality",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand2,
                        onTap: () {
                          setState(() {
                            isExpand2 = !isExpand2;
                            Variable.perfomanceName = "Punctuality";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Time Management",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand3,
                        onTap: () {
                          setState(() {
                            isExpand3 = !isExpand3;
                            Variable.perfomanceName = "Time Management";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Team Management & Leadership",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand4,
                        onTap: () {
                          setState(() {
                            isExpand4 = !isExpand4;
                            Variable.perfomanceName =
                                "Team Management & Leadership";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Attitude",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand5,
                        onTap: () {
                          setState(() {
                            isExpand5 = !isExpand5;
                            Variable.perfomanceName = "Attitude";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
