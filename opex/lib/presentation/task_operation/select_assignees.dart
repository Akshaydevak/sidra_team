import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_card.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common_widgets/loading.dart';
import '../../core/common_snackBar.dart';
import 'create/create_svg.dart';
import 'create/model/task_models.dart';
import 'create/single_row.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_model/employee_model.dart';
import 'group_list.dart';

class SelectAssignees extends StatefulWidget {
  final Function(bool val)? groupVal;
  final bool? updateAssign;
  final GetTaskList? taskRead;

  const SelectAssignees({Key? key, this.groupVal, this.updateAssign=false, this.taskRead}) : super(key: key);

  @override
  State<SelectAssignees> createState() => _SelectAssigneesState();
}

class _SelectAssigneesState extends State<SelectAssignees> {
  List<GetEmployeeList> employeeList = [];
  List<GetTaskGroupList> grouplist = [];
  int? grpValue;
  int? indValue;
  bool groupActived = false;

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      indValue = pref.getInt('index');
      grpValue = pref.getInt('index2');

      print("INX$indValue");
    });
  }


  @override
  void initState() {
    getData();
    Variable.typeAss=="IND"?context.read<JobBloc>().add(const GetEmployeeListEvent('','',''))
        :context.read<JobBloc>().add(GetGroupListEvent());;

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return   BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is UpdateTaskFailed) {
          // createButtonLoad = false;
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
          setState(() {});
        }
        if (state is UpdateTaskSuccess) {

          Fluttertoast.showToast(
              msg: 'Assignee Changed Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          Variable.assignType='';
          Variable.assignCode='';
          Variable.assignName='';

          context
              .read<TaskBloc>()
              .add(GetTaskReadListEvent(widget.taskRead?.id ?? 0));
          Navigator.pop(context);
        }
      },
  child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Select Assignees",
          isAction: false,
          isBack: false,
          onTap: () {
            widget.groupVal!(groupActived);
            print("grpVal$groupActived");
            print("grpVal${Variable.assignType}");
            print("grpVal${Variable.assignCode}");
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Variable.assignName = "";
                              Variable.assignCode = "";
                              Variable.assignType = "";
                              Variable.isselected = !Variable.isselected;
                              Variable.typeAss="IND";
                              context.read<JobBloc>().add(GetEmployeeListEvent('','',''));
                            });
                          },
                          child: Container(
                            width: w / 2.3,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            decoration: Variable.isselected == true
                                ? BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 8,
                                  offset: Offset(1, 1),
                                ),
                              ],
                              color: ColorPalette.cardBackground,
                            )
                                : BoxDecoration(
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
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Variable.isselected == true
                                      ? SvgPicture.string(
                                      HomeSvg().radioButtonActive)
                                      : SvgPicture.string(
                                      CreateSvg()
                                          .radioInActiveButton),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "To Individual",
                                  style: Variable.isselected == true
                                      ? GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 25,
                                    fontWeight: FontWeight.w500,
                                  )
                                      : GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 25,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Variable.assignName = "";
                              Variable.assignCode = "";
                              Variable.assignType = "";
                              Variable.isselected = !Variable.isselected;
                              Variable.typeAss="GRP";
                              context.read<JobBloc>().add(GetGroupListEvent());

                              groupActived = true;
                            });
                          },
                          child: Container(
                            width: w / 2.3,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Variable.isselected == false
                                  ? Border.all(color: Colors.white)
                                  : Border.all(
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
                              color: Variable.isselected == false
                                  ? ColorPalette.cardBackground
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Variable.isselected == false
                                      ? SvgPicture.string(
                                      HomeSvg().radioButtonActive)
                                      : SvgPicture.string(
                                      CreateSvg()
                                          .radioInActiveButton),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "To Group",
                                  style: Variable.isselected == false
                                      ? GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 25,
                                    fontWeight: FontWeight.w500,
                                  )
                                      : GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 25,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    Variable.isselected
                        ? Container(
                      width: w,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select from List",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              fontSize: w / 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // SearchCard(
                          //   hint: "Search Users...",
                          //   onchange: (dd){
                          //     context.read<JobBloc>().add( GetEmployeeListEvent(dd,'',''));
                          //   },
                          // ),
                          SizedBox(height: 10,),
                          BlocBuilder<JobBloc, JobState>(
                            builder: (context, state) {
                              if (state is GetEmployeeListLoading) {
                                return LottieLoader();
                              }
                              if (state is GetEmployeeListSuccess) {
                                employeeList = state.assignMeList??[];
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(bottom: 30),
                                    itemBuilder: (context, index) =>

                                    GestureDetector(
                                      onTap: ()async{
                                        HapticFeedback.heavyImpact();
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                            prefs.setInt('index', index);
                                            setState(() {
                                              groupActived = false;
                                              indValue = index;
                                              grpValue;

                                              Variable.assignType =
                                              "Individual";
                                              Variable.assignName =
                                                  employeeList[index].fname ??
                                                      "";
                                              Variable.assignCode =
                                                  employeeList[index].userCode ??
                                                      "";
                                            });
                                            widget.groupVal!(groupActived);
                                            if(widget.updateAssign==true){
                                              BlocProvider.of<TaskBloc>(context)
                                                  .add(UpdateTaskEvent(
                                                  durationOption: widget.taskRead?.duration??"",
                                                  latitude: widget.taskRead?.latitude,
                                                  longitude:
                                                  widget.taskRead?.longitude,
                                                  id: widget.taskRead?.id ?? 0,
                                                  AssigningCode:
                                                  Variable.assignCode,
                                                  AssigningType:
                                                  Variable.assignType,
                                                  createdOn: "${widget.taskRead?.createdOn?.split("T")[0]}"" ""${widget.taskRead?.createdOn?.split("T")[1].split("+")[0]}",
                                                  jobid: widget.taskRead?.jobId,
                                                  notas: widget.taskRead?.notes ??
                                                      "",
                                                  priorityLeval: 0,
                                                  remarks:
                                                  widget.taskRead?.remarks ??
                                                      "",
                                                  taskName:
                                                  widget.taskRead?.taskName ?? "",
                                                  taskType: widget.taskRead?.taskType??0,
                                                  lastmodified: null,
                                                  parant: widget.taskRead?.parent,
                                                  statusStagesId:
                                                  widget.taskRead?.statusStagesId,
                                                  discription:
                                                  widget.taskRead?.description ?? "",
                                                  createdBy: widget.taskRead?.createdPersonCode ??
                                                      "",
                                                  isActive: true,
                                                  priority: widget.taskRead?.priority??"",
                                                  reportingPerson: widget.taskRead
                                                      ?.reportingPersonCode ??
                                                      "",
                                                  endDate: "${widget.taskRead?.endDate?.split("T")[0]}",

                                                  startDate: "${widget.taskRead?.startDate?.split("T")[0]}",
                                                  endTime: "${widget.taskRead?.endDate?.split("T")[1].split("+")[0]}",
                                                  startTime: "${widget.taskRead?.startDate?.split("T")[1].split("+")[0]}",
                                                  img5: widget.taskRead
                                                      ?.metaData?.image5,
                                                  img1: widget.taskRead
                                                      ?.metaData?.image1,
                                                  img4: widget.taskRead
                                                      ?.metaData?.image4,
                                                  img2: widget.taskRead
                                                      ?.metaData?.image2,
                                                  img3: widget.taskRead
                                                      ?.metaData?.image3,
                                                  attachmentDescription:
                                                  widget.taskRead?.metaData
                                                      ?.description,
                                                  attachmentNote:
                                                  widget.taskRead?.metaData?.note));
                                            }
                                            else{
                                              Navigator.pop(context);
                                            }

                                      },
                                      child: EmployeeCard(
                                        isSelect: Variable.assignCode == employeeList[index].userCode,
                                        employeeList: employeeList[index],
                                      ),
                                    ),
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: 5,
                                      );
                                    },
                                    itemCount: employeeList.length);
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    )
                        : Container(
                      width: w,
                      child: Container(
                        child: BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            if(state is GetGroupListLoading){
                              return LottieLoader();
                            }
                            if(state is GetGroupListSuccess){
                              grouplist = state.groupList;
                              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select from List",
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: () async {
                                              HapticFeedback.heavyImpact();
                                              setState(() {
                                                grpValue = index;
                                                Variable.assignType = "Task_Group";
                                                Variable.assignName =
                                                    grouplist[index].gName ?? "";
                                                Variable.assignCode =
                                                    grouplist[index].groupCode ?? "";
                                                Variable.groupId =
                                                    grouplist[index].id ?? 0;
                                                groupActived = true;
                                                indValue = 0;
                                                print("GRRR${Variable.assignType}");
                                              });
                                              final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                              prefs.setInt('groupId',
                                                  grouplist[index].id ?? 0);
                                              prefs.setInt('index2', index);
                                              widget.groupVal!(groupActived);
                                              print("grpVal$groupActived");
                                              print("grpVal${Variable.assignType}");
                                              print("grpVal${Variable.assignCode}");
                                              if(widget.updateAssign==true){
                                                BlocProvider.of<TaskBloc>(context)
                                                    .add(UpdateTaskEvent(
                                                    durationOption: widget.taskRead?.duration??"",
                                                    latitude: widget.taskRead?.latitude,
                                                    longitude:
                                                    widget.taskRead?.longitude,
                                                    id: widget.taskRead?.id ?? 0,
                                                    AssigningCode:
                                                    Variable.assignCode,
                                                    AssigningType:
                                                    Variable.assignType,
                                                    createdOn: "${widget.taskRead?.createdOn?.split("T")[0]}"" ""${widget.taskRead?.createdOn?.split("T")[1].split("+")[0]}",
                                                    jobid: widget.taskRead?.jobId,
                                                    notas: widget.taskRead?.notes ??
                                                        "",
                                                    priorityLeval: 0,
                                                    remarks:
                                                    widget.taskRead?.remarks ??
                                                        "",
                                                    taskName:
                                                    widget.taskRead?.taskName ?? "",
                                                    taskType: widget.taskRead?.taskType??0,
                                                    lastmodified: null,
                                                    parant: widget.taskRead?.parent,
                                                    statusStagesId:
                                                    widget.taskRead?.statusStagesId,
                                                    discription:
                                                    widget.taskRead?.description ?? "",
                                                    createdBy: widget.taskRead?.createdPersonCode ??
                                                        "",
                                                    isActive: true,
                                                    priority: widget.taskRead?.priority??"",
                                                    reportingPerson: widget.taskRead
                                                        ?.reportingPersonCode ??
                                                        "",
                                                    endDate: "${widget.taskRead?.endDate?.split("T")[0]}",
                                                    startDate: "${widget.taskRead?.startDate?.split("T")[0]}",
                                                    endTime: "${widget.taskRead?.endDate?.split("T")[1].split("+")[0]}",
                                                    startTime: "${widget.taskRead?.startDate?.split("T")[1].split("+")[0]}",
                                                    img5: widget.taskRead
                                                        ?.metaData?.image5,
                                                    img1: widget.taskRead
                                                        ?.metaData?.image1,
                                                    img4: widget.taskRead
                                                        ?.metaData?.image4,
                                                    img2: widget.taskRead
                                                        ?.metaData?.image2,
                                                    img3: widget.taskRead
                                                        ?.metaData?.image3,
                                                    attachmentDescription:
                                                    widget.taskRead?.metaData
                                                        ?.description,
                                                    attachmentNote:
                                                    widget.taskRead?.metaData?.note));
                                              }
                                              else{
                                                Navigator.pop(context);
                                              }
                                              // Navigator.pop(context);
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                border: Border.all(color: grouplist[index].groupCode == Variable.assignCode?ColorPalette.primary:
                                                Color(0xffe6ecf0), width: 1, ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x05000000),
                                                    blurRadius: 8,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                                color: grouplist[index].groupCode == Variable.assignCode?
                                                ColorPalette.cardBackground:Colors.white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    // Radio(
                                                    //   value: index,
                                                    //   activeColor:
                                                    //   ColorPalette.primary,
                                                    //   groupValue: grpValue,
                                                    //   onChanged: (int? value) async {
                                                    //     setState(() {
                                                    //       grpValue = value!;
                                                    //       Variable.assignType =
                                                    //       "Task_Group";
                                                    //       Variable.assignCode =
                                                    //           grouplist[index]
                                                    //               .groupCode ??
                                                    //               "";
                                                    //       Variable.groupId =
                                                    //           grouplist[index].id ??
                                                    //               0;
                                                    //       groupActived = true;
                                                    //       indValue = 0;
                                                    //       print(
                                                    //           "GRRR${Variable.assignType}");
                                                    //     });
                                                    //     final SharedPreferences
                                                    //     prefs =
                                                    //     await SharedPreferences
                                                    //         .getInstance();
                                                    //     prefs.setInt('groupId',
                                                    //         grouplist[index].id ?? 0);
                                                    //     prefs.setInt(
                                                    //         'index2', value!);
                                                    //     setState(() {});
                                                    //   },
                                                    // ),
                                                    Row(
                                                      children: [
                                                        TextAvatar(
                                                          textColor: Colors.white,size: 40,
                                                          fontSize: w/22,
                                                          shape: Shape.Circular,

                                                          text:
                                                          "${grouplist[index].gName![0].toUpperCase()} ",
                                                          numberLetters: 2,
                                                        ),
                                                        // CircleAvatar(
                                                        //   child: Text(
                                                        //     grouplist[index].gName![0],
                                                        //     style: GoogleFonts.roboto(
                                                        //       color: Colors.white,
                                                        //       fontSize: 26,
                                                        //       fontWeight:
                                                        //           FontWeight.w500,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        SizedBox(
                                                          width: 14,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              grouplist[index].gName ??
                                                                  "",
                                                              style: TextStyle(
                                                                color: ColorPalette.black,
                                                                fontSize: w / 26,
                                                                fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.group,color: ColorPalette.primary,
                                                                  size: 20,),
                                                                SizedBox(width: 5,),
                                                                Text(
                                                                  "${grouplist[index].menberCount.toString()} Members" ??
                                                                      "",
                                                                  style: TextStyle(
                                                                    color: ColorPalette.black,
                                                                    fontSize: w / 28,
                                                                    // fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                    //
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 5,
                                        );
                                      },
                                      itemCount: grouplist.length),
                                ],
                              );
                            }
                            return Container();

                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                )
              ],
            ),
            
          ),
        ),
      ),
    ),
);
  }
}

class AssignesUnderGroup extends StatefulWidget {
  final Function(bool val)? groupVal;
  final int groupId;
  final bool? updateAssign;
  final GetTaskList? taskRead;
  const AssignesUnderGroup({Key? key, this.groupVal, required this.groupId, this.updateAssign=false, this.taskRead}) : super(key: key);

  @override
  State<AssignesUnderGroup> createState() => _AssignesUnderGroupState();
}

class _AssignesUnderGroupState extends State<AssignesUnderGroup> {
  int indValue = 0;
  int groupId = 0;

  grouid() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    groupId = sharedPreferences.getInt('groupId') ?? 0;
    setState(() {
      indValue = sharedPreferences.getInt('index') ?? 0;

      print("INX$indValue");
    });
  }

  @override
  void initState() {
    context.read<JobBloc>().add( GetUserUderGroupEvent());
    grouid();
    super.initState();
  }

  GetUserList? userList;

  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is UpdateTaskFailed) {
          // createButtonLoad = false;
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
          setState(() {});
        }
        if (state is UpdateTaskSuccess) {
          // createButtonLoad = false;
          print("task sucsess");

          Fluttertoast.showToast(
              msg: 'Assignee Changed Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          Variable.assignType='';
          Variable.assignCode='';
          Variable.assignName='';

          context
              .read<TaskBloc>()
              .add(GetTaskReadListEvent(widget.taskRead?.id ?? 0));
          Navigator.pop(context);
        }
      },
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Select Assignees",
          isAction: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Variable.assignName==""?Container():Container(
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
                        label: "Assigned Person",
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
                    GestureDetector(
                      onTap: () {

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
                                Variable.assignName ?? "",
                                style: TextStyle(
                                  color: ColorPalette.black,
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
              SizedBox(height: 15,),

              BlocBuilder<JobBloc, JobState>(
                builder: (context, state) {
                  if (state is GetUserUderGroupLoading) {
                    return LottieLoader();
                  }
                  if (state is GetUserUderGroupSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.updateAssign==true?Text(
                          "Re Assign To",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ):  Text(
                  "Assign To",
                  style: GoogleFonts.roboto(
                  color: ColorPalette.black,
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                  ),
                  ),

                        Container(
                          width: w,
                          // height: 577,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(
                            //   color: const Color(0xffe6ecf0),
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
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      if(Variable.assignName==""){
                                        setState(() {
                                          indValue = index;
                                          Variable.assignType = "Individual";
                                          Variable.assignName = state.userlist[index].fName??"";
                                          Variable.assignCode =
                                              state.userlist[index].code ?? "";
                                          print("ASSUNDER${state.userlist[index].fName}");
                                          widget.groupVal!(true);

                                          if(widget.updateAssign==true){
                                            BlocProvider.of<TaskBloc>(context)
                                                .add(UpdateTaskEvent(
                                                durationOption: widget.taskRead?.duration??"",
                                                latitude: widget.taskRead?.latitude,
                                                longitude:
                                                widget.taskRead?.longitude,
                                                id: widget.taskRead?.id ?? 0,
                                                AssigningCode:
                                                Variable.assignCode,
                                                AssigningType:
                                                Variable.assignType,
                                                createdOn: "${widget.taskRead?.createdOn?.split("T")[0]}"" ""${widget.taskRead?.createdOn?.split("T")[1].split("+")[0]}",
                                                jobid: widget.taskRead?.jobId,
                                                notas: widget.taskRead?.notes ??
                                                    "",
                                                priorityLeval: 0,
                                                remarks:
                                                widget.taskRead?.remarks ??
                                                    "",
                                                taskName:
                                                widget.taskRead?.taskName ?? "",
                                                taskType: widget.taskRead?.taskType??0,
                                                lastmodified: null,
                                                parant: widget.taskRead?.parent,
                                                statusStagesId:
                                                widget.taskRead?.statusStagesId,
                                                discription:
                                                widget.taskRead?.description ?? "",
                                                createdBy: widget.taskRead?.createdPersonCode ??
                                                    "",
                                                isActive: true,
                                                priority: widget.taskRead?.priority??"",
                                                reportingPerson: widget.taskRead
                                                    ?.reportingPersonCode ??
                                                    "",
                                                endDate: "${widget.taskRead?.endDate?.split("T")[0]}",
                                                startDate: "${widget.taskRead?.startDate?.split("T")[0]}",
                                                endTime: "${widget.taskRead?.endDate?.split("T")[1].split("+")[0]}",
                                                startTime: "${widget.taskRead?.startDate?.split("T")[1].split("+")[0]}",
                                                img5: widget.taskRead
                                                    ?.metaData?.image5,
                                                img1: widget.taskRead
                                                    ?.metaData?.image1,
                                                img4: widget.taskRead
                                                    ?.metaData?.image4,
                                                img2: widget.taskRead
                                                    ?.metaData?.image2,
                                                img3: widget.taskRead
                                                    ?.metaData?.image3,
                                                attachmentDescription:
                                                widget.taskRead?.metaData
                                                    ?.description,
                                                attachmentNote:
                                                widget.taskRead?.metaData?.note));
                                          }
                                          else{
                                            Navigator.pop(context);
                                          }
                                        });
                                      }
                                      else{
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
                                                    "Do you want to re-assign this task?",
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
                                                            setState(() {
                                                              indValue = index;
                                                              Variable.assignType = "Individual";
                                                              Variable.assignName = state.userlist[index].fName??"";
                                                              Variable.assignCode =
                                                                  state.userlist[index].code ?? "";
                                                              print("ASSUNDER${state.userlist[index].fName}");
                                                              widget.groupVal!(true);

                                                              if(widget.updateAssign==true){
                                                                BlocProvider.of<TaskBloc>(context)
                                                                    .add(UpdateTaskEvent(
                                                                    durationOption: widget.taskRead?.duration??"",
                                                                    latitude: widget.taskRead?.latitude,
                                                                    longitude:
                                                                    widget.taskRead?.longitude,
                                                                    id: widget.taskRead?.id ?? 0,
                                                                    AssigningCode:
                                                                    Variable.assignCode,
                                                                    AssigningType:
                                                                    Variable.assignType,
                                                                    createdOn: "${widget.taskRead?.createdOn?.split("T")[0]}"" ""${widget.taskRead?.createdOn?.split("T")[1].split("+")[0]}",
                                                                    jobid: widget.taskRead?.jobId,
                                                                    notas: widget.taskRead?.notes ??
                                                                        "",
                                                                    priorityLeval: 0,
                                                                    remarks:
                                                                    widget.taskRead?.remarks ??
                                                                        "",
                                                                    taskName:
                                                                    widget.taskRead?.taskName ?? "",
                                                                    taskType: widget.taskRead?.taskType??0,
                                                                    lastmodified: null,
                                                                    parant: widget.taskRead?.parent,
                                                                    statusStagesId:
                                                                    widget.taskRead?.statusStagesId,
                                                                    discription:
                                                                    widget.taskRead?.description ?? "",
                                                                    createdBy: widget.taskRead?.createdPersonCode ??
                                                                        "",
                                                                    isActive: true,
                                                                    priority: widget.taskRead?.priority??"",
                                                                    reportingPerson: widget.taskRead
                                                                        ?.reportingPersonCode ??
                                                                        "",
                                                                    endDate: "${widget.taskRead?.endDate?.split("T")[0]}",
                                                                    startDate: "${widget.taskRead?.startDate?.split("T")[0]}",
                                                                    endTime: "${widget.taskRead?.endDate?.split("T")[1].split("+")[0]}",
                                                                    startTime: "${widget.taskRead?.startDate?.split("T")[1].split("+")[0]}",
                                                                    img5: widget.taskRead
                                                                        ?.metaData?.image5,
                                                                    img1: widget.taskRead
                                                                        ?.metaData?.image1,
                                                                    img4: widget.taskRead
                                                                        ?.metaData?.image4,
                                                                    img2: widget.taskRead
                                                                        ?.metaData?.image2,
                                                                    img3: widget.taskRead
                                                                        ?.metaData?.image3,
                                                                    attachmentDescription:
                                                                    widget.taskRead?.metaData
                                                                        ?.description,
                                                                    attachmentNote:
                                                                    widget.taskRead?.metaData?.note));
                                                              }
                                                              else{
                                                                Navigator.pop(context);
                                                              }
                                                            });
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

                                    },
                                    child: EmployeeCardUnderGroup(
                                      userList: state.userlist[index],
                                    )
                                  ),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 2,
                                );
                              },
                              itemCount: state.userlist.length),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    ),
);
  }
}
