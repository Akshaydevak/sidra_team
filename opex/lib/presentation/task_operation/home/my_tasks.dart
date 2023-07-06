import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_job_card.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key}) : super(key: key);

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  int select = 0;

  void onSelect(int val) {
    select = val;
    setState(() {});
  }
  @override
  void initState() {
    context.read<JobBloc>().add(GetJobListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is GetJobListLoading) {
          customCupertinoLoading();
        }
        if (state is GetJobListSuccess) {
          print("Sucsess shifu");
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 16, right: 16, bottom: 30),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total ${state.jobList.length} Jobs",
                          style: GoogleFonts.roboto(
                            color: const Color(0xff151522),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                            ), SizedBox(width: 10,),
                            Container(
                                width: 37,
                                height: 37,
                                padding: EdgeInsets.all(8),
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
                                child: SvgPicture.string(TaskSvg().moreTaskIcon))
                          ],
                        ),
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
                            onTap: () {


                            },
                            // child: MyJobCard(
                            //   jobsList: state.jobList[i],isPinned: false,),
                          );
                        },
                        itemCount: state.jobList.length),
                  ),
                  // const SizedBox(height: 10,),
                  // MyJobCard(status: "progress",),
                  // const SizedBox(height: 10,),
                  // MyJobCard(
                  //   status: "pending",
                  // ),
                  // const SizedBox(height: 10,),
                  // MyJobCard(status: "completed"),
                ],
              ),
            ),
          );
        }
        return Container();
      },
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
