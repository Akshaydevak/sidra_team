import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../create/model/task_models.dart';
import '../task_title/job_card.dart';
import 'model/joblist_model.dart';
import 'my_job_card.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({Key? key}) : super(key: key);

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  int select = 0;
  List<String> assignTypeList = [
    "All Jobs",
    "Pending Jobs",
    "On Progress",
    "Completed"
  ];

  String? selectedType;

  void onSelect(int val) {
    select = val;
    setState(() {});
  }

  @override
  void initState() {
    context.read<JobBloc>().add(GetNewJobListEvent('', '', ''));
    super.initState();
  }

  void refresh() {
    context.read<JobBloc>().add(GetJobListEvent());
    setState(() {});
  }

  List<StatusListing>? statusList;
  List<GetTaskList> taskList = [];
  List<GetJobList> jobList = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<JobBloc>().add(GetNewJobListEvent('', '', ''));
        // context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      key: _refreshIndicatorKey,
      color: ColorPalette.primary,
      // backgroundColor: Colors.transparent,

      strokeWidth: 2.0,
      child: MultiBlocListener(
        listeners: [
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              print("Status Of$state");
              if (state is GetNewJobListLoading) {
                customCupertinoLoading();
              }
              if (state is GetNewJobListSuccess) {
                jobList = state.jobList ?? [];
                setState(() {});
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              print("stateeeeee $state");
              if (state is GetFilterJobListLoading) {
                customCupertinoLoading();
              }
              if (state is GetFilterJobListSuccess) {
                jobList = state.jobList;
                setState(() {});
              }
              if (state is GetFilterJobListFailed) {
                print("Failed JOBLIST");

                jobList.clear();
                setState(() {});
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              print("Status Of$state");
              if (state is GetStatusListLoading) {
                customCupertinoLoading();
              }
              if (state is GetStatusListSuccess) {
                statusList = state.statusList;
                setState(() {});
              }
            },
          ),
        ],
        child: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 16, right: 16, bottom: 30),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total ${jobList.length} Jobs",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color(0xffe6ecf0),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: DropdownButton(
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              underline: Container(),
                              items: assignTypeList.map((String items) {
                                return DropdownMenuItem(
                                  enabled: true,
                                  value: items,
                                  child: Text(items,
                                      style: TextStyle(color: Colors.black,fontSize: w/26)),
                                );
                              }).toList(),
                              value: selectedType,
                              onChanged: (dynamic value) {
                                jobList.clear();
                                setState(() {
                                  selectedType = value;
                                  selectedType == "Pending Jobs"
                                      ? context
                                          .read<JobBloc>()
                                          .add(GetFilterJobListEvent("PENDING"))
                                      : selectedType == "On Progress"
                                          ? context.read<JobBloc>().add(
                                              GetFilterJobListEvent(
                                                  "ON PROGRESS"))
                                          : selectedType == "Completed"
                                              ? context.read<JobBloc>().add(
                                                  GetFilterJobListEvent(
                                                      "COMPLETED"))
                                              : context.read<JobBloc>().add(
                                                  GetNewJobListEvent(
                                                      '', '', ''));
                                });
                              },
                              hint: Text(
                                "All Jobs",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 14),
                              )),
                        ),
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  selectedType != null && selectedType != 'All Jobs'
                      ? BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            if (state is GetFilterJobListLoading) {
                              return LottieLoader();
                            }
                            if (state is GetFilterJobListSuccess) {
                              jobList = state.jobList ?? [];
                              print("joblist filter$jobList");
                              return jobList.isEmpty
                                  ? Container(
                                      padding: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      height: h / 2,
                                      child: SvgPicture.string(
                                        TaskSvg().nolistSvg,
                                        height: h / 4.5,
                                      ),
                                    )
                                  : Container(
                                      //color: Colors.yellow,
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          separatorBuilder:
                                              (BuildContext cxt, int i) {
                                            return const SizedBox(
                                              height: 10,
                                            );
                                          },
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {},
                                              child: JobCard(
                                                  joblist: jobList[i],
                                                  isReporter: false),
                                              // MyJobCard(isPinned: false,
                                              //   isTaskCard: false,
                                              //   jobsList: jobList[i],
                                              // ),
                                            );
                                          },
                                          itemCount: jobList.length),
                                    );
                            }

                            return Container();
                          },
                        )
                      : BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            if (state is GetNewJobListLoading) {
                              return LottieLoader();
                            }
                            if (state is GetNewJobListSuccess) {
                              jobList = state.jobList ?? [];
                              print("joblist notmal$jobList");
                              return jobList.isEmpty
                                  ? Container(
                                      padding: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      height: h / 2,
                                      child: SvgPicture.string(
                                        TaskSvg().nolistSvg,
                                        height: h / 4.5,
                                      ),
                                    )
                                  : Container(
                                      //color: Colors.yellow,
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          separatorBuilder:
                                              (BuildContext cxt, int i) {
                                            return const SizedBox(
                                              height: 10,
                                            );
                                          },
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {},
                                              child: JobCard(
                                                  joblist: jobList[i],
                                                  isReporter: false),
                                              // MyJobCard(isPinned: false,
                                              //   isTaskCard: false,
                                              //   jobsList: jobList[i],
                                              // ),
                                            );
                                          },
                                          itemCount: jobList.length),
                                    );
                            }

                            return Container();
                          },
                        ),
                ])),
          ),
        ),
      ),
    );
  }
}
