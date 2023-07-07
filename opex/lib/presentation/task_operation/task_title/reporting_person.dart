import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
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

  const ReportingPerson(
      {Key? key, required this.editTask, this.readTask, required this.task, required this.job})
      : super(key: key);

  @override
  State<ReportingPerson> createState() => _ReportingPersonState();
}

class _ReportingPersonState extends State<ReportingPerson> {
  bool isSelect = false;
  bool isReporting = true;
  List<GetEmployeeList> employee = [];
  List<GetUserList> userList = [];

  @override
  void initState() {
    context.read<JobBloc>().add(GetEmployeeListEvent());
    context.read<JobBloc>().add(GetRoleListEvent());
    context.read<JobBloc>().add(const GetUserUderGroupEvent());
    setState(() {});
    super.initState();
  }

  void read() {
    setState(() {
      context.read<JobBloc>().add(
          GetJobReadListEvent(Variable.jobReadId));
      context.read<TaskBloc>().add(
          GetTaskReadListEvent(widget.readTask?.id ?? 0));
      context.read<JobBloc>().add(const GetUserUderGroupEvent());
    });
  }

  GetJobList? JobRead;
  List<RoleList> roleList = [];

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
              if (state is UpdateTaskLoading) {
                showSnackBar(context,
                    message: "Loading...",
                    color: Colors.white,
                    // icon: HomeSvg().SnackbarIcon,
                    autoDismiss: true);
              }

              if (state is UpdateTaskFailed) {
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is UpdateTaskSuccess) {
                Fluttertoast.showToast(
                    msg: 'Task Updated Successfully',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is UpdateTaskGroupLoading) {
                showSnackBar(context,
                    message: "Loading...",
                    color: Colors.white,
                    // icon: HomeSvg().SnackbarIcon,
                    autoDismiss: true);
              }

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
              if (state is GetEmployeeListLoading) {
                customCupertinoLoading();
              }
              if (state is GetEmployeeListSuccess) {
                employee = state.employeeList;
                print("sucsess${state.employeeList}");
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is GetUserUderGroupLoading) {
                customCupertinoLoading();
              }
              if (state is GetUserUderGroupSuccess) {
                userList = state.userlist;
                setState(() {

                });
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is GetRoleListLoading) {

              }
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
                  isAction: true,
                  action: GestureDetector(
                    onTap: () {
                      context.read<JobBloc>().add(
                          GetJobReadListEvent(
                              int.tryParse(Variable.jobReadId.toString()) ??
                                  0));
                    },
                    child: SvgPicture.string(
                      CartSvg().searchIcon,
                      color: Colors.black,
                    ),
                  ),
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

                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(
                                            0xffe6ecf0), width: 1,),
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
                                                left: 16,
                                                right: 16,
                                                bottom:  16,
                                                top:  16),
                                            child: SingleRow(
                                              label: "Reporting Person",
                                              color: Color(0xffAD51E0),
                                              svg: TaskSvg().personIcon,
                                              endIcon: Container()

                                              ,
                                              onTap: () {
                                                setState(() {
                                                  // isReporting = !isReporting;
                                                });
                                              },
                                            ),
                                          ),
                                          widget.editTask ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 16, bottom: 16),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(backgroundImage: AssetImage("asset/newprofile.png"),),
                                                  SizedBox(width: 20,),
                                                  Text(widget.readTask
                                                      ?.reportingPerson ?? ""),
                                                ],
                                              )) :
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 16, bottom: 16),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                      Variable.reportingEmail ??
                                                          ""),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 20,),

                                    Text(
                                      "Total ${employee.length} Assignee",
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
                                          child: widget.readTask
                                              ?.assigningType == "Task_Group" ?
                                          ListView.separated(
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
                                                    widget.editTask
                                                        ? BlocProvider.of<
                                                        TaskBloc>(context).add(
                                                        UpdateTaskEvent(
                                                            img5: widget.readTask?.metaData?.image5,
                                                            img1: widget.readTask?.metaData?.image1,
                                                            img4: widget.readTask?.metaData?.image4,
                                                            img2: widget.readTask?.metaData?.image2,
                                                            img3: widget.readTask?.metaData?.image3,
                                                            attachmentDescription: widget.readTask?.metaData?.description,
                                                            attachmentNote: widget.readTask?.metaData?.note,
                                                            longitude: widget.readTask?.longitude??'',
                                                            latitude: widget.readTask?.latitude??'',
                                                            taskType: widget
                                                                .readTask
                                                                ?.taskType ?? 0,
                                                            discription: widget
                                                                .readTask
                                                                ?.description ??
                                                                "",
                                                            createdBy: widget
                                                                .readTask
                                                                ?.createdPersonCode ??
                                                                "",
                                                            isActive: true,
                                                            priority: widget
                                                                .readTask
                                                                ?.priority ??
                                                                "",
                                                            reportingPerson: employee[i]
                                                                .code ?? "",
                                                            endDate: "${widget
                                                                .readTask
                                                                ?.endDate
                                                                ?.split(
                                                                "T")[0]}"" ""${widget
                                                                .readTask
                                                                ?.endDate
                                                                ?.split("T")[1]
                                                                .split(
                                                                "+")[0]}" ?? "",
                                                            startDate: "${widget
                                                                .readTask
                                                                ?.startDate
                                                                ?.split(
                                                                "T")[0]}"" ""${widget
                                                                .readTask
                                                                ?.startDate
                                                                ?.split("T")[1]
                                                                .split(
                                                                "+")[0]}" ?? "",
                                                            AssigningCode: widget
                                                                .readTask
                                                                ?.assigningCode ??
                                                                "",
                                                            notas: widget
                                                                .readTask
                                                                ?.notes ?? "",
                                                            taskName: widget
                                                                .readTask
                                                                ?.taskName ??
                                                                "",
                                                            remarks: widget
                                                                .readTask
                                                                ?.remarks ?? "",
                                                            priorityLeval: widget
                                                                .readTask
                                                                ?.priorityLevel
                                                                .toString() ??
                                                                "",
                                                            createdOn: "${widget
                                                                .readTask
                                                                ?.createdOn
                                                                ?.split(
                                                                "T")[0]}"" ""${widget
                                                                .readTask
                                                                ?.createdOn
                                                                ?.split("T")[1]
                                                                .split(
                                                                ".")[0]}" ?? "",
                                                            AssigningType: widget
                                                                .readTask
                                                                ?.assigningType ??
                                                                "",
                                                            statusStagesId: widget
                                                                .readTask
                                                                ?.statusStagesId ??
                                                                0,
                                                            parant: widget
                                                                .readTask
                                                                ?.parent ??
                                                                null,
                                                            lastmodified: widget
                                                                .readTask
                                                                ?.lastModified ??
                                                                null,
                                                            jobid: widget
                                                                .readTask
                                                                ?.jobId ?? 0,
                                                            id: widget.readTask
                                                                ?.id ?? 0


                                                        ))
                                                        : Variable
                                                        .reportingCode =
                                                        employee[i].code ?? "";
                                                    read();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(10),
                                                      border: Border.all(
                                                        color: Color(
                                                            0xffe6ecf0),
                                                        width: 1,),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(
                                                              0x05000000),
                                                          blurRadius: 8,
                                                          offset: Offset(1, 1),
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                    ),
                                                    padding: EdgeInsets
                                                        .symmetric(vertical: 10,
                                                        horizontal: 10),
                                                    width: w,

                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor: ColorPalette
                                                                    .inactiveGrey,),
                                                              SizedBox(
                                                                width: 10,),
                                                              Container(
                                                                width: w / 1.5,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      userList[i]
                                                                          .email ??
                                                                          "",
                                                                      style: TextStyle(
                                                                        color: ColorPalette
                                                                            .black,
                                                                        fontSize: w /
                                                                            22,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,),
                                                                    Text(
                                                                      userList[i]
                                                                          .role ??
                                                                          "",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red),)

                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // PopupMenuButton(
                                                          //   icon: SvgPicture.string(TaskSvg().moreIcon),
                                                          //   //don't specify icon if you want 3 dot menu
                                                          //   color: Colors.white,
                                                          //   elevation: 2,
                                                          //   padding: EdgeInsets.zero,
                                                          //   shape:
                                                          //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                          //   itemBuilder: (context) {
                                                          //     return List.generate(roleList.length, (index) {
                                                          //       return PopupMenuItem(
                                                          //         child: GestureDetector(
                                                          //           onTap: () async{
                                                          //             print("editoe");
                                                          //             final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                                          //             int groupId=sharedPreferences.getInt('groupId')??0;
                                                          //             BlocProvider.of<JobBloc>(context)
                                                          //                 .add(UpdateTaskGroupEvent(
                                                          //               userGroupId: userList[i].userGroupId??0,
                                                          //               isActive: true,
                                                          //              roleId: roleList[i].id??0,
                                                          //               taskGroup: groupId,
                                                          //               userCode: userList[i].code??""
                                                          //             ));
                                                          //             read();
                                                          //           },
                                                          //             child: Text(roleList[index].roleName??"")),
                                                          //       );
                                                          //     });
                                                          //   },
                                                          // )
                                                        ]),
                                                  ),
                                                );
                                              },
                                              itemCount: userList.length) :
                                          ListView.separated(
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
                                                    Variable.reportingEmail =
                                                        employee[i]
                                                            .primaryMail ?? "";
                                                    widget.editTask
                                                        ? BlocProvider.of<
                                                        TaskBloc>(context).add(
                                                        UpdateTaskEvent(
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
                                                          createdOn: "2023-09-04 18:00:00",
                                                          jobid: widget.readTask
                                                              ?.jobId,
                                                          notas: widget.readTask
                                                              ?.notes ?? "",
                                                          priorityLeval: widget
                                                              .readTask
                                                              ?.priorityLevel
                                                              .toString() ?? "",
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
                                                              .code ?? "",
                                                          endDate: "${widget
                                                              .readTask?.endDate
                                                              ?.split(
                                                              "T")[0]}"" ""${widget
                                                              .readTask?.endDate
                                                              ?.split("T")[1]
                                                              .split(
                                                              "+")[0]}" ?? "",
                                                          startDate: "${widget
                                                              .readTask
                                                              ?.startDate
                                                              ?.split(
                                                              "T")[0]}"" ""${widget
                                                              .readTask
                                                              ?.startDate
                                                              ?.split("T")[1]
                                                              .split(
                                                              "+")[0]}" ?? "",
                                                        ))
                                                        : Variable
                                                        .reportingCode =
                                                        employee[i].code ?? "";

                                                    context.read<TaskBloc>()
                                                        .add(
                                                        GetTaskReadListEvent(
                                                            widget.readTask
                                                                ?.id ?? 0));
                                                    read();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(10),
                                                      border: Border.all(
                                                        color: Color(
                                                            0xffe6ecf0),
                                                        width: 1,),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(
                                                              0x05000000),
                                                          blurRadius: 8,
                                                          offset: Offset(1, 1),
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                    ),
                                                    padding: EdgeInsets
                                                        .symmetric(vertical: 10,
                                                        horizontal: 16),
                                                    width: w,

                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor: ColorPalette
                                                                    .inactiveGrey,),
                                                              SizedBox(
                                                                width: 10,),
                                                              Container(
                                                                width: w / 1.5,
                                                                child: Text(
                                                                  employee[i]
                                                                      .primaryMail ??
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
                                                          // PopupMenuButton(
                                                          //   icon: SvgPicture.string(TaskSvg().moreIcon),
                                                          //   //don't specify icon if you want 3 dot menu
                                                          //   color: Colors.white,
                                                          //   elevation: 2,
                                                          //   padding: EdgeInsets.zero,
                                                          //   shape:
                                                          //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                          //   itemBuilder: (context) {
                                                          //     return List.generate(roleList.length, (index) {
                                                          //       return PopupMenuItem(
                                                          //         child: Text(roleList[index].roleName??""),
                                                          //       );
                                                          //     });
                                                          //   },
                                                          //  )
                                                        ]),
                                                  ),
                                                );
                                              },
                                              itemCount: employee.length),
                                        ),
                                      ],
                                    )
                                    // Column(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //
                                    //     Text(
                                    //       "Total ${employee.length} Assignee",
                                    //       style: GoogleFonts.roboto(
                                    //         color: Color(0xff151522),
                                    //         fontSize: w/22,
                                    //         fontWeight: FontWeight.w500,
                                    //       ),
                                    //     ),
                                    //     SizedBox(height: 16,),
                                    //     Container(
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(10),
                                    //         border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                    //         boxShadow: [
                                    //           BoxShadow(
                                    //             color: Color(0x05000000),
                                    //             blurRadius: 8,
                                    //             offset: Offset(1, 1),
                                    //           ),
                                    //         ],
                                    //         color: Colors.white,
                                    //       ),
                                    //       child: Column(
                                    //         children: [
                                    //           Container(
                                    //             margin: EdgeInsets.only(
                                    //                 left: 16,
                                    //                 right: 16,
                                    //                 bottom:  16,
                                    //                 top:  16),
                                    //             child: SingleRow(
                                    //               label: "Reporting Person",
                                    //               color: Color(0xffAD51E0),
                                    //               svg: TaskSvg().personIcon,
                                    //               endIcon:  Container()
                                    //
                                    //               ,
                                    //               onTap: () {
                                    //                 setState(() {
                                    //                   // isReporting = !isReporting;
                                    //                 });
                                    //
                                    //               },
                                    //             ),
                                    //           ),
                                    //           Container(
                                    //               padding: EdgeInsets.all(15),
                                    //               child: Row(
                                    //                 children: [
                                    //                   CircleAvatar(),
                                    //                   SizedBox(width: 20,),
                                    //                   Text(Variable.reportingEmail??""),
                                    //                 ],
                                    //               ))
                                    //         ],
                                    //       ),
                                    //     ),
                                    //
                                    //     SizedBox(height: 20,),
                                    //     ListView.separated(
                                    //         shrinkWrap: true,
                                    //         physics: const NeverScrollableScrollPhysics(),
                                    //         separatorBuilder: (BuildContext cxt, int i) {
                                    //           return const SizedBox(
                                    //             height: 5,
                                    //           );
                                    //         },
                                    //         itemBuilder: (BuildContext context, int i) {
                                    //           return InkWell(
                                    //             onTap: () {
                                    //               Variable.reportingCode=employee[i].code;
                                    //               Variable.reportingEmail=employee[i].primaryMail;
                                    //               BlocProvider.of<JobBloc>(context)
                                    //                   .add(UpdateJobEvent(
                                    //                 startDate: "${JobRead?.startDate?.split("T")[0]}"" ""${JobRead?.startDate?.split("T")[1].split("+")[0]}"??"",
                                    //                 endDate: "${JobRead?.endDate?.split("T")[0]}"" ""${JobRead?.endDate?.split("T")[1].split("+")[0]}"??"",
                                    //                 originFrom: JobRead?.orginFrom??"",
                                    //                 reportingPerson: employee[i].code??"",
                                    //                 priority:JobRead?.priority??"",
                                    //                 name: JobRead?.name??"",
                                    //                 jobType: JobRead?.jobType??0,
                                    //                 isActive: JobRead?.isActive??true,
                                    //                 assignedBy: JobRead?.assignCode??"",
                                    //                 createdBy:JobRead?.createdCode??"",
                                    //                 discription: JobRead?.description??"",
                                    //               ));
                                    //               read();
                                    //               setState(() {
                                    //
                                    //               });
                                    //             },
                                    //             child:  Container(
                                    //               decoration: BoxDecoration(
                                    //                   borderRadius: BorderRadius.circular(10),
                                    //                   border: Border.all(color: Color(0xffe6ecf0))),
                                    //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                                    //               width: w,
                                    //
                                    //               child:   Row(
                                    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //                   children: [
                                    //                     Row(
                                    //                       children: [
                                    //                         CircleAvatar(),
                                    //                         SizedBox(width: 10,),
                                    //                         Container(
                                    //                           width: w/1.8,
                                    //                           child: Text(
                                    //                             employee[i].primaryMail??"",
                                    //                             style: TextStyle(
                                    //                               color: ColorPalette.black,
                                    //                               fontSize: w/22,
                                    //                             ),
                                    //                           ),
                                    //                         ),
                                    //
                                    //                       ],
                                    //                     ),
                                    //
                                    //                   ]),
                                    //             ),
                                    //           );
                                    //         },
                                    //         itemCount: employee.length),
                                    //   ],
                                    // )

                                  ])
                            ]))))));
  }
}