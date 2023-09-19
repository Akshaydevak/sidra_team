import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/loading.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../home/bloc/job_bloc.dart';
import '../home/model/joblist_model.dart';
import '../home/my_job_card.dart';
import '../task_svg.dart';

class PendingJobs extends StatefulWidget {
  const PendingJobs({Key? key}) : super(key: key);

  @override
  State<PendingJobs> createState() => _PendingJobsState();
}

class _PendingJobsState extends State<PendingJobs> {
  List<GetTaskList> taskList = [];

  @override
  void initState() {
    context.read<TaskBloc>().add(GetPendingTaskListEvent());
    context.read<JobBloc>().add(GetStatusListEvent());
    super.initState();
  }

  List<StatusListing>? statusList;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is GetPendingTaskListLoading) {}
            if (state is GetPendingTaskListSuccess) {
              taskList = state.taskList;
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: " Pending Job List",
            onTap: () {},
            isAction: false,
          ),
        ),
        body: SingleChildScrollView(
          child: 

              BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    print("pendingffff$state");
                      if (state is GetPendingTaskListLoading) {
                        return LottieLoader();
                      }
            if (state is GetPendingTaskListSuccess) {
              taskList = state.taskList;
          
                    return
                      taskList.isEmpty
                          ? Container(
                              padding: EdgeInsets.all(25),
                              height: h / 3,
                              child: SvgPicture.string(TaskSvg().nolistSvg),
                            )
                          :
                          Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 16, right: 16, bottom: 30),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total ${taskList.length} Jobs",
                                      style: GoogleFonts.roboto(
                                        color: const Color(0xff151522),
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
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
                                        height: 5,
                                      );
                                    },
                                    itemBuilder: (BuildContext context, int i) {
                                      return InkWell(
                                        onTap: () {},
                                        child: MyJobCard(
                                          tasksList: taskList[i],
                                          isPinned: false,
                                          statusList: statusList,
                                          status: taskList[i].statusName ?? "",
                                          isPending: true,
                                        ),
                                      );
                                    },
                                    itemCount: taskList.length),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }
            if(state is GetPendingTaskListFailed){
              taskList=[];
              return  Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                height: h / 3.5,
                child: SvgPicture.string(TaskSvg().nolistSvg),
              );
            }
            return Container();
                  },
                ),
        ),
      ),
    );
  }
}
