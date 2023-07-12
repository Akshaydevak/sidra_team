import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/promotion_app/dropdown_card.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/more_details_screen.dart';
import 'package:cluster/presentation/task_operation/select_assignees.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/reporting_person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/utils/variables.dart';
import '../home/bloc/job_bloc.dart';
import 'add_text.dart';
import 'create_svg.dart';
import 'model/task_models.dart';

class CreateNewTask extends StatefulWidget {
  final bool isSubTask;
  final bool editTask;
  const CreateNewTask({Key? key, this.isSubTask = false, this.editTask = false})
      : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  bool isTime = false;
  bool isLocation = false;
  bool grpval = false;
  bool updateval = false;
  void grpVal(bool val) {
    grpval = val;
    setState(() {});
    print("uuu$grpval");
  }

  void updatevalue(bool val) {
    updateval = val;
    setState(() {});
  }

  String _selectedDate1 = '';
  String _dateCount = '';
  String _range = '';
  String _range2 = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
        _range2 = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
      print("searjjj${_range.split(" - ")[1]}");
      startDate = _range.split(" - ")[0];
      startDate2 = _range2.split(" - ")[0];
      ebdDate = _range.split(" - ")[1];
      ebdDate2 = _range2.split(" - ")[1];
    });
  }

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _time2 = TimeOfDay(hour: 8, minute: 15);

  TextEditingController jobtitle = TextEditingController();
  TextEditingController jobdiscription = TextEditingController();
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        startTime = "${newTime.hour}" ":" "${newTime.minute}" ":" "00 ";
      });
    }
  }

  void _endTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (newTime != null) {
      setState(() {
        _time2 = newTime;
        endTime = "${newTime.hour}" ":" "${newTime.minute}" ":" "00 ";
      });
    }
    print("TYM${_time2.hour}" ":" "${_time2.minute}");
  }

  String PriorityLeval = "";
  void refreah() {
    setState(() {});
  }

  int select = 0;
  void onselct(index) {
    setState(() {
      select = index;
      print("seler$select");
    });
  }

  String startDate = "";
  String startDate2 = "";
  String ebdDate = "";
  String ebdDate2 = "";
  String startTime = "";
  String endTime = "";
  var endstdDate = "";
  var startstdDate = "";

  int tappedTile = 0;
  bool isSubTask = false;
  TextEditingController taskTitle = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }

  GetTaskList? readTask;
  String? taskYype;
  @override
  void initState() {
    context.read<TaskBloc>().add(const GetTaskTypeListEvent());
    super.initState();
  }

  String? taskId;
  List<GetTaskTypeList>? typelist;
  List<GetTaskList> taskListNew = [];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is CreateTaskLoading) {
              print("task loading");
              showSnackBar(context,
                  message: "Loading...",
                  color: Colors.white,
                  // icon: HomeSvg().SnackbarIcon,
                  autoDismiss: true);
            }

            if (state is CreateTaskFailed) {
              showSnackBar(
                context,
                message: state.error,
                color: Colors.red,
                // icon: Icons.admin_panel_settings_outlined
              );
            }
            if (state is CreateTaskSuccess) {
              if (isSubTask == true) {
                taskId = state.taskId;
                print("TASKID${state.taskId}");

                Fluttertoast.showToast(
                    msg: 'Successfully Created',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                Variable.taskIdForSubtask=int.tryParse(taskId.toString()??'')??0;
                context.read<TaskBloc>().add(const GetSubTaskListEvent());
                context.read<TaskBloc>().add(
                    GetTaskReadListEvent(int.tryParse(taskId.toString()) ?? 0));
                // Navigator.pop(context);
              } else {
                print("task sucsess");

                taskId = state.taskId;
                print("TASKID${state.taskId}");

                Fluttertoast.showToast(
                    msg: 'Successfully Created',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                context.read<TaskBloc>().add(GetTaskListEvent(
                    int.tryParse(Variable.jobReadId.toString()),"","",""));
                // context.read<TaskBloc>().add(
                //     GetTaskReadListEvent(int.tryParse(taskId.toString()) ?? 0));
                Navigator.pop(context);
              }
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is UpdateTaskLoading) {
              print("task loading");
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
              print("task sucsess");

              Fluttertoast.showToast(
                  msg: 'Successfully Updated',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.white,
                  textColor: Colors.black);

              context.read<TaskBloc>().add(const GetTaskTypeListEvent());
              context
                  .read<TaskBloc>()
                  .add(GetTaskReadListEvent(readTask?.id ?? 0));
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: MoreDetailsScreen(
                    taskList: readTask, updateValue: updatevalue),
                withNavBar: true,
                // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              // Navigator.pop(context);
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is GetTaskTypeListLoading) {
              print("task loading");
            }

            if (state is GetTaskTypeListFailed) {}
            if (state is GetTaskTypeListSuccess) {
              typelist = state.taskTypeList;

              print("task sucsess");
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is GetTaskReadLoading) {}
            if (state is GetTaskReadSuccess) {
              readTask = state.getTaskRead;
              taskTitle.text = readTask?.taskName ?? "";
              discription.text = readTask?.description ?? "";
              startDate = readTask?.startDate?.split("T")[0] ?? "";
              ebdDate = readTask?.endDate?.split("T")[0] ?? "";
              startTime =
                  readTask?.startDate?.split("T")[1].split("+")[0] ?? "";
              endTime = readTask?.endDate?.split("T")[1].split("+")[0] ?? "";
              PriorityLeval = readTask?.priority ?? "";
              Variable.assignCode = readTask?.assigningCode ?? "";
              Variable.assignType = readTask?.assigningType ?? "";
              notesController.text = readTask?.notes ?? "";
              remarksController.text = readTask?.remarks ?? "";
              Variable.taskType = readTask?.taskType ?? 0;
              var date = readTask?.endDate;
              var date2 = readTask?.startDate;
              var dateTime = DateTime.parse("$date");
              var dateTime2 = DateTime.parse("$date2");
              endstdDate = DateFormat('dd-MM-yyyy').format(dateTime).toString();
              startstdDate =
                  DateFormat('dd-MM-yyyy').format(dateTime2).toString();
              // print("STD TIME$stdTime");
              setState(() {});
            }
          },
        ),
        BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            print("subtaskkk state $state");
            if (state is GetSubTaskListLoading) {
              print("task loading");
            }

            if (state is GetSubTaskListFailed) {}
            if (state is GetSubTaskListSuccess) {
              print("subtaskkk sucsess${state.taskList}");

              taskListNew = state.taskList;
              setState(() {});
            }
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: ColorPalette.white, // Navigation bar
                statusBarColor: ColorPalette.white, // Status bar
              ),
              elevation: 0,
            ),
          ),
          body: SingleChildScrollView(
              child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskAndOperationAppBar(
                  label: readTask?.taskName ?? "Create New Task",
                  // EndIcon: widget.isSubTask?GestureDetector(
                  //   onTap: (){
                  //     print("subb$taskId");
                  //     widget.editTask?BlocProvider.of<TaskBloc>(context).add(
                  //         UpdateTaskEvent(
                  //           locationUrl: Variable.locationUrl,
                  //           id: readTask?.id??0,
                  //           AssigningCode: Variable.assignCode,
                  //           AssigningType: Variable.assignType,
                  //           createdOn: "2023-09-04 18:00:00",
                  //           jobid: Variable.jobReadId,
                  //           notas: notesController.text,
                  //           priorityLeval: "1",
                  //           remarks: remarksController.text,
                  //           taskName: taskTitle.text??"",
                  //           taskType: Variable.taskType,
                  //           lastmodified: null,
                  //           parant: Variable.taskIdForSubtask,
                  //           statusStagesId: null,
                  //           discription:discription.text??"",
                  //           createdBy: authentication.authenticatedUser.code??"",
                  //           isActive: true,
                  //           priority: Variable.prioritys,
                  //           reportingPerson: authentication.authenticatedUser.code??"",
                  //           endDate: "${_range.split(" - ")[1]} ${_time2.hour}"":""${_time2.minute}"":""00",
                  //           startDate: "${_range.split(" - ")[0]} ${_time.hour}"":""${_time.minute}"":""00",
                  //         ))
                  //         :BlocProvider.of<TaskBloc>(context).add(
                  //         CreateTaskEvent(
                  //           locationUrl: Variable.locationUrl,
                  //           AssigningCode: Variable.assignCode,
                  //           AssigningType: Variable.assignType,
                  //           createdOn: "2023-09-04 18:00:00",
                  //           jobId: Variable.jobReadId,
                  //           notas: notesController.text??"",
                  //           priorityLeval: "1",
                  //           remarks: remarksController.text??"",
                  //           taskName: taskTitle.text??"",
                  //           taskType: Variable.taskType,
                  //           lastmodified: null,
                  //           parant: Variable.taskIdForSubtask,
                  //           statusStagesId: null,
                  //           discription:discription.text??"",
                  //           createdBy: authentication.authenticatedUser.code??"",
                  //           isActive: true,
                  //           priority: Variable.prioritys,
                  //           reportingPerson: Variable.reportingCode==""?authentication.authenticatedUser.code.toString():Variable.reportingCode.toString(),
                  //           endDate: "${_range.split(" - ")[1]} ${_time2.hour}"":""${_time2.minute}"":""00",
                  //           startDate: "${_range.split(" - ")[0]} ${_time.hour}"":""${_time.minute}"":""00",
                  //         ));
                  //     context.read<TaskBloc>().add(const GetSubTaskListEvent());
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     // width: 110,
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 8),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color: ColorPalette.primary,
                  //     ),
                  //     alignment: Alignment.center,
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
                  // ):GestureDetector(
                  //   onTap: (){
                  //
                  //     grpval||updateval?BlocProvider.of<TaskBloc>(context).add(
                  //         UpdateTaskEvent(
                  //           locationUrl: Variable.locationUrl,
                  //           id: readTask?.id??0,
                  //           AssigningCode: Variable.assignCode,
                  //           AssigningType: Variable.assignType,
                  //           createdOn: "2023-09-04 18:00:00",
                  //           jobid: Variable.jobReadId,
                  //           notas: notesController.text,
                  //           priorityLeval: "1",
                  //           remarks: remarksController.text,
                  //           taskName: taskTitle.text??"",
                  //           taskType: Variable.taskType,
                  //           lastmodified: null,
                  //           parant: Variable.taskIdForSubtask,
                  //           statusStagesId: null,
                  //           discription:discription.text??"",
                  //           createdBy: authentication.authenticatedUser.code??"",
                  //           isActive: true,
                  //           priority: Variable.prioritys,
                  //           reportingPerson: authentication.authenticatedUser.code??"",
                  //           endDate: "${_range.split(" - ")[1]} ${_time2.hour}"":""${_time2.minute}"":""00",
                  //           startDate: "${_range.split(" - ")[0]} ${_time.hour}"":""${_time.minute}"":""00",
                  //         ))
                  //         :BlocProvider.of<TaskBloc>(context).add(
                  //         CreateTaskEvent(
                  //           locationUrl: Variable.locationUrl,
                  //           AssigningCode: Variable.assignCode,
                  //             AssigningType: Variable.assignType,
                  //             createdOn: "2023-09-04 18:00:00",
                  //             jobId: Variable.jobReadId,
                  //             notas: notesController.text??"",
                  //             priorityLeval: "1",
                  //             remarks: remarksController.text??"",
                  //             taskName: taskTitle.text??"",
                  //             taskType: Variable.taskType,
                  //             lastmodified: null,
                  //             parant: null,
                  //             statusStagesId: null,
                  //             discription:discription.text??"",
                  //             createdBy: authentication.authenticatedUser.code??"",
                  //             isActive: true,
                  //             priority: Variable.prioritys,
                  //             reportingPerson: Variable.reportingCode==""?authentication.authenticatedUser.code.toString():Variable.reportingCode.toString(),
                  //             endDate: "${_range.split(" - ")[1]} ${_time2.hour}"":""${_time2.minute}"":""00",
                  //             startDate: "${_range.split(" - ")[0]} ${_time.hour}"":""${_time.minute}"":""00",
                  //         ));
                  //   },
                  //   child: Container(
                  //     // width: 110,
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 8),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color: ColorPalette.primary,
                  //     ),
                  //     alignment: Alignment.center,
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
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              taskYype == null
                                  ? "Select Task Type"
                                  : taskYype ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffe70c0c),
                                fontSize: w / 22,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showModalBottomSheet(context, typelist ?? []);
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // DropDownCard(
                      //   label: "",
                      //   selValue: taskYype,
                      //   onTap: (){
                      //     _showModalBottomSheet(
                      //         context, typelist??[]);
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: w,
                        height: 185,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: taskTitle,
                                  decoration: InputDecoration(
                                      hintText: "Task Title",
                                      border: InputBorder.none),
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              color: Color(0xffE6ECF0).withOpacity(0.5),
                              height: 1,
                              width: w,
                            ),
                            Container(
                                padding: EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: discription,
                                  decoration: InputDecoration(
                                      hintText: "Enter Discription",
                                      border: InputBorder.none),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: w,
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
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 10, top: 20),
                              child: SingleRow(
                                  color: const Color(0xff1ECAC0),
                                  label: "Time",
                                  svg: CreateSvg().calenderIcon,
                                  onTap: () {
                                    setState(() {
                                      // isTime = !isTime;
                                    });
                                  },
                                  endIcon: Container()),
                            ),
                            Column(
                              children: [
                                Divider(
                                  indent: 50,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // _restorableDatePickerRouteFuture.present();
                                        },
                                        child: const Text(
                                          "Start Date :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 300,
                                                        child: Scaffold(
                                                          body:
                                                              SfDateRangePicker(
                                                            onSelectionChanged:
                                                                _onSelectionChanged,
                                                            selectionMode:
                                                                DateRangePickerSelectionMode
                                                                    .range,
                                                            initialSelectedRange: PickerDateRange(
                                                                DateTime.now().subtract(
                                                                    const Duration(
                                                                        days:
                                                                            4)),
                                                                DateTime.now().add(
                                                                    const Duration(
                                                                        days:
                                                                            3))),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 25,
                                                          width: 75,
                                                          color: ColorPalette
                                                              .primary,
                                                          child: const Center(
                                                              child:
                                                                  Text("Ok")),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          widget.editTask
                                              ? startstdDate
                                              : _range2.isNotEmpty
                                                  ? startDate2
                                                  : "Choose Date",
                                          style: GoogleFonts.roboto(
                                            color: Color(0xfffe5762),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _selectTime,
                                        child: Text(
                                          // widget.edit?startTime:
                                          widget.editTask
                                              ? startTime
                                              : "${_time.hour}"
                                                      ":"
                                                      "${_time.minute} ${_time.period.name}" ??
                                                  "",
                                          style: GoogleFonts.roboto(
                                            color: Color(0xfffe5762),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  indent: 50,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 20, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "End Date :",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        widget.editTask
                                            ? endstdDate
                                            : _range2.isNotEmpty
                                                ? ebdDate2
                                                : "Choose Date",
                                        style: GoogleFonts.roboto(
                                          color: Color(0xfffe5762),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _endTime,
                                        child: Text(
                                          // widget.edit?endTime:
                                          widget.editTask
                                              ? endTime
                                              : "${_time2.hour}"
                                                      ":"
                                                      "${_time2.minute} ${_time2.period.name}" ??
                                                  "",
                                          style: GoogleFonts.roboto(
                                            color: Color(0xfffe5762),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showModalBottomSheetpriority();
                        },
                        child: Container(
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
                          child: SingleRow(
                              color: Color(0xff33c658),
                              label: "Set Priority",
                              svg: CreateSvg().priorityIcon,
                              onTap: () {},
                              endIcon: Row(
                                children: [
                                  Container(
                                      // color:Colors.red,
                                      width: w / 4.5,
                                      child: PriorityLeval == ""
                                          ? Container()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.string(
                                                  TaskSvg().priorityIcon,
                                                  color: PriorityLeval == "Low"
                                                      ? Color(0xff50D166)
                                                      : PriorityLeval ==
                                                              "Medium"
                                                          ? Color(0xffF18F1C)
                                                          : null,
                                                ),
                                                Text(
                                                  PriorityLeval,
                                                  style: TextStyle(
                                                      fontSize: w / 24,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )),
                                  PriorityLeval == ""
                                      ? Icon(Icons.arrow_forward_ios_sharp)
                                      : Container()
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      widget.editTask == false
                          ? widget.isSubTask
                              ? GestureDetector(
                                  onTap: () {
                                    context
                                        .read<JobBloc>()
                                        .add(const GetEmployeeListEvent());
                                    context
                                        .read<JobBloc>()
                                        .add(GetGroupListEvent());
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: AssignesUnderGroup(),
                                      withNavBar: true,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Container(
                                    width: w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 14),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 32,
                                              height: 32,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xff33c658),
                                              ),
                                              child: SvgPicture.string(
                                                  CreateSvg().assignIcon),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Assign To",
                                              style: GoogleFonts.roboto(
                                                color: Color(0xff151522),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "asset/img_6.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Icon(Icons.arrow_forward_ios_sharp)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    // context.read<JobBloc>().add( const GetEmployeeListEvent());
                                    context
                                        .read<JobBloc>()
                                        .add(GetGroupListEvent());
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: SelectAssignees(groupVal: grpVal),
                                      withNavBar: true,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Container(
                                    width: w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 14),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 32,
                                              height: 32,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xff33c658),
                                              ),
                                              child: SvgPicture.string(
                                                  CreateSvg().assignIcon),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Assign To",
                                              style: GoogleFonts.roboto(
                                                color: Color(0xff151522),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "asset/img_6.png",
                                              height: 30,
                                              width: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Icon(Icons.arrow_forward_ios_sharp)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                          : Container(),

                      widget.editTask == true
                          ? Container()
                          : SizedBox(
                              height: 10,
                            ),
                      widget.isSubTask
                          ? Container()
                          : grpval == true
                              ? Column(
                                  children: [
                                    Container(
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
                                      child: SingleRow(
                                        label: "Subtasks",
                                        color: Color(0xffFFC800),
                                        svg: CreateSvg().taskIcon,
                                        endIcon: isSubTask
                                            ? SvgPicture.string(
                                                HomeSvg().toggleActive)
                                            : SvgPicture.string(
                                                HomeSvg().toggleInActive),
                                        onTap: () {
                                          setState(() {
                                            taskYype == null||taskTitle.text==""||discription.text==""||_range==""||Variable.assignType==""||Variable.assignCode==""
                                                ? Fluttertoast.showToast(
                                                    msg:
                                                        'Please fill the fields',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        Colors.white,
                                                    textColor: Colors.black)
                                                : BlocProvider.of<TaskBloc>(
                                                        context)
                                                    .add(CreateTaskEvent(
                                                    latitude: null,
                                                    longitude: null,
                                                    AssigningCode:
                                                        Variable.assignCode,
                                                    AssigningType:
                                                        Variable.assignType,
                                                    createdOn:
                                                        "2023-09-04 18:00:00",
                                                    jobId: Variable.jobReadId,
                                                    notas:
                                                        notesController.text ??
                                                            "",
                                                    priorityLeval: "1",
                                                    remarks:
                                                        remarksController.text,
                                                    taskName:
                                                        taskTitle.text ?? "",
                                                    taskType: Variable.taskType,
                                                    lastmodified: null,
                                                    parant: null,
                                                    statusStagesId: null,
                                                    discription:
                                                        discription.text ?? "",
                                                    createdBy: authentication
                                                            .authenticatedUser
                                                            .code ??
                                                        "",
                                                    isActive: true,
                                                    priority:
                                                        Variable.prioritys,
                                                    reportingPerson: Variable
                                                                .reportingCode ==
                                                            ""
                                                        ? authentication
                                                            .authenticatedUser
                                                            .code
                                                            .toString()
                                                        : Variable.reportingCode
                                                            .toString(),
                                                    endDate:
                                                        "${_range.split(" - ")[1]} ${_time2.hour}"
                                                        ":"
                                                        "${_time2.minute}"
                                                        ":"
                                                        "00",
                                                    startDate:
                                                        "${_range.split(" - ")[0]} ${_time.hour}"
                                                        ":"
                                                        "${_time.minute}"
                                                        ":"
                                                        "00",
                                                  ));
                                            isSubTask = !isSubTask;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: w,
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
                                        children: [
                                          Container(
                                            width: w,
                                            // height: 577,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffe6ecf0),
                                                  width: 1),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x05000000),
                                                  blurRadius: 8,
                                                  offset: Offset(1, 1),
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: taskListNew.isEmpty
                                                ? Container()
                                                : Container(
                                                    child: ListView.separated(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Card(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          taskListNew[index].taskName ??
                                                                              "",
                                                                          style:
                                                                              GoogleFonts.roboto(
                                                                            color:
                                                                                Color(0xff151522),
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              "asset/img_6.png",
                                                                              height: 27,
                                                                              width: 27,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            // Icon(
                                                                            //     Icons
                                                                            //         .arrow_forward_ios_sharp)
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return SizedBox(
                                                            height: 5,
                                                          );
                                                        },
                                                        itemCount:
                                                            taskListNew.length),
                                                  ),
                                          ),
                                          Divider(
                                            color: Color(0xffE6ECF0)
                                                .withOpacity(0.5),
                                            thickness: 1,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print("SUbtask$taskId");
                                              Variable.taskIdForSubtask =
                                                  int.tryParse(taskId!) ?? 0;
                                              PersistentNavBarNavigator
                                                  .pushNewScreen(
                                                context,
                                                screen: CreateNewTask(
                                                  isSubTask: true,
                                                ),
                                                withNavBar: true,
                                                // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .fade,
                                              );
                                            },
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    bottom: 20,
                                                    top: 8),
                                                child: Text(
                                                  "Add Subtask",
                                                  style: TextStyle(
                                                    color: Color(0xffe70c0c),
                                                    fontSize: 18,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Container(),

                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<TaskBloc>()
                              .add(GetTaskReadListEvent(readTask?.id ?? 0));
                          print(readTask?.id);
                          readTask?.id == null
                              ? PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: ReportingPerson(
                                    editTask: false,
                                    readTask: readTask,
                                    task: true,
                                    job: false,
                                  ),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                )
                              : PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: ReportingPerson(
                                    editTask: true,
                                    readTask: readTask,
                                    task: true,
                                    job: false,
                                  ),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                        },
                        child: Container(
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
                          child: SingleRow(
                              color: Color(0xffAD51E0),
                              label: "Reporting Person",
                              svg: TaskSvg().personIcon,
                              onTap: () {
                                //    ReportingPerson
                              },
                              endIcon: Icon(Icons.arrow_forward_ios_sharp)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        width: w,
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
                        child: AddText(
                          label: "Add Notes",
                          controller: notesController,
                          isActive: notesController.text == "" ? false : true,
                          hint: "Enter Notes",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: w,
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
                        child: AddText(
                            label: "Add Remarks",
                            controller: remarksController,
                            hint: "Enter Remarks",
                            isActive:
                                remarksController.text == "" ? false : true),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("JOB IDDD${Variable.jobReadId}");
                          taskYype == null||taskTitle.text==""||discription.text==""||_range==""||Variable.assignType==""||Variable.assignCode==""
                              ? Fluttertoast.showToast(
                                  msg: 'Please fill the fields',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black)
                              : widget.editTask || updateval || isSubTask
                                  ? BlocProvider.of<TaskBloc>(context).add(
                                      UpdateTaskEvent(
                                          latitude: readTask?.latitude,
                                          longitude: readTask?.longitude,
                                          id: readTask?.id ?? 0,
                                          AssigningCode: Variable.assignCode,
                                          AssigningType: Variable.assignType,
                                          createdOn: "2023-09-04 18:00:00",
                                          jobid: Variable.jobReadId,
                                          notas: notesController.text ?? "",
                                          priorityLeval: "1",
                                          remarks: remarksController.text ?? "",
                                          taskName: taskTitle.text ?? "",
                                          taskType: Variable.taskType,
                                          lastmodified: null,
                                          parant: Variable.taskIdForSubtask,
                                          statusStagesId: null,
                                          discription: discription.text ?? "",
                                          createdBy:
                                              authentication
                                                      .authenticatedUser.code ??
                                                  "",
                                          isActive: true,
                                          priority: Variable.prioritys,
                                          reportingPerson:
                                              authentication
                                                      .authenticatedUser.code ??
                                                  "",
                                          endDate: "$ebdDate" " " "$endTime",
                                          startDate:
                                              "$startDate" " " "$startTime",
                                          img5: readTask?.metaData?.image5,
                                          img1: readTask?.metaData?.image1,
                                          img4: readTask?.metaData?.image4,
                                          img2: readTask?.metaData?.image2,
                                          img3: readTask?.metaData?.image3,
                                          attachmentDescription:
                                              readTask?.metaData?.description,
                                          attachmentNote:
                                              readTask?.metaData?.note))
                                  : BlocProvider.of<TaskBloc>(context)
                                      .add(CreateTaskEvent(
                                      latitude: null,
                                      longitude: null,
                                      AssigningCode: Variable.assignCode,
                                      AssigningType: Variable.assignType,
                                      createdOn: "2023-09-04 18:00:00",
                                      jobId: Variable.jobReadId,
                                      notas: notesController.text ?? "",
                                      priorityLeval: "1",
                                      remarks: remarksController.text ?? "",
                                      taskName: taskTitle.text ?? "",
                                      taskType: Variable.taskType,
                                      lastmodified: null,
                                      parant: Variable.taskIdForSubtask,
                                      statusStagesId: null,
                                      discription: discription.text ?? "",
                                      createdBy: authentication
                                              .authenticatedUser.code ??
                                          "",
                                      isActive: true,
                                      priority: Variable.prioritys,
                                      reportingPerson: Variable.reportingCode ==
                                              ""
                                          ? authentication
                                              .authenticatedUser.code
                                              .toString()
                                          : Variable.reportingCode.toString(),
                                      endDate:
                                          "${_range.split(" - ")[1]} ${_time2.hour}"
                                          ":"
                                          "${_time2.minute}"
                                          ":"
                                          "00",
                                      startDate:
                                          "${_range.split(" - ")[0]} ${_time.hour}"
                                          ":"
                                          "${_time.minute}"
                                          ":"
                                          "00",
                                    ));
                          // Navigator.pop(context);
                        },
                        child: Container(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Create & Continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffe70c0c),
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  _showModalBottomSheet(
      BuildContext context, List<GetTaskTypeList> taskTypeList) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: w,
                        alignment: Alignment.center,
                        child: Text(
                          "Select Task Type",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.only(),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: taskTypeList.length,
                        itemBuilder: (BuildContext context, int i) {
                          return GestureDetector(
                            onTap: () {
                              changeTappedTile(i);
                              Variable.taskType = taskTypeList[i].id ?? 0;
                              taskYype = taskTypeList[i].typeName ?? "";
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              color: tappedTile == i
                                  ? ColorPalette.cardBackground
                                  : ColorPalette.white,
                              child: Row(
                                children: [
                                  tappedTile == i
                                      ? SvgPicture.string(
                                          CreateSvg().radioActiveButton)
                                      : SvgPicture.string(
                                          CreateSvg().radioInActiveButton),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    taskTypeList[i].typeName ?? "",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            color: Color(0xffE6ECF0),
                            height: 1,
                            width: w,
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetpriority() {
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
                padding: EdgeInsets.all(16),
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      alignment: Alignment.center,
                      child: Text(
                        "Priority",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xffA9A8A8).withOpacity(0.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Variable.prioritys = "High";
                        PriorityLeval = "High";
                        setState(() {});
                        refreah();
                        print("TASK PRIORITY$PriorityLeval");
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xffe6ecf0),
                                width: 1,
                              ),
                              color: Colors.white,
                            ),
                            child: SvgPicture.string(TaskSvg().priorityIcon),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "High Priority",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      indent: 50,
                      color: Color(0xffA9A8A8).withOpacity(0.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Variable.prioritys = "Medium";
                        PriorityLeval = "Medium";
                        setState(() {});
                        refreah();
                        print("TASK PRIORITY${Variable.prioritys}");
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xffe6ecf0),
                                width: 1,
                              ),
                              color: Colors.white,
                            ),
                            child: SvgPicture.string(
                              TaskSvg().priorityIcon,
                              color: Color(0xffF18F1C),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Medium Priority",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      indent: 50,
                      color: const Color(0xffA9A8A8).withOpacity(0.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Variable.prioritys = "Low";
                        PriorityLeval = "Low";
                        setState(() {});
                        refreah();
                        print("TASK PRIORITY${Variable.prioritys}");
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xffe6ecf0),
                                width: 1,
                              ),
                              color: Colors.white,
                            ),
                            child: SvgPicture.string(
                              TaskSvg().priorityIcon,
                              color: Color(0xff50D166),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Low Priority",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
