import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/order_app/activity_log.dart';
import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_appraisal.dart';
import 'package:cluster/presentation/task_operation/rewards_screen.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/attachment_card.dart';
import 'package:cluster/presentation/task_operation/task_title/task_title_card.dart';
import 'package:cluster/presentation/task_operation/task_title/text_card.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../common_widgets/custom_radio_button.dart';
import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/loading.dart';
import '../../core/color_palatte.dart';
import '../../core/common_snackBar.dart';
import '../../core/utils/variables.dart';
import '../comunication_module/chat_screen.dart';
import 'attachment_screen.dart';
import 'create/create_newtask.dart';
import 'create/create_svg.dart';
import 'create/map_location.dart';
import 'create/model/task_models.dart';
import 'create/single_row.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_bloc/employee_bloc.dart';
import 'employee_model/employee_model.dart';
import 'home/bloc/job_bloc.dart';
import 'home/comments_screen.dart';
import 'home/model/joblist_model.dart';
import 'lottieLoader.dart';

class TaskTitle extends StatefulWidget {
  bool isMyJob;
  bool isReporter;

  TaskTitle({Key? key, this.isMyJob = false, this.isReporter = false})
      : super(key: key);

  @override
  State<TaskTitle> createState() => _TaskTitleState();
}

class _TaskTitleState extends State<TaskTitle> {
  bool isSubTask = true;
  bool isDate = true;
  bool isLocation = false;
  location() {
    if (isLocation == false) {
      BlocProvider.of<TaskBloc>(context).add(UpdateTaskEvent(
        latitude: null,
        longitude: null,
        img5: getTaskRead?.metaData?.image5,
        img1: getTaskRead?.metaData?.image1,
        img4: getTaskRead?.metaData?.image4,
        img2: getTaskRead?.metaData?.image2,
        img3: getTaskRead?.metaData?.image3,
        attachmentDescription: getTaskRead?.metaData?.description,
        attachmentNote: getTaskRead?.metaData?.note,
        id: getTaskRead?.id ?? 0,
        AssigningCode: getTaskRead?.assigningCode ?? "",
        AssigningType: getTaskRead?.assigningType ?? "",
        createdOn: "${getTaskRead?.createdOn?.split("T")[0]}"
            " "
            "${getTaskRead?.createdOn?.split("T")[1].split("+")[0]}",
        jobid: getTaskRead?.jobId,
        notas: getTaskRead?.notes ?? "",
        priorityLeval: "1",
        remarks: getTaskRead?.remarks ?? "",
        taskName: getTaskRead?.taskName ?? "",
        taskType: getTaskRead?.taskType ?? 0,
        lastmodified: null,
        parant: getTaskRead?.parent,
        statusStagesId: null,
        discription: getTaskRead?.description ?? "",
        createdBy: getTaskRead?.createdPersonCode ?? "",
        isActive: true,
        priority: getTaskRead?.priority ?? "",
        reportingPerson: getTaskRead?.reportingPersonCode ?? "",
        endDate: "${getTaskRead?.endDate?.split("T")[0]}"
                " "
                "${getTaskRead?.endDate?.split("T")[1].split("+")[0]}" ??
            "",
        startDate: "${getTaskRead?.startDate?.split("T")[0]}"
                " "
                "${getTaskRead?.startDate?.split("T")[1].split("+")[0]}" ??
            "",
      ));
    } else {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: AddressPickFromMap(
          taskRead: getTaskRead,
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade,
      );
    }
  }

  bool isReporting = true;
  bool isNotify = false;
  String PriorityLeval = "";
  GetTaskList? getTaskRead;
  PerfomerModel? reportingPersonModel;
  PerfomerModel? assignToModel;
  PerfomerModel? assignByModel;
  @override
  void initState() {
    getSocket();
    context.read<JobBloc>().add(GetStatusListEvent());
    context.read<TaskBloc>().add(GetTopicListEvent());
    super.initState();
  }

  void refresh() {
    setState(() {});
  }
  String communicationGroupId='';

  int tappedTile = 0;
  List<StatusListing> statusList = [];
  List<GetTaskList> taskListNew = [];
  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }

  var endstdDate = "";
  var startstdDate = "";
  String startTime = '';
  String endTime = '';
  int? selected;
  void onSelect(int val) {
    selected = val;
    setState(() {});
  }

  TextEditingController reportNotes = TextEditingController();
  TextEditingController replayApproveNotes = TextEditingController();
  TextEditingController replayRejectNotes = TextEditingController();
  int topicId = 0;
  bool _isLoading = true;
  List<FriendListModel>? userList=[];
  GetTaskGroupList? readGroup;
  SharedPreferences? pref;
  String? token;
  String? loginuserId;
  IO.Socket? socketCon;
  getSocket()async{
    pref=await SharedPreferences.getInstance();
    token = pref!.getString("token");
    loginuserId=pref!.getString("loginuserid");
  }

  @override
  Widget build(BuildContext context) {
    final socketpro =context.watch<scoketProvider>();
    socketCon =socketpro.socket;
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        print("popScope");
        if (widget.isReporter == true) {
          context
              .read<TaskBloc>()
              .add(GetTaskListEvent(getTaskRead?.jobId, '', '', '',false,'',''));
          context
              .read<JobBloc>()
              .add(GetJobReadListEvent(getTaskRead?.jobId ?? 0));
          context.read<JobBloc>().add(GetReorterListEvent('', '', ''));
        } else {
          context
              .read<TaskBloc>()
              .add(GetTaskListEvent(getTaskRead?.jobId, '', '', '',false,'',''));
          context
              .read<JobBloc>()
              .add(GetJobReadListEvent(getTaskRead?.jobId ?? 0));
          context.read<JobBloc>().add(GetNewJobListEvent('', '', ''));
        }
        return true;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is GetTaskReadSuccess) {
                getTaskRead = state.getTaskRead;
                if(getTaskRead?.assigningType=="Individual"){

                    userList?.add(
                        FriendListModel(
                            userCode: getTaskRead?.assignToDict?.userCode??"",
                            email: getTaskRead?.assignToDict?.email,
                            fName: getTaskRead?.assignToDict?.fName,
                            lName: getTaskRead?.assignToDict?.lName
                        ));
                    if(getTaskRead?.assignByDict?.userCode==getTaskRead?.reportingPersonDict?.userCode){
                      print("both are same");
                      userList?.add(
                          FriendListModel(
                              userCode: getTaskRead?.assignByDict?.userCode??"",
                              email: getTaskRead?.assignByDict?.email,
                              fName: getTaskRead?.assignByDict?.fName,
                              lName: getTaskRead?.assignByDict?.lName
                          ));
                    }
                    else{
                      print("both are different");
                      userList?.add(
                          FriendListModel(
                              userCode: getTaskRead?.assignByDict?.userCode??"",
                              email: getTaskRead?.assignByDict?.email,
                              fName: getTaskRead?.assignByDict?.fName,
                              lName: getTaskRead?.assignByDict?.lName
                          ));
                      userList?.add(
                          FriendListModel(
                              userCode: getTaskRead?.reportingPersonDict?.userCode??"",
                              email: getTaskRead?.reportingPersonDict?.email,
                              fName: getTaskRead?.reportingPersonDict?.fName,
                              lName: getTaskRead?.reportingPersonDict?.lName
                          ));
                    }

                    print("user list length${userList!.length}");
                    for(var i=0;i<userList!.length;i++){
                      print("user list code${userList?[i].userCode}");
                    }

                  CommunicationTaskGroup? chat;
                  chat=CommunicationTaskGroup(
                      createdBy: getTaskRead?.createdPersonCode,
                      friendList: userList,
                      taskCode: getTaskRead?.taskCode,
                      taskName: getTaskRead?.taskName
                  );
                  context.read<EmployeeBloc>().add(
                      CreateTaskGroupCommunicationEvent(chat));
                }else{
                  context.read<EmployeeBloc>().add(
                      GetGroupTReadEvent(getTaskRead?.groupId?? 0));
                }

                var date = getTaskRead?.endDate;
                var date2 = getTaskRead?.startDate;
                var dateTime = DateTime.parse("$date");
                var dateTime2 = DateTime.parse("$date2");
                endstdDate =
                    DateFormat('dd-MM-yyyy').format(dateTime).toString();
                startstdDate =
                    DateFormat('dd-MM-yyyy').format(dateTime2).toString();
                startTime =
                    getTaskRead?.startDate?.split("T")[1].split("+")[0] ?? "";
                endTime =
                    getTaskRead?.endDate?.split("T")[1].split("+")[0] ?? "";
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
                // startTime2 = twentyFourHourFormat.format(dateTimet);
                endTime = twelveHourFormat.format(dateTimett);
                // endTime2=twentyFourHourFormat.format(dateTimett);
                getTaskRead?.assigningType == "Individual"
                    ? null
                    : context
                        .read<TaskBloc>()
                        .add(GetSubTaskListEvent(getTaskRead?.id));
                isNotify = getTaskRead?.isNotify ?? false;
                if (getTaskRead?.latitude == null &&
                        getTaskRead?.longitude == null ||
                    getTaskRead?.latitude == "" &&
                        getTaskRead?.longitude == "") {
                  isLocation = false;
                } else {
                  isLocation = true;
                }
                _isLoading = false;
                setState(() {});
              }
            },
          ),

          BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              print("state group$state");
              if(state is GetReadGroupLoading){

              }
              if(state is GetReadGroupSuccess){
                readGroup=state.getGroupRead;


                for(var i=0;i<state.getGroupRead.userList!.length;i++){

                  userList?.add(
                      FriendListModel(
                          userCode: state.getGroupRead.userList?[i].code??"",
                          email: state.getGroupRead.userList?[i].email,
                        fName: state.getGroupRead.userList?[i].fName,
                        lName: state.getGroupRead?.userList?[i].lName
                      ));

                }
                CommunicationTaskGroup? chat;
                chat=CommunicationTaskGroup(
                  createdBy: getTaskRead?.createdPersonCode,
                  friendList: userList,
                  taskCode: getTaskRead?.taskCode,
                  taskName: getTaskRead?.taskName
                );
                context.read<EmployeeBloc>().add(
                    CreateTaskGroupCommunicationEvent(chat));

                setState(() {

                });
              }

            },
          ),
          BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              print("Communication Chat$state");


              if (state is TaskGroupCreationSuccess) {
                communicationGroupId=state.message;
                print("chat group id........$communicationGroupId");
                setState(() {

                });


                setState(() {});
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              print("Status Of$state");

              if (state is GetStatusListSuccess) {
                statusList.clear();
                // statusList = state.statusList;
                for (var i in state.statusList) {
                  print("name eeeeee i hereeee   ${i.name}");

                  statusList.add(i);
                }
                // setState(() {});

                if (authentication.isAssociateAdmin == false) {
                  for (var i = 0; i < statusList.length; i++) {
                    // print("name eeeeee i   ${i.name}")
                    if (statusList[i].name == "VERIFIED") {
                      statusList.removeAt(i);
                    }
                  }
                }
                setState(() {});
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              print("Status Of$state");

              if (state is CreateReportSuccess) {
                showSnackBar(context,
                    message: "Task Successfully Reported", color: Colors.black);
                context
                    .read<TaskBloc>()
                    .add(GetTaskReadListEvent(getTaskRead?.id ?? 0));
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              print("subtaskkk stateee $state");
              if (state is GetSubTaskListLoading) {
                print("task loading");
              }

              if (state is GetSubTaskListFailed) {}
              if (state is GetSubTaskListSuccess) {
                print("subtaskkk sucsess${state.taskList}");

                taskListNew = state.taskList;
                setState(() {});
                // context.read<TaskBloc>().add(const GetTaskTypeListEvent());
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is DeleteTaskLoading) {
                // showSnackBar(context,
                //     message: "Loading...",
                //     color: Colors.white,
                //     // icon: HomeSvg().SnackbarIcon,
                //     autoDismiss: true);
              }

              if (state is DeleteTaskFailed) {
                showSnackBar(
                  context,
                  message: "Job Not Deleted",
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is DeleteTaskSuccess) {
                // createJob = state.user;

                Fluttertoast.showToast(
                    msg: 'Successfully Deleted',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                context.read<TaskBloc>().add(GetTaskListEvent(
                    int.tryParse(getTaskRead?.jobId.toString() ?? ""),
                    '',
                    '',
                    '',false,'',''));
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is PinCreationLoading) {
                // showSnackBar(context,
                //     message: "Loading...",
                //     color: Colors.white,
                //     // icon: HomeSvg().SnackbarIcon,
                //     autoDismiss: true);
              }

              if (state is PinCreationFailed) {
                showSnackBar(
                  context,
                  message: "Job Not Deleted",
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is PinCreationSuccess) {
                // createJob = state.user;

                getTaskRead?.isPinned == true
                    ? Fluttertoast.showToast(
                        msg: 'Job Unpinned Successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white)
                    : Fluttertoast.showToast(
                        msg: 'Job Pinned Successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white);
                context
                    .read<TaskBloc>()
                    .add(GetTaskReadListEvent(getTaskRead?.id ?? 0));
                // Navigator.pop(context);
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is NotificationDueLoading) {
                // showSnackBar(context,
                //     message: "Loading...",
                //     color: Colors.white,
                //     // icon: HomeSvg().SnackbarIcon,
                //     autoDismiss: true);
              }

              if (state is NotificationDueSuccess) {
                showSnackBar(
                  context,
                  message: "Enabled",
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
                context
                    .read<TaskBloc>()
                    .add(GetTaskReadListEvent(getTaskRead?.id ?? 0));
              }
              if (state is NotificationDueFailed) {}
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is ReplayReportLoading) {
                // showSnackBar(context,
                //     message: "Loading...",
                //     color: Colors.white,
                //     // icon: HomeSvg().SnackbarIcon,
                //     autoDismiss: true);
              }

              if (state is ReplayReportSuccess) {
                showSnackBar(
                  context,
                  message: state.taskId,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
                Navigator.pop(context);
                context
                    .read<TaskBloc>()
                    .add(GetTaskListEvent(getTaskRead?.jobId, '', '', '',false,'',''));
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: BackAppBar(
              isAction: false,
              isBack: false,
              onTap: () {
                print("BACK");
                if (widget.isReporter == true) {
                  context
                      .read<TaskBloc>()
                      .add(GetTaskListEvent(getTaskRead?.jobId, '', '', '',false,'',''));
                  context
                      .read<JobBloc>()
                      .add(GetJobReadListEvent(getTaskRead?.jobId ?? 0));
                  context.read<JobBloc>().add(GetReorterListEvent('', '', ''));
                } else if (widget.isReporter == false) {
                  context
                      .read<TaskBloc>()
                      .add(GetTaskListEvent(getTaskRead?.jobId, '', '', '',false,'',''));
                  context
                      .read<JobBloc>()
                      .add(GetJobReadListEvent(getTaskRead?.jobId ?? 0));
                  context.read<JobBloc>().add(GetNewJobListEvent('', '', ''));
                } else {}
                Navigator.pop(context);
              },
              label: " ${getTaskRead?.taskName ?? ""}",
              action: PopupMenuButton(
                icon: SvgPicture.string(TaskSvg().moreIcon),
                color: Colors.white,
                elevation: 2,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      padding: const EdgeInsets.all(0),
                      height: 10,
                      value: 'a',
                      enabled: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.isMyJob
                              ? GestureDetector(
                                  onTap: () {
                                    context.read<TaskBloc>().add(
                                        GetTaskReadListEvent(
                                            getTaskRead?.id ?? 0));
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: CreateNewTask(editTask: true),
                                      withNavBar: true,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        // SvgPicture.string(TaskSvg().editorIcon),
                                        // const SizedBox(
                                        //   width: 10,
                                        // ),
                                        Text(
                                          'Edit this Task',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black54,
                                              fontSize: w / 26,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    context.read<JobBloc>().add(
                                        PinAJobPostEvent(
                                            userCode: authentication
                                                    .authenticatedUser.code ??
                                                "",
                                            taskId: getTaskRead?.id ?? 0,
                                            isPinned:
                                                getTaskRead?.isPinned == true
                                                    ? false
                                                    : true));
                                    context.read<TaskBloc>().add(
                                        GetTaskReadListEvent(
                                            getTaskRead?.id ?? 0));
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          getTaskRead?.isPinned == true
                                              ? 'Unpin this Task'
                                              : 'Pin this Task',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black54,
                                              fontSize: w / 26,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          // const Divider(
                          //   indent: 30,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   child: Row(
                          //     children: [
                          //       SvgPicture.string(TaskSvg().msgSendIcon),
                          //       const SizedBox(
                          //         width: 10,
                          //       ),
                          //       Text(
                          //         'Share by message',
                          //         style: GoogleFonts.poppins(
                          //             color: Colors.black54,
                          //             fontSize: 13,
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const Divider(
                          //   indent: 30,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   child: Row(
                          //     children: [
                          //       SvgPicture.string(TaskSvg().shareJobIcon),
                          //       const SizedBox(
                          //         width: 10,
                          //       ),
                          //       Text(
                          //         'Share this Job',
                          //         style: GoogleFonts.poppins(
                          //             color: Colors.black54,
                          //             fontSize: 13,
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          widget.isMyJob
                              ? Divider(
                                  indent: 30,
                                )
                              : Container(),
                          widget.isMyJob
                              ? GestureDetector(
                                  onTap: () {
                                    context.read<EmployeeBloc>().add(
                                        GetActivityLogListingEvent(
                                            getTaskRead?.jobId));
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: ActivityLog(),
                                      withNavBar:
                                          false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        // SvgPicture.string(
                                        //     TaskSvg().activityIcon),
                                        // const SizedBox(
                                        //   width: 10,
                                        // ),
                                        Text(
                                          'View Activity Logs',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black54,
                                              fontSize: w / 26,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ))
                ],
                onSelected: (value) {},
              ),
            ),
          ),
          body: ScrollConfiguration(
              behavior: NoGlow(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_isLoading) ...[
                      LottieLoader()
                    ] else ...[
                      Column(
                        children: [
                          Container(
                            height: getTaskRead?.isReported == true &&
                                    authentication.isAdmin == true
                                ? h / 1.3
                                : null,
                            margin: const EdgeInsets.all(16),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Job Details",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xff151522),
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TaskTitleCard(
                                      paddingg: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      widget: TextCard(
                                        isTask: true,
                                        title: getTaskRead?.jobTitle,
                                        subText: getTaskRead?.jobDiscription,
                                      )),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Task Details",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xff151522),
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TaskTitleCard(
                                      paddingg: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      widget: TextCard(
                                        isTask: true,
                                        title: getTaskRead?.taskName,
                                        subText: getTaskRead?.description,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: w1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: const Color(0xffe6ecf0),
                                        width: 1,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                      color: Color(0xfff8f7f5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: Row(
                                      // mainAxisAlignment:
                                      // MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 28,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: ColorPalette.blue,
                                          ),
                                          child: SvgPicture.string(
                                              CreateSvg().prioriyIcon),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Text(
                                            "Priority : ",
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff151522),
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        // Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child:
                                              Text(getTaskRead?.priority ?? ""),
                                        ),
                                      ],
                                    ),
                                  ),
                                  authentication.isAdmin ||
                                          authentication.isAssociateAdmin
                                      ? SizedBox(
                                          height: 5,
                                        )
                                      : Container(),

                                  authentication.isAdmin ||
                                          authentication.isAssociateAdmin
                                      ? Container(
                                          width: w1,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color: const Color(0xffe6ecf0),
                                              width: 1,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x05000000),
                                                blurRadius: 8,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                            color: Color(0xfff8f7f5),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: Row(
                                            // mainAxisAlignment:
                                            // MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 28,
                                                width: 28,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: ColorPalette.green,
                                                ),
                                                child: SvgPicture.string(
                                                    CreateSvg().priorityIcon),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Text(
                                                  "Status : ",
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        const Color(0xff151522),
                                                    fontSize: w / 24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              // Spacer(),
                                              getTaskRead?.statusName=="VERIFIED"?Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: [
                                                    Text("COMPLETED"),
                                                    SizedBox(width: 3,),
                                                    SvgPicture.string(
                                                      TaskSvg().tickIcon,
                                                      color: Colors.green,
                                                      width: 15,
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              ): Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                    getTaskRead?.statusName ??
                                                        "NOT INITIATED"),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  widget.isMyJob
                                      ? Column(
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            getTaskRead?.assigningType ==
                                                    "Individual"
                                                ? Container(
                                                    width: w1,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xffe6ecf0),
                                                        width: 1,
                                                      ),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x05000000),
                                                          blurRadius: 8,
                                                          offset: Offset(1, 1),
                                                        ),
                                                      ],
                                                      color: Color(0xfff8f7f5),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 28,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: const Color(
                                                                      0xff33c658),
                                                                ),
                                                                child: SvgPicture
                                                                    .string(CreateSvg()
                                                                        .assignIcon),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Assign To : ",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: const Color(
                                                                      0xff151522),
                                                                  fontSize:
                                                                      w / 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              // SizedBox(
                                                              //   width: w / 4,
                                                              // ),
                                                              Container(
                                                                  width:
                                                                      w / 2.25,
                                                                  child: Text(
                                                                    getTaskRead
                                                                            ?.assignToName ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts
                                                                        .roboto(),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            getTaskRead?.assigningType ==
                                                    "Task_Group"
                                                ? TaskTitleCard(
                                                    paddingg: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                    widget: SingleRow(
                                                      label: "Subtasks",
                                                      color: const Color(
                                                          0xffFFC800),
                                                      svg: CreateSvg().taskIcon,
                                                      endIcon: isSubTask
                                                          ? SvgPicture.string(
                                                              HomeSvg()
                                                                  .toggleActive)
                                                          : SvgPicture.string(
                                                              HomeSvg()
                                                                  .toggleInActive),
                                                      onTap: () {
                                                        setState(() {
                                                          // isSubTask = !isSubTask;
                                                        });
                                                      },
                                                    ),
                                                  )
                                                : Container(),
                                            getTaskRead?.assigningType ==
                                                    "Task_Group"
                                                ? Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      TaskTitleCard(
                                                        widget: Column(
                                                          children: [
                                                            ListView.separated(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                          TaskBloc>()
                                                                      .add(GetTaskReadListEvent(
                                                                          taskListNew[index].id ??
                                                                              0));
                                                                  PersistentNavBarNavigator
                                                                      .pushNewScreen(
                                                                    context,
                                                                    screen:
                                                                        TaskTitle(
                                                                      isMyJob:
                                                                          true,
                                                                    ),
                                                                    withNavBar:
                                                                        false, // OPTIONAL VALUE. True by default.
                                                                    pageTransitionAnimation:
                                                                        PageTransitionAnimation
                                                                            .fade,
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                16,
                                                                            right:
                                                                                16,
                                                                            top:
                                                                                5,
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              "${index + 1}: ${taskListNew[index].taskName.toString().toTitleCase()}",
                                                                              style: GoogleFonts.roboto(
                                                                                color: ColorPalette.primary,
                                                                                fontSize: w / 22,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                            // CircleAvatar(
                                                                            //   radius: 16,
                                                                            //   backgroundImage:
                                                                            //       AssetImage(
                                                                            //     "asset/newprofile.png",
                                                                            //   ),
                                                                            // ),
                                                                            // Image.asset(
                                                                            //
                                                                            //   height: 27,
                                                                            //   width: 27,
                                                                            // )
                                                                          ],
                                                                        )),
                                                              ),
                                                              primary: true,
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  taskListNew
                                                                      .length,
                                                              separatorBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      Divider(
                                                                color: const Color(
                                                                        0xffE6ECF0)
                                                                    .withOpacity(
                                                                        0.5),
                                                                thickness: 1,
                                                                indent: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TaskTitleCard(
                                    widget: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: SingleRow(
                                            color: Color(0xff1ec9bf),
                                            label: "Date & Time",
                                            svg: CreateSvg().msgIcon,
                                            onTap: () {
                                              setState(() {
                                                isDate = !isDate;
                                              });
                                            },
                                            endIcon: Container(),
                                          ),
                                        ),
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
                                                  bottom: 16,
                                                  top: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Text(
                                                          "Start Date :",
                                                          style: TextStyle(
                                                            color: ColorPalette
                                                                .black,
                                                            fontSize: w / 24,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        startstdDate,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: ColorPalette
                                                              .black,
                                                          fontSize: w / 24,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Text(
                                                        startTime,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: ColorPalette
                                                              .black,
                                                          fontSize: w / 24,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Due Date  :",
                                                        style: TextStyle(
                                                          color: ColorPalette
                                                              .black,
                                                          fontSize: w / 24,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        endstdDate,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: ColorPalette
                                                              .black,
                                                          fontSize: w / 24,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Text(
                                                        endTime,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: ColorPalette
                                                              .black,
                                                          fontSize: w / 24,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  authentication.isAdmin == true
                                      ? Container()
                                      : getTaskRead?.latitude != null &&
                                              getTaskRead?.latitude != "" &&
                                              getTaskRead?.longitude != null &&
                                              getTaskRead?.latitude != ""
                                          ? GestureDetector(
                                              onTap: () {
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen: AddressPickFromMap(
                                                    taskRead: getTaskRead,
                                                    isUser: true,
                                                  ),
                                                  withNavBar: true,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .fade,
                                                );
                                              },
                                              child: TaskTitleCard(
                                                paddingg: EdgeInsets.zero,
                                                widget: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: isLocation
                                                          ? const EdgeInsets
                                                                  .only(
                                                              left: 16,
                                                              right: 16,
                                                              bottom: 10,
                                                              top: 10)
                                                          : EdgeInsets.all(16),
                                                      child: SingleRow(
                                                        color:
                                                            Color(0xff3B9FFC),
                                                        label: widget.isMyJob
                                                            ? "Shared Location"
                                                            : "Location",
                                                        svg: CreateSvg()
                                                            .locationIcon,
                                                        onTap: () {
                                                          widget.isMyJob
                                                              ? setState(() {
                                                                  // isLocation = !isLocation;
                                                                })
                                                              : print("");
                                                        },
                                                        endIcon: Icon(
                                                          Icons
                                                              .arrow_forward_ios_sharp,
                                                          size: 18,
                                                          color: ColorPalette
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  TaskTitleCard(
                                    widget: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          child: SingleRow(
                                            label: "Reporting Person",
                                            color: const Color(0xffAD51E0),
                                            svg: TaskSvg().personIcon,
                                            endIcon: Container(),
                                            onTap: () {
                                              widget.isMyJob
                                                  ? setState(() {
                                                      // isReporting = !isReporting;
                                                    })
                                                  : print("");
                                            },
                                          ),
                                        ),
                                        isReporting || widget.isMyJob == false
                                            ? Column(
                                                children: [
                                                  const Divider(
                                                    indent: 10,
                                                    height: 2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 16,
                                                              bottom: 10,
                                                              top: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextAvatar(
                                                            shape:
                                                                Shape.Circular,
                                                            size: 40,
                                                            numberLetters: 2,
                                                            fontSize: w / 22,
                                                            textColor:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            text:
                                                                "${getTaskRead?.reportingPerson.toString().toUpperCase()}",
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: w / 1.5,
                                                            child: Text(
                                                              getTaskRead
                                                                      ?.reportingPerson
                                                                      .toString() ??
                                                                  "",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color:
                                                                    ColorPalette
                                                                        .black,
                                                                fontSize:
                                                                    w / 24,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                  getTaskRead?.notes == ""
                                      ? Container()
                                      : SizedBox(
                                          height: 15,
                                        ),
                                  getTaskRead?.notes == ""
                                      ? Container()
                                      : TaskTitleCard(
                                          paddingg: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          widget: TextCard(
                                              title: "Note",
                                              subText: getTaskRead?.notes)),
                                  getTaskRead?.remarks == ""
                                      ? Container()
                                      : SizedBox(
                                          height: 5,
                                        ),
                                  getTaskRead?.remarks == ""
                                      ? Container()
                                      : TaskTitleCard(
                                          paddingg: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          widget: TextCard(
                                              title: "Remarks",
                                              subText: getTaskRead?.remarks)),
                                  getTaskRead?.remarks == ""
                                      ? Container()
                                      : SizedBox(
                                          height: 5,
                                        ),
                                  authentication.isAdmin == false &&
                                          getTaskRead?.rewardsData?.name != null
                                      ? SizedBox(
                                          height: 5,
                                        )
                                      : Container(),
                                  authentication.isAdmin == false &&
                                          getTaskRead?.rewardsData?.name != null
                                      ? TaskTitleCard(
                                          paddingg: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          widget: Column(
                                            children: [
                                              TextCard(
                                                  title: "Rewards",
                                                  subText: getTaskRead
                                                      ?.rewardsData?.name),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: RewardsCard(
                                                    readData: getTaskRead),
                                              ),
                                            ],
                                          ))
                                      : Container(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  authentication.isAdmin == false &&
                                          getTaskRead?.paymentMeta
                                                  ?.descriptionreward !=
                                              null
                                      ? TaskTitleCard(
                                          paddingg: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          widget: Column(
                                            children: [
                                              TextCard(
                                                  title: "Payments",
                                                  subText: getTaskRead
                                                      ?.paymentMeta?.notes),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: PaymentCard(
                                                    readData: getTaskRead),
                                              ),
                                            ],
                                          ))
                                      : Container(),
                                  SizedBox(height: 5),
                                  authentication.isAdmin == false &&
                                          getTaskRead?.metaData?.description !=
                                              null
                                      ? TaskTitleCard(
                                          paddingg: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          widget: Column(
                                            children: [
                                              TextCard(
                                                  title: "Attachment",
                                                  subText: getTaskRead
                                                      ?.metaData?.note),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: AttachmentCard(
                                                    readData: getTaskRead),
                                              ),
                                            ],
                                          ))
                                      : Container(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  widget.isMyJob
                                      ? Column(
                                          children: [
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     context.read<TaskBloc>().add(
                                            //         GetTaskReadListEvent(
                                            //             getTaskRead?.id ?? 0));
                                            //     PersistentNavBarNavigator.pushNewScreen(
                                            //       context,
                                            //       screen: CreateNewTask(editTask: true),
                                            //       withNavBar: true,
                                            //       // OPTIONAL VALUE. True by default.
                                            //       pageTransitionAnimation:
                                            //           PageTransitionAnimation.fade,
                                            //     );
                                            //   },
                                            //   child: Container(
                                            //     width: w,
                                            //     padding: EdgeInsets.all(16),
                                            //     decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(10),
                                            //       border: Border.all(
                                            //         color: Color(0xffe6ecf0),
                                            //         width: 1,
                                            //       ),
                                            //       boxShadow: [
                                            //         BoxShadow(
                                            //           color: Color(0x05000000),
                                            //           blurRadius: 8,
                                            //           offset: Offset(1, 1),
                                            //         ),
                                            //       ],
                                            //       color: Colors.white,
                                            //     ),
                                            //     child: SingleRow(
                                            //       label: "Edit this Task",
                                            //       color: Color(0xff0094FF),
                                            //       svg: TaskSvg().editIcon,
                                            //       endIcon:
                                            //           Icon(Icons.arrow_forward_ios_sharp),
                                            //       onTap: () {},
                                            //     ),
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   height: 10,
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isLocation = !isLocation;
                                                  location();
                                                });
                                                // location();
                                              },
                                              child: Container(
                                                width: w1,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SingleRow(
                                                        color:
                                                            Color(0xff3B9FFC),
                                                        label: "Share Location",
                                                        svg: CreateSvg()
                                                            .locationIcon,
                                                        onTap: () {
                                                          setState(() {
                                                            // if(isLocation==false){
                                                            isLocation =
                                                                !isLocation;
                                                            location();
                                                            setState(() {});
                                                            // }
                                                            // else{
                                                            //
                                                            // }

                                                            // PersistentNavBarNavigator.pushNewScreen(
                                                            //   context,
                                                            //   screen: AddressPickFromMap(taskRead: readTask),
                                                            //   withNavBar: true,
                                                            //   pageTransitionAnimation: PageTransitionAnimation.fade,
                                                            // );
                                                          });
                                                        },
                                                        endIcon: isLocation
                                                            ? SvgPicture.string(
                                                                HomeSvg()
                                                                    .toggleActive,
                                                                height: 22)
                                                            : SvgPicture.string(
                                                                HomeSvg()
                                                                    .toggleInActive,
                                                                height: 22),
                                                      ),
                                                      isLocation
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Divider(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    PersistentNavBarNavigator
                                                                        .pushNewScreen(
                                                                      context,
                                                                      screen:
                                                                          AddressPickFromMap(
                                                                        taskRead:
                                                                            getTaskRead,
                                                                      ),
                                                                      withNavBar:
                                                                          true,
                                                                      pageTransitionAnimation:
                                                                          PageTransitionAnimation
                                                                              .fade,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        w / 1.5,
                                                                    child: Text(
                                                                      "https://www.google.com/maps/search/?api=1&query=${getTaskRead?.latitude},${getTaskRead?.longitude}",
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.roboto(
                                                                          color: ColorPalette
                                                                              .primary,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              w / 24),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen: AttachmentScreen(
                                                      readData: getTaskRead),
                                                  withNavBar:
                                                      true, // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .fade,
                                                );
                                              },
                                              child: Container(
                                                width: w1,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                                                child: SingleRow(
                                                  color: Color(0xffFFC800),
                                                  label: "Add Attachments",
                                                  svg: TaskSvg().attachmentIcon,
                                                  onTap: () {},
                                                  endIcon: getTaskRead?.metaData
                                                              ?.description !=
                                                          null
                                                      ? SvgPicture.string(
                                                          TaskSvg().tickIcon,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .arrow_forward_ios_sharp,
                                                          size: 18,
                                                          color: ColorPalette
                                                              .primary,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                getTaskRead?.paymentId != null
                                                    ? context.read<TaskBloc>().add(
                                                        GetPaymentReadListEvent(
                                                            getTaskRead?.id ??
                                                                0,
                                                            true))
                                                    : null;
                                                Variable.taskReadId =
                                                    getTaskRead?.id ?? 0;
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen: PaymentOption(
                                                    currencyCode:
                                                        getTaskRead?.currency,
                                                    isJob: false,
                                                    isTask: true,
                                                    update: getTaskRead
                                                                ?.paymentId ==
                                                            null
                                                        ? false
                                                        : getTaskRead
                                                                    ?.paymentId ==
                                                                null
                                                            ? false
                                                            : true,
                                                    paymentId: getTaskRead
                                                            ?.paymentId ??
                                                        0,
                                                    taskId:
                                                        getTaskRead?.id ?? 0,
                                                    jobId: null,
                                                  ),
                                                  withNavBar:
                                                      true, // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .fade,
                                                );
                                              },
                                              child: Container(
                                                width: w1,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                                                  color: Color(0xff519BE0),
                                                  svg: TaskSvg().walletIcon,
                                                  label: "Payment Option",
                                                  onTap: () {},
                                                  endIcon: getTaskRead
                                                              ?.paymentId !=
                                                          null
                                                      ? SvgPicture.string(
                                                          TaskSvg().tickIcon,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .arrow_forward_ios_sharp,
                                                          size: 18,
                                                          color: ColorPalette
                                                              .primary,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                getTaskRead?.rewardid != null
                                                    ? context
                                                        .read<TaskBloc>()
                                                        .add(
                                                            GetReadRewardsEvent(
                                                                getTaskRead
                                                                        ?.id ??
                                                                    0,
                                                                true))
                                                    : null;
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen: RewardsScreen(
                                                    type: "Task",
                                                    typeId:
                                                        getTaskRead?.id ?? 0,
                                                    update: getTaskRead
                                                                ?.rewardid ==
                                                            null
                                                        ? false
                                                        : getTaskRead
                                                                    ?.rewardid ==
                                                                null
                                                            ? false
                                                            : true,
                                                  ),
                                                  withNavBar: true,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .fade,
                                                );
                                              },
                                              child: Container(
                                                width: w1,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                                                  label: "Rewards",
                                                  color: Color(0xffE051B8),
                                                  svg: TaskSvg().rewardIcon,
                                                  onTap: () {},
                                                  endIcon: getTaskRead
                                                              ?.rewardid !=
                                                          null
                                                      ? SvgPicture.string(
                                                          TaskSvg().tickIcon,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .arrow_forward_ios_sharp,
                                                          size: 18,
                                                          color: ColorPalette
                                                              .primary,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            if(getTaskRead?.statusStagesId == 5&&authentication.isAdmin==false&&authentication.isAssociateAdmin==false){

                                            }
                                            else{
                                              _showModalBottomSheet();
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            child: SingleRow(
                                                color: const Color(0xff33c658),
                                                label: "Status",
                                                svg: CreateSvg().priorityIcon,
                                                onTap: () {},
                                                endIcon: Row(
                                                  children: [
                                                    Container(
                                                        // color:Colors.red,
                                                        // width: w / 4,
                                                        child: getTaskRead
                                                                    ?.statusStagesId ==
                                                                1
                                                            ? const Text(
                                                                "STARTED",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: ColorPalette
                                                                        .primary),
                                                              )
                                                            : getTaskRead?.statusStagesId ==
                                                                    2
                                                                ? const Text(
                                                                    "ON PROGRESS",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: ColorPalette
                                                                            .primary))
                                                                : getTaskRead?.statusStagesId ==
                                                                        3
                                                                    ? const Text(
                                                                        "COMPLETED",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            color: ColorPalette
                                                                                .primary))
                                                                    : getTaskRead?.statusStagesId ==
                                                                            4
                                                                        ? const Text(
                                                                            "PENDING",
                                                                            style: TextStyle(fontWeight: FontWeight.w500, color: ColorPalette.primary))
                                                                        : getTaskRead?.statusStagesId == 5
                                                                            ? Row(
                                                                                children: [
                                                                                  Text("COMPLETED", style: TextStyle(fontWeight: FontWeight.w600, color: ColorPalette.primary)),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  SvgPicture.string(
                                                                                    TaskSvg().tickIcon,
                                                                                    color: Colors.green,
                                                                                    width: 15,
                                                                                    height: 15,
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : Text(
                                                                                "NOT INITIATED",
                                                                                style: TextStyle(fontWeight: FontWeight.w600, color: ColorPalette.primary),
                                                                              )),
                                                  ],
                                                )),
                                          ),
                                        ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,

                                        screen: ChatScreen(
                                          token: token,
                                          loginUserId: loginuserId,
                                          socket: socketCon,
                                          chatid: communicationGroupId,
                                          isGroup: true,
                                          // communicationUserModel: widget.communicationUserModel,
                                        ),
                                        withNavBar: false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.fade,
                                      );
                                      // PersistentNavBarNavigator.pushNewScreen(
                                      //   context,
                                      //   screen: CommentsScreen(
                                      //     taskId: getTaskRead?.id,
                                      //   ),
                                      //   withNavBar: true,
                                      //   pageTransitionAnimation:
                                      //       PageTransitionAnimation.fade,
                                      // );
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
                                        label: "Add Comments",
                                        color: Color(0xff0094FF),
                                        svg: TaskSvg().commentIcon,
                                        endIcon: Row(
                                          children: [
                                            // Text(
                                            //   "New",
                                            //   style: GoogleFonts.roboto(
                                            //     color: Color(0xfffe5762),
                                            //     fontSize: 18,
                                            //     fontWeight: FontWeight.w500,
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   width: 10,
                                            // ),
                                            Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              size: 18,
                                              color: ColorPalette.primary,
                                            ),
                                          ],
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                  getTaskRead?.assigningType == "Individual" &&
                                          authentication.isAdmin
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print("FFFFFF$getTaskRead");
                                                context.read<TaskBloc>().add(
                                                    GetPerformanceListEvent(
                                                        getTaskRead?.id ?? 0,
                                                        getTaskRead
                                                                ?.assigningCode ??
                                                            ""));
                                                context.read<TaskBloc>().add(
                                                    GetPerformanceReadEvent(
                                                        getTaskRead?.id ?? 0));
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen: PerformanceAppraisal(
                                                    tasklist: getTaskRead,
                                                  ),
                                                  withNavBar: false,
                                                  // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .fade,
                                                );
                                              },
                                              child: Container(
                                                width: w1,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
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
                                                  label:
                                                      "Performance Appraisal",
                                                  color: Color(0xffE05151),
                                                  svg:
                                                      TaskSvg().performanceIcon,
                                                  endIcon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_sharp,
                                                    size: 18,
                                                    color: ColorPalette.primary,
                                                  ),
                                                  onTap: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
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
                                      label: "Notify me on due date",
                                      color: Color(0xffffc800),
                                      svg: TaskSvg().notificationIcon,
                                      endIcon: isNotify
                                          ? SvgPicture.string(
                                              HomeSvg().toggleActive,
                                              height: 22,
                                            )
                                          : SvgPicture.string(
                                              HomeSvg().toggleInActive,
                                              height: 22,
                                            ),
                                      onTap: () {
                                        setState(() {
                                          if (isNotify == false) {
                                            isNotify = !isNotify;
                                            context.read<TaskBloc>().add(
                                                NotificationDueEvent(
                                                    getTaskRead?.id ?? 0));
                                          } else {}
                                        });
                                      },
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // authentication.isAdmin
                                  //     ? GestureDetector(
                                  //         onTap: () {
                                  //           context.read<TaskBloc>().add(
                                  //               GetPaymentReadListEvent(
                                  //                   getTaskRead?.id ?? 0, true));
                                  //           PersistentNavBarNavigator.pushNewScreen(
                                  //             context,
                                  //             screen: PaymentOption(
                                  //               update: getTaskRead?.paymentId == null
                                  //                   ? false
                                  //                   : true,
                                  //               isJob: false,
                                  //               isTask: true,
                                  //               paymentId: getTaskRead?.paymentId ?? 0,
                                  //               taskId: getTaskRead?.id ?? 0,
                                  //             ),
                                  //             withNavBar:
                                  //                 true, // OPTIONAL VALUE. True by default.
                                  //             pageTransitionAnimation:
                                  //                 PageTransitionAnimation.fade,
                                  //           );
                                  //         },
                                  //         child: Container(
                                  //           width: w,
                                  //           height: 60,
                                  //           decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(10),
                                  //             border: Border.all(
                                  //               color: Color(0xffe6ecf0),
                                  //               width: 1,
                                  //             ),
                                  //             boxShadow: [
                                  //               BoxShadow(
                                  //                 color: Color(0x05000000),
                                  //                 blurRadius: 8,
                                  //                 offset: Offset(1, 1),
                                  //               ),
                                  //             ],
                                  //             color: Colors.white,
                                  //           ),
                                  //           alignment: Alignment.center,
                                  //           child: Text(
                                  //             "Payment Option",
                                  //             style: GoogleFonts.roboto(
                                  //               color: Colors.black,
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.w500,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     : Container(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.isMyJob
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        "Are you Sure ?",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color:
                                                              Color(0xff151522),
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        "Did you wants delete this task",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff6d6d6d),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                width: w / 3.3,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xffed4e4e),
                                                                    width: 1,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  "Cancel",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xffed4e4e),
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                )),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                BlocProvider.of<
                                                                            TaskBloc>(
                                                                        context)
                                                                    .add(DeleteTaskEvent(
                                                                        getTaskRead?.id ??
                                                                            0));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                  width:
                                                                      w / 3.1,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: Color(
                                                                        0xffed4e4e),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Delete",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ])
                                                    ],
                                                  ),
                                                );
                                              })
                                          : getTaskRead?.isReported == true &&
                                                  authentication.isAdmin ==
                                                      false
                                              ? Fluttertoast.showToast(
                                                  msg: "Task Already Reported",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      ColorPalette.black,
                                                  textColor: Colors.white)
                                              : _showModalBottomAdditionalRole();
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
                                      alignment: Alignment.center,
                                      child: widget.isMyJob
                                          ? Text(
                                              widget.isMyJob
                                                  ? "Delete this Task"
                                                  : "Report this Task",
                                              style: GoogleFonts.roboto(
                                                color: Color(0xfffe5762),
                                                fontSize: w / 24,
                                                // fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.isMyJob
                                                      ? "Delete this Task"
                                                      : "Report this Task",
                                                  style: GoogleFonts.roboto(
                                                    color: Color(0xfffe5762),
                                                    fontSize: w / 24,
                                                    // fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    _showModalBottomInfoData();
                                                  },
                                                  child: SvgPicture.string(
                                                    TaskSvg().infoIcon,
                                                    color: ColorPalette.primary,
                                                  ),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h / 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                          getTaskRead?.isReported == true &&
                                  authentication.isAdmin == true
                              ? Container(
                                  width: w,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: w / 2.3,
                                        child: GradientButton(
                                            color: ColorPalette.green,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            "Accept the Report",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color: Color(
                                                                  0xff151522),
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          Text(
                                                            "Accept the report submitted by \n Shifas",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff6d6d6d),
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          Container(
                                                            height: h / 8,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xffD3D3D3),
                                                                    width: 0.2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    "Add Notes...",
                                                                hintStyle: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        w / 26,
                                                                    color: Color(
                                                                        0xffD3D3D3)),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                              ),
                                                              onChanged:
                                                                  (ss) {},
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              cursorColor:
                                                                  ColorPalette
                                                                      .primary,
                                                              obscureText:
                                                                  false,
                                                              style: TextStyle(
                                                                  color:
                                                                      ColorPalette
                                                                          .black,
                                                                  fontSize: 17),
                                                              // keyboardType: widget.numField==true||widget.floatVal==true?TextInputType.numberWithOptions(decimal: false):TextInputType.emailAddress,
                                                              // inputFormatters: [
                                                              //   widget.numField==true?FilteringTextInputFormatter.digitsOnly:
                                                              //   widget.floatVal==true?FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')):
                                                              //   FilteringTextInputFormatter.singleLineFormatter,
                                                              //
                                                              // ],
                                                              controller:
                                                                  replayApproveNotes,
                                                              maxLines: 5,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <Widget>[
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        w / 3.3,
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        border: Border.all(
                                                                          color:
                                                                              Color(0xffC6C6C6).withOpacity(0.2),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        color: Color(0xffC6C6C6).withOpacity(0.2)),
                                                                    child: const Center(
                                                                        child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .close,
                                                                            color:
                                                                                Colors.white),
                                                                        Text(
                                                                          "Cancel",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    context.read<TaskBloc>().add(ReplayReportEvent(
                                                                        reportStatus:
                                                                            "Report_approved",
                                                                        replay: replayApproveNotes
                                                                            .text,
                                                                        id: getTaskRead
                                                                            ?.reportId));
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      width: w / 3.1,
                                                                      padding: EdgeInsets.symmetric(vertical: 10),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: ColorPalette
                                                                            .green,
                                                                      ),
                                                                      child: Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.task_alt_rounded,
                                                                              color: Colors.white,
                                                                            ),
                                                                            Text(
                                                                              "OK",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ),
                                                              ])
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  ColorPalette.green,
                                                  ColorPalette.green
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.task_alt_rounded,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "Approve",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontSize: w / 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Container(
                                        width: w / 2.3,
                                        child: GradientButton(
                                            color: ColorPalette.primary,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            "Reject the Report",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color: Color(
                                                                  0xff151522),
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          Text(
                                                            "Reject the report submitted by \n Shifas",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff6d6d6d),
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          Container(
                                                            height: h / 8,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xffD3D3D3),
                                                                    width: 0.2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    "Add Notes...",
                                                                hintStyle: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        w / 26,
                                                                    color: Color(
                                                                        0xffD3D3D3)),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                              ),
                                                              onChanged:
                                                                  (ss) {},
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              cursorColor:
                                                                  ColorPalette
                                                                      .primary,
                                                              obscureText:
                                                                  false,
                                                              style: TextStyle(
                                                                  color:
                                                                      ColorPalette
                                                                          .black,
                                                                  fontSize: 17),
                                                              // keyboardType: widget.numField==true||widget.floatVal==true?TextInputType.numberWithOptions(decimal: false):TextInputType.emailAddress,
                                                              // inputFormatters: [
                                                              //   widget.numField==true?FilteringTextInputFormatter.digitsOnly:
                                                              //   widget.floatVal==true?FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')):
                                                              //   FilteringTextInputFormatter.singleLineFormatter,
                                                              //
                                                              // ],
                                                              controller:
                                                                  replayRejectNotes,
                                                              maxLines: 5,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <Widget>[
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        w / 3.3,
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(5),
                                                                        border: Border.all(
                                                                          color:
                                                                              Color(0xffC6C6C6).withOpacity(0.2),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        color: Color(0xffC6C6C6).withOpacity(0.2)),
                                                                    child: const Center(
                                                                        child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .close,
                                                                            color:
                                                                                Colors.white),
                                                                        Text(
                                                                          "Cancel",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    context.read<TaskBloc>().add(ReplayReportEvent(
                                                                        reportStatus:
                                                                            "Report_rejected",
                                                                        replay: replayRejectNotes
                                                                            .text,
                                                                        id: getTaskRead
                                                                            ?.reportId));
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      width: w / 3.1,
                                                                      padding: EdgeInsets.symmetric(vertical: 10),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: ColorPalette
                                                                            .primary,
                                                                      ),
                                                                      child: Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.task_alt_rounded,
                                                                              color: Colors.white,
                                                                            ),
                                                                            Text(
                                                                              "Reject",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ),
                                                              ])
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  ColorPalette.primary,
                                                  ColorPalette.primary
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.close,
                                                    color: Colors.white),
                                                Text(
                                                  "Reject",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontSize: w / 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      )
                    ]
                  ],
                ),
              )),
        ),
      ),
    );
  }

  _showModalBottomSheetstatus() {
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
                // height: 350,
                // padding: EdgeInsets.all(16),
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
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Change Status To:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      padding: const EdgeInsets.only(),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: statusList!.length,
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                          onTap: () async {
                            refresh();
                            changeTappedTile(i);
                            BlocProvider.of<TaskBloc>(context).add(
                                UpdateTaskEvent(
                                    longitude: getTaskRead?.longitude ?? "",
                                    latitude: getTaskRead?.latitude ?? "",
                                    taskType: getTaskRead?.taskType ?? 0,
                                    discription: getTaskRead?.description ?? "",
                                    createdBy:
                                        getTaskRead?.createdPersonCode ?? "",
                                    isActive: true,
                                    priority: getTaskRead?.priority ?? "",
                                    reportingPerson:
                                        getTaskRead?.reportingPersonCode ?? "",
                                    endDate:
                                        "${getTaskRead?.endDate?.split("T")[0]}"
                                                " "
                                                "${getTaskRead?.endDate?.split("T")[1].split("+")[0]}" ??
                                            "",
                                    startDate:
                                        "${getTaskRead?.startDate?.split("T")[0]}"
                                                " "
                                                "${getTaskRead?.startDate?.split("T")[1].split("+")[0]}" ??
                                            "",
                                    AssigningCode:
                                        getTaskRead?.assigningCode ?? "",
                                    notas: getTaskRead?.notes ?? "",
                                    taskName: getTaskRead?.taskName ?? "",
                                    remarks: getTaskRead?.remarks ?? "",
                                    priorityLeval:
                                        getTaskRead?.priorityLevel.toString() ??
                                            "",
                                    createdOn:
                                        "${getTaskRead?.createdOn?.split("T")[0]}"
                                                " "
                                                "${getTaskRead?.createdOn?.split("T")[1].split(".")[0]}" ??
                                            "",
                                    AssigningType:
                                        getTaskRead?.assigningType ?? "",
                                    statusStagesId: statusList?[i].id,
                                    parant: getTaskRead?.parent,
                                    lastmodified: getTaskRead?.lastModified,
                                    jobid: getTaskRead?.jobId ?? 0,
                                    id: getTaskRead?.id ?? 0,
                                    img5: getTaskRead?.metaData?.image5,
                                    img1: getTaskRead?.metaData?.image1,
                                    img4: getTaskRead?.metaData?.image4,
                                    img2: getTaskRead?.metaData?.image2,
                                    img3: getTaskRead?.metaData?.image3,
                                    attachmentDescription:
                                        getTaskRead?.metaData?.description,
                                    attachmentNote:
                                        getTaskRead?.metaData?.note));
                            context.read<TaskBloc>().add(
                                GetTaskReadListEvent(getTaskRead?.id ?? 0));
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
                                        TaskSvg().checkActiveIcon)
                                    : SvgPicture.string(
                                        TaskSvg().checkInActiveIcon),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  statusList?[i].name ?? "",
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
              );
            },
          );
        });
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 2.6,
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
                          "Change Status To:",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: h / 3.5,
                          // color: Colors.yellow,
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
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListView.separated(
                                            padding: const EdgeInsets.only(),
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: statusList!.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  refresh();
                                                  changeTappedTile(i);
                                                  BlocProvider.of<TaskBloc>(context)
                                                      .add(UpdateTaskEvent(
                                                          longitude: getTaskRead
                                                                  ?.longitude ??
                                                              "",
                                                          latitude: getTaskRead
                                                                  ?.latitude ??
                                                              "",
                                                          taskType: getTaskRead
                                                                  ?.taskType ??
                                                              0,
                                                          discription: getTaskRead
                                                                  ?.description ??
                                                              "",
                                                          createdBy: getTaskRead
                                                                  ?.createdPersonCode ??
                                                              "",
                                                          isActive: true,
                                                          priority: getTaskRead
                                                                  ?.priority ??
                                                              "",
                                                          reportingPerson:
                                                              getTaskRead?.reportingPersonCode ??
                                                                  "",
                                                          endDate:
                                                              "${getTaskRead?.endDate?.split("T")[0]}"
                                                                      " "
                                                                      "${getTaskRead?.endDate?.split("T")[1].split("+")[0]}" ??
                                                                  "",
                                                          startDate:
                                                              "${getTaskRead?.startDate?.split("T")[0]}"
                                                                      " "
                                                                      "${getTaskRead?.startDate?.split("T")[1].split("+")[0]}" ??
                                                                  "",
                                                          AssigningCode: getTaskRead
                                                                  ?.assigningCode ??
                                                              "",
                                                          notas: getTaskRead?.notes ??
                                                              "",
                                                          taskName: getTaskRead
                                                                  ?.taskName ??
                                                              "",
                                                          remarks: getTaskRead
                                                                  ?.remarks ??
                                                              "",
                                                          priorityLeval: getTaskRead?.priorityLevel.toString() ?? "",
                                                          createdOn: "${getTaskRead?.createdOn?.split("T")[0]}"
                                                                  " "
                                                                  "${getTaskRead?.createdOn?.split("T")[1].split(".")[0]}" ??
                                                              "",
                                                          AssigningType: getTaskRead?.assigningType ?? "",
                                                          statusStagesId: statusList?[i].id,
                                                          parant: getTaskRead?.parent,
                                                          lastmodified: getTaskRead?.lastModified,
                                                          jobid: getTaskRead?.jobId ?? 0,
                                                          id: getTaskRead?.id ?? 0,
                                                          img5: getTaskRead?.metaData?.image5,
                                                          img1: getTaskRead?.metaData?.image1,
                                                          img4: getTaskRead?.metaData?.image4,
                                                          img2: getTaskRead?.metaData?.image2,
                                                          img3: getTaskRead?.metaData?.image3,
                                                          attachmentDescription: getTaskRead?.metaData?.description,
                                                          attachmentNote: getTaskRead?.metaData?.note));
                                                  context.read<TaskBloc>().add(
                                                      GetTaskReadListEvent(
                                                          getTaskRead?.id ??
                                                              0));
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  color: tappedTile == i
                                                      ? ColorPalette
                                                          .cardBackground
                                                      : ColorPalette.white,
                                                  child: Row(
                                                    children: [
                                                      // tappedTile == i
                                                      //     ? SvgPicture.string(
                                                      //         TaskSvg().checkActiveIcon)
                                                      //     : SvgPicture.string(
                                                      //         TaskSvg().checkInActiveIcon),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        statusList?[i].name ??
                                                            "",
                                                        style:
                                                            GoogleFonts.roboto(
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
                                                (BuildContext context,
                                                    int index) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    left: 16, right: 16),
                                                color: Color(0xffE6ECF0),
                                                height: 1,
                                                width: w,
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         left: 15, right: 15, bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           context.read<TaskBloc>().add(CreateReportEvent(
                    //               toipicId: topicId,
                    //               taskId: getTaskRead?.id,
                    //               notes: reportNotes.text,
                    //               userId:
                    //                   authentication.authenticatedUser.code));
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Report this Task",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomAdditionalRole() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
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
                          "Report Task",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Container(
                          height: h / 2.2,
                          // color: Colors.yellow,
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
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Why Are You Reporting This Task?",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: w / 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            width: w,
                                            // height: h / 2.5,
                                            // decoration: BoxDecoration(
                                            //   // borderRadius:
                                            //   //     BorderRadius.circular(10),
                                            //   // border: Border.all(
                                            //   //   color: Color(0xffe6ecf0),
                                            //   //   width: 1,
                                            //   // ),
                                            //   boxShadow: const [
                                            //     BoxShadow(
                                            //       color: Color(0x05000000),
                                            //       blurRadius: 8,
                                            //       offset: Offset(1, 1),
                                            //     ),
                                            //   ],
                                            //   color: Colors.white,
                                            // ),
                                            child: BlocBuilder<TaskBloc,
                                                TaskState>(
                                              builder: (context, state) {
                                                if (state
                                                    is GetTopicListLoading) {
                                                  return LottieLoader();
                                                }
                                                if (state
                                                    is GetTopicListSuccess) {
                                                  return ListView.separated(
                                                      primary: true,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Row(
                                                                children: [
                                                                  CustomRadioButton(
                                                                    onTap: () {
                                                                      onSelect(
                                                                          index);
                                                                      topicId =
                                                                          state.taskList[index].id ??
                                                                              0;
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    isActive:
                                                                        selected ==
                                                                            index,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                      width: w /
                                                                          1.5,
                                                                      child:
                                                                          Text(
                                                                        state.taskList[index].name ??
                                                                            "",
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize: w /
                                                                                24,
                                                                            fontWeight: selected == index
                                                                                ? FontWeight.w600
                                                                                : FontWeight.w400),
                                                                      )),
                                                                ],
                                                              ),
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              Divider(),
                                                      itemCount: 8);
                                                }
                                                return Container();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: h / 8,
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0xffD3D3D3), width: 0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                            readOnly: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Add Notes...",
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: w / 26, color: Color(0xffD3D3D3)),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (ss) {},
                            scrollPadding: EdgeInsets.all(10),
                            cursorColor: ColorPalette.primary,
                            obscureText: false,
                            style: TextStyle(
                                color: ColorPalette.black, fontSize: 17),
                            // keyboardType: widget.numField==true||widget.floatVal==true?TextInputType.numberWithOptions(decimal: false):TextInputType.emailAddress,
                            // inputFormatters: [
                            //   widget.numField==true?FilteringTextInputFormatter.digitsOnly:
                            //   widget.floatVal==true?FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')):
                            //   FilteringTextInputFormatter.singleLineFormatter,
                            //
                            // ],
                            controller: reportNotes,
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              context.read<TaskBloc>().add(CreateReportEvent(
                                  toipicId: topicId,
                                  taskId: getTaskRead?.id,
                                  notes: reportNotes.text,
                                  userId:
                                      authentication.authenticatedUser.code));
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "Report this Task",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomInfoData() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 2.1,
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
                          "Report Info",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Container(
                          height: h / 3,
                          // color: Colors.yellow,
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
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "If your admin has mistakenly assigned a task to you, please report the task. Once approved, the task will be removed from your assignment list. You can use the comment option for further clarification if needed from the admin.",
                                            style: GoogleFonts.roboto(
                                                color: Color(0xff6D6D6D),
                                                fontSize: w / 24,
                                                height: 1.4,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.justify,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Please note that this is a one-time request to rectify the inadvertent assignment, and if the admin rejects the report request, the 'Report' button will automatically disable. So that text to request any concerns using text field in report option.",
                                            style: GoogleFonts.roboto(
                                                color: Color(0xff6D6D6D),
                                                fontSize: w / 24,
                                                height: 1.4,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         left: 15, right: 15, bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           context.read<TaskBloc>().add(CreateReportEvent(
                    //               toipicId: topicId,
                    //               taskId: getTaskRead?.id,
                    //               notes: reportNotes.text,
                    //               userId:
                    //               authentication.authenticatedUser.code));
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Report this Task",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          );
        });
  }
}
