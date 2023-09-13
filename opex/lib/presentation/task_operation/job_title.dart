import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/order_app/activity_log.dart';
import 'package:cluster/presentation/task_operation/create/model/task_models.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/performance_appraisal/performance_appraisal.dart';
import 'package:cluster/presentation/task_operation/rewards_screen.dart';
import 'package:cluster/presentation/task_operation/task_card.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/reporting_person_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../common_widgets/loading.dart';
import '../../../../core/common_snackBar.dart';
import '../../../../core/utils/variables.dart';
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'create/create_job.dart';
import 'create/create_newtask.dart';
import 'create/reporting_person_job.dart';
import 'create/single_row.dart';
import 'home/bloc/job_bloc.dart';
import 'home/model/joblist_model.dart';
import 'lottieLoader.dart';

class JobTitle extends StatefulWidget {
  bool isMyJob = false;
  JobTitle({Key? key, this.isMyJob = false}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          context.read<JobBloc>().add(const GetAssignedMeListEvent('', '', ''));
      return true;},
      child: MultiBlocListener(
        listeners: [
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is DeleteJobLoading) {
                showSnackBar(context,
                    message: "Loading...",
                    color: Colors.white,
                    // icon: HomeSvg().SnackbarIcon,
                    autoDismiss: true);
              }

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
              if (state is GetJobReadLoading) {}
              if (state is GetJobReadSuccess) {
                JobRead = state.getjobRead;

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
                  context.read<JobBloc>().add(const GetAssignedMeListEvent('', '', ''));
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
                            // Container(
                            //   padding: EdgeInsets.only(left: 10),
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.string(TaskSvg().msgSendIcon),
                            //       SizedBox(width: 10,),
                            //       Text(
                            //         'Share by message',
                            //         style: GoogleFonts.poppins(
                            //             color: ColorPalette.black,
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w500),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Divider(indent: 30,),
                            // Container(
                            //   padding: EdgeInsets.only(left: 10),
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.string(TaskSvg().shareJobIcon),
                            //       SizedBox(width: 10,),
                            //       Text(
                            //         'Share this Job',
                            //         style: GoogleFonts.poppins(
                            //             color: ColorPalette.black,
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w500),
                            //       ),
                            //     ],
                            //   ),
                            // ), Divider(indent: 30,),
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
              child: Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<TaskBloc, TaskState>(
                      builder: (context, state) {
                        if (state is GetTaskListLoading) {
                          return  Container(
                            height: h / 4,
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
                          taskList = state.taskList ?? [];
                          nextUrl = state.nextPageUrl ?? "";
                          prevUrl = state.prevPageUrl ?? "";
                          return Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Task List",
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.black,
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GridView.builder(
                                  shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1.2,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemBuilder: (BuildContext context, int i) {
                                    return InkWell(
                                      onTap: () {},
                                      child: TaskCard(
                                        isMylist: widget.isMyJob,
                                        taskList: taskList[i],
                                      ),
                                    );
                                  },
                                  itemCount: taskList.length),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
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
                                                      prevUrl));
                                              // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                            },
                                            child: Text(
                                              "Previous",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorPalette.primary,
                                                  fontSize: w / 24),
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
                                                        ""));
                                              });
                                            },
                                            child: Text(
                                              "Next",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorPalette.primary,
                                                  fontSize: w / 24),
                                            ),
                                          )
                                        : Text("")
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GradientButton(
                        color: ColorPalette.primary,
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: CreateNewTask(
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
                      width: w,
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
                    GestureDetector(
                      onTap: () {
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
                        width: w,
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
                        width: w,
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
                          width: w,
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
            ),
          ),
        ),
      ),
    );
  }
}
