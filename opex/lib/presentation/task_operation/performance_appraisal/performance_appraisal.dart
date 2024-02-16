import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_expansiontile.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
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
  ReadMarkRead? TotalMark;
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
             if (state is CreatePerformanceLoading) {
      // showSnackBar(context,
      //     message: "Loading...",
      //     color: Colors.white,
      //     // icon: HomeSvg().SnackbarIcon,
      //     autoDismiss: true);
    }

    if (state is CreatePerformanceFailed) {
      showSnackBar(
        context,
        message: state.error,
        color: Colors.red,
        // icon: Icons.admin_panel_settings_outlined
      );
    }
    if (state is CreatePerformanceSuccess) {
      // Fluttertoast.showToast(
      //     msg: 'Performance Created',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.white,
      //     textColor: Colors.black);
      context.read<TaskBloc>().add(
          GetTotalPerformanceEvent(employeeCode: widget.tasklist?.assigningCode??"",widget.tasklist?.id));
    }
    }
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {

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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            isAction: false,
            label: "Performance Appraisal",

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
                       TextAvatar(
                              shape: Shape.Circular,
                              size: 60,
                              numberLetters: 1,
                              fontSize: w / 16,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w500,
                              text: widget.tasklist?.assignToName?.toUpperCase() ??
                                  "".toUpperCase(),
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
                          fontSize: w/28,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                        Text(
                                "OVERALL EMPLOYEE PERFORMANCE",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/26,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 10,),
                      loadingBool==true?customCupertinoLoading():Container(
                        width: w,
                        padding: EdgeInsets.all(16),
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
                          color: Color(0xffDFEAF3),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            
                             Text(
                                TotalMark?.key??"",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w/26,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 16, bottom: 16),
                                child: LinearProgressIndicator(
                                  value: TotalMark?.value==null?0/25:int.tryParse(TotalMark?.value??"")! / 25,
                                  backgroundColor: Colors.white,
                                  color: ColorPalette.primary,
                                  minHeight: 10,
                                ),
                              ),
                              Text(
                                TotalMark?.value==null?"0/25":"(${TotalMark?.value}/25)",
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
                        label: "Task Quality",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand,
                        onTap: () {
                          setState(() {
                            isExpand = !isExpand;
                            Variable.perfomanceName = "Task Quality";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Technical Skills and Innovation",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand2,
                        onTap: () {
                          setState(() {
                            isExpand2 = !isExpand2;
                            Variable.perfomanceName = "Technical Skills and Innovation";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Team Collaboration and Leadership",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand3,
                        onTap: () {
                          setState(() {
                            isExpand3 = !isExpand3;
                            Variable.perfomanceName = "Team Collaboration and Leadership";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Business Requirements",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand4,
                        onTap: () {
                          setState(() {
                            isExpand4 = !isExpand4;
                            Variable.perfomanceName =
                                "Business Requirements";
                            print("das${Variable.perfomanceName}");
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PerformanceExpansionTile(
                        load: grpVal,
                        label: "Efficient Time Management",
                        pointlist: pointList,
                        tasklist: widget.tasklist,
                        isExpand: isExpand5,
                        onTap: () {
                          setState(() {
                            isExpand5 = !isExpand5;
                            Variable.perfomanceName = "Efficient Time Management";
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
