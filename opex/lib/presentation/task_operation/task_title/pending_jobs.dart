import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
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
  List<GetTaskList>taskList = [];

  @override
  void initState() {
    context.read<TaskBloc>().add(GetPendingTaskListEvent());
    context.read<JobBloc>().add(GetStatusListEvent());
    super.initState();
  }
  List<StatusListing>? statusList;
  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    return MultiBlocListener(
  listeners: [
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if(state is GetPendingTaskListLoading){

        }
        if(state is GetPendingTaskListSuccess){
          taskList=state.taskList;
          setState(() {

          });
        }
      },
),
    BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        print("Status Of$state");
        if(state is GetStatusListLoading){
          customCupertinoLoading();
        }
        if(state is GetStatusListSuccess){
          statusList=state.statusList;
          setState(() {

          });
        }
      },
    ),
  ],
  child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(label: " Pending Job List",
        isAction: false,

            onTap: () {

            },),
        ),
        body: SingleChildScrollView(
          child:
          taskList.isEmpty?
          Container(
            padding: EdgeInsets.only(top: 15),
            height: h/3,
            child: SvgPicture.string(TaskSvg().nolistSvg),
          ):
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 16, right: 16, bottom: 30),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total ${taskList.length} Jobs",
                            style: GoogleFonts.roboto(
                              color: const Color(0xff151522),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: 120,
                          //       height: 37,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(5),
                          //         border: Border.all(
                          //           color: Color(0xffe6ecf0), width: 1,),
                          //         boxShadow: const [
                          //           BoxShadow(
                          //             color: Color(0x05000000),
                          //             blurRadius: 8,
                          //             offset: Offset(1, 1),
                          //           ),
                          //         ],
                          //         color: Colors.white,
                          //       ),
                          //     ), SizedBox(width: 10,),
                          //     Container(
                          //         width: 37,
                          //         height: 37,
                          //         padding: EdgeInsets.all(8),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           border: Border.all(
                          //             color: Color(0xffe6ecf0), width: 1,),
                          //           boxShadow: const [
                          //             BoxShadow(
                          //               color: Color(0x05000000),
                          //               blurRadius: 8,
                          //               offset: Offset(1, 1),
                          //             ),
                          //           ],
                          //           color: Colors.white,
                          //         ),
                          //         child: SvgPicture.string(
                          //             TaskSvg().moreTaskIcon))
                          //   ],
                          // ),
                        ]),
                    const SizedBox(height: 16,),
                    Container(
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
                              child: MyJobCard(tasksList: taskList[i],isPinned: false,statusList: statusList,status: taskList[i].statusName??"",
                              isPending: true,),
                            );
                          },
                          itemCount: taskList.length),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
);
  }
}
