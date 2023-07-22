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
                label: "Individual",
                // EndIcon: GestureDetector(
                //   onTap: () {
                //     // PersistentNavBarNavigator.pushNewScreen(
                //     //   context,
                //     //   screen: CreatePerformance(),
                //     //   withNavBar: true, // OPTIONAL VALUE. True by default.
                //     //   pageTransitionAnimation: PageTransitionAnimation.fade,
                //     // );
                //   },
                //   child: Container(
                //     // width: 110,
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: ColorPalette.primary,
                //     ),
                //     alignment: Alignment.center,
                //
                //     child: Text(
                //       "Create",
                //       textAlign: TextAlign.center,
                //       style: GoogleFonts.roboto(
                //         color: Colors.white,
                //         fontSize: 20,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
              ),
              Container(
                height: h / 1.3,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: Container(
                        //         width: w / 2.5,
                        //         height: 50,
                        //         padding: EdgeInsets.all(10),
                        //         decoration: isSelected == true
                        //             ? BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: Color(0x05000000),
                        //                     blurRadius: 8,
                        //                     offset: Offset(1, 1),
                        //                   ),
                        //                 ],
                        //                 color: ColorPalette.cardBackground,
                        //               )
                        //             : BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 border: Border.all(
                        //                   color: Color(0xffe6ecf0),
                        //                   width: 1,
                        //                 ),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: Color(0x05000000),
                        //                     blurRadius: 8,
                        //                     offset: Offset(1, 1),
                        //                   ),
                        //                 ],
                        //                 color: Colors.white,
                        //               ),
                        //         child: Row(
                        //           children: [
                        //             GestureDetector(
                        //               onTap: () {
                        //                 setState(() {
                        //                   isSelected =
                        //                       !isSelected;
                        //                 });
                        //               },
                        //               child: isSelected == true
                        //                   ? SvgPicture.string(
                        //                       HomeSvg().radioButtonActive)
                        //                   : SvgPicture.string(
                        //                       HomeSvg().radioButtonInActive),
                        //             ),
                        //             SizedBox(
                        //               width: 5,
                        //             ),
                        //             Text(
                        //               "Criteria",
                        //               style: isSelected == true
                        //                   ? GoogleFonts.roboto(
                        //                       color: ColorPalette.black,
                        //                       fontSize: w / 25,
                        //                       fontWeight: FontWeight.w500,
                        //                     )
                        //                   : GoogleFonts.roboto(
                        //                       color: ColorPalette.black,
                        //                       fontSize: w / 25,
                        //                       fontWeight: FontWeight.w400,
                        //                     ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     Container(
                        //       width: w / 2.5,
                        //       height: 50,
                        //       padding: EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         border: isSelected == false
                        //             ? Border.all(color: Colors.white)
                        //             : Border.all(
                        //                 color: Color(0xffe6ecf0),
                        //                 width: 1,
                        //               ),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Color(0x05000000),
                        //             blurRadius: 8,
                        //             offset: Offset(1, 1),
                        //           ),
                        //         ],
                        //         color: isSelected == false
                        //             ? ColorPalette.cardBackground
                        //             : Colors.white,
                        //       ),
                        //       child: Row(
                        //         children: [
                        //           GestureDetector(
                        //             onTap: () {
                        //               isSelected =
                        //               !isSelected;
                        //               setState(() {});
                        //             },
                        //             child: isSelected == false
                        //                 ? SvgPicture.string(
                        //                     HomeSvg().radioButtonActive)
                        //                 : SvgPicture.string(
                        //                     HomeSvg().radioButtonInActive),
                        //           ),
                        //           SizedBox(
                        //             width: 5,
                        //           ),
                        //           Text(
                        //             "Individual",
                        //             style: isSelected == false
                        //                 ? GoogleFonts.roboto(
                        //                     color: ColorPalette.black,
                        //                     fontSize: w / 25,
                        //                     fontWeight: FontWeight.w500,
                        //                   )
                        //                 : GoogleFonts.roboto(
                        //                     color: ColorPalette.black,
                        //                     fontSize: w / 25,
                        //                     fontWeight: FontWeight.w400,
                        //                   ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // DropDownCard(
                        //   selValue: offerPeriodName,
                        //
                        //   label: "Select Employee",
                        //   onTap: () {
                        //     context.read<JobBloc>().add(const GetEmployeeListEvent());
                        //     _showModalBottomSheetOfferPeriod(offerPeriodName);
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
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
