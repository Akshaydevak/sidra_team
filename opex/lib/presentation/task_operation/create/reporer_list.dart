import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common_widgets/loading.dart';
import '../../../core/color_palatte.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../home/bloc/job_bloc.dart';
import '../home/model/joblist_model.dart';
import '../task_svg.dart';
import '../task_title/job_card.dart';

class ReporterList extends StatefulWidget {
  const ReporterList({super.key});

  @override
  State<ReporterList> createState() => _ReporterListState();
}

class _ReporterListState extends State<ReporterList> {

  List<GetJobList> joblist = [];
  String? selectedType;
  bool isFilter=false;
  @override
  void initState() {
    context.read<JobBloc>().add(GetReorterListEvent('','',''));
    super.initState();
  }
  String nextUrl = "";
  String prevUrl = "";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: ()async{
        context.read<JobBloc>().add(GetReorterListEvent('','',''));
        // context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      key: _refreshIndicatorKey,
      color: ColorPalette.primary,
      // backgroundColor: Colors.transparent,

      strokeWidth: 2.0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Reporter",
            isAction: false,
            onTap: () {},
          ),
        ),
        body: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            if (state is GetReporterListLoading) {
              return LottieLoader();
            }
            if (state is GetReporterListSuccess) {
              nextUrl=state.nextPageUrl??"";
              prevUrl=state.prevPageUrl??"";
              joblist = state.jobList??[];
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "Reporting Person: for these tasks (${joblist.length})",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: w / 26,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          // Spacer(),
                          // Container(
                          //   width: 120,
                          //   height: 37,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     border: Border.all(
                          //       color: Color(0xffe6ecf0),
                          //       width: 1,
                          //     ),
                          //     boxShadow: const [
                          //       BoxShadow(
                          //         color: Color(0x05000000),
                          //         blurRadius: 8,
                          //         offset: Offset(1, 1),
                          //       ),
                          //     ],
                          //     color: Colors.white,
                          //   ),
                          //   child: DropdownButton(
                          //       isExpanded: true,
                          //       icon: Icon(Icons.keyboard_arrow_down_outlined),
                          //       underline: Container(),
                          //       items: assignTypeList.map((String items) {
                          //         return DropdownMenuItem(
                          //           enabled: true,
                          //           value: items,
                          //           child: Text(items,
                          //               style: TextStyle(color: Colors.black)),
                          //         );
                          //       }).toList(),
                          //       value: selectedType,
                          //       onChanged: (dynamic value) {
                          //         setState(() {
                          //           isFilter=true;
                          //           selectedType = value;
                          //           selectedType == "Pending Jobs"
                          //               ? context.read<JobBloc>().add(
                          //               GetFilterJobListEvent("PENDING"))
                          //               : selectedType == "On Progress"
                          //               ? context.read<JobBloc>().add(
                          //               GetFilterJobListEvent(
                          //                   "ON PROGRESS"))
                          //               : selectedType == "Completed"
                          //               ? context.read<JobBloc>().add(
                          //               GetFilterJobListEvent(
                          //                   "COMPLETED"))
                          //               : context.read<JobBloc>().add(GetNewJobListEvent('','',''));
                          //         });
                          //       },
                          //       hint: Text(
                          //         "All Jobs",
                          //         style: GoogleFonts.poppins(
                          //             color: Colors.grey, fontSize: 14),
                          //       )),
                          // ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      joblist.isEmpty?
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        height: h / 3.5,
                        child: SvgPicture.string(TaskSvg().nolistSvg),
                      ):
                      Container(
                        // height: h/1.3,
                        padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                        width: w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "New Jobs",
                            //   style: GoogleFonts.roboto(
                            //     color: Color(0xff151522),
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),

                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  separatorBuilder: (BuildContext cxt, int i) {
                                    return const SizedBox(
                                      height: 5,
                                    );
                                  },
                                  itemBuilder: (BuildContext context, int i) {
                                    return InkWell(
                                      onTap: () {},
                                      child: JobCard(joblist: joblist[i]),
                                    );
                                  },
                                  itemCount: joblist.length),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15,bottom: 20,right: 15,left: 15
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            prevUrl != ""
                                ? GestureDetector(
                              onTap: () {
                                context.read<JobBloc>().add(
                                    GetReorterListEvent(
                                        '',
                                        '',
                                        prevUrl));
                                // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                              },
                              child: Text(
                                "Previous",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.primary,
                                    fontSize: w / 24),
                              ),
                            )
                                : Container(),
                            nextUrl != ""
                                ? GestureDetector(
                              onTap: () {
                                // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                setState(() {
                                  context.read<JobBloc>().add(
                                      GetReorterListEvent(
                                          '',
                                          nextUrl,
                                          ""));
                                });
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.primary,
                                    fontSize: w / 24),
                              ),
                            )
                                : Text("")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if(state is GetReporterListFailed){
              joblist=[];
              return joblist.isEmpty?  Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                height: h / 3.5,
                child: SvgPicture.string(TaskSvg().nolistSvg),
              ):
              Container();
            }
            return  Container();
          },
        ),
      ),
    );
  }
}
