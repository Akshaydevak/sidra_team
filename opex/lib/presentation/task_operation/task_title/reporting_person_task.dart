import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common_snackBar.dart';
import '../../../core/utils/variables.dart';
import '../create/single_row.dart';
import '../employee_model/employee_model.dart';
import '../home/model/joblist_model.dart';
import '../task_operation_appbar.dart';
import '../task_svg.dart';

class ReportingPerson extends StatefulWidget {
  final bool editTask;
  final GetTaskList? readTask;
  final bool task;
  final bool job;
  final Function()? refresh;

  const ReportingPerson(
      {Key? key, required this.editTask, this.readTask,this.refresh, required this.task, required this.job})
      : super(key: key);

  @override
  State<ReportingPerson> createState() => _ReportingPersonState();
}

class _ReportingPersonState extends State<ReportingPerson> {
  List<GetEmployeeList> employee = [];
  List<GetUserList> userList = [];

  @override
  void initState() {
    context.read<JobBloc>().add(GetReportingPersonListEvent());
    // context.read<JobBloc>().add(GetRoleListEvent());
    context.read<JobBloc>().add(const GetUserUderGroupEvent());
    setState(() {});
    super.initState();
  }

  void read() {
    setState(() {
      context.read<JobBloc>().add(
          GetJobReadListEvent(widget.readTask?.jobId??0));
      context.read<TaskBloc>().add(
          GetTaskReadListEvent(widget.readTask?.id ?? 0));
      context.read<JobBloc>().add(const GetUserUderGroupEvent());
    });
  }

  GetJobList? JobRead;
  List<RoleList> roleList = [];
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return MultiBlocListener(
        listeners: [
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {


              if (state is UpdateReportingFailed) {
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is UpdateReportingSuccess) {
                Fluttertoast.showToast(
                    msg: "Reporting Person Changed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                Navigator.pop(context);
                context.read<TaskBloc>()
                    .add(
                    GetTaskReadListEvent(
                        widget.readTask
                            ?.id ?? 0));
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {


              if (state is UpdateTaskGroupFailed) {
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                );
              }
              if (state is UpdateTaskGroupSuccess) {
                Fluttertoast.showToast(
                    msg: 'Role Updated Successfully',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {

              if (state is GetReportingPersonListSuccess) {
                employee = state.employeeList;
                _isLoading=false;
                setState(() {

                });
                print("sucsess${state.employeeList}");
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {

              if (state is GetUserUderGroupSuccess) {
                userList = state.userlist;
                setState(() {

                });
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is GetRoleListSuccess) {
                roleList = state.roleList;

                setState(() {

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
                  label: "Reporting Person",
                  isAction: false,
                )
            ),
            body: Container(

                padding: EdgeInsets.all(16),
                child: ScrollConfiguration(
                    behavior: NoGlow(),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              if(_isLoading)...[
                                LottieLoader()
                              ]
                              else...[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Variable.reportingEmail==""?Container():
                                      Container(
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
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, right: 16, bottom: 10, top: 10),
                                              child: SingleRow(
                                                label: "Reporting Person",
                                                color: Color(0xffAD51E0),
                                                svg: TaskSvg().personIcon,
                                                endIcon: Container(),
                                                onTap: () {
                                                  setState(() {
                                                    // isReporting = !isReporting;
                                                  });
                                                },
                                              ),
                                            ),
                                            Divider(
                                              indent: 10,
                                              height: 2,
                                            ),
                                            widget.editTask?
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, right: 16, bottom: 16, top: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.string(TaskSvg().profileReporting),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      widget.readTask
                                                          ?.reportingPerson ?? "",
                                                      style: TextStyle(
                                                        color: ColorPalette.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ):
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, right: 16, bottom: 16, top: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.string(TaskSvg().profileReporting),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      Variable.reportingEmail ?? "",
                                                      style: TextStyle(
                                                        color: ColorPalette.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(4),
                                      //     border: Border.all(color: Color(
                                      //         0xffe6ecf0), width: 1,),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Color(0x05000000),
                                      //         blurRadius: 8,
                                      //         offset: Offset(1, 1),
                                      //       ),
                                      //     ],
                                      //     color: Colors.white,
                                      //   ),
                                      //   child: Column(
                                      //     children: [
                                      //       Container(
                                      //         margin: EdgeInsets.only(
                                      //             left: 16,
                                      //             right: 16,
                                      //             bottom:  16,
                                      //             top:  16),
                                      //         child: SingleRow(
                                      //           label: "Reporting Person",
                                      //           color: Color(0xffAD51E0),
                                      //           svg: TaskSvg().personIcon,
                                      //           endIcon: Container()
                                      //
                                      //           ,
                                      //           onTap: () {
                                      //             setState(() {
                                      //               // isReporting = !isReporting;
                                      //             });
                                      //           },
                                      //         ),
                                      //       ),
                                      //       widget.editTask ? Container(
                                      //           padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                      //           child: Row(
                                      //             children: [
                                      //               TextAvatar(
                                      //                 shape: Shape.Circular,
                                      //                 size: 40,
                                      //                 numberLetters: 2,
                                      //                 fontSize: w/22,
                                      //                 textColor: Colors.white,
                                      //                 fontWeight: FontWeight.w500,
                                      //                 text:widget.readTask
                                      //                     ?.reportingPerson.toString().toUpperCase() ,
                                      //               ),
                                      //               SizedBox(width: 20,),
                                      //               Text(widget.readTask
                                      //                   ?.reportingPerson ?? ""),
                                      //             ],
                                      //           )) :
                                      //       Container(
                                      //           padding: EdgeInsets.only(
                                      //               left: 16, bottom: 16),
                                      //           child: Row(
                                      //             children: [
                                      //               TextAvatar(
                                      //                 shape: Shape.Circular,
                                      //                 size: 40,
                                      //                 numberLetters: 2,
                                      //                 fontSize: w/22,
                                      //                 textColor: Colors.white,
                                      //                 fontWeight: FontWeight.w500,
                                      //                 text:Variable.reportingEmail.toString().toUpperCase() ,
                                      //               ),
                                      //               SizedBox(width: 10,),
                                      //               Text(
                                      //                   Variable.reportingEmail ??
                                      //                       ""),
                                      //             ],
                                      //           ))
                                      //     ],
                                      //   ),
                                      // ),

                                      Variable.reportingEmail==""?Container():SizedBox(height: 20,),

                                      Text(
                                        "Total ${employee.length} Users",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.black,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            //color: Colors.yellow,
                                            padding: const EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                physics: const ScrollPhysics(),
                                                separatorBuilder: (
                                                    BuildContext cxt, int i) {
                                                  return const SizedBox(
                                                    height: 5,
                                                  );
                                                },
                                                itemBuilder: (
                                                    BuildContext context, int i) {
                                                  return InkWell(
                                                    onTap: () {
                                                      if(widget.editTask==true){
                                                        Variable.reportingEmail =
                                                            employee[i]
                                                                .email ?? "";
                                                        Variable.reportingName =
                                                            employee[i]
                                                                .fname ?? "";
                                                        Variable
                                                            .reportingCode =
                                                            employee[i].userCode ?? "";
                                                        BlocProvider.of<
                                                            TaskBloc>(context).add(
                                                            UpdateReportingTaskEvent(
                                                              img5: widget.readTask?.metaData?.image5,
                                                              img1: widget.readTask?.metaData?.image1,
                                                              img4: widget.readTask?.metaData?.image4,
                                                              img2: widget.readTask?.metaData?.image2,
                                                              img3: widget.readTask?.metaData?.image3,
                                                              attachmentDescription: widget.readTask?.metaData?.description,
                                                              attachmentNote: widget.readTask?.metaData?.note,
                                                              latitude: widget.readTask?.latitude??"",
                                                              longitude: widget.readTask?.longitude??"",
                                                              id: widget.readTask
                                                                  ?.id ?? 0,
                                                              AssigningCode: widget
                                                                  .readTask
                                                                  ?.assigningCode ??
                                                                  "",
                                                              AssigningType: widget
                                                                  .readTask
                                                                  ?.assigningType ??
                                                                  "",
                                                              createdOn: "${widget
                                                                  .readTask
                                                                  ?.startDate
                                                                  ?.split(
                                                                  "T")[0]}"" ""${widget
                                                                  .readTask
                                                                  ?.startDate
                                                                  ?.split("T")[1]
                                                                  .split(
                                                                  "+")[0]}",
                                                              jobid: widget.readTask
                                                                  ?.jobId,
                                                              durationOption: widget.readTask?.duration??"",
                                                              notas: widget.readTask
                                                                  ?.notes ?? "",
                                                              priorityLeval: widget
                                                                  .readTask
                                                                  ?.priorityLevel
                                                                  ?? 0,
                                                              remarks: widget
                                                                  .readTask
                                                                  ?.remarks ?? "",
                                                              taskName: widget
                                                                  .readTask
                                                                  ?.taskName ?? "",
                                                              taskType: widget
                                                                  .readTask
                                                                  ?.taskType ?? 0,
                                                              lastmodified: widget
                                                                  .readTask
                                                                  ?.lastModified ??
                                                                  "",
                                                              parant: widget
                                                                  .readTask?.parent,
                                                              statusStagesId: widget
                                                                  .readTask
                                                                  ?.statusStagesId,
                                                              discription: widget
                                                                  .readTask
                                                                  ?.description ??
                                                                  "",
                                                              createdBy: widget
                                                                  .readTask
                                                                  ?.createdBy
                                                                  .toString() ?? "",
                                                              isActive: true,
                                                              priority: widget
                                                                  .readTask
                                                                  ?.priority ?? "",
                                                              reportingPerson: employee[i]
                                                                  .userCode ?? "",
                                                              endDate: "${widget
                                                                  .readTask?.endDate
                                                                  ?.split(
                                                                  "T")[0]}",
                                                              endTime: "${widget
                                                                  .readTask?.endDate
                                                                  ?.split("T")[1]
                                                                  .split(
                                                                  "+")[0]}",
                                                              startDate: "${widget
                                                                  .readTask
                                                                  ?.startDate
                                                                  ?.split(
                                                                  "T")[0]}",
                                                              startTime: "${widget
                                                                  .readTask
                                                                  ?.startDate
                                                                  ?.split("T")[1]
                                                                  .split(
                                                                  "+")[0]}"
                                                            ));
                                                        context.read<TaskBloc>()
                                                            .add(
                                                            GetTaskReadListEvent(
                                                                widget.readTask
                                                                    ?.id ?? 0));
                                                        read();
                                                      }
                                                      else{
                                                        Variable.reportingEmail =
                                                            employee[i]
                                                                .email ?? "";
                                                        Variable.reportingName =
                                                            employee[i]
                                                                .fname ?? "";
                                                        Variable
                                                            .reportingCode =
                                                            employee[i].userCode ?? "";
                                                        Navigator.pop(context);

                                                      }
                                                      widget.refresh!();
                                                      setState(() {

                                                      });



                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(4),
                                                        border: Border.all(
                                                          color: Variable.reportingEmail ==
                                                              employee[i].email?ColorPalette.primary: Color(0xffe6ecf0),
                                                          width: 1,),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                                0x05000000),
                                                            blurRadius: 8,
                                                            offset: Offset(1, 1),
                                                          ),
                                                        ],
                                                        color: Variable.reportingEmail ==
                                                            employee[i].email?Color(0xffEAF1F7):Colors.white,
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(vertical: 10,
                                                          horizontal: 16),
                                                      width: w,

                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                employee[i]?.userMete?.profile==null?TextAvatar(
                                                                  shape: Shape.Circular,
                                                                  size: 40,
                                                                  numberLetters: 2,
                                                                  fontSize: w/22,
                                                                  textColor: Colors.white,
                                                                  fontWeight: FontWeight.w500,
                                                                  text:employee[i].email.toString().toUpperCase() ,
                                                                ):  CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: NetworkImage(employee[i]?.userMete?.profile??"",),
                                                    ),
                                                                SizedBox(
                                                                  width: 10,),
                                                                Container(
                                                                  width: w / 1.5,
                                                                  child: Text(
                                                                    employee[i]
                                                                        .email ??
                                                                        "",
                                                                    style: TextStyle(
                                                                      color: ColorPalette
                                                                          .black,
                                                                      fontSize: w /
                                                                          22,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ]),
                                                    ),
                                                  );
                                                },
                                                itemCount: employee.length),
                                          ),
                                        ],
                                      )

                                    ])
                              ]

                            ]))))));
  }
}