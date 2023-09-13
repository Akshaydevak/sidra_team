import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../promotion_app/blocs/discount_bloc/discount_bloc.dart';
import '../../promotion_app/dropdown_card.dart';
import 'critirea_card.dart';

class CritireaPerformance extends StatefulWidget {
  const CritireaPerformance({Key? key}) : super(key: key);

  @override
  State<CritireaPerformance> createState() => _CritireaPerformanceState();
}

class _CritireaPerformanceState extends State<CritireaPerformance> {
  int? offerperiodId;
  String? offerPeriodName;
  CriteriaRead? readCriteria;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return BlocListener<TaskBloc, TaskState>(
  listener: (context, state) {
    print("DASASAS$state");

    if(state is GetCriteriaReadLoading){

    }
    if(state is GetCriteriaReadSuccess){
      print("RRRRR${state.criteriaRead}");
      readCriteria=state.criteriaRead;
      print("sssaasa${readCriteria?.attittude}");
      setState(() {

      });
    }
    if(state is GetCriteriaReadFailed){
      readCriteria?.attittude?.clear();
      readCriteria?.projectCompletion?.clear();
      readCriteria?.punctuality?.clear();
      readCriteria?.teamManagement?.clear();
      readCriteria?.timeMange?.clear();
    }
  },
  child: Builder(
    builder: (context) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            DropDownCard(
              selValue: offerPeriodName,

              label: "Choose Task",
              onTap: () {
                context.read<TaskBloc>().add( TaskAssignedGroupListEvent("",""));
                _showModalBottomSheetOfferPeriod(offerPeriodName);
              },
            ),

            SizedBox(height: 5,),
            CritiriaCard(label: "Task Quality",list: readCriteria?.punctuality??[]),
            SizedBox(height: 5,),
            CritiriaCard(label: "Technical Skills and Innovation",list: readCriteria?.attittude??[],),
            SizedBox(height: 5,),
            CritiriaCard(label: "Team Collaboration and Leadership",list: readCriteria?.projectCompletion??[],),
            SizedBox(height: 5,),
            CritiriaCard(label: "Business Requirements",list: readCriteria?.teamManagement??[],),
            SizedBox(height: 5,),
            CritiriaCard(label: "Efficient Time Management",list: readCriteria?.teamManagement??[],),
            
          ],
        );
    }
  ),
);
  }

  _showModalBottomSheetOfferPeriod(
      String? offerPeriodNameNew) {
    int selectIndex = 0;
    List<GetTaskList> list=[];
    void onselect(int index) {
      setState(() {
        selectIndex = index;
      });
    }
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Select Task",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Container(
                          height: h / 1.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  BlocBuilder<TaskBloc, TaskState>(
                                    builder: (context, state) {
                                      print("SASAFA$state");
                                      if (state is GetTaskAssignedGroupListLoading) {
                                        Container(
                                            width: w,
                                            height: 300,
                                            child: customCupertinoLoading());
                                      }
                                      if (state is GetTaskAssignedGroupListSuccess) {
                                        print("OZFFDARA${state.offerPeriod.data}");

                                        list=state.offerPeriod.data;
                                        print("OZFFDARA${state.offerPeriod.nextPageUrl}");
                                        print("OZFFDARA${state.offerPeriod.count}");
                                        print("OZFFDARA${state.offerPeriod.count}");
                                        return Container(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ListView.separated(
                                                primary: true,
                                                shrinkWrap: true,
                                                itemCount: list.length,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) => Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        onselect(index);
                                                        setState(() {});
                                                        context.read<TaskBloc>().add(
                                                            GetCriteriaReadEvent(list[index].taskCode??""));
                                                        offerperiodId = list[index].id ??
                                                            0;
                                                        offerPeriodName = list[index].taskName ??
                                                            "";
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){
                                                              onselect(index);
                                                              setState(() {});
                                                              context.read<TaskBloc>().add(
                                                                  GetCriteriaReadEvent(list[index].taskCode??""));
                                                              offerperiodId = list[index].id ??
                                                                  0;
                                                              offerPeriodName = list[index].taskName ??
                                                                  "";
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.only(
                                                                  left: 8,
                                                                  bottom: 10,
                                                                  top: 5,
                                                                  right: 8),
                                                              child: SvgPicture.string(list[index]
                                                                  .taskName ==
                                                                  offerPeriodNameNew
                                                              // selectIndex == index
                                                                  ? HomeSvg().radioButtonActive
                                                                  : HomeSvg().radioInActive),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            list[index].taskName ??
                                                                "",
                                                            style: GoogleFonts.roboto(
                                                              color: Colors.black,
                                                              fontSize: w / 24,
                                                              // fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // Spacer(),
                                                    // GestureDetector(
                                                    //   onTap: () {
                                                    //
                                                    //     context.read<DiscountBloc>().add(
                                                    //         GetOfferPeriodReadEvent(state
                                                    //             .offerPeriod
                                                    //             .data[index]
                                                    //             .id ??
                                                    //             0));
                                                    //     context.read<DiscountBloc>().add(
                                                    //         PaginatedOfferPeriodEvent("",""));
                                                    //   },
                                                    //   child: Text(
                                                    //     "View",
                                                    //     style: TextStyle(
                                                    //         fontWeight: FontWeight.w500,
                                                    //         color: ColorPalette.primary,
                                                    //         fontSize: w / 24),
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                separatorBuilder: (context, index) =>
                                                    Container(
                                                      color: ColorPalette.divider,
                                                      height: 1,
                                                      width: w,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     state.offerPeriod.count==null?Text(""):
                                              //     GestureDetector(
                                              //       onTap: (){
                                              //         context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent(state.offerPeriod.nextPageUrl??"",state.offerPeriod.count));
                                              //       },
                                              //       child: Text(
                                              //         "Previous",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //     state.offerPeriod.nextPageUrl==null?Text(""):
                                              //     GestureDetector(
                                              //       onTap: (){
                                              //         context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent(state.offerPeriod.nextPageUrl??"",""));
                                              //       },
                                              //       child: Text(
                                              //         "Next",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //
                                              //   ],
                                              // ),
                                              // GradientButton(
                                              //     color: ColorPalette.primary,
                                              //     onPressed: () {
                                              //
                                              //     },
                                              //     gradient: const LinearGradient(
                                              //         begin: Alignment.topCenter,
                                              //         end: Alignment.bottomCenter,
                                              //         colors: [
                                              //           ColorPalette.primary,
                                              //           ColorPalette.primary
                                              //         ]),
                                              //     child: Text(
                                              //       "Create New",
                                              //       textAlign: TextAlign.center,
                                              //       style: GoogleFonts.roboto(
                                              //         color: Colors.white,
                                              //         fontSize: w / 22,
                                              //         fontWeight: FontWeight.w600,
                                              //       ),
                                              //     )),
                                            ],
                                          ),
                                        );
                                      }
                                      return Container(
                                          width: w,
                                          height: 300,
                                          child: customCupertinoLoading());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           // refresh();
                    //           Navigator.pop(context);
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Select Task Type",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          );
        });
  }
  // _showModalBottomSheetOfferPeriod(String? offerPeriodNameNew) {
  //   int selectIndex = 0;
  //   List<GetTaskList> list=[];
  //   void onselect(int index) {
  //     setState(() {
  //       selectIndex = index;
  //     });
  //   }
  //
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(18), topRight: Radius.circular(18)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         var h = MediaQuery.of(context).size.height;
  //         var w = MediaQuery.of(context).size.width;
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Container(
  //               width: double.infinity,
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(10),
  //                     topLeft: Radius.circular(10),
  //                   )),
  //               alignment: Alignment.center,
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: 10,),
  //                     Text(
  //                       "Select Task",
  //                       style: GoogleFonts.roboto(
  //                         color: Colors.black,
  //                         fontSize: w / 20,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                     // SizedBox(height: 10,),
  //                     BlocBuilder<TaskBloc, TaskState>(
  //                       builder: (context, state) {
  //                         print("SASAFA$state");
  //                         if (state is GetTaskAssignedGroupListLoading) {
  //                           Container(
  //                               width: w,
  //                               height: 300,
  //                               child: customCupertinoLoading());
  //                         }
  //                         if (state is GetTaskAssignedGroupListSuccess) {
  //                           print("OZFFDARA${state.offerPeriod.data}");
  //
  //                          list=state.offerPeriod.data;
  //                           print("OZFFDARA${state.offerPeriod.nextPageUrl}");
  //                           print("OZFFDARA${state.offerPeriod.count}");
  //                           print("OZFFDARA${state.offerPeriod.count}");
  //                           return Container(
  //                             padding: EdgeInsets.all(16),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 ListView.separated(
  //                                   primary: true,
  //                                   shrinkWrap: true,
  //                                   itemCount: list.length,
  //                                   physics:
  //                                   const NeverScrollableScrollPhysics(),
  //                                   itemBuilder: (context, index) => Row(
  //                                     children: [
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           onselect(index);
  //                                           setState(() {});
  //                                           context.read<TaskBloc>().add(
  //                                                     GetCriteriaReadEvent(list[index].taskCode??""));
  //                                           offerperiodId = list[index].id ??
  //                                               0;
  //                                           offerPeriodName = list[index].taskName ??
  //                                               "";
  //                                           Navigator.pop(context);
  //                                         },
  //                                         child: Row(
  //                                           children: [
  //                                             GestureDetector(
  //                                               onTap: (){
  //                                                 onselect(index);
  //                                                 setState(() {});
  //                                                 context.read<TaskBloc>().add(
  //                                                     GetCriteriaReadEvent(list[index].taskCode??""));
  //                                                 offerperiodId = list[index].id ??
  //                                                     0;
  //                                                 offerPeriodName = list[index].taskName ??
  //                                                     "";
  //                                                 Navigator.pop(context);
  //                                               },
  //                                               child: Container(
  //                                                 padding: const EdgeInsets.only(
  //                                                     left: 8,
  //                                                     bottom: 10,
  //                                                     top: 5,
  //                                                     right: 8),
  //                                                 child: SvgPicture.string(list[index]
  //                                                     .taskName ==
  //                                                     offerPeriodNameNew
  //                                                 // selectIndex == index
  //                                                     ? HomeSvg().radioButtonActive
  //                                                     : HomeSvg().radioInActive),
  //                                               ),
  //                                             ),
  //                                             SizedBox(
  //                                               width: 5,
  //                                             ),
  //                                             Text(
  //                                               list[index].taskName ??
  //                                                   "",
  //                                               style: GoogleFonts.roboto(
  //                                                 color: Colors.black,
  //                                                 fontSize: w / 22,
  //                                                 fontWeight: FontWeight.w500,
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //
  //                                       // Spacer(),
  //                                       // GestureDetector(
  //                                       //   onTap: () {
  //                                       //
  //                                       //     context.read<DiscountBloc>().add(
  //                                       //         GetOfferPeriodReadEvent(state
  //                                       //             .offerPeriod
  //                                       //             .data[index]
  //                                       //             .id ??
  //                                       //             0));
  //                                       //     context.read<DiscountBloc>().add(
  //                                       //         PaginatedOfferPeriodEvent("",""));
  //                                       //   },
  //                                       //   child: Text(
  //                                       //     "View",
  //                                       //     style: TextStyle(
  //                                       //         fontWeight: FontWeight.w500,
  //                                       //         color: ColorPalette.primary,
  //                                       //         fontSize: w / 24),
  //                                       //   ),
  //                                       // )
  //                                     ],
  //                                   ),
  //                                   separatorBuilder: (context, index) =>
  //                                       Container(
  //                                         color: ColorPalette.divider,
  //                                         height: 1,
  //                                         width: w,
  //                                       ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 30,
  //                                 ),
  //                                 // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 //   children: [
  //                                 //     state.offerPeriod.count==null?Text(""):
  //                                 //     GestureDetector(
  //                                 //       onTap: (){
  //                                 //         context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent(state.offerPeriod.nextPageUrl??"",state.offerPeriod.count));
  //                                 //       },
  //                                 //       child: Text(
  //                                 //         "Previous",
  //                                 //         style: TextStyle(
  //                                 //             fontWeight: FontWeight.w500,
  //                                 //             color: ColorPalette.primary,
  //                                 //             fontSize: w / 24),
  //                                 //       ),
  //                                 //     ),
  //                                 //     state.offerPeriod.nextPageUrl==null?Text(""):
  //                                 //     GestureDetector(
  //                                 //       onTap: (){
  //                                 //         context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent(state.offerPeriod.nextPageUrl??"",""));
  //                                 //       },
  //                                 //       child: Text(
  //                                 //         "Next",
  //                                 //         style: TextStyle(
  //                                 //             fontWeight: FontWeight.w500,
  //                                 //             color: ColorPalette.primary,
  //                                 //             fontSize: w / 24),
  //                                 //       ),
  //                                 //     ),
  //                                 //
  //                                 //   ],
  //                                 // ),
  //                                 // GradientButton(
  //                                 //     color: ColorPalette.primary,
  //                                 //     onPressed: () {
  //                                 //
  //                                 //     },
  //                                 //     gradient: const LinearGradient(
  //                                 //         begin: Alignment.topCenter,
  //                                 //         end: Alignment.bottomCenter,
  //                                 //         colors: [
  //                                 //           ColorPalette.primary,
  //                                 //           ColorPalette.primary
  //                                 //         ]),
  //                                 //     child: Text(
  //                                 //       "Create New",
  //                                 //       textAlign: TextAlign.center,
  //                                 //       style: GoogleFonts.roboto(
  //                                 //         color: Colors.white,
  //                                 //         fontSize: w / 22,
  //                                 //         fontWeight: FontWeight.w600,
  //                                 //       ),
  //                                 //     )),
  //                               ],
  //                             ),
  //                           );
  //                         }
  //                         return Container(
  //                             width: w,
  //                             height: 300,
  //                             child: customCupertinoLoading());
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }
}
