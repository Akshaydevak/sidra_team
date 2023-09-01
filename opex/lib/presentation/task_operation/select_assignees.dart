import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common_widgets/loading.dart';
import 'create/create_svg.dart';
import 'employee_model/employee_model.dart';
import 'group_list.dart';

class SelectAssignees extends StatefulWidget {
  final Function(bool val)? groupVal;

  const SelectAssignees({Key? key, this.groupVal}) : super(key: key);

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
      indValue = pref.getInt('index') ?? 0;
      grpValue = pref.getInt('index2') ?? 0;

      print("INX$indValue");
    });
  }

  @override
  void initState() {
    getData();
    context.read<JobBloc>().add(const GetEmployeeListEvent());
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            if (state is GetEmployeeListLoading) {
              customCupertinoLoading();
            }
            if (state is GetEmployeeListSuccess) {
              employeeList = state.employeeList;
              setState(() {});
            }
          },
        ),
        BlocListener<JobBloc, JobState>(
          listener: (context, state) {
            if (state is GetGroupListLoading) {
              customCupertinoLoading();
            }
            if (state is GetGroupListSuccess) {
              grouplist = state.groupList;
              setState(() {});
            }
          },
        ),
      ],
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
                  Text(
                    "Task Assign To",
                    style: GoogleFonts.roboto(
                      color: Color(0xff151522),
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Variable.isselected = !Variable.isselected;
                            context
                                .read<JobBloc>()
                                .add(GetEmployeeListEvent());
                          });
                        },
                        child: Container(
                          width: w / 2.5,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: Variable.isselected == true
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                            children: [
                              GestureDetector(
                                onTap: () {

                                },
                                child: Variable.isselected == true
                                    ? SvgPicture.string(
                                        HomeSvg().radioButtonActive)
                                    : SvgPicture.string(
                                        HomeSvg().radioButtonInActive),
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
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            Variable.isselected = !Variable.isselected;
                            context
                                .read<JobBloc>()
                                .add(GetGroupListEvent());

                            groupActived = true;
                          });
                        },
                        child: Container(
                          width: w / 2.5,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                                onTap: () {

                                },
                                child: Variable.isselected == false
                                    ? SvgPicture.string(
                                        HomeSvg().radioButtonActive)
                                    : SvgPicture.string(
                                        HomeSvg().radioButtonInActive),
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
                  Text(
                    "Select from List",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Variable.isselected
                      ? Container(
                          width: w,
                          // // height: 577,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          //   border: Border.all(
                          //     color: Color(0xffe6ecf0), width: 1,),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Color(0x05000000),
                          //       blurRadius: 8,
                          //       offset: Offset(1, 1),
                          //     ),
                          //   ],
                          //   color: Colors.white,
                          // ),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 30),
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setInt('index', index!);
                                      setState(() {
                                        groupActived = false;
                                        indValue = index;
                                        grpValue;

                                        Variable.assignType = "Individual";
                                        Variable.assignName =
                                            employeeList[index].fname ?? "";
                                        Variable.assignCode =
                                            employeeList[index].code ?? "";
                                      });
                                      widget.groupVal!(groupActived);
                                      print("grpVal$groupActived");
                                      print("grpVal${Variable.assignType}");
                                      print("grpVal${Variable.assignCode}");
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: index == indValue
                                              ? ColorPalette.primary
                                              : Color(0xffe6ecf0),
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: index,
                                              groupValue: indValue,
                                              activeColor: ColorPalette.primary,
                                              onChanged: (int? value) async {
                                                final SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setInt('index', value!);
                                                setState(() {
                                                  groupActived = false;
                                                  indValue = value;
                                                  grpValue;

                                                  Variable.assignType =
                                                      "Individual";
                                                  Variable.assignCode =
                                                      employeeList[index]
                                                              .code ??
                                                          "";
                                                });
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                employeeList[index].profile !=
                                                        ""
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            ColorPalette
                                                                .inactiveGrey,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                employeeList[
                                                                            index]
                                                                        .profile ??
                                                                    ""),
                                                      )
                                                    : TextAvatar(
                                                        textColor: Colors.white,
                                                        shape: Shape.Circular,
                                                        text:
                                                            "${employeeList[index].fname![0].toUpperCase()} ",
                                                        numberLetters: 2,
                                                      ),
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      employeeList[index]
                                                              .fname ??
                                                          "",
                                                      style: TextStyle(
                                                        color:
                                                            ColorPalette.black,
                                                        fontSize: w / 22,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      width: w / 1.8,
                                                      child: Text(
                                                        employeeList[index]
                                                                .primaryMail ??
                                                            "",
                                                        style: TextStyle(
                                                          color: ColorPalette
                                                              .black,
                                                          fontSize: w / 24,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
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
                              itemCount: employeeList.length),
                        )
                      : Container(
                          width: w,
                          // height: 577,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          //   border: Border.all(
                          //     color: Color(0xffe6ecf0),
                          //     width: 1,
                          //   ),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Color(0x05000000),
                          //       blurRadius: 8,
                          //       offset: Offset(1, 1),
                          //     ),
                          //   ],
                          //   color: Colors.white,
                          // ),
                          child: Container(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          grpValue = index!;
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
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: index == grpValue
                                                ? ColorPalette.primary
                                                : Color(0xffe6ecf0),
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                value: index,
                                                activeColor:
                                                    ColorPalette.primary,
                                                groupValue: grpValue,
                                                onChanged: (int? value) async {
                                                  setState(() {
                                                    grpValue = value!;
                                                    Variable.assignType =
                                                        "Task_Group";
                                                    Variable.assignCode =
                                                        grouplist[index]
                                                                .groupCode ??
                                                            "";
                                                    Variable.groupId =
                                                        grouplist[index].id ??
                                                            0;
                                                    groupActived = true;
                                                    indValue = 0;
                                                    print(
                                                        "GRRR${Variable.assignType}");
                                                  });
                                                  final SharedPreferences
                                                      prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  prefs.setInt('groupId',
                                                      grouplist[index].id ?? 0);
                                                  prefs.setInt(
                                                      'index2', value!);
                                                  setState(() {});
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  TextAvatar(
                                                    textColor: Colors.white,
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
                                                  Text(
                                                    grouplist[index].gName ??
                                                        "",
                                                    style: TextStyle(
                                                      color: ColorPalette.black,
                                                      fontSize: w / 22,
                                                    ),
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
                          ),
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
    );
  }
}

class AssignesUnderGroup extends StatefulWidget {
  const AssignesUnderGroup({Key? key}) : super(key: key);

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
    context.read<JobBloc>().add(const GetUserUderGroupEvent());
    grouid();
    super.initState();
  }

  GetUserList? userList;

  @override
  Widget build(BuildContext context) {
    print("GroupID$groupId");
    // print("GroupID${Variable.groupId}");
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
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
              // Container(
              //   width: w,
              //   // height: 120,
              //   // padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(
              //       color: Color(0xffe6ecf0),
              //       width: 1,
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color(0x05000000),
              //         blurRadius: 8,
              //         offset: Offset(1, 1),
              //       ),
              //     ],
              //     color: Colors.white,
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // Container(
              //       //   padding: EdgeInsets.only(
              //       //       left: 16, right: 16, top: 20, bottom: 10),
              //       //   child: Row(
              //       //     children: [
              //       //       Container(
              //       //         width: 32,
              //       //         height: 32,
              //       //         decoration: BoxDecoration(
              //       //           borderRadius: BorderRadius.circular(5),
              //       //           color: Color(0xff1ECAC0),
              //       //         ),
              //       //         child: Center(
              //       //           child:
              //       //           SvgPicture.string(CreateSvg().calenderIcon),
              //       //         ),
              //       //       ),
              //       //       SizedBox(
              //       //         width: 10,
              //       //       ),
              //       //       Text(
              //       //         "Invite from device contacts",
              //       //         style: TextStyle(
              //       //           color: Color(0xff151522),
              //       //           fontSize: 18,
              //       //         ),
              //       //       )
              //       //     ],
              //       //   ),
              //       // ),
              //       // Divider(
              //       //   indent: 50,
              //       //   color: Color(0xffE6ECF0),
              //       // ),
              //       // Container(
              //       //   padding: EdgeInsets.only(
              //       //       left: 16, right: 16, top: 10, bottom: 20),
              //       //   child: Row(
              //       //     children: [
              //       //       Container(
              //       //         width: 32,
              //       //         height: 32,
              //       //         decoration: BoxDecoration(
              //       //           borderRadius: BorderRadius.circular(5),
              //       //           color: Color(0xffFC3B98),
              //       //         ),
              //       //         child: Center(
              //       //           child: SvgPicture.string(CreateSvg().clockIcon),
              //       //         ),
              //       //       ),
              //       //       SizedBox(
              //       //         width: 10,
              //       //       ),
              //       //       Text(
              //       //         "Invite from device contacts",
              //       //         style: TextStyle(
              //       //           color: Color(0xff151522),
              //       //           fontSize: 18,
              //       //         ),
              //       //       )
              //       //     ],
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // Text(
              //   "Task Assign To",
              //   style: GoogleFonts.roboto(
              //     color: Color(0xff151522),
              //     fontSize: 18,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              Text(
                "Select from List",
                style: GoogleFonts.roboto(
                  color: Color(0xff151522),
                  fontSize: w / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<JobBloc, JobState>(
                builder: (context, state) {
                  if (state is GetUserUderGroupLoading) {
                    customCupertinoLoading();
                  }
                  if (state is GetUserUderGroupSuccess) {
                    return Container(
                      width: w,
                      // height: 577,
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
                        color: Color(0xffd3d3d3).withOpacity(0.2),
                      ),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    indValue = index;
                                    Variable.assignType = "Individual";
                                    // Variable.assignName = state.userlist[index].code??"";
                                    Variable.assignCode =
                                        state.userlist[index].code ?? "";

                                    Navigator.pop(context);
                                  });
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: index,
                                          groupValue: indValue,
                                          activeColor: ColorPalette.primary,
                                          onChanged: (int? value) {
                                            setState(() {
                                              indValue = value!;
                                              Variable.assignType =
                                                  "Individual";
                                              Variable.assignCode =
                                                  state.userlist[index].code ??
                                                      "";
                                            });
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Image.asset("asset/newprofile.png",
                                                width: 35, height: 35),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: w / 1.7,
                                              child: Text(
                                                state.userlist[index].email ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xff151522),
                                                  fontSize: w / 24,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 2,
                            );
                          },
                          itemCount: state.userlist.length),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
