import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
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
    context.read<JobBloc>().add(GetNewJobListEvent());
    super.initState();
  }
  void refresh(){
    context.read<JobBloc>().add(GetJobListEvent());
    setState(() {

    });
  }
  List<StatusListing>? statusList;
  List<GetTaskList> taskList = [];
  List<GetJobList> jobList = [];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return MultiBlocListener(
      listeners: [
        BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            print("Status Of$state");
            if (state is GetNewJobListLoading) {
              customCupertinoLoading();
            }
            if (state is GetNewJobListSuccess) {
              jobList = state.jobList;
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
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 30),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total ${jobList.length} Jobs",
                        style: GoogleFonts.roboto(
                          color:  ColorPalette.black,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ]),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color(0xffe6ecf0), width: 1,),
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
                                      style: TextStyle(
                                          color: Colors.black)),
                                );
                              }).toList(),
                              value: selectedType,
                              onChanged: (dynamic value) {


                                setState(() {
                                  selectedType = value;
                                  selectedType=="Pending Jobs"?context.read<JobBloc>().add( GetFilterJobListEvent("PENDING")):
                                  selectedType=="On Progress"?context.read<JobBloc>().add( GetFilterJobListEvent("ON PROGRESS")):
                                  selectedType=="Completed"?context.read<JobBloc>().add( GetFilterJobListEvent("COMPLETED")):
                                  context.read<JobBloc>().add(const GetNewJobListEvent());
                                });

                              },
                              hint: Text(
                                "All Jobs",
                                style: GoogleFonts.poppins(
                                    color:Colors.grey,fontSize: 14),
                              )),
                        ), SizedBox(width: 10,),
                        Container(
                            width: 37,
                            height: 37,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xffe6ecf0), width: 1,),
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
                              elevation: 0,
                                borderRadius: BorderRadius.circular(8),
                                isExpanded: true,

                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                underline: Container(),
                                items: assignTypeList.map((String items) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: items,
                                    child: Text(" $items",
                                        style: TextStyle(color: Colors.black)),
                                  );
                                }).toList(),
                                value: selectedType,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    selectedType = value;
                                    selectedType == "Pending Jobs"
                                        ? context.read<JobBloc>().add(
                                            GetFilterJobListEvent("PENDING"))
                                        : selectedType == "On Progress"
                                            ? context.read<JobBloc>().add(
                                                GetFilterJobListEvent(
                                                    "ON PROGRESS"))
                                            : selectedType == "Completed"
                                                ? context.read<JobBloc>().add(
                                                    GetFilterJobListEvent(
                                                        "COMPLETED"))
                                                : context.read<JobBloc>().add(
                                                    const GetNewJobListEvent());
                                  });
                                },
                                hint: Text(
                                  " All Jobs",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontSize: 14),
                                )),
                          ),
                          // SizedBox(width: 10,),
                          // Container(
                          //     width: 37,
                          //     height: 37,
                          //     padding: EdgeInsets.all(8),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       border: Border.all(
                          //         color: Color(0xffe6ecf0), width: 1,),
                          //       boxShadow: const [
                          //         BoxShadow(
                          //           color: Color(0x05000000),
                          //           blurRadius: 8,
                          //           offset: Offset(1, 1),
                          //         ),
                          //       ],
                          //       color: Colors.white,
                          //
                          //     ),
                          //     child: SvgPicture.string(
                          //         TaskSvg().moreTaskIcon)),
                        ],
                      ),
                    
                const SizedBox(
                  height: 16,
                ),
                jobList.isEmpty
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
                            separatorBuilder: (BuildContext cxt, int i) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {},
                                child: JobCard(joblist: jobList[i]),
                                // MyJobCard(isPinned: false,
                                //   isTaskCard: false,
                                //   jobsList: jobList[i],
                                // ),
                              );
                            },
                            itemCount: jobList.length),
                      ),
                // const SizedBox(height: 10,),
                // MyJobCard(status: "progress",),
                // const SizedBox(height: 10,),
                // MyJobCard(
                //   status: "pending",
                // ),
                // const SizedBox(height: 10,),
                // MyJobCard(status: "completed"),
              ])
            ),
          ),
        ),
    


);


  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
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
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Change Status To:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: h / 2.25,
                      child: ListView.separated(
                          shrinkWrap: true,
                          primary: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  onSelect(index);

                                  setState((){});
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: w,
                                  padding: const EdgeInsets.all(16),
                                  color:select==index? Color(0x194b9c25):Colors.white,
                                  child: Row(
                                    children: [
                                      SvgPicture.string(select==index?TaskSvg().checkActiveIcon:TaskSvg().checkInActiveIcon),
                                      const SizedBox(width: 16,),
                                      Text(
                                        "Completed",
                                        style: select==index?GoogleFonts.roboto(
                                          color: Color(0xff50d166),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ):  GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => Container(
                            width: w,
                                height: 1,
                                margin: const EdgeInsets.only(left: 16, right: 16),
                                color: const Color(0xffE6ECF0),
                              ),
                          itemCount: 6),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
