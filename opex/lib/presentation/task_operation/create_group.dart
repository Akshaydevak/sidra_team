import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../common_widgets/gradient_button.dart';
import '../../../../common_widgets/loading.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'employee_group_screen.dart';
import 'group_list.dart';

class CreateGroup extends StatefulWidget {
  final bool edit;
  const CreateGroup({Key? key,  this.edit=false}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  int isSelected = 0;
  bool select = false;
  void onSelect(int val) {
    isSelected = val;
    select = true;
    setState(() {});
  }
  List<String> userCodeList=[]  ;
  List<GetUserList>? userList=[];
  GetTaskGroupList? readGroup;
  List<String> newTable=[];
  void chaneTable(List<String> val,List<GetUserList> update){
    // userList?.clear();
    newTable=val;
    userList=update;
    setState((){});

  }
  @override
  void initState() {

    context.read<JobBloc>().add(const GetEmployeeListEvent());
    super.initState();
  }

  GetTaskGroupList? taskgroup;
  final TextEditingController groupName = TextEditingController();
  final TextEditingController discription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("uuu$newTable");
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(label: widget.edit==true?"Edit Group":"Create Group",
          isAction: false),
        ),
        body: SingleChildScrollView(
          child: MultiBlocListener(
  listeners: [
    BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if (state is CreateGroupLoading) {
                showSnackBar(context,
                    message: "Loading...",
                    color: Colors.white,
                    // icon: HomeSvg().SnackbarIcon,
                    autoDismiss: true);
              }

              if (state is CreateGroupFailed) {
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is CreateGroupSuccess) {
                taskgroup = state.group;

                Fluttertoast.showToast(
                    msg: 'Successfully Created Group',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: EmployeesGroupScreen(newIndex: 0),
                  withNavBar: true,
                  // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation:
                  PageTransitionAnimation.fade,
                );
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
          // print(":GPName4${state.getGroupRead.i}");
          groupName.text=state.getGroupRead.gName??"";
          discription.text=state.getGroupRead.description??"";
          // userList=state.getGroupRead.userList;

          for(var i=0;i<state.getGroupRead.userList!.length;i++){
            userCodeList.add(state.getGroupRead.userList?[i].code??"");
            userList?.add(
                GetUserList(
                    userCode: state.getGroupRead.userList?[i].code??"",
            isActive: state.getGroupRead.userList?[i].isActive??false));

          }
          setState(() {

          });
        }

      },
    ),
    BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is UpdateGroupLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is UpdateGroupFailed) {
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is UpdateGroupSuccess) {

          Fluttertoast.showToast(
              msg: 'Successfully Created Group',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: EmployeesGroupScreen(newIndex: 1),
            withNavBar: true,
            // OPTIONAL VALUE. True by default.
            pageTransitionAnimation:
            PageTransitionAnimation.fade,
          );
        }
      },
    ),
  ],
  child:  Column(
          children: [
          SizedBox(
            height: h / 1.25,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: w,
                      padding:
                      EdgeInsets.all(10),
                      // height: 117,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 16),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey,
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.edit,
                                          size: 18,
                                        )))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: w / 1.57,
                            // alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.yellow,
                                  width: w / 1.6,
                                  child: TextFormField(
                                    controller: groupName,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 0, top: 10),
                                        border: InputBorder.none,
                                        hintText: "Group Name"),
                                  ),
                                ),
                                Container(
                                  width: w / 1.57,
                                  height: 1,
                                  color: Color(0xffE6ECF0),
                                ),
                                Container(
                                  // color: Colors.yellow,
                                  width: w / 1.6,
                                  child: TextFormField(
                                    controller: discription,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 0, top: 10),
                                        border: InputBorder.none,
                                        hintText: "Group Description"),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Select from List",
                      style: GoogleFonts.roboto(
                        color: Color(0xff151522),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: w,
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: w / 1.5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(bottom: 0, top: 0),
                                  border: InputBorder.none,
                                  hintText: "Group Name"),
                            ),
                          ),
                          SvgPicture.string(
                            CartSvg().searchIcon,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    BlocBuilder<JobBloc, JobState>(
                      builder: (context, state) {
                        if (state is GetEmployeeListLoading) {
                          customCupertinoLoading();
                        }
                        if (state is GetEmployeeListSuccess) {

                          print("Success shifu");

                          return SingleChildScrollView(
                            child: Container(
                              // width: w,
                              // height: h / 2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: w,
                                    // height: h / 2.5,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
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
                                    child: ListView.separated(
                                        primary: true,
                                        shrinkWrap: true,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            GroupList(
                                              userUpdateList: userList??[],
                                              userList: userCodeList,
                                              readUser:userCodeList!=null && userCodeList.isNotEmpty? userCodeList.contains(state.employeeList[index].code):false,

                                                listuser: chaneTable,
                                                employeeList: state
                                                    .employeeList[index]),
                                        separatorBuilder:
                                            (context, index) => Divider(),
                                        itemCount:
                                        state.employeeList.length),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                        onPressed: () {
                          widget.edit?
                          BlocProvider.of<EmployeeBloc>(context).add(
                              UpdateGroupEvent(
                                  groupName: groupName.text,
                                  discription: discription.text,
                                  userList: userList??[],
                              isActive: true,
                              id: readGroup?.id??0)):
                          BlocProvider.of<EmployeeBloc>(context).add(
                              CreateGroupEvent(
                                  groupName: groupName.text,
                                  discription: discription.text,
                                  userlist: newTable));
                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfffe5762),
                            Color(0xfffe5762),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: const Color(0xfffe5762),
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ])

),
        ));
  }
}
