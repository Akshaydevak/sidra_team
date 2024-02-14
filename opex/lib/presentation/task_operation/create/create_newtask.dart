import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/select_assignees.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/reporting_person_task.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/utils/variables.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/no_glow.dart';
import '../home/bloc/job_bloc.dart';
import '../task_title.dart';
import 'create_svg.dart';
import 'model/task_models.dart';

class CreateNewTask extends StatefulWidget {
  final bool isSubTask;
  final bool editTask;
  final bool backRead;
  final int? subTaskId;
  final int? jobId;
  final String startDateTime;
  final String endDateTime;
  const CreateNewTask(
      {Key? key,
      this.isSubTask = false,
      this.editTask = false,
      this.backRead = false,
      this.subTaskId,
      this.jobId,
      this.startDateTime="",
      this.endDateTime=""})
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
    validationCheck();
    grpval = val;
    setState(() {});
    print("uuu$grpval");
  }

  void updatevalue(bool val) {
    updateval = val;
    validationCheck();
    setState(() {});
  }

  String _range = '';
  String _range2 = '';

  _onSelectionChanged(DateTime? startDatePass,DateTime? endDatePass) {

    setState(() {
      _range = '${DateFormat('yyyy-MM-dd').format(startDatePass!)} -'
          ' ${DateFormat('yyyy-MM-dd').format(endDatePass!)}';

      _range2 = '${DateFormat('dd-MM-yyyy').format(startDatePass)} -'
          ' ${DateFormat('dd-MM-yyyy').format(endDatePass)}';
      startDate=_range.split(" - ")[0];
      startDate2=_range2.split(" - ")[0];
      ebdDate=_range.split(" - ")[1];
      ebdDate2=_range2.split(" - ")[1];

      validationCheck();
    });
  }

  // TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  // TimeOfDay _time2 = TimeOfDay(hour: 8, minute: 15);

  TextEditingController jobtitle = TextEditingController();
  TextEditingController jobdiscription = TextEditingController();
  String startTime = "Select Time";
  String startTime2 = "00:00";
  String endTime = "Select Time";
  String endTime2 = "00:00";
  Time _time = Time(hour: 11, minute: 30, second: 20);
  Time _timeRead = Time(hour: 12, minute: 30, second: 20);
  bool time1Selected = false;
  bool time2Selected = false;
  String time2='';
  String time3='';
  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;

    });
  }
  void onTimeChangedEnd(Time newTime) {
    setState(() {
      _timeRead = newTime;
    });
  }
  // void _selectTime() async {
  //   final TimeOfDay? newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _time = newTime;
  //       startTime = "${newTime.hour}" ":" "${newTime.minute}" ":" "00 ";
  //     });
  //   }
  //   final timeOfDay =
  //       TimeOfDay(hour: newTime?.hour ?? 3, minute: newTime?.minute ?? 30);
  //
  //   final twentyFourHourFormat = DateFormat('HH:mm:00');
  //   final twelveHourFormat = DateFormat('h:mm a');
  //
  //   final dateTime = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
  //   startTime = twelveHourFormat.format(dateTime);
  //   startTime2 = twentyFourHourFormat.format(dateTime);
  //   validationCheck();
  //   print(startTime);
  // }

  // void _endTime() async {
  //   final TimeOfDay? newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time2,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _time2 = newTime;
  //       endTime = "${newTime.hour}" ":" "${newTime.minute}" ":" "00 ";
  //     });
  //   }
  //   print("TYM${_time2.hour}" ":" "${_time2.minute}");
  //   final timeOfDay = TimeOfDay(
  //       hour: newTime?.hour ?? 3,
  //       minute: newTime?.minute ?? 30); // Example time of day (3:30 PM)
  //
  //   final twentyFourHourFormat = DateFormat('HH:mm:00');
  //   final twelveHourFormat = DateFormat('h:mm a');
  //
  //   final dateTime = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
  //   endTime = twelveHourFormat.format(dateTime);
  //   endTime2 = twentyFourHourFormat.format(dateTime);
  //   validationCheck();
  //   print(endTime);
  // }

  String PriorityLeval = "Low";
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

  String startDate = DateTime.now().toString();
  String startDate2 = "";
  String ebdDate = DateTime.now().toString();
  String ebdDate2 = "";

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

  bool? isValid = false;
  validationCheck() {
    if (taskTitle.text != "" &&
        discription.text != "" &&
        // _range != "" &&
        // startTime2 != "00:00" &&
        // endTime2 != "00:00" &&
        taskYype != null &&
        Variable.assignCode != "") {
      isValid = true;
    } else {
      isValid = false;
    }
    print("is valid$isValid");
  }

  GetTaskList? readTask;
  String? taskYype;
  @override
  void initState() {
    context.read<TaskBloc>().add(const GetTaskTypeListEvent());
    context.read<TaskBloc>().add(const GetTaskReadCreateEvent());
    Variable.assignName = "";
    Variable.assignCode = "";
    Variable.assignType = "";
    Variable.reportingEmail = "";
    Variable.reportingName = "";
    Variable.typeAss = "IND";
    clearIndexVal();
    super.initState();
  }

  clearIndexVal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('index');
    await pref.remove('index2');
    Variable.isselected = true;
  }
  void refreshPage(){

    setState((){});
  }

  String? taskId;
  List<GetTaskTypeList>? typelist;
  List<GetTaskList> taskListNew = [];
  List<String> durationList = [];

  bool createButtonLoad = false;
  String selectedValue = 'Today';
  popFunction() {
    context.read<TaskBloc>().add(GetTaskListEvent(
        widget.jobId, '', '', '', false, '', ''));
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if(taskListNew.isEmpty&&Variable.assignType=="Task_Group"){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: w,
                      // height: h/7,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "You are not added a subtask for this task. Do you want to continue?",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: w / 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: w / 3.3,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: Color(0x26000000).withOpacity(0.05)),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Color(0x26000000),
                                //     blurRadius: 0,
                                //     offset: Offset(0, 0),
                                //   ),
                                // ],
                                color: ColorPalette.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: w / 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              popFunction();
                              //
                            },
                            child: Container(
                              width: w / 3.1,
                              padding: EdgeInsets.symmetric(vertical: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: Color(0x26000000).withOpacity(0.05)),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ColorPalette.white,
                                    ColorPalette.white,
                                  ],
                                ),
                              ),
                              child: Text(
                                "Confirm",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.grey,
                                  fontSize: w / 26,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: h / 80,
                    )
                  ],
                ),
              );
            },
          );
          return false;
        }
        else{
          context
              .read<TaskBloc>()
              .add(GetTaskListEvent(widget.jobId, '', '', '', false, '', ''));

          return true;
        }

      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is CreateTaskFailed) {
                createButtonLoad = false;
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
                setState(() {});
              }
              if (state is CreateTaskSuccess) {
                createButtonLoad = false;
                if (isSubTask == true) {
                  taskId = state.taskId;
                  print("task id for sub task${state.taskId}");

                  Fluttertoast.showToast(
                      msg: 'Successfully Created',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white);

                  context.read<TaskBloc>().add(GetSubTaskListEvent(
                      int.tryParse(taskId.toString() ?? '') ?? 0));
                  context.read<TaskBloc>().add(GetTaskReadListEvent(
                      int.tryParse(taskId.toString()) ?? 0));
                  // Navigator.pop(context);
                } else {
                  if (widget.isSubTask == true) {
                    Fluttertoast.showToast(
                        msg: 'Successfully Created',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white);
                    context.read<TaskBloc>().add(
                        GetTaskReadListEvent(widget.subTaskId ?? 0));
                    Navigator.pop(context);
                  }

                  else {
                    Navigator.pop(context);
                    context.read<TaskBloc>().add(
                        GetTaskReadListEvent(int.tryParse(state.taskId) ?? 0));
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: TaskTitle(
                        isMyJob: true,
                      ),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  }
                }
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is UpdateTaskFailed) {
                createButtonLoad = false;
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
                setState(() {});
              }
              if (state is UpdateTaskSuccess) {
                createButtonLoad = false;
                print("task sucsess");

                Fluttertoast.showToast(
                    msg: 'Successfully Updated',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);

                context
                    .read<TaskBloc>()
                    .add(GetTaskReadListEvent(readTask?.id ?? 0));
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is GetTaskTypeListSuccess) {
                typelist = state.taskTypeList;

                print("task sucsess");
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is GetTaskReadCreateSuccess) {
                durationList=state.createRead.duration??[];

                setState(() {

                });
                print("task sucsess");
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is GetTaskReadSuccess) {
                readTask = state.getTaskRead;
                selectedValue=readTask?.duration??"";
                taskTitle.text = readTask?.taskName ?? "";
                discription.text = readTask?.description ?? "";
                taskYype = readTask?.taskTypeName ?? "";
                startDate = readTask?.startDate?.split("T")[0] ?? "";
                ebdDate = readTask?.endDate?.split("T")[0] ?? "";
                Variable.reportingEmail =
                    readTask?.reportingPersonDict?.email??"";
                Variable.reportingName =
                    readTask?.reportingPersonDict?.fName??"";
                Variable
                    .reportingCode = readTask?.reportingPersonDict?.userCode?? "";
                startTime =
                    readTask?.startDate?.split("T")[1].split("+")[0] ?? "";
                endTime = readTask?.endDate?.split("T")[1].split("+")[0] ?? "";

                final timeOfDay = TimeOfDay(
                    hour: int.tryParse(startTime.split(":")[0]) ?? 0,
                    minute: int.tryParse(startTime.split(":")[1]) ??
                        0); // Example time of day (3:30 PM)
                final timeOfDayEnd = TimeOfDay(
                    hour: int.tryParse(endTime.split(":")[0]) ?? 0,
                    minute: int.tryParse(endTime.split(":")[1]) ??
                        0); // Example time of day (3:30 PM)

                final twentyFourHourFormat = DateFormat('HH:mm:00');
                final twelveHourFormat = DateFormat('h:mm a');

                final dateTimet =
                    DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
                final dateTimett =
                    DateTime(1, 1, 1, timeOfDayEnd.hour, timeOfDayEnd.minute);
                startTime = twelveHourFormat.format(dateTimet);
                startTime2 = twentyFourHourFormat.format(dateTimet);
                endTime = twelveHourFormat.format(dateTimett);
                endTime2 = twentyFourHourFormat.format(dateTimett);

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
                ebdDate2 = DateFormat('dd-MM-yyyy').format(dateTime).toString();
                startDate2 =
                    DateFormat('dd-MM-yyyy').format(dateTime2).toString();
                _range2 =
                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse("$date"))} -'
                    ' ${DateFormat('dd-MM-yyyy').format(DateTime.parse("$date2"))}';
                _range =
                    '${DateFormat('yyyy-MM-dd').format(DateTime.parse("$date"))} -'
                    ' ${DateFormat('yyyy-MM-dd').format(DateTime.parse("$date2"))}';
                setState(() {});
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
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
                preferredSize: Size.fromHeight(60),
                child: BackAppBar(
                  label: readTask?.taskName ?? "Create New Task",
                  isAction: false,
                  isBack: false,
                  onTap: () {
                    if(taskListNew.isEmpty&&Variable.assignType=="Task_Group"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: w,
                                  // height: h/7,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Confirm",
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "You are not added a subtask for this task. Do you want to continue?",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          width: w / 3.3,
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0x26000000).withOpacity(0.05)),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Color(0x26000000),
                                            //     blurRadius: 0,
                                            //     offset: Offset(0, 0),
                                            //   ),
                                            // ],
                                            color: ColorPalette.primary,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Cancel",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: w / 26,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          popFunction();
                                          //
                                        },
                                        child: Container(
                                          width: w / 3.1,
                                          padding: EdgeInsets.symmetric(vertical: 13),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0x26000000).withOpacity(0.05)),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                ColorPalette.white,
                                                ColorPalette.white,
                                              ],
                                            ),
                                          ),
                                          child: Text(
                                            "Confirm",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontSize: w / 26,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                SizedBox(
                                  height: h / 80,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else{
                      context
                          .read<TaskBloc>()
                          .add(GetTaskListEvent(widget.jobId, '', '', '', false, '', ''));

                    }

                  },
                )),
            body: SingleChildScrollView(
                child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            validationCheck();
                            _showModalBottomSheet(
                                context, typelist ?? [], taskYype);
                          },
                          child: Container(
                            width: w1,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
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
                              color: Color(0xffF4F4F4),
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
                                      color: ColorPalette.primary,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 18,
                                  color: ColorPalette.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: w1,
                          // height: 185,
                          // padding: EdgeInsets.all(16),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              TextFormField(
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600),
                                onChanged: (n) {
                                  validationCheck();
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 16, right: 16),
                                  hintText: "Task Title",
                                  hintStyle: TextStyle(
                                    color: Color(0x66151522),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none,
                                ),
                                controller: taskTitle,
                                maxLines: 1,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                width: w1,
                                height: 1.50,
                                color: ColorPalette.divider,
                              ),
                              TextFormField(
                                controller: discription,
                                maxLines: 4,
                                minLines: 1,
                                onChanged: (n) {
                                  validationCheck();
                                  setState(() {});
                                },
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 16, top: 10, right: 16, bottom: 16),
                                  hintText: "Enter Description",
                                  hintStyle: TextStyle(
                                    color: Color(0x66151522),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: w1,
                          // height: 120,
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
                                    color: Color(0xfffc3a97),
                                    label: "Date & Time",
                                    svg: CreateSvg().clockIcon,
                                    onTap: () {
                                      setState(() {
                                        // isTime = !isTime;
                                      });
                                    },
                                    endIcon: GestureDetector(
                                      onTap: () {
                                        // focusNode.unfocus();
                                        // descriptionfocusNode.unfocus();

                                      },
                                      child: DropdownButton<String>(
                                        value: selectedValue,
                                        isDense: true,
                                        dropdownColor: Colors.white,
                                        padding: EdgeInsets.zero,
                                        underline: Container(),
                                        // elevation: 16,
                                        style: GoogleFonts.roboto(color: ColorPalette.primary,
                                        fontWeight: FontWeight.w500),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedValue = newValue??"";
                                            // startDate="";
                                            // startDate2="";
                                            // startTime="";
                                            // startTime2="";
                                            // endTime2='';
                                            // endTime='';
                                            // ebdDate='';
                                            // ebdDate2='';
                                            if(selectedValue=="Custom date"){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      insetPadding:w1>700?  EdgeInsets.all(50): const EdgeInsets.all(15),
                                                      contentPadding: EdgeInsets.zero,

                                                      content: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 18),
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,

                                                            borderRadius: BorderRadius.all(Radius.circular(12))),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            Text("Please select start date & end date",
                                                              style: GoogleFonts.roboto(
                                                                  color: ColorPalette.subtextGrey,
                                                                  fontSize: w/28
                                                              ),),
                                                            Container(
                                                              width: w1,
                                                              child: CalendarDatePicker2WithActionButtons(
                                                                onOkTapped: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                onCancelTapped: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                onValueChanged: (ff){
                                                                  print("value changed$ff");
                                                                  DateTime? dateTime =  DateTime.parse(ff[0].toString());
                                                                  DateTime? dateTime2 =  DateTime.parse(ff[1].toString());
                                                                  _onSelectionChanged(dateTime,dateTime2);
                                                                  // _range = '${DateFormat('yyyy-MM-dd').format(dateTime)} -'
                                                                  //     ' ${DateFormat('yyyy-MM-dd').format(dateTime2)}';
                                                                  // _range2 = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} -'
                                                                  //     ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
                                                                  print("value changed${dateTime}");
                                                                  print("value changed${dateTime2}");
                                                                  print("value changed${_range}");
                                                                  setState(() {

                                                                  });
                                                                },

                                                                config: CalendarDatePicker2WithActionButtonsConfig(
                                                                  firstDayOfWeek: 1,firstDate: DateTime.tryParse(startDate),
                                                                  calendarType: CalendarDatePicker2Type.range,
                                                                  selectedDayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                                                  selectedDayHighlightColor: ColorPalette.primary,
                                                                  centerAlignModePicker: true,
                                                                  customModePickerIcon: SizedBox(),
                                                                ),
                                                                value: [DateTime.tryParse(startDate),DateTime.tryParse(ebdDate)],
                                                              ),
                                                            ),
                                                            // Row(
                                                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            //     children: <Widget>[
                                                            //       GestureDetector(
                                                            //         onTap: () {
                                                            //           Navigator.of(context).pop();
                                                            //         },
                                                            //         child: Container(
                                                            //           width: w1 > 700 ? w1 / 3.3 : w / 3.3,
                                                            //           padding: const EdgeInsets.symmetric(vertical: 10),
                                                            //           decoration: BoxDecoration(
                                                            //             borderRadius: BorderRadius.circular(5),
                                                            //             border: Border.all(
                                                            //                 width: 1,
                                                            //                 color: const Color(0x26000000)
                                                            //                     .withOpacity(0.05)),
                                                            //             // boxShadow: [
                                                            //             //   BoxShadow(
                                                            //             //     color: Color(0x26000000),
                                                            //             //     blurRadius: 3,
                                                            //             //     offset: Offset(0, 0),
                                                            //             //   ),
                                                            //             // ],
                                                            //             color: Colors.white,
                                                            //           ),
                                                            //           child: Center(
                                                            //             child: Text(
                                                            //               "Close",
                                                            //               textAlign: TextAlign.center,
                                                            //               style: GoogleFonts.inter(
                                                            //                 color: const Color(0xffa9a8a8),
                                                            //                 fontSize: w / 26,
                                                            //                 fontWeight: FontWeight.w500,
                                                            //               ),
                                                            //             ),
                                                            //           ),
                                                            //         ),
                                                            //       ),
                                                            //       GestureDetector(
                                                            //         onTap: () {
                                                            //           // BlocProvider.of<SignupBloc>(context).add(
                                                            //           //     DeactivateAccount(password: password.text));
                                                            //         },
                                                            //         child: Container(
                                                            //           width: w1 > 700 ? w1 / 3.3 : w / 2.5,
                                                            //           padding: const EdgeInsets.symmetric(vertical: 10),
                                                            //           decoration: BoxDecoration(
                                                            //             borderRadius: BorderRadius.circular(5),
                                                            //             color: ColorPalette.primary,
                                                            //           ),
                                                            //           child: Text(
                                                            //             "Deactivate",
                                                            //             textAlign: TextAlign.center,
                                                            //             style: GoogleFonts.inter(
                                                            //               color: Colors.white,
                                                            //               fontSize: w / 26,
                                                            //               fontWeight: FontWeight.w500,
                                                            //             ),
                                                            //           ),
                                                            //         ),
                                                            //       ),
                                                            //     ]),
                                                            // const SizedBox(height: 16,)
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                    // return AlertDialog(
                                                    //   surfaceTintColor: Colors.white,
                                                    //   backgroundColor: Colors.white,
                                                    //   shape: RoundedRectangleBorder(
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(
                                                    //             10.0),
                                                    //   ),
                                                    //   content: Column(
                                                    //     mainAxisSize:
                                                    //         MainAxisSize.min,
                                                    //     children: [
                                                    //       Container(
                                                    //         height: 300,
                                                    //         child: Scaffold(
                                                    //           body: SfDateRangePicker(
                                                    //             backgroundColor:
                                                    //                 Colors.white,
                                                    //             endRangeSelectionColor:
                                                    //                 ColorPalette
                                                    //                     .primary,
                                                    //             startRangeSelectionColor:
                                                    //                 ColorPalette
                                                    //                     .primary,
                                                    //             rangeSelectionColor:
                                                    //                 ColorPalette
                                                    //                     .primary
                                                    //                     .withOpacity(
                                                    //                         0.1),
                                                    //             selectionColor:
                                                    //                 Colors.grey,
                                                    //             todayHighlightColor:
                                                    //                 ColorPalette
                                                    //                     .primary,
                                                    //             onSelectionChanged:
                                                    //                 _onSelectionChanged,
                                                    //             selectionMode:
                                                    //                 DateRangePickerSelectionMode
                                                    //                     .range,
                                                    //             initialSelectedRange: widget
                                                    //                     .editTask
                                                    //                 ? PickerDateRange(
                                                    //                     DateTime.parse(
                                                    //                         startDate),
                                                    //                     DateTime.parse(
                                                    //                         ebdDate))
                                                    //                 : startDate != ""
                                                    //                     ? PickerDateRange(
                                                    //                         DateTime.parse(
                                                    //                             startDate),
                                                    //                         DateTime.parse(
                                                    //                             ebdDate))
                                                    //                     : PickerDateRange(
                                                    //                         DateTime
                                                    //                             .now(),
                                                    //                         DateTime
                                                    //                             .now()),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //       GestureDetector(
                                                    //         onTap: () {
                                                    //           if (_range.isEmpty)
                                                    //             setState(() {
                                                    //               // if (DateTime.now() is PickerDateRange) {
                                                    //               _range =
                                                    //                   '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
                                                    //               _range2 =
                                                    //                   '${DateFormat('dd-MM-yyyy').format(DateTime.now())}';
                                                    //               print(
                                                    //                   "range is here$_range");
                                                    //
                                                    //               startDate = _range;
                                                    //               startDate2 =
                                                    //                   _range2;
                                                    //               ebdDate = _range;
                                                    //               ebdDate2 = _range2;
                                                    //
                                                    //               // validationCheck();
                                                    //             });
                                                    //
                                                    //           Navigator.pop(context);
                                                    //         },
                                                    //         child: Container(
                                                    //           height: 25,
                                                    //           width: 75,
                                                    //           color: ColorPalette
                                                    //               .primary,
                                                    //           child: Center(
                                                    //               child: Text(
                                                    //             "Ok",
                                                    //             style: GoogleFonts
                                                    //                 .roboto(
                                                    //                     color: Colors
                                                    //                         .white),
                                                    //           )),
                                                    //         ),
                                                    //       )
                                                    //     ],
                                                    //   ),
                                                    // );
                                                  });
                                            }
                                          });
                                        },
                                        items: durationList
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                              ),
                              selectedValue=="Custom date"?
                              Column(
                                children: [
                                  Divider(
                                    indent: 10,
                                    height: 2,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 10,
                                        top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "From :",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: w / 24,
                                              ),
                                            ),
                                            SizedBox(
                                              width: w / 40,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                // border:
                                                // Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x05000000),
                                                    blurRadius: 8,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                                color: Color(0xffF4F4F4),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                _range2.isNotEmpty
                                                    ? startDate2
                                                    : "           ",
                                                style: GoogleFonts.roboto(
                                                  color: ColorPalette.black,
                                                  fontSize: w / 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "To :",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: w / 24,
                                              ),
                                            ),
                                            SizedBox(
                                              width: w / 40,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                // border:
                                                // Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x05000000),
                                                    blurRadius: 8,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                                color: Color(0xffF4F4F4),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                _range2.isNotEmpty
                                                    ? ebdDate2
                                                    : "           ",
                                                style: GoogleFonts.roboto(
                                                  color: ColorPalette.black,
                                                  fontSize: w / 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    indent: 10,
                                    height: 2,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 12,
                                        top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).push(
                                              showPicker(
                                                showSecondSelector: false,
                                                context: context,
                                                value: _time,
                                                onChange: onTimeChanged,
                                                minuteInterval: TimePickerInterval.FIVE,
                                                // Optional onChange to receive value as DateTime
                                                onChangeDateTime: (DateTime dateTime) {
                                                  time1Selected=true;

                                                  time2 = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
                                                  final twentyFourHourFormat = DateFormat('HH:mm:ss');
                                                  final twelveHourFormat = DateFormat('h:mm a');
                                                  startTime = twelveHourFormat.format(dateTime);
                                                  startTime2 = twentyFourHourFormat.format(dateTime);
                                                  print(startTime);
                                                  print(startTime2);
                                                  debugPrint("[debug datetime]:  $dateTime");
                                                  debugPrint("[debug datetime]:  $time2");
                                                  validationCheck();
                                                  setState((){});
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            startTime,
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff2871AF),
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).push(
                                              showPicker(
                                                showSecondSelector: false,
                                                context: context,
                                                value: _timeRead,
                                                onChange: onTimeChangedEnd,
                                                minuteInterval: TimePickerInterval.FIVE,
                                                // Optional onChange to receive value as DateTime
                                                onChangeDateTime: (DateTime dateTime) {
                                                  time1Selected=true;

                                                  time3 = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
                                                  final twentyFourHourFormat = DateFormat('HH:mm:ss');
                                                  final twelveHourFormat = DateFormat('h:mm a');
                                                  endTime = twelveHourFormat.format(dateTime);
                                                  endTime2 = twentyFourHourFormat.format(dateTime);
                                                  print(endTime);
                                                  print(endTime2);
                                                  debugPrint("[debug datetime]:  $time3");
                                                  validationCheck();
                                                  setState((){});
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            endTime,
                                            style: GoogleFonts.roboto(
                                              color: Color(0xff2871AF),
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ):Container(),
                            ],
                          ),
                        ),
                        Text(
                          "Job Duration ${widget.startDateTime} - ${widget.endDateTime}",
                          style: GoogleFonts.roboto(
                              color: Color(0x66151522),
                              fontSize: w / 32,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            validationCheck();
                            _showModalBottomSheetPriority(PriorityLeval);
                          },
                          child: Container(
                            width: w1,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.string(
                                                    TaskSvg().priorityIcon,
                                                    color: PriorityLeval ==
                                                            "Low"
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
                                        ? Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: ColorPalette.primary,
                                            size: 18,
                                          )
                                        : Container()
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            validationCheck();
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
                                      refresh: refreshPage,
                                    ),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  )
                                : PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: ReportingPerson(
                                      refresh: refreshPage,
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
                            width: w1,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
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
                            child: SingleRow(
                                color: Color(0xffAD51E0),
                                label: "Reporting Person",
                                svg: TaskSvg().personIcon,
                                onTap: () {
                                  validationCheck();
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
                                      refresh: refreshPage,
                                    ),
                                    withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                                  )
                                      : PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: ReportingPerson(
                                      refresh: refreshPage,
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
                                endIcon: Variable.reportingEmail == ""?Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: ColorPalette.primary,
                                  size: 18,
                                ):Container(
                                  width: w1/4,
                                    alignment: Alignment.centerRight,
                                    // color: Colors.orange,
                                    child: Text(Variable.reportingName??"",
                                    overflow: TextOverflow.ellipsis,
                                        maxLines: 2,))),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: w1,
                          // height: 185,
                          // padding: EdgeInsets.all(16),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400),
                                onChanged: (n) {
                                  validationCheck();
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 16, right: 16),
                                  hintText: "Add Notes",
                                  hintStyle: TextStyle(
                                    color: Color(0x66151522),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none,
                                ),
                                controller: notesController,
                                maxLines: 1,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                width: w1,
                                height: 1.50,
                                color: ColorPalette.divider,
                              ),
                              TextFormField(
                                controller: remarksController,
                                maxLines: 4,
                                minLines: 1,
                                onChanged: (n) {
                                  validationCheck();
                                  setState(() {});
                                },
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 16, top: 10, right: 16, bottom: 16),
                                  hintText: "Add Remarks",
                                  hintStyle: TextStyle(
                                    color: Color(0x66151522),
                                    fontSize: w / 26,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        widget.editTask == false
                            ? widget.isSubTask
                                ? GestureDetector(
                                    onTap: () {
                                      context.read<JobBloc>().add(
                                          const GetEmployeeListEvent(
                                              '', '', ''));
                                      context
                                          .read<JobBloc>()
                                          .add(GetGroupListEvent());
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: AssignesUnderGroup(
                                          groupVal: updatevalue,
                                          groupId: readTask?.groupId??0,
                                        ),
                                        withNavBar: true,
                                        // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                      );
                                    },
                                    child: Container(
                                      width: w1,
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
                                                  fontSize: w / 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // Image.asset(
                                              //   "asset/img_6.png",
                                              //   height: 30,
                                              //   width: 30,
                                              // ),
                                              // const SizedBox(
                                              //   width: 10,
                                              // ),
                                              // Variable.assignName==""?Icon(Icons.arrow_forward_ios_sharp):Text(Variable.assignName)
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
                                        screen:
                                            SelectAssignees(groupVal: grpVal),
                                        withNavBar: true,
                                        // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                      );
                                    },
                                    child: Container(
                                      width: w1,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
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
                                                  fontSize: w / 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // Image.asset(
                                              //   "asset/img_6.png",
                                              //   height: 30,
                                              //   width: 30,
                                              // ),
                                              // const SizedBox(
                                              //   width: 10,
                                              // ),
                                              Variable.assignName == ""
                                                  ? Icon(
                                                      Icons
                                                          .arrow_forward_ios_sharp,
                                                      color:
                                                          ColorPalette.primary,
                                                      size: 18,
                                                    )
                                                  : Text(Variable.assignName)
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
                                height: 5,
                              ),
                        // widget.isSubTask
                        //     ? Container()
                        //     : grpval == true
                        //         ? Column(
                        //             children: [
                        //               Container(
                        //                 width: w,
                        //                 padding: EdgeInsets.symmetric(
                        //                     horizontal: 16, vertical: 10),
                        //                 decoration: BoxDecoration(
                        //                   borderRadius:
                        //                       BorderRadius.circular(5),
                        //                   border: Border.all(
                        //                     color: Color(0xffe6ecf0),
                        //                     width: 1,
                        //                   ),
                        //                   boxShadow: [
                        //                     BoxShadow(
                        //                       color: Color(0x05000000),
                        //                       blurRadius: 8,
                        //                       offset: Offset(1, 1),
                        //                     ),
                        //                   ],
                        //                   color: Colors.white,
                        //                 ),
                        //                 child: SingleRow(
                        //                   label: "Subtasks",
                        //                   color: Color(0xffFFC800),
                        //                   svg: CreateSvg().taskIcon,
                        //                   endIcon: isSubTask
                        //                       ? SvgPicture.string(
                        //                           HomeSvg().toggleActive)
                        //                       : SvgPicture.string(
                        //                           HomeSvg().toggleInActive),
                        //                   onTap: () {
                        //                     setState(() {
                        //                       Variable.taskType == 0 ||
                        //                               taskTitle.text == "" ||
                        //                               discription.text == "" ||
                        //                               Variable.assignType ==
                        //                                   "" ||
                        //                               Variable.assignCode == ""
                        //                           ? Fluttertoast.showToast(
                        //                               msg:
                        //                                   'Please fill the fields',
                        //                               toastLength:
                        //                                   Toast.LENGTH_SHORT,
                        //                               gravity:
                        //                                   ToastGravity.BOTTOM,
                        //                               backgroundColor:
                        //                                   Colors.black,
                        //                               textColor: Colors.white)
                        //                           : BlocProvider.of<TaskBloc>(
                        //                                   context)
                        //                               .add(CreateTaskEvent(
                        //                               latitude: null,
                        //                               longitude: null,
                        //                               AssigningCode:
                        //                                   Variable.assignCode,
                        //                               AssigningType:
                        //                                   Variable.assignType,
                        //                               createdOn:
                        //                                   "${_range.split(" - ")[0]} $startTime2",
                        //                               jobId: widget.jobId ?? 0,
                        //                               notas: notesController
                        //                                       .text ??
                        //                                   "",
                        //                               durationOption: selectedValue,
                        //                               priorityLeval: 0,
                        //                               remarks: remarksController
                        //                                   .text,
                        //                               taskName:
                        //                                   taskTitle.text ?? "",
                        //                               taskType:
                        //                                   Variable.taskType,
                        //                               lastmodified: null,
                        //                               parant: null,
                        //                               statusStagesId: null,
                        //                               discription:
                        //                                   discription.text ??
                        //                                       "",
                        //                               createdBy: authentication
                        //                                       .authenticatedUser
                        //                                       .code ??
                        //                                   "",
                        //                               isActive: true,
                        //                               priority: PriorityLeval,
                        //                               reportingPerson: Variable
                        //                                           .reportingCode ==
                        //                                       ""
                        //                                   ? authentication
                        //                                       .authenticatedUser
                        //                                       .code
                        //                                       .toString()
                        //                                   : Variable
                        //                                       .reportingCode
                        //                                       .toString(),
                        //                               endDate:
                        //                                   "$ebdDate ${endTime2}",
                        //                               startDate:
                        //                                   "$startDate ${startTime2}",
                        //                             ));
                        //                       Variable.taskType == 0 ||
                        //                               taskTitle.text == "" ||
                        //                               discription.text == "" ||
                        //                               Variable.assignType ==
                        //                                   "" ||
                        //                               Variable.assignCode == ""
                        //                           ? Fluttertoast.showToast(
                        //                               msg:
                        //                                   'Please fill the fields',
                        //                               toastLength:
                        //                                   Toast.LENGTH_SHORT,
                        //                               gravity:
                        //                                   ToastGravity.BOTTOM,
                        //                               backgroundColor:
                        //                                   Colors.black,
                        //                               textColor: Colors.white)
                        //                           : isSubTask = !isSubTask;
                        //                     });
                        //                   },
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: 10,
                        //               ),
                        //               isSubTask == true
                        //                   ? Container(
                        //                       width: w,
                        //                       decoration: BoxDecoration(
                        //                         borderRadius:
                        //                             BorderRadius.circular(4),
                        //                         border: Border.all(
                        //                           color: Color(0xffe6ecf0),
                        //                           width: 1,
                        //                         ),
                        //                         boxShadow: [
                        //                           BoxShadow(
                        //                             color: Color(0x05000000),
                        //                             blurRadius: 8,
                        //                             offset: Offset(1, 1),
                        //                           ),
                        //                         ],
                        //                         color: Colors.white,
                        //                       ),
                        //                       child: Column(
                        //                         children: [
                        //                           Container(
                        //                             width: w,
                        //                             child: taskListNew.isEmpty
                        //                                 ? Container()
                        //                                 : Container(
                        //                                     child: ListView
                        //                                         .separated(
                        //                                             shrinkWrap:
                        //                                                 true,
                        //                                             physics:
                        //                                                 NeverScrollableScrollPhysics(),
                        //                                             itemBuilder:
                        //                                                 (context,
                        //                                                         index) =>
                        //                                                     Container(
                        //                                                       decoration: BoxDecoration(
                        //                                                         color: Colors.white,
                        //                                                         border: Border.all(color: ColorPalette.borderGrey),
                        //                                                         borderRadius: BorderRadius.circular(10)
                        //                                                       ),
                        //                                                       margin: EdgeInsets.all(5),
                        //                                                       child: Padding(
                        //                                                         padding: const EdgeInsets.all(10),
                        //                                                         child: Row(
                        //                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                                                           children: [
                        //                                                             Text(
                        //                                                               "${index + 1}- ${taskListNew[index].taskName ?? ""}",
                        //                                                               style: GoogleFonts.roboto(
                        //                                                                 color: Color(0xff151522),
                        //                                                                 fontSize: 18,
                        //                                                                 fontWeight: FontWeight.w500,
                        //                                                               ),
                        //                                                             ),
                        //                                                             // Row(
                        //                                                             //   children: [
                        //                                                             //     Text(taskListNew[index].assigningCode??""),
                        //                                                             //     SizedBox(
                        //                                                             //       width: 10,
                        //                                                             //     ),
                        //                                                             //     // Icon(
                        //                                                             //     //     Icons
                        //                                                             //     //         .arrow_forward_ios_sharp)
                        //                                                             //   ],
                        //                                                             // )
                        //                                                           ],
                        //                                                         ),
                        //                                                       ),
                        //                                                     ),
                        //                                             separatorBuilder:
                        //                                                 (context,
                        //                                                     index) {
                        //                                               return SizedBox(
                        //                                                 height:
                        //                                                     5,
                        //                                               );
                        //                                             },
                        //                                             itemCount:
                        //                                                 taskListNew
                        //                                                     .length),
                        //                                   ),
                        //                           ),
                        //                           // Divider(
                        //                           //   color: Color(0xffE6ECF0)
                        //                           //       .withOpacity(0.5),
                        //                           //   thickness: 1,
                        //                           // ),
                        //                           isSubTask == true
                        //                               ? GestureDetector(
                        //                                   onTap: () {
                        //                                     print(
                        //                                         "SUbtask$taskId");
                        //                                     // Variable.taskIdForSubtask =
                        //                                     //     int.tryParse(taskId!) ?? 0;
                        //                                     PersistentNavBarNavigator
                        //                                         .pushNewScreen(
                        //                                       context,
                        //                                       screen:
                        //                                           CreateNewTask(
                        //                                         jobId: widget
                        //                                             .jobId,
                        //                                             startDateTime: "${startDate2}  ${startTime}",
                        //                                             endDateTime: "$ebdDate2  $endTime",
                        //                                         isSubTask: true,
                        //                                         subTaskId:
                        //                                             int.tryParse(
                        //                                                     taskId!) ??
                        //                                                 0,
                        //                                       ),
                        //                                       withNavBar: true,
                        //                                       // OPTIONAL VALUE. True by default.
                        //                                       pageTransitionAnimation:
                        //                                           PageTransitionAnimation
                        //                                               .fade,
                        //                                     );
                        //                                   },
                        //                                   child: Container(
                        //                                       width: w,
                        //                                       alignment:
                        //                                           Alignment
                        //                                               .center,
                        //                                       decoration:
                        //                                           BoxDecoration(
                        //                                         borderRadius:
                        //                                             BorderRadius
                        //                                                 .circular(
                        //                                                     4),
                        //                                         color: Color(
                        //                                             0xffF4F4F4),
                        //                                       ),
                        //                                       padding: EdgeInsets
                        //                                           .symmetric(
                        //                                               horizontal:
                        //                                                   16,
                        //                                               vertical:
                        //                                                   10),
                        //                                       child: Text(
                        //                                         "Add Subtask",
                        //                                         style: TextStyle(
                        //                                             color: ColorPalette
                        //                                                 .primary,
                        //                                             fontSize:
                        //                                                 w / 24,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w500),
                        //                                       )),
                        //                                 )
                        //                               : Container(),
                        //                         ],
                        //                       ),
                        //                     )
                        //                   : Container()
                        //             ],
                        //           )
                        //         : Container(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                      isValid == false
                                ? GradientButton(
                                    color: ColorPalette.inactiveGrey,
                                    onPressed: () {},
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorPalette.inactiveGrey,
                                          ColorPalette.inactiveGrey
                                        ]),
                                    child: Text(
                                      widget.editTask ? "Update" : "Create",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ))
                                : GradientButton(
                                    color: ColorPalette.primary,
                                    onPressed: () {
                                      createButtonLoad = true;
                                      setState(() {});
                                      widget.editTask || isSubTask
                                          ? BlocProvider.of<TaskBloc>(context)
                                              .add(UpdateTaskEvent(
                                        durationOption: selectedValue,
                                                  latitude: readTask?.latitude,
                                                  longitude:
                                                      readTask?.longitude,
                                                  id: readTask?.id ?? 0,
                                                  AssigningCode:
                                                      Variable.assignCode,
                                                  AssigningType:
                                                      Variable.assignType,
                                                  createdOn:
                                                      "${_range.split(" - ")[0]} ${startTime2}",
                                                  jobid: readTask?.jobId,
                                                  notas: notesController.text ??
                                                      "",
                                                  priorityLeval: 0,
                                                  remarks:
                                                      remarksController.text ??
                                                          "",
                                                  taskName:
                                                      taskTitle.text ?? "",
                                                  taskType: Variable.taskType,
                                                  lastmodified: null,
                                                  parant: readTask?.parent,
                                                  statusStagesId:
                                                      readTask?.statusStagesId,
                                                  discription:
                                                      discription.text ?? "",
                                                  createdBy: authentication
                                                          .authenticatedUser
                                                          .code ??
                                                      "",
                                                  isActive: true,
                                                  priority: PriorityLeval,
                                                  reportingPerson: readTask
                                                          ?.reportingPersonCode ??
                                                      "",
                                                  endDate: "$ebdDate"
                                                      " "
                                                      "$endTime2",
                                                  startDate: "$startDate"
                                                      " "
                                                      "$startTime2",
                                                  img5: readTask
                                                      ?.metaData?.image5,
                                                  img1: readTask
                                                      ?.metaData?.image1,
                                                  img4: readTask
                                                      ?.metaData?.image4,
                                                  img2: readTask
                                                      ?.metaData?.image2,
                                                  img3: readTask
                                                      ?.metaData?.image3,
                                                  attachmentDescription:
                                                      readTask?.metaData
                                                          ?.description,
                                                  attachmentNote:
                                                      readTask?.metaData?.note))
                                          : BlocProvider.of<TaskBloc>(context)
                                              .add(CreateTaskEvent(
                                              latitude: null,
                                              longitude: null,
                                              durationOption: selectedValue,
                                              AssigningCode:
                                                  Variable.assignCode,
                                              AssigningType:
                                                  Variable.assignType,
                                              createdOn:
                                                  "${_range.split(" - ")[0]} ${startTime2}",
                                              jobId: widget.jobId ?? 0,
                                              notas: notesController.text,
                                              priorityLeval: 0,
                                              remarks: remarksController.text,
                                              taskName: taskTitle.text,
                                              taskType: Variable.taskType,
                                              lastmodified: null,
                                              parant: widget.subTaskId,
                                              statusStagesId: null,
                                              discription: discription.text,
                                              createdBy: authentication
                                                      .authenticatedUser.code ??
                                                  "",
                                              isActive: true,
                                              priority: PriorityLeval,
                                              reportingPerson:
                                                  Variable.reportingCode == ""
                                                      ? authentication
                                                          .authenticatedUser
                                                          .code
                                                          .toString()
                                                      : Variable.reportingCode
                                                          .toString(),
                                              endDate: "$ebdDate ${endTime2}",
                                              startDate:
                                                  "$startDate ${startTime2}",
                                            ));
                                    },
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorPalette.primary,
                                          ColorPalette.primary
                                        ]),
                                    child: createButtonLoad == true
                                        ? SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 15.0,
                                          )
                                        : Text(
                                            widget.editTask
                                                ? "Update"
                                                : "Create",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                      ],
                    ),
                  ),
                ],
              ),
            ))),
      ),
    );
  }

  _showModalBottomSheet(
      BuildContext context, List<GetTaskTypeList> taskTypeList, String? type) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          var h = MediaQuery.of(context).size.height;
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
                          "Select Task Type",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        SizedBox(
                          height: h / 1.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.separated(
                                      padding: const EdgeInsets.only(),
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: taskTypeList.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return GestureDetector(
                                          onTap: () {
                                            changeTappedTile(i);
                                            Variable.taskType =
                                                taskTypeList[i].id ?? 0;
                                            taskYype =
                                                taskTypeList[i].typeName ?? "";
                                            validationCheck();
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            color: type ==
                                                    taskTypeList[i].typeName
                                                ? ColorPalette.cardBackground
                                                : ColorPalette.white,
                                            child: Row(
                                              children: [
                                                type == taskTypeList[i].typeName
                                                    ? SvgPicture.string(
                                                        HomeSvg()
                                                            .radioButtonActive,
                                                        // color: ColorPalette
                                                        //     .primary,
                                                      )
                                                    : SvgPicture.string(
                                                        CreateSvg()
                                                            .radioInActiveButton),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  taskTypeList[i].typeName ??
                                                      "",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: w / 24,
                                                    // fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          // margin: EdgeInsets.only(left: 16, right: 16),
                                          color: Color(0xffE6ECF0),
                                          height: 1,
                                          width: w,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetPriority(String priorityread) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        useRootNavigator: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                // height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Set Priority ",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          // thickness: 1,
                          // indent: 10,
                          height: 1,
                          width: w,
                          color: Color(0xfff8f7f5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Variable.prioritys = "High";
                            PriorityLeval = "High";
                            setState(() {});
                            refreah();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: priorityread == "High"
                                ? EdgeInsets.all(10)
                                : null,
                            color: priorityread == "High"
                                ? Color(0xffF4F4F4)
                                : Colors.white,
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
                                  child:
                                      SvgPicture.string(TaskSvg().priorityIcon),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "High Priority",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 22,
                                    fontWeight: priorityread == "High"
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // thickness: 1,
                          // indent: 10,
                          height: 1,
                          width: w,
                          color: Color(0xfff8f7f5),
                        ),
                        SizedBox(
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
                          child: Container(
                            padding: priorityread == "Medium"
                                ? EdgeInsets.all(10)
                                : null,
                            color: priorityread == "Medium"
                                ? Color(0xffF4F4F4)
                                : Colors.white,
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
                                    fontSize: w / 22,
                                    fontWeight: priorityread == "Medium"
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // thickness: 1,
                          // indent: 10,
                          height: 1,
                          width: w,
                          color: Color(0xfff8f7f5),
                        ),
                        SizedBox(
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
                          child: Container(
                            padding: priorityread == "Low"
                                ? EdgeInsets.all(10)
                                : null,
                            color: priorityread == "Low"
                                ? Color(0xffF4F4F4)
                                : Colors.white,
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
                                    fontSize: w / 22,
                                    fontWeight: priorityread == "Low"
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )

                        // Row(
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(left: 16),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: const Color(0xfffd5762),
                        //       ),
                        //       child: SvgPicture.string(HomeSvg().imgFeedIcon),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Video / Image Feed ",
                        //       style: GoogleFonts.roboto(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   indent: 70,
                        //   color: Color(0xffE6ECF0),
                        // ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(left: 16),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: const Color(0xfffd5762),
                        //       ),
                        //       child: SvgPicture.string(HomeSvg().analyticIcon),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Updation / Analytics",
                        //       style: GoogleFonts.roboto(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   indent: 70,
                        //   color: Color(0xffE6ECF0),
                        // ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(left: 16),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: const Color(0xfffd5762),
                        //       ),
                        //       child: SvgPicture.string(HomeSvg().chatGroupIcon),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Chat or Group",
                        //       style: GoogleFonts.roboto(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 50,
                        // )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
