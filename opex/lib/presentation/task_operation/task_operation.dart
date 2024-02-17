import 'package:calendar_date_picker2/calendar_date_picker2.dart';
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
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
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
import 'all_job_list_admin.dart';
import 'create/create_job.dart';
import 'create/create_svg.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';
import 'create_group.dart';
import 'employee_group_screen.dart';
import 'evaluation_pages/evaluate_user_by_teamleads.dart';
import 'evaluation_pages/evaluation_list_ceo.dart';
import 'evaluation_pages/evaluation_user_list.dart';
import 'home/model/joblist_model.dart';

import 'home/my_jobs.dart';
import 'home_card.dart';
import 'organisation_pages/organisation_chart_screen.dart';

class TaskAndOperation extends StatefulWidget {
  const TaskAndOperation({Key? key}) : super(key: key);

  @override
  State<TaskAndOperation> createState() => _TaskAndOperationState();
}

class _TaskAndOperationState extends State<TaskAndOperation> {
  String? finalDate;

  String startDate = '';
  String startDate2 = '';
  String ebdDate = '';
  String ebdDate2 = '';
  kkkk(){
    var end = DateTime.now();
    var start = DateTime.now().subtract(Duration(days: 30));
    var end2 =  DateTime.parse("$end");
    var start2 =  DateTime.parse("$start");
    startDate2 =  DateFormat('dd-MM-yyyy').format(start2).toString();
    startDate =  DateFormat('yyyy-MM-dd').format(start2).toString();
    ebdDate2 =  DateFormat('dd-MM-yyyy').format(end2).toString();
    ebdDate =  DateFormat('yyyy-MM-dd').format(end2).toString();
    BlocProvider.of<JobBloc>(
        context)
        .add(
        FilterAssignTaskCountEvent(
            startDate:
            startDate,
            endDate:
            ebdDate));
    print("strt$startDate");
    print("end$ebdDate");
  }
  GetCountTask? taskcount;
  bool isStaff = false;

  String _range = '';
  String _range1 = '';
  List<GetJobList> joblist = [];
  List<PerfomerModel> perfomance = [];

  _onSelectionChanged(DateTime? startDatePass,DateTime? endDatePass) {

    setState(() {
      _range = '${DateFormat('yyyy-MM-dd').format(startDatePass!)} -'
          ' ${DateFormat('yyyy-MM-dd').format(endDatePass!)}';

      _range1 = '${DateFormat('dd-MM-yyyy').format(startDatePass)} -'
          ' ${DateFormat('dd-MM-yyyy').format(endDatePass)}';
      startDate=_range.split(" - ")[0];
      startDate2=_range1.split(" - ")[0];
      ebdDate=_range.split(" - ")[1];
      ebdDate2=_range1.split(" - ")[1];

      // validationCheck();
    });
  }
  var formatter =  DateFormat('MM').format(DateTime.now());
  @override
  void initState() {
    print("init");
    context.read<JobBloc>().add(const GetUserVerifyEvent());
    context.read<JobBloc>().add(const GetAdminDataEvent());
    context.read<JobBloc>().add(GetNewJobListEvent('','',''));
    context.read<TaskBloc>().add(GetOrganisationPerformanceList(int.tryParse(formatter), 2023));
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
    return MultiBlocListener(
  listeners: [
    BlocListener<JobBloc, JobState>(
      listener: (context, state) {

        if (state is GetNewJobListSuccess) {
          setState(() {});
          joblist = state.jobList??[];
        }
      },
),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is GetOrgPerfListSuccess) {
          perfomance = state.taskList ?? [];
          setState(() {});
        }
        if (state is GetOrgPerfListFailed) {
          perfomance = [];
          setState(() {});
        }
      },
    ),
  ],
  child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Column(
            children: [
              AppBar(
                surfaceTintColor: Colors.white,
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
              ),
              Container(
                width: w1,
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
                                    print("start$startDate");
                                    print("end$ebdDate");
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
                                                  Container(
                                                    width: w1,
                                                    child: CalendarDatePicker2WithActionButtons(
                                                      onOkTapped: (){
                                                        BlocProvider.of<JobBloc>(
                                                                          context)
                                                                          .add(
                                                                          FilterAssignTaskCountEvent(
                                                                              startDate:
                                                                              startDate,
                                                                              endDate:
                                                                              ebdDate));
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
                                                        firstDayOfWeek: 1,
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
                                                  const SizedBox(height: 16,)
                                                ],
                                              ),
                                            ),
                                          );
                                          // return AlertDialog(
                                          //   surfaceTintColor: Colors.white,
                                          //   backgroundColor: Colors.white,
                                          //   shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(10.0),),
                                          //   content: Column(
                                          //     mainAxisSize: MainAxisSize.min,
                                          //     children: [
                                          //       Container(
                                          //         height: 300,
                                          //         child: Scaffold(
                                          //           body: SfDateRangePicker(
                                          //
                                          //
                                          //               backgroundColor:
                                          //               Colors.white,
                                          //               endRangeSelectionColor:
                                          //               ColorPalette.primary,
                                          //               startRangeSelectionColor:
                                          //               ColorPalette.primary,
                                          //               rangeSelectionColor:
                                          //               ColorPalette.primary
                                          //                   .withOpacity(0.1),
                                          //
                                          //               selectionColor:
                                          //               Colors.grey,
                                          //               todayHighlightColor:
                                          //               ColorPalette.primary,
                                          //               onSelectionChanged:
                                          //               _onSelectionChanged,
                                          //               selectionMode:
                                          //               DateRangePickerSelectionMode
                                          //                   .range,
                                          //               initialSelectedRange:PickerDateRange(
                                          //                   DateTime.parse(startDate2),
                                          //                   DateTime.parse(ebdDate2))
                                          //
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       GestureDetector(
                                          //         onTap: () {
                                          //           BlocProvider.of<JobBloc>(
                                          //               context)
                                          //               .add(
                                          //               FilterAssignTaskCountEvent(
                                          //                   startDate:
                                          //                   ebdDate2,
                                          //                   endDate:
                                          //                   startDate2));
                                          //           setState(() {});
                                          //           Navigator.pop(context);
                                          //         },
                                          //         child: Container(width: w/3,
                                          //           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                          //           alignment: Alignment.center,
                                          //           color: ColorPalette.primary,
                                          //           child: Text("Ok",style: GoogleFonts.roboto(color: Colors.white),),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // );
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
                            Container(
                              width: w1,
                              child: Row(
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
                            ),

                            perfomance.isEmpty
                                ? Container()
                                : Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15,),
                                    Text(
                                      "Best Performer",
                                      style: GoogleFonts.roboto(
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                              height: 100,
                              child: CarouselSlider.builder(
                                      slideTransform: DefaultTransform(),
                                      slideIndicator: CircularSlideIndicator(
                                          padding: EdgeInsets.only(bottom: 10, left: 0),
                                          alignment: Alignment.bottomCenter,
                                          indicatorBorderWidth: 0.2,
                                          indicatorRadius: 3.5,
                                          itemSpacing: 10,
                                          currentIndicatorColor: Color(0xff086DB5),
                                          indicatorBackgroundColor: ColorPalette.cardBackground),
                                      itemCount: perfomance.length,
                                      // disableGesture: true,
                                      // options: CarouselOptions(
                                      //   height: 100,
                                      //   aspectRatio: 16 / 12,
                                      //   viewportFraction: 1,
                                      //   initialPage: 0,
                                      //   enableInfiniteScroll: false,
                                      //   reverse: false,
                                      //   autoPlay: false,
                                      //   // autoPlayInterval: Duration(seconds: 3),
                                      //   autoPlayAnimationDuration: Duration(milliseconds: 800),
                                      //   autoPlayCurve: Curves.fastOutSlowIn,
                                      //   enlargeCenterPage: true,
                                      //   enlargeFactor: 0.3,
                                      //   scrollDirection: Axis.horizontal,
                                      // ),
                                      slideBuilder: (int i) {
                                        return Container(
                                          width: w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(0xFF2772B0),
                                                const Color(0xFF27A8B0),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              // begin: const FractionalOffset(0.0, 0.0),
                                              // end: const FractionalOffset(1.0, 0.0),
                                              // stops: [0.0, 1.0],
                                              // tileMode: TileMode.clamp
                                            ),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                          child: Column(children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                TextAvatar(
                                                  shape: Shape.Circular,
                                                  size: 40,
                                                  numberLetters: 1,
                                                  fontSize: w / 14,
                                                  textColor: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  text: perfomance[i].fName ?? "".toUpperCase(),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        perfomance[i].fName ?? "",
                                                        style: GoogleFonts.roboto(
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: w / 24),
                                                      ),
                                                      Text(
                                                        perfomance[i].email ?? "",
                                                        style: GoogleFonts.roboto(
                                                          // fontWeight: FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize: w / 26),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 45),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Total Points : ${perfomance[i].points}",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white,
                                                      fontSize: w / 28),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      }),
                            ),
                                  ],
                                ),

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
                                    width: w1,
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
                                    width: w1,
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
                                        screen: ReportedListAdmin(),
                                        withNavBar: false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.fade,
                                      );
                                    },
                                    child: FourCard(
                                      label: "Reported List",
                                      svg: TaskSvg().reportedList,
                                    )),

                              ],
                            ),
                                    ),
                                    SizedBox(height: 20,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 15),
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
                                          // authentication.isAssociateAdmin==false?
                                          // GestureDetector(
                                          //     onTap: () {
                                          //       PersistentNavBarNavigator.pushNewScreen(
                                          //         context,
                                          //         screen: CreatePerformance(),
                                          //         withNavBar: false, // OPTIONAL VALUE. True by default.
                                          //         pageTransitionAnimation: PageTransitionAnimation.fade,
                                          //       );
                                          //     },
                                          //     child: FourCard(
                                          //       label: "Criteria",
                                          //       svg: TaskSvg().criteriaIcon,
                                          //     )):  Container(
                                          //   width: w1/6,
                                          //   height: 60,
                                          //   padding: EdgeInsets.all(10),
                                          //
                                          //   decoration: BoxDecoration(
                                          //     borderRadius: BorderRadius.circular(10),
                                          //     color: Colors.white,
                                          //   ),
                                          //   child: Column(
                                          //     children: [
                                          //       // SvgPicture.string(svg??TaskSvg().quickaccessIcon),
                                          //       //
                                          //       // SizedBox(height: 5,),
                                          //       // Text(
                                          //       //   label??"Employees",
                                          //       //   textAlign: TextAlign.center,
                                          //       //   style: TextStyle(
                                          //       //     color: ColorPalette.black,
                                          //       //     fontSize: 11,
                                          //       //
                                          //       //   ),
                                          //       // )
                                          //     ],
                                          //   ),
                                          // ),
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
                                          authentication.isAdmin?GestureDetector(
                                              onTap: () {
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen:  AllJobListAdmin(),
                                                  withNavBar: false,
                                                  // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation:
                                                  PageTransitionAnimation.fade,
                                                );
                                              },
                                              child: FourCard(
                                                  label: "All Job List",
                                                  svg: TaskSvg().alljobList
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
                                            padding: EdgeInsets.all(20),

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              // border: Border.all(color: Colors.grey,width: 0.1),
                                              color: Color(0x0ffFFFFFF),
                                            ),
                                            // child: SvgPicture.string(svg??TaskSvg().deleteBox),
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 20,),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 10,right: 15),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       GestureDetector(
                                    //           onTap: () {
                                    //             PersistentNavBarNavigator.pushNewScreen(
                                    //               context,
                                    //               screen: EvaluationUserListing(),
                                    //               withNavBar: false, // OPTIONAL VALUE. True by default.
                                    //               pageTransitionAnimation: PageTransitionAnimation.fade,
                                    //             );
                                    //           },
                                    //           child: FourCard(
                                    //             label: "Evaluate\n(HR)",
                                    //             svg: TaskSvg().reporterSvg,
                                    //           )),
                                    //       GestureDetector(
                                    //           onTap: () {
                                    //             PersistentNavBarNavigator.pushNewScreen(
                                    //               context,
                                    //               screen: EvaluationUserListByTLs(),
                                    //               withNavBar: false, // OPTIONAL VALUE. True by default.
                                    //               pageTransitionAnimation: PageTransitionAnimation.fade,
                                    //             );
                                    //           },
                                    //           child: FourCard(
                                    //             label: "Evaluate\n(TL's)",
                                    //             svg: TaskSvg().reporterSvg,
                                    //           )),
                                    //       GestureDetector(
                                    //           onTap: () {
                                    //             PersistentNavBarNavigator.pushNewScreen(
                                    //               context,
                                    //               screen: EvaluationUserListToCEO(),
                                    //               withNavBar: false, // OPTIONAL VALUE. True by default.
                                    //               pageTransitionAnimation: PageTransitionAnimation.fade,
                                    //             );
                                    //           },
                                    //           child: FourCard(
                                    //             label: "Evaluate\n(CEO)",
                                    //             svg: TaskSvg().reporterSvg,
                                    //           )),
                                    //       GestureDetector(
                                    //           onTap: () {
                                    //             PersistentNavBarNavigator.pushNewScreen(
                                    //               context,
                                    //               screen: OrganisationChartScreen(),
                                    //               withNavBar: false, // OPTIONAL VALUE. True by default.
                                    //               pageTransitionAnimation: PageTransitionAnimation.fade,
                                    //             );
                                    //           },
                                    //           child: FourCard(
                                    //             label: "Organisation",
                                    //             svg: TaskSvg().reporterSvg,
                                    //           )),
                                    //
                                    //
                                    //     ],
                                    //   ),
                                    // ),
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
                                      screen:  NewJobList(
                                          startDate:
                                          ebdDate2,
                                          endDate:
                                          startDate2
                                      ),
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
                                      screen:  PendingJobs(
                                          startDate:
                                      ebdDate2,
                                          endDate:
                                          startDate2),
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
                            // joblist.isEmpty
                            //     ? Container()
                            //     : Column(
                            //   children: [
                            //     Row(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Text(
                            //           "New Tasks",
                            //           style: GoogleFonts.roboto(
                            //             color: ColorPalette.black,
                            //             fontSize: w / 24,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //         GestureDetector(
                            //             onTap: () {
                            //               PersistentNavBarNavigator
                            //                   .pushNewScreen(
                            //                 context,
                            //                 screen: authentication.isAdmin
                            //                     ? TaskAndOperationHomePage(
                            //                   newIndex: 0,
                            //                 )
                            //                     : NewJobList(),
                            //                 withNavBar: false,
                            //                 // OPTIONAL VALUE. True by default.
                            //                 pageTransitionAnimation:
                            //                 PageTransitionAnimation
                            //                     .fade,
                            //               );
                            //             },
                            //             child: Text("View All",
                            //                 style: GoogleFonts.roboto(
                            //                   color: ColorPalette.primary,
                            //                   fontSize: w / 24,
                            //                   fontWeight: FontWeight.w500,
                            //                 )))
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       height: 16,
                            //     ),
                            //     Container(
                            //       //color: Colors.yellow,
                            //       padding: const EdgeInsets.only(
                            //         bottom: 20,
                            //       ),
                            //       child: ListView.separated(
                            //           shrinkWrap: true,
                            //           physics: const ScrollPhysics(),
                            //           separatorBuilder:
                            //               (BuildContext cxt, int i) {
                            //             return const SizedBox(
                            //               height: 5,
                            //             );
                            //           },
                            //           itemBuilder:
                            //               (BuildContext context, int i) {
                            //             return InkWell(
                            //               onTap: () {},
                            //               child: JobCard(
                            //                 joblist: joblist[i],
                            //               ),
                            //             );
                            //           },
                            //           itemCount: joblist.length>=5?5:joblist.length),
                            //     )
                            //   ],
                            // ),
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
