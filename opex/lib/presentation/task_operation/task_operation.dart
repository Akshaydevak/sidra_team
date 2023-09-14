import 'package:cluster/common_widgets/datefield.dart';
import 'package:cluster/common_widgets/headline_text.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/create/reporer_list.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/create_performance.dart';
import 'package:cluster/presentation/task_operation/task_home_page.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/four_card.dart';
import 'package:cluster/presentation/task_operation/task_title/job_card.dart';
import 'package:cluster/presentation/task_operation/task_title/new_employee.dart';
import 'package:cluster/presentation/task_operation/task_title/new_job_list.dart';
import 'package:cluster/presentation/task_operation/task_title/pending_jobs.dart';
import 'package:cluster/presentation/task_operation/task_title/pinned_jobs.dart';
import 'package:cluster/presentation/task_operation/task_title/repored_list_admin.dart';
import 'package:cluster/presentation/task_operation/task_title/repoted_list_user.dart';
import 'package:cluster/presentation/task_operation/task_title/staff_joblist.dart';
import 'package:cluster/presentation/task_operation/task_title/two_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../common_widgets/loading.dart';

import '../../../../core/common_snackBar.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'create/create_job.dart';
import 'create/create_svg.dart';
import 'create/model/task_models.dart';
import 'create_group.dart';
import 'employee_group_screen.dart';
import 'home/model/joblist_model.dart';

import 'home/my_jobs.dart';
import 'home_card.dart';

class TaskAndOperation extends StatefulWidget {
  const TaskAndOperation({Key? key}) : super(key: key);

  @override
  State<TaskAndOperation> createState() => _TaskAndOperationState();
}

class _TaskAndOperationState extends State<TaskAndOperation> {
  String? finalDate;

  String startDate = "";
  String startDate2 = "10-12-2020";
  String ebdDate = "";
  String ebdDate2 = "25-1-2022";
  kkkk(){
    var date2 = DateTime.now();
    var date3 = DateTime.now().subtract(Duration(days: 30));
    var dateTime2 =  DateTime.parse("$date2");
    var dateTime3 =  DateTime.parse("$date3");
    startDate =  DateFormat('dd-MM-yyyy').format(dateTime2).toString();
    startDate2 =  DateFormat('yyyy-MM-dd').format(dateTime2).toString();
    ebdDate =  DateFormat('dd-MM-yyyy').format(dateTime3).toString();
    ebdDate2 =  DateFormat('yyyy-MM-dd').format(dateTime3).toString();
    BlocProvider.of<JobBloc>(
        context)
        .add(
        FilterAssignTaskCountEvent(
            startDate:
            ebdDate2,
            endDate:
            startDate2));
    print("endDate$startDate");
    print("endDate$ebdDate");
  }
  GetCountTask? taskcount;
  bool isStaff = false;

  String _selectedDate1 = '';
  String _dateCount = '';
  String _range = '';
  String _range1 = '';
  String _rangeCount = '';
  List<GetJobList> joblist = [];

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
        _range1 = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }

      ebdDate2 = _range.split(" - ")[0];
      ebdDate = _range1.split(" - ")[0];
      startDate2 = _range.split(" - ")[1];
      startDate = _range1.split(" - ")[1];

      print("statatat$startDate");
      print("statatat$ebdDate");
    });
  }

  @override
  void initState() {
    print("init");
    context.read<JobBloc>().add(const GetUserVerifyEvent());
    context.read<JobBloc>().add(const GetAdminDataEvent());
    context.read<JobBloc>().add(GetNewJobListEvent('','',''));
    kkkk();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if (state is GetNewJobListLoading) {
          customCupertinoLoading();
        }
        if (state is GetNewJobListSuccess) {
          setState(() {});
          joblist = state.jobList??[];
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Column(
            children: [
              AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  systemNavigationBarColor: Colors.white, // Navigation bar
                  statusBarColor: Colors.white, // Status bar
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: false,

                title: Text(
                  "Task & Operation",
                  style:  TextStyle(color: Colors.black,fontSize: w/22),
                ),
                titleSpacing: 10,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SvgPicture.string(
                    AppsSvg().appbarIcon,
                  ),
                ),
                leadingWidth: 28,
                // actions: [
                //   // Padding(
                //   //   padding: const EdgeInsets.only(top: 12,left: 16),
                //   //   child: InkWell(
                //   //     onTap: (){},
                //   //     //   if(activeTextfield==true){
                //   //     //     context.read<ProfileBloc>().add(UpdateProfileEvent(
                //   //     //       mobile: mobileController.text,
                //   //     //       lname: "",
                //   //     //       fname: nameController.text,
                //   //     //       dob: "",
                //   //     //       email: emailController.text,
                //   //     //
                //   //     //     ));
                //   //     //   }
                //   //     //   else{
                //   //     //
                //   //     //   }
                //   //     //   myfocus.unfocus();
                //   //     //   myfocus1.unfocus();
                //   //     //   myfocus2.unfocus();
                //   //     //   activeTextfield=false;
                //   //     // },
                //   //     child: Text(
                //   //       "Save",
                //   //       style: GoogleFonts.roboto(
                //   //         color: activeTextfield==true?Color(0xFF2871AF):Color(0xFFD3D3D3),
                //   //         fontSize: 18,
                //   //         fontWeight: FontWeight.w500,
                //   //         height: 1.56,
                //   //       ),
                //   //     ),
                //   //   ),
                //   // ),
                //
                //
                //   // SvgPicture.string(HomeSvg().msgIcon),
                //   //         const SizedBox(
                //   //           width: 16,
                //   //         ),
                //   //         GestureDetector(
                //   //           onTap: widget.onTap,
                //   //             child: SvgPicture.string(HomeSvg().addIcon)),
                //
                //   const SizedBox(
                //     width: 16,
                //   )
                // ],
              ),
              Container(
                width: w,
                height: 1.50,
                decoration: const BoxDecoration(
                  color: Color(0xb2e6e6e6),
                ),
              ),
            ],
          ),
        ),
        body: BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            print("Entered listener$state");
            if (state is TaskCountSuccess) {
              taskcount = state.data;
              // print('SHIFU${taskcount?.assignTask.toString()}');
              setState(() {});
            }
          },
          child: SafeArea(
            child: ScrollConfiguration(
              behavior: NoGlow(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: w1,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      // border: Border.all(
                                      //   color: Color(0xfffdf2f2),
                                      //   width: 1.50,
                                      // ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                      color: Color(0xffE7E7E7)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      ebdDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorPalette.black),
                                    )),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      // border: Border.all(
                                      //   color: Color(0xfffdf2f2),
                                      //   width: 1.50,
                                      // ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                      color: Color(0xffE7E7E7),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      startDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorPalette.black),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 300,
                                                  child: Scaffold(
                                                    body: SfDateRangePicker(

                                                        backgroundColor:
                                                        Colors.white,
                                                        endRangeSelectionColor:
                                                        ColorPalette.primary,
                                                        startRangeSelectionColor:
                                                        ColorPalette.primary,
                                                        rangeSelectionColor:
                                                        ColorPalette.primary
                                                            .withOpacity(0.1),
                                                        selectionColor:
                                                        Colors.grey,
                                                        todayHighlightColor:
                                                        ColorPalette.primary,
                                                        onSelectionChanged:
                                                        _onSelectionChanged,
                                                        selectionMode:
                                                        DateRangePickerSelectionMode
                                                            .range,
                                                        initialSelectedRange:PickerDateRange(
                                                            DateTime.parse(startDate2),
                                                            DateTime.parse(ebdDate2))

                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    BlocProvider.of<JobBloc>(
                                                        context)
                                                        .add(
                                                        FilterAssignTaskCountEvent(
                                                            startDate:
                                                            ebdDate2,
                                                            endDate:
                                                            startDate2));
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(width: w/3,
                                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                                    alignment: Alignment.center,
                                                    color: ColorPalette.primary,
                                                    child: Text("Ok",style: GoogleFonts.roboto(color: Colors.white),),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),

                                      color: ColorPalette.primary,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                        ),
                                      ],

                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: SvgPicture.string(
                                      CreateSvg().calenderIcon,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HomeCard(
                                    head:
                                    taskcount?.assignTask.toString() ?? "0",
                                    sub: "Assigned Task",
                                colorContainer: Color(0xff2871AF).withOpacity(0.2),),
                                HomeCard(
                                    head: taskcount?.taskCompleted.toString() ??
                                        "0",
                                    sub: "Task Completed",
                                colorContainer: Color(0xffE8FFE0)),
                                HomeCard(
                                  head:
                                  taskcount?.taskPending.toString() ?? "0",
                                  sub: "Task Pending",
                                  colorContainer: Color(0xffFFEAEA),
                                )
                              ],
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     // HomeCard(
                            //     //   head: taskcount?.taskOnProgress.toString() ??
                            //     //       "0",
                            //     //   sub: "Task on Progress",
                            //     // ),
                            //
                            //   ],
                            // ),

                            authentication.isAdmin ||authentication.isAssociateAdmin
                                ? Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator
                                        .pushNewScreen(
                                      context,
                                      screen: CreateJob(),
                                      withNavBar: false,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Container(
                                    width: w,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    // height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: const Color(0xffE7E7E7).withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.string(TaskSvg().newjobIcon,color: Colors.black,),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Create new Job",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: w/24,
                                              ),
                                            )
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,size: 18,color: ColorPalette.primary),
                                        // SvgPicture.string(TaskSvg().arrowIcon,color: ColorPalette.primary,h)
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator
                                        .pushNewScreen(
                                      context,
                                      screen: const PinnedJobs(),
                                      withNavBar: false,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: Container(
                                    width: w,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    // height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(4),
                                      color: Color(0xffE7E7E7).withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.string(TaskSvg().pinIcon,color: Colors.black),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Pinned Job List",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: w/24,
                                              ),
                                            )
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,size: 18,color: ColorPalette.primary),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container(),
                            HeadlineText(headText: "Quick access to :"),
                            authentication.isAdmin ||authentication.isAssociateAdmin
                                ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                      GestureDetector(
                                          onTap: () {
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen:
                                              const TaskAndOperationHomePage(),
                                              withNavBar: false,
                                              // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                              PageTransitionAnimation.fade,
                                            );
                                          },
                                          child: FourCard(
                                            label: "Job List",
                                            svg: TaskSvg().joblistSvg,
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen: EmployeesGroupScreen(
                                                  newIndex: 0),
                                              withNavBar: false,
                                              // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                              PageTransitionAnimation.fade,
                                            );
                                          },
                                          child: FourCard(label: "Users",
                                              svg:
                                              TaskSvg().userSvg)),
                                      GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: EmployeesGroupScreen(
                                                newIndex: 1),
                                            withNavBar: false,
                                            // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                          );
                                        },
                                        child: FourCard(
                                          label: "Groups",
                                            svg:
                                            TaskSvg().groupSvg
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            PersistentNavBarNavigator.pushNewScreen(
                                              context,
                                              screen: CreatePerformance(),
                                              withNavBar: false, // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation: PageTransitionAnimation.fade,
                                            );
                                          },
                                          child: FourCard(
                                            label: "Criteria",
                                            svg: TaskSvg().criteriaIcon,
                                          ))
                              ],
                            ),
                                    ),
                                    SizedBox(height: 20,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                PersistentNavBarNavigator.pushNewScreen(
                                                  context,
                                                  screen: ReporterList(),
                                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                                );
                                              },
                                              child: FourCard(
                                                label: "Reporter",
                                                svg: TaskSvg().reporterSvg,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                PersistentNavBarNavigator.pushNewScreen(
                                                  context,
                                                  screen: ReportedListAdmin(),
                                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                                );
                                              },
                                              child: FourCard(
                                                label: "Reported List",
                                                svg: TaskSvg().reportedList,
                                              )),
                                          authentication.isAdmin? GestureDetector(
                                              onTap: () {
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen: const CreateGroup(),
                                                  withNavBar: false,
                                                  // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation:
                                                  PageTransitionAnimation.fade,
                                                );
                                              },
                                              child: FourCard(
                                                label: "Create Group",
                                                  svg: TaskSvg().createGroupSvg
                                              )):Container(
                                            width: w1/6,
                                            height: 60,
                                            padding: EdgeInsets.all(10),

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                // SvgPicture.string(svg??TaskSvg().quickaccessIcon),
                                                //
                                                // SizedBox(height: 5,),
                                                // Text(
                                                //   label??"Employees",
                                                //   textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //     color: ColorPalette.black,
                                                //     fontSize: 11,
                                                //
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: w1/6,
                                            height: 60,
                                            padding: EdgeInsets.all(10),

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                // SvgPicture.string(svg??TaskSvg().quickaccessIcon),
                                                //
                                                // SizedBox(height: 5,),
                                                // Text(
                                                //   label??"Employees",
                                                //   textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //     color: ColorPalette.black,
                                                //     fontSize: 11,
                                                //
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator
                                        .pushNewScreen(
                                      context,
                                      screen: const NewJobList(),
                                      withNavBar: false,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: FourCard(
                                    label: "Job List",
                                    svg: TaskSvg().joblistSvg,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator
                                        .pushNewScreen(
                                      context,
                                      screen: const PinnedJobs(),
                                      withNavBar: false,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: FourCard(
                                    label: "Pinned Job",
                                    svg: TaskSvg().pinnedSvg,
                                    
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<JobBloc>()
                                        .add(GetStatusListEvent());
                                    PersistentNavBarNavigator
                                        .pushNewScreen(
                                      context,
                                      screen: const PendingJobs(),
                                      withNavBar: false,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: FourCard(
                                    label: "Pending Jobs",
                                    svg: TaskSvg().reportedList,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator
                                        .pushNewScreen(
                                      context,
                                      screen: const ReportedListUser(),
                                      withNavBar: false,
                                      // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                    );
                                  },
                                  child: FourCard(
                                    label: "Reported List",
                                    svg: TaskSvg().reporterSvg,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // authentication.isAdmin
                            //     ? Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     GestureDetector(
                            //         onTap: () {
                            //           // PersistentNavBarNavigator.pushNewScreen(
                            //           //   context,
                            //           //   screen: const NewEmployee(),
                            //           //   withNavBar: true,
                            //           //   // OPTIONAL VALUE. True by default.
                            //           //   pageTransitionAnimation:
                            //           //       PageTransitionAnimation.fade,
                            //           // );
                            //           PersistentNavBarNavigator
                            //               .pushNewScreen(
                            //             context,
                            //             screen: const ReportedListAdmin(),
                            //             withNavBar: false,
                            //             // OPTIONAL VALUE. True by default.
                            //             pageTransitionAnimation:
                            //             PageTransitionAnimation.fade,
                            //           );
                            //         },
                            //         child: Container(
                            //           width: w/1.1,
                            //           padding: EdgeInsets.all(12),
                            //           height: 90,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Color(0x0ce30000),
                            //           ),
                            //           child: Column(
                            //             children: [
                            //               SvgPicture.string(TaskSvg().quickaccessIcon),
                            //               SizedBox(height: 10,),
                            //               Text(
                            //                 "Reported List",
                            //                 textAlign: TextAlign.center,
                            //                 style: TextStyle(
                            //                   color: Color(0xff121113),
                            //                   fontSize: 13,
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         )),
                            //     SizedBox(height: 10,),
                            //     GestureDetector(
                            //         onTap: () {
                            //           PersistentNavBarNavigator
                            //               .pushNewScreen(
                            //             context,
                            //             screen: const CreateGroup(),
                            //             withNavBar: false,
                            //             // OPTIONAL VALUE. True by default.
                            //             pageTransitionAnimation:
                            //             PageTransitionAnimation.fade,
                            //           );
                            //           //  CreateGroup
                            //         },
                            //         child: TwoCard())
                            //   ],
                            // )
                            //     : Container(),
                            const SizedBox(
                              height: 25,
                            ),
                            joblist.isEmpty
                                ? Container()
                                : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "New Tasks",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.black,
                                        fontSize: w / 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: authentication.isAdmin
                                                ? TaskAndOperationHomePage(
                                              newIndex: 0,
                                            )
                                                : NewJobList(),
                                            withNavBar: false,
                                            // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation:
                                            PageTransitionAnimation
                                                .fade,
                                          );
                                        },
                                        child: Text("View All",
                                            style: GoogleFonts.roboto(
                                              color: ColorPalette.primary,
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            )))
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
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
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return InkWell(
                                          onTap: () {},
                                          child: JobCard(
                                            joblist: joblist[i],
                                          ),
                                        );
                                      },
                                      itemCount: joblist.length>=5?5:joblist.length),
                                )
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
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
                padding: EdgeInsets.only(
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
                  child: Column(
                    children: [
                      Text(
                        "Create ",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xfff8f7f5),
                      ),
                      GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: CreateJob(),
                            withNavBar: false,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                            PageTransitionAnimation.fade,
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xfffd5762),
                              ),
                              child: SvgPicture.string(HomeSvg().jobIcon),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: w / 1.5,
                              child: Text(
                                "Job ",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 70,
                        color: Color(0xffE6ECF0),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffd5762),
                            ),
                            child: SvgPicture.string(HomeSvg().imgFeedIcon),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: w / 1.5,
                            child: Text(
                              "Video / Image Feed ",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        indent: 70,
                        color: Color(0xffE6ECF0),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffd5762),
                            ),
                            child: SvgPicture.string(HomeSvg().analyticIcon),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: w / 1.5,
                            child: Text(
                              "Updation / Analytics",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        indent: 70,
                        color: Color(0xffE6ECF0),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffd5762),
                            ),
                            child: SvgPicture.string(HomeSvg().chatGroupIcon),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: w / 1.5,
                            child: Text(
                              "Chat or Group",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
