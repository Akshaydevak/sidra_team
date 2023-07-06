import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/order_app/activity_log.dart';
import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/create_performance.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_appraisal.dart';
import 'package:cluster/presentation/task_operation/select_assignees.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/task_title_card.dart';
import 'package:cluster/presentation/task_operation/task_title/text_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/loading.dart';
import '../../core/color_palatte.dart';
import '../../core/common_snackBar.dart';
import '../../core/utils/variables.dart';
import 'create/create_newtask.dart';
import 'create/create_svg.dart';
import 'create/model/task_models.dart';
import 'create/single_row.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_bloc/employee_bloc.dart';
import 'home/bloc/job_bloc.dart';
import 'home/comments_screen.dart';
import 'home/model/joblist_model.dart';

class TaskTitle extends StatefulWidget {
  bool isMyJob;

  TaskTitle({Key? key, this.isMyJob = false}) : super(key: key);

  @override
  State<TaskTitle> createState() => _TaskTitleState();
}

class _TaskTitleState extends State<TaskTitle> {
  bool isSubTask = true;
  bool isDate = true;
  bool isLocation = false;
  bool isReporting = true;
  bool isNotify = false;
  String PriorityLeval="";
  GetTaskList? getTaskRead;
  @override
  void initState() {
    context.read<JobBloc>().add(GetStatusListEvent());
    super.initState();
  }
  void refresh(){
    setState(() {

    });
  }
  int tappedTile = 0;
  List<StatusListing>? statusList;
  List<GetTaskList> taskListNew=[];
  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }
  var endstdDate="";
  var startstdDate="";
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        print("popScope");
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
        return true;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if(state is GetTaskReadLoading){

              }
              if(state is GetTaskReadSuccess){
                getTaskRead=state.getTaskRead;
                Variable.taskIdForSubtask=getTaskRead?.id??0;
                var date = getTaskRead?.endDate;
                var date2 = getTaskRead?.startDate;
                var dateTime =  DateTime.parse("$date");
                var dateTime2 =  DateTime.parse("$date2");
                endstdDate =  DateFormat('dd-MM-yyyy').format(dateTime).toString();
                startstdDate =  DateFormat('dd-MM-yyyy').format(dateTime2).toString();
                context.read<TaskBloc>().add(const GetSubTaskListEvent());
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
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              print("subtaskkk stateee $state");
              if (state is GetSubTaskListLoading) {
                print("task loading");
              }

              if (state is GetSubTaskListFailed) {

              }
              if (state is GetSubTaskListSuccess) {

                print("subtaskkk sucsess${state.taskList}");

                taskListNew=state.taskList;
                setState(() {

                });
                // context.read<TaskBloc>().add(const GetTaskTypeListEvent());

              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is DeleteTaskLoading) {
                showSnackBar(context,
                    message: "Loading...",
                    color: Colors.white,
                    // icon: HomeSvg().SnackbarIcon,
                    autoDismiss: true);
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
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                Navigator.pop(context);
              }
            },

          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is PinCreationLoading) {
                showSnackBar(context,
                    message: "Loading...",
                    color: Colors.white,
                    // icon: HomeSvg().SnackbarIcon,
                    autoDismiss: true);
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

                Fluttertoast.showToast(
                    msg: 'Job Pinned Successfully',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                // Navigator.pop(context);
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
              label:" ${getTaskRead?.taskName}",action:PopupMenuButton(
              icon: SvgPicture.string(TaskSvg().moreIcon),
              //don't specify icon if you want 3 dot menu
              color: Colors.white,
              elevation: 2,
              padding: EdgeInsets.zero,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                    padding: const EdgeInsets.all(0),
                    value: 'a',
                    enabled: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.isMyJob?GestureDetector(
                          onTap: (){
                            context.read<TaskBloc>().add(
                                GetTaskReadListEvent(getTaskRead?.id??0));
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: CreateNewTask(editTask: true),
                              withNavBar: true,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation
                                  .fade,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SvgPicture.string(TaskSvg().editorIcon),
                                const SizedBox(width: 10,),
                                Text(
                                  'Edit this Task',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ):
                        GestureDetector(
                          onTap: (){
                            context.read<JobBloc>().add(
                                PinAJobPostEvent(
                                    userCode: authentication.authenticatedUser.code??"",
                                    taskId: getTaskRead?.id??0,
                                    isPinned: getTaskRead?.isPinned==true?false:true));
                            context.read<TaskBloc>().add(
                                GetTaskReadListEvent(getTaskRead?.id??0));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SvgPicture.string(TaskSvg().editorIcon),
                                const SizedBox(width: 10,),
                                Text(
                                  'Pin this Task',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(indent: 30,),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              SvgPicture.string(TaskSvg().msgSendIcon),
                              const SizedBox(width: 10,),
                              Text(
                                'Share by message',
                                style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const Divider(indent: 30,),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              SvgPicture.string(TaskSvg().shareJobIcon),
                              const SizedBox(width: 10,),
                              Text(
                                'Share this Job',
                                style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ), const Divider(indent: 30,),
                        GestureDetector(
                          onTap: (){
                            context.read<EmployeeBloc>().add(
                                GetActivityLogListingEvent(getTaskRead?.id));
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: ActivityLog(),
                              withNavBar: false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );

                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                SvgPicture.string(TaskSvg().activityIcon),
                                const SizedBox(width: 10,),
                                Text(
                                  'View Activity Logs',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))

              ],
              onSelected: (value) {

              },
            ) ,),
          ),
          // child: AppBar(
          //   systemOverlayStyle: const SystemUiOverlayStyle(
          //     systemNavigationBarColor: Colors.white, // Navigation bar
          //     statusBarColor: Colors.white, // Status bar
          //   ),
          //
          //   elevation: 0,
          //
          // ),

          body: ScrollConfiguration(
              behavior: NoGlow(),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskTitleCard(
                          paddingg: const EdgeInsets.symmetric(vertical: 16),
                          widget: TextCard(
                            isTask: true,
                            title: getTaskRead?.jobTitle,
                            subText:getTaskRead?.jobDiscription,
                          )),
                      const SizedBox(height: 10,),
                      TaskTitleCard(
                          paddingg: const EdgeInsets.symmetric(vertical: 16),
                          widget: TextCard(
                            isTask: true,
                            title: getTaskRead?.taskName,
                            subText:getTaskRead?.description,
                          )),
                      widget.isMyJob
                          ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          getTaskRead?.assigningType=="Individual"?Container(
                            width: w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 28,
                                        height: 28,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: const Color(0xff33c658),
                                        ),
                                        child: SvgPicture.string(
                                            CreateSvg().assignIcon),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Assign To",
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xff151522),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: w/4,),
                                      Text(getTaskRead?.assignToName??""),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ):Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          getTaskRead?.assigningType=="Task_Group"?TaskTitleCard(
                            paddingg: const EdgeInsets.all(16),
                            widget: SingleRow(
                              label: "Subtasks",
                              color: const Color(0xffFFC800),
                              svg: CreateSvg().taskIcon,
                              endIcon: isSubTask
                                  ? SvgPicture.string(
                                  HomeSvg().toggleActive)
                                  : SvgPicture.string(
                                  HomeSvg().toggleInActive),
                              onTap: () {
                                setState(() {
                                  // isSubTask = !isSubTask;
                                });
                              },
                            ),
                          ):Container(),
                          getTaskRead?.assigningType=="Task_Group"?
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              TaskTitleCard(
                                widget: Column(
                                  children: [
                                    ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: (){
                                              context.read<TaskBloc>().add(
                                                  GetTaskReadListEvent(taskListNew[index].id?? 0));
                                              PersistentNavBarNavigator.pushNewScreen(
                                                context,
                                                screen: TaskTitle(isMyJob: true,),
                                                withNavBar: true, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation: PageTransitionAnimation.fade,
                                              );
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${index+1}${taskListNew[index].taskName}",
                                                      style: GoogleFonts
                                                          .roboto(
                                                        color: const Color(
                                                            0xfffe5762),
                                                        fontSize: w/22,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                    CircleAvatar(radius: 16,
                                                      backgroundImage: AssetImage("asset/newprofile.png",),),
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
                                      itemCount: taskListNew.length,
                                      separatorBuilder: (context, index) => Divider(
                                        color: const Color(0xffE6ECF0)
                                            .withOpacity(0.5),
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
                      const SizedBox(
                        height: 10,
                      ),
                      TaskTitleCard(
                        widget: Column(
                          children: [
                            Container(
                              margin: isDate
                                  ? const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 5,
                                  top: 16)
                                  : EdgeInsets.all(16),
                              child: SingleRow(
                                color: Color(0xff1ec9bf),
                                label: "Date",
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
                                  indent: 50,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      bottom: 16,
                                      top: 5),
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
                                                color:
                                                ColorPalette.black,
                                                fontSize: w/22,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            startstdDate,
                                            style: GoogleFonts.roboto(
                                              color: ColorPalette.primary,
                                              fontSize: w/22,
                                              fontWeight:
                                              FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            getTaskRead?.startDate.toString().split("T")[1].split("+")[0]??"",
                                            style: GoogleFonts.roboto(
                                              color: ColorPalette.primary,
                                              fontSize: w/22,
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
                                              color: ColorPalette.black,
                                              fontSize: w/22,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            endstdDate,
                                            style: GoogleFonts.roboto(
                                              color: ColorPalette.primary,
                                              fontSize: w/22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            getTaskRead?.endDate.toString().split("T")[1].split("+")[0]??"",
                                            style: GoogleFonts.roboto(
                                              color: ColorPalette.primary,
                                              fontSize: w/22,
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

                      getTaskRead?.locayionUrl==""?Container():TaskTitleCard(
                        paddingg: EdgeInsets.zero,
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: isLocation
                                  ? const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 5,
                                  top: 15)
                                  : EdgeInsets.all(16),
                              child: SingleRow(
                                  color: Color(0xff3B9FFC),
                                  label: widget.isMyJob
                                      ? "Share Location"
                                      : "Location",
                                  svg: CreateSvg().locationIcon,
                                  onTap: () {
                                    widget.isMyJob
                                        ? setState(() {
                                      // isLocation = !isLocation;
                                    })
                                        : print("");
                                  },
                                  endIcon: Container()),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Divider(
                                  indent: 30,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 20,
                                        top: 10),
                                    child:  Text(
                                      getTaskRead?.locayionUrl??"",
                                      style: TextStyle(
                                        color: ColorPalette.primary,
                                        fontSize: w/22,
                                      ),
                                    ))
                              ],
                            )

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TaskTitleCard(
                        widget: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: isReporting ? 5 : 16,
                                  top: isReporting ? 16 : 16),
                              child: SingleRow(
                                label: "Reporting Person",
                                color: const Color(0xffAD51E0),
                                svg: TaskSvg().personIcon,
                                endIcon: widget.isMyJob
                                    ? isReporting
                                    ? SvgPicture.string(
                                    HomeSvg().toggleActive)
                                    : SvgPicture.string(
                                    HomeSvg().toggleInActive)
                                    : Container(),
                                onTap: () {
                                  widget.isMyJob
                                      ? setState(() {
                                    isReporting = !isReporting;

                                  })
                                      : print("");
                                },
                              ),
                            ),
                            isReporting || widget.isMyJob == false
                                ? Column(
                              children: [
                                const Divider(
                                  indent: 50,
                                ),
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 16,
                                        top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(backgroundColor: ColorPalette.inactiveGrey,),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          getTaskRead?.reportingPerson.toString()??"",
                                          style:  TextStyle(
                                            color: ColorPalette.black,
                                            fontSize: w/22,
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
                      const SizedBox(
                        height: 10,
                      ),
                      getTaskRead?.notes==""?Container():TaskTitleCard(
                          paddingg: const EdgeInsets.symmetric(vertical: 16),
                          widget: TextCard(
                              title: "Note",
                              subText:getTaskRead?.notes
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      getTaskRead?.remarks==""?Container():TaskTitleCard(
                          paddingg: const EdgeInsets.symmetric(vertical: 16),
                          widget: TextCard(
                              title: "Remarks",
                              subText:getTaskRead?.remarks)),
                      SizedBox(
                        height: 10,
                      ),

                      // Text(
                      //   "Attachments",
                      //   style: GoogleFonts.roboto(
                      //     color: Color(0xff151522),
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // AttachmentCard(),
                      SizedBox(
                        height: 30,
                      ),
                      widget.isMyJob
                          ? Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              context.read<TaskBloc>().add(
                                  GetTaskReadListEvent(getTaskRead?.id??0));
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: CreateNewTask(editTask: true),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation
                                    .fade,
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
                                label: "Edit this Task",
                                color: Color(0xff0094FF),
                                svg: TaskSvg().editIcon,
                                endIcon:
                                Icon(Icons.arrow_forward_ios_sharp),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      )
                          : GestureDetector(
                        onTap: (){
                          _showModalBottomSheet();
                        },
                        child: Container(
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
                          padding: EdgeInsets.all(16),
                          child: SingleRow(
                              color: const Color(0xff33c658),
                              label: "Status",
                              svg: CreateSvg().priorityIcon,
                              onTap: () {
                              },
                              endIcon: Row(
                                children: [
                                  Container(
                                    // color:Colors.red,
                                      width: w/4,
                                      child: getTaskRead?.statusStagesId==1?Text("STARTED",style: TextStyle(fontWeight: FontWeight.w500,color: ColorPalette.primary),):
                                      getTaskRead?.statusStagesId==2?Text("ON PROGRESS",style: TextStyle(fontWeight: FontWeight.w500,color: ColorPalette.primary)):
                                      getTaskRead?.statusStagesId==3?Text("COMPLETED",style: TextStyle(fontWeight: FontWeight.w500,color: ColorPalette.primary)):
                                      getTaskRead?.statusStagesId==4?Text("PENDING",style: TextStyle(fontWeight: FontWeight.w500,color: ColorPalette.primary)):
                                      Text("")),
                                ],
                              )),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: CommentsScreen(taskId: getTaskRead?.id,),
                            withNavBar: true,
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
                            label: "Add Comments",
                            color: Color(0xff0094FF),
                            svg: TaskSvg().msgIcon,
                            endIcon: Row(
                              children: [
                                Text(
                                  "New",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xfffe5762),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.arrow_forward_ios_sharp),
                              ],
                            ),
                            onTap: () {

                            },
                          ),
                        ),
                      ),
                      widget.isMyJob
                          ? Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: (){
                              context.read<TaskBloc>().add(
                                  GetPerformanceListEvent(getTaskRead?.id??0,getTaskRead?.assigningCode??""));
                              context.read<TaskBloc>().add(
                                  GetPerformanceReadEvent(getTaskRead?.id??0));
                              getTaskRead?.assigningType=="Task_Group"?
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: CreatePerformance(taskList: getTaskRead,),
                                withNavBar: true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.fade,
                              ):PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen:
                                PerformanceAppraisal(tasklist: getTaskRead,),
                                withNavBar: true,
                                // OPTIONAL VALUE. True by default.
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
                                label: "Performance Appraisal",
                                color: Color(0xffE05151),
                                svg: TaskSvg().performanceIcon,
                                endIcon:
                                Icon(Icons.arrow_forward_ios_sharp),
                                onTap: () {

                                },
                              ),
                            ),
                          ),
                        ],
                      )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
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
                          label: "Notify me on due date",
                          color: Color(0xffffc800),
                          svg: TaskSvg().notificationIcon,
                          endIcon: isNotify
                              ? SvgPicture.string(HomeSvg().toggleActive,height: 22,)
                              : SvgPicture.string(HomeSvg().toggleInActive,height: 22,  ),
                          onTap: () {
                            setState(() {
                              isNotify = !isNotify;
                            });
                          },
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // GestureDetector(
                      //   onTap: (){
                      //     context.read<TaskBloc>().add(
                      //         GetPaymentReadListEvent(getTaskRead?.id??0));
                      //     PersistentNavBarNavigator.pushNewScreen(
                      //       context,
                      //       screen:  PaymentOption(update: true,isJob: false,isTask: true,),
                      //       withNavBar: true, // OPTIONAL VALUE. True by default.
                      //       pageTransitionAnimation: PageTransitionAnimation.fade,
                      //     );
                      //   },
                      //   child: Container(
                      //     width: w,
                      //     height: 60,
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
                      //     alignment: Alignment.center,
                      //     child: Text("Payment Option",
                      //       style: GoogleFonts.roboto(
                      //         color: Colors.black,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          widget.isMyJob ?
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "Are you Sure ?",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Color(0xff151522),
                                          fontSize: 22,

                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Text(
                                        "Did you wants this Task.This process cannot be undone",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff6d6d6d),
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                width: w / 3.3,
                                                padding:
                                                EdgeInsets.symmetric(vertical: 10),

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color: Color(0xffed4e4e), width: 1, ),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: Color(0xffed4e4e),
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<TaskBloc>(context)
                                                    .add(DeleteTaskEvent(getTaskRead?.id??0));
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  width: w / 3.1,
                                                  padding:
                                                  EdgeInsets.symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color(0xffed4e4e),
                                                  ),

                                                  child: Center(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ])
                                    ],
                                  ),
                                );
                              }):
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: CommentsScreen(taskId: getTaskRead?.id,),
                            withNavBar: true,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                            PageTransitionAnimation.fade,
                          );
                        },
                        child: Container(
                          width: w,
                          height: 60,
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
                          alignment: Alignment.center,
                          child: Text(
                            widget.isMyJob
                                ? "Delete this Task"
                                : "Report this Task",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffe5762),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )

          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {

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
                    const SizedBox(height: 24,),
                    Text(
                      "Change Status To:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListView.separated(
                      padding: const EdgeInsets.only(),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: statusList!.length,
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                          onTap: () async{
                            refresh();
                            final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            String? code = sharedPreferences.getString('code');
                            changeTappedTile(i);
                            BlocProvider.of<TaskBloc>(context).add(
                                UpdateTaskEvent(
                                    locationUrl: Variable.locationUrl,
                                    taskType: getTaskRead?.taskType??0,
                                    discription: getTaskRead?.description??"",
                                    createdBy: getTaskRead?.createdPersonCode??"",
                                    isActive: true,
                                    priority: getTaskRead?.priority??"",
                                    reportingPerson: getTaskRead?.reportingPersonCode??"",
                                    endDate: "${getTaskRead?.endDate?.split("T")[0]}"" ""${getTaskRead?.endDate?.split("T")[1].split("+")[0]}"??"",
                                    startDate: "${getTaskRead?.startDate?.split("T")[0]}"" ""${getTaskRead?.startDate?.split("T")[1].split("+")[0]}"??"",
                                    AssigningCode: getTaskRead?.assigningCode??"",
                                    notas: getTaskRead?.notes??"",
                                    taskName: getTaskRead?.taskName??"",
                                    remarks: getTaskRead?.remarks??"",
                                    priorityLeval: getTaskRead?.priorityLevel.toString()??"",
                                    createdOn: "${getTaskRead?.createdOn?.split("T")[0]}"" ""${getTaskRead?.createdOn?.split("T")[1].split(".")[0]}"??"",
                                    AssigningType: getTaskRead?.assigningType??"",
                                    statusStagesId: statusList?[i].id,
                                    parant: getTaskRead?.parent??null,
                                    lastmodified: getTaskRead?.lastModified??null,
                                    jobid: getTaskRead?.jobId??0,
                                    id: getTaskRead?.id??0


                                ));
                            context.read<TaskBloc>().add(
                                GetTaskReadListEvent(getTaskRead?.id??0));
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
                                    ? SvgPicture.string(TaskSvg().checkActiveIcon)
                                    : SvgPicture.string(TaskSvg().checkInActiveIcon),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  statusList?[i].name??"",
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
}
