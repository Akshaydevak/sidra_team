import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../common_widgets/custom_checkbox.dart';
import '../../common_widgets/gradient_button.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'create/create_svg.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_model/employee_model.dart';
import 'home/model/joblist_model.dart';
import 'job_title.dart';

class AllJobListAdmin extends StatefulWidget {
  const AllJobListAdmin({Key? key}) : super(key: key);

  @override
  State<AllJobListAdmin> createState() => _AllJobListAdminState();
}

class _AllJobListAdminState extends State<AllJobListAdmin> {
  List<GetJobList> jobList = [];
  String nextUrl = "";
  String prevUrl = "";
  String priorityFilter="";
  String statusFilter="";
  String reportingPersonFilter="";
  @override
  void initState() {
    context.read<TaskBloc>().add(const GetAllJobsListEvent('', '', '',false,"",'',''));
    context.read<JobBloc>().add(GetReportingPersonListEvent());
    super.initState();
  }
  bool isExpanded=false;
  int ?select;
  int ?alreadySelect;

  void onselect(index){
    setState(() {
      select=index;
    });

  }
  List<bool> open=[];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  int tappedTile = 0;
  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }
  onRefreash(){
    setState(() {

    });
  }
  List<GetEmployeeList> employee = [];
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: ()async{
        context.read<TaskBloc>().add(const GetAllJobsListEvent('', '', '',false,'','',''));
        // context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      key: _refreshIndicatorKey,
      color: ColorPalette.primary,
      // backgroundColor: Colors.transparent,

      strokeWidth: 2.0,
      child:     BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state is GetReportingPersonListLoading) {
            // customCupertinoLoading();
          }
          if (state is GetReportingPersonListSuccess) {
            employee = state.employeeList;

            print("sucsess${state.employeeList}");
            setState(() {});
          }
        },
  child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "All Job List",
            isAction: false,
            onTap: () {},
          ),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(child:
          // jobList.isEmpty? Container(
          //   padding: EdgeInsets.only(top: 10),
          //   alignment: Alignment.center,
          //   height: h/2,
          //   child: SvgPicture.string(TaskSvg().nolistSvg,height: h/4.5,),
          // ):
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is GetAllJobsListLoading) {
                return LottieLoader();
              }
              if (state is GetAllJobsListSuccess) {
                jobList = state.taskList ?? [];

                print("hereeee open $open");
                nextUrl = state.nextPageUrl ?? "";
                prevUrl = state.prevPageUrl ?? "";
                return jobList.isEmpty?Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  height: h / 2,
                  child: SvgPicture.string(
                    TaskSvg().nolistSvg,
                    height: h / 4.5,
                  ),
                ):Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total ${jobList.length} Jobs",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _showModalBottomAdditionalRole(priorityFilter,statusFilter,reportingPersonFilter);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Color(0xff086DB5).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Filter",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.primary,
                                        fontSize: w / 28,
                                        // fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    SvgPicture.string(TaskSvg().filterSvg),
                                  ],
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //
                            //     Container(
                            //         width: 37,
                            //         height: 37,
                            //         padding: EdgeInsets.all(8),
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(5),
                            //           border: Border.all(
                            //             color: Color(0xffe6ecf0), width: 1,),
                            //           boxShadow: const [
                            //             BoxShadow(
                            //               color: Color(0x05000000),
                            //               blurRadius: 8,
                            //               offset: Offset(1, 1),
                            //             ),
                            //           ],
                            //           color: Colors.white,
                            //         ),
                            //         child: SvgPicture.string(TaskSvg().moreTaskIcon))
                            //   ],
                            // ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        //color: Colors.yellow,
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            separatorBuilder: (BuildContext cxt, int i) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {

                                  context.read<TaskBloc>().add(GetTaskListEvent(jobList[i].id,'','','',false,'',''));
                                  context.read<JobBloc>().add(GetJobReadListEvent(jobList[i].id??0));
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: JobTitle(isMyJob: true,isAllJob: true),
                                    withNavBar: false,
                                    pageTransitionAnimation: PageTransitionAnimation.slideUp,
                                  );
                                },
                                child:
                                CardExpaned(
                                  assignedMe: jobList[i],
                                  isExpanded: select==i,
                                  onTap: (){



                                    onselect(i);

                                    setState(() {

                                    });
// open[i]=false;
                                  },
                                ),

                              );
                            },
                            itemCount: jobList.length),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            prevUrl != ""
                                ? GestureDetector(
                              onTap: () {
                                context.read<JobBloc>().add(
                                    GetAssignedMeListEvent('', '', prevUrl));
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
                                  context.read<JobBloc>().add(
                                      GetAssignedMeListEvent(
                                          '', nextUrl, ""));
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
                  ),
                );
              }
              return Container();
            },
          )),
        ),
      ),
),
    );
  }
  _showModalBottomAdditionalRole(String? type,String? statusType,String empCode) {
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
                                                width:w,
                                                child: GridView.builder(
                                                    shrinkWrap: true,
                                                    // scrollDirection: Axis.horizontal,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        childAspectRatio: 4,
                                                        crossAxisCount: 2,
                                                        mainAxisSpacing: 10,
                                                        crossAxisSpacing: 10),
                                                    itemBuilder: (BuildContext context, int i) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          changeTappedTile(i);


                                                          statusFilter=status[i];
                                                          onRefreash();
                                                          // Navigator.pop(context);
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 16, vertical: 10),
                                                          color: statusType ==
                                                              status[i]
                                                              ? ColorPalette.cardBackground
                                                              : ColorPalette.white,
                                                          child: Row(
                                                            children: [
                                                              statusType == status[i]
                                                                  ? SvgPicture.string(
                                                                HomeSvg()
                                                                    .radioButtonActive,
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
                                          SizedBox(height: 5,),
                                          Divider(height: 2,indent: 10,color: Colors.grey,),
                                          SizedBox(height: 5,),
                                          Text(
                                            "Reporting Person",
                                            style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: w / 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: w,
                                            // height: h / 2.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              // border: Border.all(
                                              //   color: Color(0xffe6ecf0),
                                              //   width: 1,
                                              // ),
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
                                                    InkWell(
                                                      onTap: () {
                                                        reportingPersonFilter=employee[index].userCode??"";
                                                        print("code user$reportingPersonFilter");
                                                        setState((){});
                                                      },
                                                      child:
                                                        Row(
                                                          children: [
                                                            empCode == employee[index].code
                                                                ? SvgPicture.string(
                                                              HomeSvg()
                                                                  .radioButtonActive,
                                                            )
                                                                : SvgPicture.string(
                                                                CreateSvg()
                                                                    .radioInActiveButton),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              employee[index].fname ??
                                                                  "",
                                                              style: GoogleFonts.roboto(
                                                                color: Colors.black,
                                                                fontSize: w / 24,
                                                                // fontWeight: FontWeight.w500,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      // CustomCheckBox(
                                                      //   key: UniqueKey(),
                                                      //   value: true,
                                                      //   // passNameList.contains(roleList[index].role),
                                                      //   onChange: (p0) {
                                                      //     if (p0) {
                                                      //       // passIdList.add(roleList[index].id ?? 0);
                                                      //       // passNameList.add(roleList[index].role??"");
                                                      //
                                                      //     } else {
                                                      //       // passIdList.remove(
                                                      //       //     roleList[index].id ?? 0);
                                                      //       // passNameList.remove(roleList[index].role??"");
                                                      //
                                                      //
                                                      //     }
                                                      //     // print("fsd$passNameList");
                                                      //     // refresh();
                                                      //   },
                                                      //   text: employee[index].fname??"",
                                                      //   widget: TextAvatar(
                                                      //     shape: Shape.Circular,
                                                      //     size: 35,
                                                      //     numberLetters: 2,
                                                      //     fontSize: w/22,
                                                      //     textColor: Colors.white,
                                                      //     fontWeight: FontWeight.w500,
                                                      //     text:employee[index].fname ,
                                                      //   ),
                                                      //   isWidget: true,
                                                      //
                                                      //
                                                      // ),
                                                    ),
                                                separatorBuilder:
                                                    (context, index) => SizedBox(height: 5,),
                                                itemCount:
                                                employee.length),
                                          ),
                                          SizedBox(height: 15,),
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
                                            width: w,
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


                                                        priorityFilter=priority[index];
                                                        onRefreash();
                                                        // Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 16, vertical: 5),
                                                        color: type ==
                                                            priority[index]
                                                            ? ColorPalette.cardBackground
                                                            : ColorPalette.white,
                                                        child: Row(
                                                          children: [
                                                            type == priority[index]
                                                                ? SvgPicture.string(
                                                              HomeSvg()
                                                                  .radioButtonActive,
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
                                                                fontSize: w / 24,
                                                                // fontWeight: FontWeight.w500,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                separatorBuilder:
                                                    (context, index) => SizedBox(height: 5,),
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
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              context.read<TaskBloc>().add( GetAllJobsListEvent('', '', '',true,statusFilter,priorityFilter,reportingPersonFilter));
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
                              "Done",
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
}


class CardExpaned extends StatefulWidget {
  final GetJobList? assignedMe;
  final bool? isExpanded;

  final VoidCallback? onTap;
  const CardExpaned({super.key, this.assignedMe, this.isExpanded, this.onTap});

  @override
  State<CardExpaned> createState() => _CardExpanedState();
}

class _CardExpanedState extends State<CardExpaned> {
  String endstdDate='';
  String startstdDate='';
  String startTime="Select Time";
  String startTime2="00:00";
  String endTime="Select Time";
  String endTime2="00:00";
  @override
  Widget build(BuildContext context) {
    // print("sta${widget.assignedMe?.startDate}");
    print("sta${widget.isExpanded}");


    var date = widget.assignedMe?.endDate;
    var date2 = widget.assignedMe?.startDate;
    var dateTime = DateTime.parse("$date");
    var dateTime2 = DateTime.parse("$date2");
    endstdDate =
        DateFormat('dd-MM-yyyy').format(dateTime).toString();
    startstdDate =
        DateFormat('dd-MM-yyyy').format(dateTime2).toString();

    startTime=widget.assignedMe?.startDate?.split("T")[1].split("+")[0]??"";
    endTime=widget.assignedMe?.endDate?.split("T")[1].split("+")[0]??"";
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
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Container(
      width: w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0x4ca9a8a8),
          width: 1,
        ),
        color: const Color(0xfff8f7f5),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: w/1.4,
                          child: Text(
                            widget.assignedMe?.name??"",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              fontSize: w/22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // GestureDetector(
                        //   onTap: widget.onTap,
                        //     child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.assignedMe?.description??"",
                      style:  TextStyle(
                        color: Colors.black,
                        fontSize: w/26,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ]),
            ),
            Divider(
              color: const Color(0xffA9A8A8).withOpacity(0.3),
              height: 2,
            ),

            Container(
                padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.string(
                          TaskSvg().priorityIcon,
                          // height: 20,width: 20,
                          color: widget.assignedMe?.priority=="Low"?Color(0xff50D166):
                          widget.assignedMe?.priority=="Medium"?Color(0xffF18F1C):
                          null,
                        ),
                        SizedBox(width: 5,),
                        Text("${widget.assignedMe?.priority} Priority"??"",style: TextStyle(fontSize: w/24,fontWeight: FontWeight.w500),),

                      ],
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Text("View Details"??"",style: TextStyle(fontSize: w/26,
                            color: widget.isExpanded==true?
                            Color(0xffC6C6C6):ColorPalette.primary),)),

                  ],
                )),
            widget.isExpanded==true?Column(
              children: [
                Divider(
                  height: 2,
                  color: const Color(0xffA9A8A8).withOpacity(0.3),
                ),
                Container(
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(children: [
                        Container(
                          width: w/3.5,
                          child: const Text(
                            "Start On",
                            style: TextStyle(
                              color: Color(0xff6d6d6d),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          width: 16,
                          child: const Text(":",
                            style: TextStyle(
                              color: Color(0xff6d6d6d),
                              fontSize: 15,
                            ),),
                        ),
                        Text(
                          "${startstdDate}  ${startTime}" ,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],),
                      const SizedBox(height: 5,),
                      Row(children: [
                        Container(
                          width: w/3.5,
                          child: const Text(
                            "Due On",
                            style: TextStyle(
                              color: Color(0xff6d6d6d),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          width: 16,
                          child: const Text(":",
                            style: TextStyle(
                              color: Color(0xff6d6d6d),
                              fontSize: 15,
                            ),),
                        ),
                        Text(
                          "$endstdDate  $endTime",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 15,

                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],),




                    ],
                  ),
                ),

              ],
            ):Container(),
          ]),
    );
  }
}
