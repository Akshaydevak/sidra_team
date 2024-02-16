import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/order_app/activity_log.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/rewards_screen.dart';
import 'package:cluster/presentation/task_operation/task_card.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../../core/common_snackBar.dart';
import '../../common_widgets/custom_checkbox.dart';
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'create/create_job.dart';
import 'create/create_newtask.dart';
import 'create/create_svg.dart';
import 'create/reporting_person_job.dart';
import 'create/single_row.dart';
import 'home/bloc/job_bloc.dart';
import 'home/model/joblist_model.dart';

class JobTitle extends StatefulWidget {
  bool isMyJob = false;
  bool isAllJob = false;
  bool isCreated = false;
  JobTitle({Key? key, this.isMyJob = false,this.isAllJob = false,this.isCreated=false}) : super(key: key);

  @override
  State<JobTitle> createState() => _JobTitleState();
}

class _JobTitleState extends State<JobTitle> {
  bool isReporting = true;
  bool isNotify = false;
  List<GetTaskList> taskList = [];
  GetJobList? JobRead;
  String nextUrl = "";
  String prevUrl = "";
  String endstdDate='';
  String startstdDate='';
  String startTime="";
  String startTime2="";
  String endTime="";
  String endTime2="";
  String priorityFilter="";
  String statusFilter="";
  String reportingPersonFilter="";
  int tappedTile = 0;
  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }
  onRefreash(){
    setState(() {

    });
  }
  @override
  void initState() {
    if(widget.isCreated==true){
      taskList=[];

    }
    // dialog();
    super.initState();
    widget.isCreated==true?WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
          useSafeArea: true,
          barrierDismissible: true,
          context: context,
          builder: (context) {
            player!.setAsset('asset/job.mp3').then((value) {
              return {
                player!.playerStateStream.listen((state) {
                  if (state.playing) {
                    setState(() {
                      print("audio,,,,");
                    });
                  }
                  else
                    switch (state.processingState) {
                      case ProcessingState.idle:
                        break;
                      case ProcessingState.loading:
                        break;
                      case ProcessingState.buffering:
                        break;
                      case ProcessingState.ready:
                        setState(() {
                        });
                        break;
                      case ProcessingState.completed:
                        setState(() {
                        });
                        break;
                    }
                }),
                player!.play(),
              };
            });
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        // height: MediaQuery.of(context).size.height / 2.5,
                        // padding: const EdgeInsets.all(8),

                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //       image: NetworkImage(
                        //         "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Ym9va3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
                        //       ),
                        //       fit: BoxFit.fill),
                        // ),
                        child: SvgPicture.string(TaskSvg().jobSucsess,width:MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 3,),
                      ),
                      Positioned(
                        right: 90,
                        bottom: 140,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Lottie.asset(
                              'asset/tick.json',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    }):null;
  }
  AudioPlayer? player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          if(widget.isAllJob==true){
            context.read<TaskBloc>().add(const GetAllJobsListEvent('', '', '',false,'','',''));
          }
          context.read<JobBloc>().add(const GetAssignedMeListEvent('', '', ''));
          taskList.clear();
      return true;},
      child: MultiBlocListener(
        listeners: [
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {


              if (state is DeleteJobFailed) {
                showSnackBar(
                  context,
                  message: "Job Not Deleted",
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is DeleteJobSuccess) {
                // createJob = state.user;

                Fluttertoast.showToast(
                    msg: 'Job Deleted Successfully ',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                Navigator.pop(context);
                context
                    .read<JobBloc>()
                    .add(const GetAssignedMeListEvent('', '', ''));
              }
            },
          ),
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is GetJobReadSuccess) {
                JobRead = state.getjobRead;
                var date = JobRead?.endDate;
                var date2 = JobRead?.startDate;
                var dateTime = DateTime.parse("$date");
                var dateTime2 = DateTime.parse("$date2");
                endstdDate =
                    DateFormat('dd-MM-yyyy').format(dateTime).toString();
                startstdDate =
                    DateFormat('dd-MM-yyyy').format(dateTime2).toString();

                startTime=JobRead?.startDate?.split("T")[1].split("+")[0]??"";
                endTime=JobRead?.endDate?.split("T")[1].split("+")[0]??"";
                final timeOfDay = TimeOfDay(hour: int.tryParse(startTime.split(":")[0])??0, minute: int.tryParse(startTime.split(":")[1])??0); // Example time of day (3:30 PM)
                final timeOfDayEnd = TimeOfDay(hour: int.tryParse(endTime.split(":")[0])??0, minute: int.tryParse(endTime.split(":")[1])??0); // Example time of day (3:30 PM)

                final twentyFourHourFormat = DateFormat('HH:mm:00');
                final twelveHourFormat = DateFormat('h:mm a');

                final dateTimet = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
                final dateTimett = DateTime(1, 1, 1, timeOfDayEnd.hour, timeOfDayEnd.minute);
                startTime = twelveHourFormat.format(dateTimet);
                startTime2 = twentyFourHourFormat.format(dateTimet);
                endTime=twelveHourFormat.format(dateTimett);
                endTime2=twentyFourHourFormat.format(dateTimett);

                print("Succsess read");
                setState(() {});
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: ColorPalette.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: BackAppBar(
                label: JobRead?.name ?? "",
                isAction: false,
                isBack: false,
                onTap: (){
                  if(widget.isAllJob==true){
                    context.read<TaskBloc>().add(const GetAllJobsListEvent('', '', '',false,'','',''));
                  }
                  context.read<JobBloc>().add(const GetAssignedMeListEvent('', '', ''));
                  taskList.clear();
                  Navigator.pop(context);
                },
                action: PopupMenuButton(
                  icon: SvgPicture.string(TaskSvg().moreIcon),
                  color: ColorPalette.white,
                  elevation: 2,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        padding: EdgeInsets.all(0),
                        value: 'a',
                        enabled: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                print("EdIT");
                                context.read<JobBloc>().add(
                                    GetJobReadListEvent(JobRead?.id??0));
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: const CreateJob(
                                    edit: true,
                                  ),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    // SvgPicture.string(TaskSvg().editorIcon),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Text(
                                      'Edit this Job',
                                      style: GoogleFonts.poppins(
                                          color: ColorPalette.black,
                                          fontSize: w/26,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              indent: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  context.read<EmployeeBloc>().add(
                                      GetActivityLogListingEvent(
                                          JobRead?.id));
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
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      // SvgPicture.string(TaskSvg().activityIcon),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text(
                                        'View Activity Logs',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: w/26,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ))
                  ],
                  onSelected: (value) {},
                ),
              )),
          body: ScrollConfiguration(
            behavior: NoGlow(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    color: ColorPalette.cardBackground,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        BlocBuilder<TaskBloc, TaskState>(
                          builder: (context, state) {
                            if (state is GetTaskListLoading) {
                              return  Container(
                                height: h / 3,
                                color: Colors.white.withOpacity(0.5),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'asset/loadingteams.json',
                                    ),
                                    Text(
                                      "Loading...",
                                      style: GoogleFonts.roboto(
                                        fontSize: w / 24,
                                      ),
                                    )
                                  ],
                                ),
                                // Image.asset('asset/Logo'),
                                //child: SvgPicture.string(IconConstants().SplashIcon),
                              );
                            }

                            if (state is GetTaskListSuccess) {
                              // taskList.clear();
                              taskList = state.taskList ?? [];

                              nextUrl = state.nextPageUrl ?? "";
                              prevUrl = state.prevPageUrl ?? "";

                              return taskList.isEmpty?
                              Stack(
                                children: [
                                  Container(
                                    height: h / 1.85,
                                    child: Column(
                                      children: [
                                        widget.isCreated==true?Container():
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Task List",
                                              style: GoogleFonts.roboto(
                                                color: ColorPalette.black,
                                                fontSize: w / 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                _showModalBottomAdditionalRole(priorityFilter,statusFilter,"");
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: ColorPalette.primary,
                                                    borderRadius: BorderRadius.circular(4)
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Filter",

                                                      style: GoogleFonts.roboto(
                                                        color: ColorPalette.white,
                                                        fontSize: w / 28,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    // SizedBox(width: 8,),
                                                    // SvgPicture.string(TaskSvg().filterSvg),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          alignment: Alignment.center,
                                          height: h / 4,
                                          child: SvgPicture.string(
                                            TaskSvg().nolistSvg,
                                            height: h / 4.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: h/3,
                                    left: w1/4.5,
                                    child:
                                  Container(
                                    alignment: Alignment.center,
                                    width: w1/2.2,
                                    height: 50,
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(15)
                                    // ),
                                    child: GradientButton(
                                        color: ColorPalette.primary,
                                        onPressed: () {
                                          PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: CreateNewTask(
                                              startDateTime: "${startstdDate}  ${startTime}",
                                              endDateTime: "$endstdDate  $endTime",
                                              isSubTask: false,
                                              jobId: JobRead?.id,
                                            ),
                                            withNavBar: true,
                                            // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation: PageTransitionAnimation.fade,
                                          );
                                        },
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [ColorPalette.primary, ColorPalette.primary]),
                                        child: Text(
                                          "Create new Task",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),)

                                ],
                              ):
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Task List",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.black,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          _showModalBottomAdditionalRole(priorityFilter,statusFilter,"");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                          decoration: BoxDecoration(
                                              color: ColorPalette.primary,
                                              borderRadius: BorderRadius.circular(4)
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Filter",
                                                style: GoogleFonts.roboto(
                                                  color: ColorPalette.white,
                                                  fontSize: w / 28,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              // SizedBox(width: 8,),
                                              // SvgPicture.string(TaskSvg().filterSvg),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: h/2.3,
                                    color: ColorPalette.cardBackground,
                                    child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        physics: AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            TaskCard(
                                              isMylist: widget.isMyJob,
                                              taskList: taskList[index],
                                            ),
                                        separatorBuilder: (context, index) => SizedBox(
                                          height: 5,
                                        ),
                                        itemCount:  taskList.length),
                                  ),
                                  // GridView.builder(
                                  //     shrinkWrap: true,
                                  //     // scrollDirection: Axis.horizontal,
                                  //     physics: NeverScrollableScrollPhysics(),
                                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  //             // childAspectRatio: 1.1,
                                  //             // crossAxisCount: 2,
                                  //             mainAxisSpacing: 10,
                                  //         crossAxisCount: w1 > 700 ? 3 : 2,
                                  //         childAspectRatio: w1 > 700 ? 1.5 : 1.1,
                                  //             crossAxisSpacing: 10),
                                  //     itemBuilder: (BuildContext context, int i) {
                                  //       return InkWell(
                                  //         onTap: () {},
                                  //         child: TaskCard(
                                  //           isMylist: widget.isMyJob,
                                  //           taskList: taskList[i],
                                  //         ),
                                  //       );
                                  //     },
                                  //     itemCount: taskList.length),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,bottom: 5
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        prevUrl != ""
                                            ? GestureDetector(
                                          onTap: () {
                                            context.read<TaskBloc>().add(
                                                GetTaskListEvent(
                                                    JobRead?.id,
                                                    '',
                                                    '',
                                                    prevUrl,false,'',''));
                                            // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                          },
                                          child: Text(
                                            "Previous",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 26),
                                          ),
                                        )
                                            : Container(),
                                        nextUrl != ""
                                            ? GestureDetector(
                                          onTap: () {
                                            // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                            setState(() {
                                              context.read<TaskBloc>().add(
                                                  GetTaskListEvent(
                                                      JobRead?.id,
                                                      '',
                                                      nextUrl,
                                                      "",false,'',''));
                                            });
                                          },
                                          child: Text(
                                            "Next",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 26),
                                          ),
                                        )
                                            : Text("")
                                      ],
                                    ),
                                  ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: CreateNewTask(
                                            startDateTime: "${startstdDate}  ${startTime}",
                                            endDateTime: "$endstdDate  $endTime",
                                            isSubTask: false,
                                            jobId: JobRead?.id,
                                          ),
                                          withNavBar: true,
                                          // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation: PageTransitionAnimation.fade,
                                        );
                                      },
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [ColorPalette.primary, ColorPalette.primary]),
                                      child: Text(
                                        "Create New Task",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                  SizedBox(height: 10,),
                                ],
                              );
                            }
                            return Stack(
                              children: [
                                Container(
                                  height: h / 1.85,
                                  child: Column(
                                    children: [
                                      widget.isCreated==true?Container():
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Task List",
                                            style: GoogleFonts.roboto(
                                              color: ColorPalette.black,
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              _showModalBottomAdditionalRole(priorityFilter,statusFilter,"");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: ColorPalette.primary,
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Filter",

                                                    style: GoogleFonts.roboto(
                                                      color: ColorPalette.white,
                                                      fontSize: w / 28,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  // SizedBox(width: 8,),
                                                  // SvgPicture.string(TaskSvg().filterSvg),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        alignment: Alignment.center,
                                        height: h / 4,
                                        child: SvgPicture.string(
                                          TaskSvg().nolistSvg,
                                          height: h / 4.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: h/3,
                                  left: w1/4.5,
                                  child:
                                  Container(
                                    alignment: Alignment.center,
                                    width: w1/2.2,
                                    height: 50,
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(15)
                                    // ),
                                    child: GradientButton(
                                        color: ColorPalette.primary,
                                        onPressed: () {
                                          PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: CreateNewTask(
                                              startDateTime: "${startstdDate}  ${startTime}",
                                              endDateTime: "$endstdDate  $endTime",
                                              isSubTask: false,
                                              jobId: JobRead?.id,
                                            ),
                                            withNavBar: true,
                                            // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation: PageTransitionAnimation.fade,
                                          );
                                        },
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [ColorPalette.primary, ColorPalette.primary]),
                                        child: Text(
                                          "Create new Task",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),)

                              ],
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                  Container(
                    // color: ColorPalette.cardBackground,
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   width: w1,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(4),
                        //     border: Border.all(
                        //       color: const Color(0x4ca9a8a8),
                        //       width: 1,
                        //     ),
                        //     color: const Color(0xfff8f7f5),
                        //   ),
                        //   padding:
                        //   const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                        //   child: Column(
                        //     children: [
                        //       Row(children: [
                        //         Container(
                        //           width: w/3.5,
                        //           child: const Text(
                        //             "Start On",
                        //             style: TextStyle(
                        //               color: Color(0xff6d6d6d),
                        //               fontSize: 15,
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //           width: 16,
                        //           child: const Text(":",
                        //             style: TextStyle(
                        //               color: Color(0xff6d6d6d),
                        //               fontSize: 15,
                        //             ),),
                        //         ),
                        //         Text(
                        //           "${startstdDate}  ${startTime}" ,
                        //           style: const TextStyle(
                        //             color: Colors.black,
                        //             fontSize: 15,
                        //             fontFamily: "Roboto",
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         )
                        //       ],),
                        //       const SizedBox(height: 5,),
                        //       Row(children: [
                        //         Container(
                        //           width: w/3.5,
                        //           child: const Text(
                        //             "Due On",
                        //             style: TextStyle(
                        //               color: Color(0xff6d6d6d),
                        //               fontSize: 15,
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //           width: 16,
                        //           child: const Text(":",
                        //             style: TextStyle(
                        //               color: Color(0xff6d6d6d),
                        //               fontSize: 15,
                        //             ),),
                        //         ),
                        //         Text(
                        //           "$endstdDate  $endTime",
                        //           style: GoogleFonts.roboto(
                        //             color: Colors.black,
                        //             fontSize: 15,
                        //
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         )
                        //       ],),
                        //
                        //
                        //
                        //
                        //     ],
                        //   ),
                        // ),


                        // GestureDetector(
                        //   onTap: () {
                        //     PersistentNavBarNavigator.pushNewScreen(
                        //       context,
                        //       screen: CreateNewTask(
                        //         isSubTask: false,
                        //       ),
                        //       withNavBar: true,
                        //       // OPTIONAL VALUE. True by default.
                        //       pageTransitionAnimation: PageTransitionAnimation.fade,
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
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Icon(
                        //               Icons.add,
                        //               color: Color(0xffe70c0c),
                        //             ),
                        //             SizedBox(
                        //               width: 10,
                        //             ),
                        //             Text(
                        //               "Create New Task",
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                 color: Color(0xffe70c0c),
                        //                 fontSize: w / 22,
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //         Icon(
                        //           Icons.arrow_forward_ios_sharp,
                        //           color: Colors.black,
                        //           size: 18,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 26,
                        ),
                        Container(
                          width: w1,
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
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  context.read<JobBloc>().add(GetJobReadListEvent(JobRead?.id??0));
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: ReportingPersonJob(),
                                    withNavBar: true,
                                    // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 10, top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4)
                                  ),
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
                              ),
                              Divider(
                                indent: 10,
                                height: 2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  context
                                      .read<JobBloc>()
                                      .add(GetJobReadListEvent(JobRead?.id??0));
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,

                                    screen: ReportingPersonJob(),

                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                },
                                child: Container(
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
                                          JobRead?.reportingMail ?? "",
                                          style: TextStyle(
                                            color: ColorPalette.primary,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        widget.isAllJob?Container(
                          width: w1,
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
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 10, top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: SingleRow(
                                  label: "Created Person",
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
                                        JobRead?.createdPerson ?? "",
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
                        ):Container(),
                        widget.isAllJob?SizedBox(height: 5,):Container(),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.vibrate();
                            JobRead?.paymentId != null
                                ? context.read<TaskBloc>().add(
                                    GetPaymentReadListEvent(
                                        JobRead?.id ?? 0, false))
                                : null;
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PaymentOption(
                                currencyCode: JobRead?.currency,
                                isJob: true,
                                isTask: false,
                                update: JobRead?.paymentId == null ? false : true,
                                jobId: JobRead?.id,
                                paymentId: JobRead?.paymentId ?? 0,
                                joblist: JobRead,
                              ),
                              withNavBar: true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );
                          },
                          child: Container(
                            width: w1,
                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
                              label: "Payment Option",
                              color: Color(0xff519BE0),
                              svg: TaskSvg().walletIcon,
                              endIcon: JobRead?.paymentId!=null?
                              SvgPicture.string(TaskSvg().tickIcon,color: Colors.green,):
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18,
                                color: ColorPalette.primary,
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.vibrate();
                            JobRead?.rewardId != null
                                ? context.read<TaskBloc>().add(
                                    GetReadRewardsEvent(JobRead?.id ?? 0, false))
                                : null;
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: RewardsScreen(
                                  type: "Job",
                                  typeId: JobRead?.id ?? 0,
                                  update: JobRead?.rewardId == null
                                      ? false
                                      : JobRead?.rewardId == null
                                          ? false
                                          : true),
                              withNavBar: true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation: PageTransitionAnimation.fade,
                            );
                          },
                          child: Container(
                            width: w1,
                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
                              label: "Rewards",
                              color: Color(0xffE051B8),
                              svg: TaskSvg().walletIcon,
                              endIcon: JobRead?.rewardId!=null?
                              SvgPicture.string(TaskSvg().tickIcon,color: Colors.green,):Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: ColorPalette.primary,
                                size: 18,
                              ),
                              onTap: () {
                                //  RewardsScreen
                              },
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // GestureDetector(
                        //   onTap: (){
                        //     PersistentNavBarNavigator.pushNewScreen(
                        //       context,
                        //       screen: PerformanceAppraisal(tasklist: ),
                        //       withNavBar: true, // OPTIONAL VALUE. True by default.
                        //       pageTransitionAnimation: PageTransitionAnimation.fade,
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
                        //       label: "Performance Appraisal",
                        //       color: Color(0xffE05151),
                        //       svg: TaskSvg().performanceIcon,
                        //       endIcon: Icon(Icons.arrow_forward_ios_sharp),
                        //       onTap: () {
                        //
                        //       },
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     print("EdIT");
                        //     context
                        //         .read<JobBloc>()
                        //         .add(GetJobReadListEvent(Variable.jobReadId));
                        //     PersistentNavBarNavigator.pushNewScreen(
                        //       context,
                        //       screen: const CreateJob(
                        //         edit: true,
                        //       ),
                        //       withNavBar: true, // OPTIONAL VALUE. True by default.
                        //       pageTransitionAnimation: PageTransitionAnimation.fade,
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
                        //       label: "Edit this Job",
                        //       color: Color(0xff0094FF),
                        //       svg: TaskSvg().editIcon,
                        //       endIcon: Icon(
                        //         Icons.arrow_forward_ios_sharp,
                        //         size: 18,
                        //       ),
                        //       onTap: () {},
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // // Container(
                        // //   width: w,
                        // //   padding: EdgeInsets.all(16),
                        // //   decoration: BoxDecoration(
                        // //     borderRadius: BorderRadius.circular(10),
                        // //     border: Border.all(
                        // //       color: Color(0xffe6ecf0),
                        // //       width: 1,
                        // //     ),
                        // //     boxShadow: [
                        // //       BoxShadow(
                        // //         color: Color(0x05000000),
                        // //         blurRadius: 8,
                        // //         offset: Offset(1, 1),
                        // //       ),
                        // //     ],
                        // //     color: Colors.white,
                        // //
                        // //   ),
                        // //   child: SingleRow(
                        // //     label: "Notify me on due date",
                        // //     color: Color(0xffFFC800),
                        // //     svg: TaskSvg().notificationIcon,
                        // //     endIcon: isNotify
                        // //         ? SvgPicture.string(HomeSvg().toggleActive,height: 22)
                        // //         : SvgPicture.string(HomeSvg().toggleInActive,height: 22),
                        // //     onTap: () {
                        // //       setState(() {
                        // //         isNotify = !isNotify;
                        // //       });
                        // //     },
                        // //   ),
                        // //
                        // // ),
                        // // SizedBox(height: 30,),
                        // GestureDetector(
                        //   onTap: () {
                        //     context.read<EmployeeBloc>().add(
                        //         GetActivityLogListingEvent(Variable.jobReadId));
                        //     PersistentNavBarNavigator.pushNewScreen(
                        //       context,
                        //       screen: ActivityLog(),
                        //       withNavBar: false, // OPTIONAL VALUE. True by default.
                        //       pageTransitionAnimation: PageTransitionAnimation.fade,
                        //     );
                        //   },
                        //   child: Container(
                        //       width: w,
                        //       height: 60,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         border: Border.all(
                        //           color: Color(0xffe6ecf0),
                        //           width: 1,
                        //         ),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Color(0x05000000),
                        //             blurRadius: 8,
                        //             offset: Offset(1, 1),
                        //           ),
                        //         ],
                        //         color: Colors.white,
                        //       ),
                        //       child: Center(
                        //         child: Text("View Activity Logs",
                        //             style: GoogleFonts.roboto(
                        //               color: Colors.black,
                        //               fontSize: w / 24,
                        //               fontWeight: FontWeight.w400,
                        //             )),
                        //       )),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
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
                                        Text(
                                          "Are you Sure ?",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff151522),
                                            fontSize: w/22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          "Did you wants to delete this job",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xff6d6d6d),
                                            fontSize: w/26,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
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
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: ColorPalette.primary,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: const Center(
                                                      child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: ColorPalette.primary,
                                                      fontSize: 18,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  BlocProvider.of<JobBloc>(context)
                                                      .add(DeleteJobEvent(
                                                      JobRead?.id??0));
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                    width: w / 3.1,
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(5),
                                                      color: ColorPalette.primary,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ])
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                              width: w1,
                              // height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
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
                              child: Center(
                                child: Text("Delete this Job",
                                    style: GoogleFonts.roboto(
                                      color: Color(0xffe70c0c),
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w400,
                                    )),
                              )),
                        ),
                        SizedBox(
                          height: 30,
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
    );
  }
  _showModalBottomAdditionalRole(String? type,String? statusType,String empCode) {
    String newStatus='';
    String newPriority='';
    String newReportibg='';
    List<String> status=['Not Initiated','Started','Completed','Pending'];
    List<String> priority=['Low','Medium','High'];
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          double w1 = MediaQuery.of(context).size.width ;
          double w = w1> 700
              ? 400
              : w1;
          var h=MediaQuery.of(context).size.height;
          newPriority=priorityFilter;
          newReportibg=reportingPersonFilter;
          newStatus=statusFilter;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.7,
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
                          "Task Filter",
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
                          height: h/2.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Task Status",
                                            style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Column(
                                            children: [

                                              Container(
                                                width:w1,
                                                child: GridView.builder(
                                                    shrinkWrap: true,
                                                    // scrollDirection: Axis.horizontal,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        childAspectRatio: w1>700?6:4,
                                                        crossAxisCount: w1>700?3:2,
                                                        mainAxisSpacing: 10,
                                                        crossAxisSpacing: 10),
                                                    itemBuilder: (BuildContext context, int i) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          changeTappedTile(i);


                                                          newStatus=status[i].toUpperCase();
                                                          statusFilter=status[i].toUpperCase();
                                                          onRefreash();
                                                          // Navigator.pop(context);
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 16, vertical: 10),
                                                          color: newStatus ==
                                                              status[i]
                                                              ? ColorPalette.cardBackground
                                                              : ColorPalette.white,
                                                          child: Row(
                                                            children: [
                                                              newStatus == status[i].toUpperCase()
                                                                  ? SvgPicture.string(
                                                                HomeSvg()
                                                                    .radioButtonActive,width: 24,height: 24
                                                              )
                                                                  : SvgPicture.string(
                                                                  CreateSvg()
                                                                      .radioInActiveButton),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                status[i] ??
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
                                                    itemCount: status.length),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(height: 5,),
                                          // Divider(height: 2,indent: 10,color: Colors.grey,),
                                          // SizedBox(height: 5,),
                                          // Text(
                                          //   "Reporting Person",
                                          //   style: GoogleFonts.roboto(
                                          //     color: Colors.black,
                                          //     fontSize: w / 24,
                                          //     fontWeight: FontWeight.w500,
                                          //   ),
                                          // ),
                                          // SizedBox(height: 10,),
                                          // Container(
                                          //   width: w1,
                                          //   // height: h / 2.5,
                                          //   decoration: BoxDecoration(
                                          //     borderRadius:
                                          //     BorderRadius.circular(10),
                                          //     // border: Border.all(
                                          //     //   color: Color(0xffe6ecf0),
                                          //     //   width: 1,
                                          //     // ),
                                          //     boxShadow: const [
                                          //       BoxShadow(
                                          //         color: Color(0x05000000),
                                          //         blurRadius: 8,
                                          //         offset: Offset(1, 1),
                                          //       ),
                                          //     ],
                                          //     color: Colors.white,
                                          //   ),
                                          //   child:
                                          //   // ListView.separated(
                                          //   //     padding:
                                          //   //     EdgeInsets.symmetric(horizontal: 16),
                                          //   //     physics: ScrollPhysics(),
                                          //   //     shrinkWrap: true,
                                          //   //     itemBuilder: (context, index) =>
                                          //   //         GestureDetector(
                                          //   //           onTap: () {
                                          //   //             reportingPersonFilter=employee[index].userCode??"";
                                          //   //                         print("code user$reportingPersonFilter");
                                          //   //                         setState((){});
                                          //   //             // onRefresh();
                                          //   //             // Navigator.pop(context);
                                          //   //           },
                                          //   //           child: Row(
                                          //   //             mainAxisAlignment:
                                          //   //             MainAxisAlignment.start,
                                          //   //             crossAxisAlignment:
                                          //   //             CrossAxisAlignment.center,
                                          //   //             children: [
                                          //   //               empCode == employee[index].code
                                          //   //                   ? Container(
                                          //   //                 // padding: EdgeInsets.all(10),
                                          //   //                   child: SvgPicture.string(
                                          //   //                       OrderSvg()
                                          //   //                           .checkBoxActiveIcon))
                                          //   //                   : SvgPicture.string(
                                          //   //                 OrderSvg().checkBoxIcon,
                                          //   //               ),
                                          //   //               SizedBox(
                                          //   //                 width: 10,
                                          //   //               ),
                                          //   //               Text(employee?[index].fname ?? "")
                                          //   //             ],
                                          //   //           ),
                                          //   //         ),
                                          //   //     separatorBuilder: (context, index) =>
                                          //   //         SizedBox(
                                          //   //           height: 10,
                                          //   //         ),
                                          //   //     itemCount: employee!.length)
                                          //   ListView.separated(
                                          //       primary: true,
                                          //       shrinkWrap: true,
                                          //       physics:
                                          //       NeverScrollableScrollPhysics(),
                                          //       itemBuilder: (context, index) =>
                                          //           InkWell(
                                          //             onTap: () {
                                          //               newReportibg=employee[index].userCode??"";
                                          //               reportingPersonFilter=employee[index].userCode??"";
                                          //               print("code user$reportingPersonFilter");
                                          //               setState((){});
                                          //               onRefreash();
                                          //             },
                                          //             child:
                                          //             Container(
                                          //               padding: EdgeInsets.symmetric(
                                          //                   horizontal: 16, vertical: 10),
                                          //               color: newReportibg ==
                                          //                   employee[index].userCode
                                          //                   ? ColorPalette.cardBackground
                                          //                   : ColorPalette.white,
                                          //               child: Row(
                                          //                 children: [
                                          //                   newReportibg == employee[index].userCode
                                          //                       ? SvgPicture.string(
                                          //                     HomeSvg()
                                          //                         .radioButtonActive,width: 24,height: 24,
                                          //                   )
                                          //                       : SvgPicture.string(
                                          //                       CreateSvg()
                                          //                           .radioInActiveButton),
                                          //                   const SizedBox(
                                          //                     width: 10,
                                          //                   ),
                                          //                   Text(
                                          //                     employee[index].fname ??
                                          //                         "",
                                          //                     style: GoogleFonts.roboto(
                                          //                       color: Colors.black,
                                          //                       fontSize: w / 26,
                                          //                       fontWeight:newReportibg == employee[index].userCode? FontWeight.w500:FontWeight.w400,
                                          //                     ),
                                          //                   )
                                          //                 ],
                                          //               ),
                                          //             ),
                                          //             // CustomCheckBox(
                                          //             //   key: UniqueKey(),
                                          //             //   value: true,
                                          //             //   // passNameList.contains(roleList[index].role),
                                          //             //   onChange: (p0) {
                                          //             //     if (p0) {
                                          //             //       // passIdList.add(roleList[index].id ?? 0);
                                          //             //       // passNameList.add(roleList[index].role??"");
                                          //             //
                                          //             //     } else {
                                          //             //       // passIdList.remove(
                                          //             //       //     roleList[index].id ?? 0);
                                          //             //       // passNameList.remove(roleList[index].role??"");
                                          //             //
                                          //             //
                                          //             //     }
                                          //             //     // print("fsd$passNameList");
                                          //             //     // refresh();
                                          //             //   },
                                          //             //   text: employee[index].fname??"",
                                          //             //   widget: TextAvatar(
                                          //             //     shape: Shape.Circular,
                                          //             //     size: 35,
                                          //             //     numberLetters: 2,
                                          //             //     fontSize: w/22,
                                          //             //     textColor: Colors.white,
                                          //             //     fontWeight: FontWeight.w500,
                                          //             //     text:employee[index].fname ,
                                          //             //   ),
                                          //             //   isWidget: true,
                                          //             //
                                          //             //
                                          //             // ),
                                          //           ),
                                          //       separatorBuilder:
                                          //           (context, index) => Container(height: 1,width: w1,color: Colors.grey.withOpacity(0.2),),
                                          //       itemCount:
                                          //       employee.length),
                                          // ),
                                          SizedBox(height: 30,),
                                          Text(
                                            "Task Priority",
                                            style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 10,),

                                          Container(
                                            width: w1,
                                            // height: h / 2.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x05000000),
                                                  blurRadius: 8,
                                                  offset: Offset(1, 1),
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: ListView.separated(
                                                primary: true,
                                                shrinkWrap: true,
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    GestureDetector(
                                                      onTap: () {
                                                        changeTappedTile(index);


                                                        newPriority=priority[index];
                                                        priorityFilter=priority[index];
                                                        onRefreash();
                                                        // Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 16, vertical: 10),
                                                        color: newPriority ==
                                                            priority[index]
                                                            ? ColorPalette.cardBackground
                                                            : ColorPalette.white,
                                                        child: Row(
                                                          children: [
                                                            newPriority == priority[index]
                                                                ? SvgPicture.string(
                                                              HomeSvg()
                                                                  .radioButtonActive,width: 24,height: 24
                                                            )
                                                                : SvgPicture.string(
                                                                CreateSvg()
                                                                    .radioInActiveButton),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              priority[index] ??
                                                                  "",
                                                              style: GoogleFonts.roboto(
                                                                color: Colors.black,
                                                                fontSize: w / 26,
                                                                // fontWeight: FontWeight.w500,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                separatorBuilder:
                                                    (context, index) => Container(height: 1,width: w1,color: Colors.grey.withOpacity(0.2),),
                                                itemCount:
                                                priority.length),
                                          ),
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 50,
                      left: w1/1.23,
                      child: newStatus==""&&newPriority==""?
                      GestureDetector(
                        onTap: (){
                          // priorityFilter='';
                          // reportingPersonFilter='';
                          // context.read<TaskBloc>().add( GetAllJobsListEvent('', '', '',false,"","",""));
                          // Navigator.pop(context);
                        },
                        child: Text(
                          "Clear All",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.inactiveGrey,
                            fontSize: w / 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ):GestureDetector(
                        onTap: (){
                          priorityFilter='';
                          reportingPersonFilter='';
                          statusFilter='';
                          context.read<TaskBloc>().add(GetTaskListEvent(JobRead?.id,'','','',false,'',''));
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Clear All",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.primary,
                            fontSize: w / 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                        child: newStatus==""&&newPriority==""?GradientButton(
                            color: ColorPalette.inactiveGrey,
                            onPressed: () {
                              // context.read<TaskBloc>().add( GetAllJobsListEvent('', '', '',true,newStatus,newPriority,newReportibg));
                              // Navigator.pop(context);
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.inactiveGrey,
                                  ColorPalette.inactiveGrey
                                ]),
                            child: Text(
                              "View Result",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )):
                        GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              context.read<TaskBloc>().add(GetTaskListEvent(JobRead?.id,'','','',true,newStatus,newPriority));
                              Navigator.pop(context);
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "View Result",
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
  dialog(){
    showDialog(
        useSafeArea: true,
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 2.5,
                      // padding: const EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              "event.data['image'].toString()",
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      top: 3,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 31,
                          height: 31,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, -1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
                // event.data['card_banner'].toString() == "true"
                //     ? Container(
                //   padding: const EdgeInsets.all(8),
                //   width: MediaQuery.of(context).size.width / 1.5,
                //   height: MediaQuery.of(context).size.height / 6.5,
                //   color: Colors.white,
                //   child: Column(
                //     // mainAxisAlignment: MainAxisAlignment.end,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         event.data['title'] ?? "hi",
                //         style: const TextStyle(
                //           color: Colors.black,
                //           fontSize: 20,
                //           fontFamily: 'Roboto',
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       Text(
                //         event.data['description'] ?? "",
                //         style: const TextStyle(
                //           color: Colors.black,
                //           fontSize: 14,
                //           fontFamily: 'Roboto',
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //       Center(
                //         child: Container(
                //           width: 160,
                //           height: 45,
                //           decoration: ShapeDecoration(
                //             gradient: const LinearGradient(
                //               begin: Alignment(0.00, -1.00),
                //               end: Alignment(0, 1),
                //               colors: [
                //                 Color(0xFFFF9900),
                //                 Color(0xFFFF7E07)
                //               ],
                //             ),
                //             shape: RoundedRectangleBorder(
                //                 borderRadius:
                //                 BorderRadius.circular(5)),
                //           ),
                //           child: const Center(
                //             child: Text(
                //               'CHECK NOW',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 18,
                //                 fontFamily: 'Roboto',
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // )
                //     : Container()
                //  Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       event.data['title'] ?? "",
                //       style: const TextStyle(
                //         color: Colors.black,
                //         fontSize: 20,
                //         fontFamily: 'Roboto',
                //         fontWeight: FontWeight.w600,
                //         height: 41,
                //       ),
                //     ),
                //     // const SizedBox(height: 8),
                //     Text(
                //       event.data['description'] ?? "",
                //       style: const TextStyle(
                //         color: Colors.black,
                //         fontSize: 14,
                //         fontFamily: 'Roboto',
                //         fontWeight: FontWeight.w400,
                //         height: 22,
                //       ),
                //     ),
                //     // Container(
                //     //   // width: 160,
                //     //   // height: 45,
                //     //   decoration: ShapeDecoration(
                //     //     gradient: const LinearGradient(
                //     //       begin: Alignment(0.00, -1.00),
                //     //       end: Alignment(0, 1),
                //     //       colors: [
                //     //         Color(0xFFFF9900),
                //     //         Color(0xFFFF7E07)
                //     //       ],
                //     //     ),
                //     //     shape: RoundedRectangleBorder(
                //     //         borderRadius: BorderRadius.circular(5)),
                //     //   ),
                //     //   child: const Text(
                //     //     'CHECK NOW',
                //     //     textAlign: TextAlign.center,
                //     //     style: TextStyle(
                //     //       color: Colors.white,
                //     //       fontSize: 18,
                //     //       fontFamily: 'Roboto',
                //     //       fontWeight: FontWeight.w600,
                //     //       height: 20,
                //     //     ),
                //     //   ),
                //     // )
                //   ],
                // ) ,
              ],
            ),
          );
        });
  }
}
