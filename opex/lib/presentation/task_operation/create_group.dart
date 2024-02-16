import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../common_widgets/gradient_button.dart';
import '../../../../common_widgets/loading.dart';

import '../../core/color_palatte.dart';
import '../authentication/authentication.dart';
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
  void chaneTable(List<String> val,List<GetUserList> update,bool changeVal){
    // userList?.clear();
    newTable=val;
    userList=update;
    isChange=changeVal;
    validationCheck();
    setState((){});

  }
  @override
  void initState() {

    context.read<JobBloc>().add(const GetEmployeeListEvent('','',''));
    super.initState();
  }
  bool isChange=false;
  FocusNode focusNode=FocusNode();
  FocusNode descriptionfocusNode=FocusNode();
  bool? isValid=false;
  validationCheck(){
    if(groupName.text!=""&&discription.text!=""&&isChange==true){
      isValid=true;
    }
    else{
      isValid=false;
    }
  }

  GetTaskGroupList? taskgroup;
  final TextEditingController groupName = TextEditingController();
  final TextEditingController discription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("uuu$newTable");
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(label: "Create Group",
          isAction: false),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: MultiBlocListener(
  listeners: [
    BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {

              if (state is CreateGroupFailed) {
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is CreateGroupSuccess) {
                // taskgroup = state.group;

                Fluttertoast.showToast(
                    msg: 'Successfully Created Group',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                Navigator.pop(context);
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
  child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w1,
              // height: 185,
              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style:GoogleFonts.roboto(
                        fontWeight: FontWeight.w600
                    ) ,
                    onChanged: (n){
                      validationCheck();
                      setState(() {

                      });
                    },
                    focusNode: focusNode,
                    decoration:  InputDecoration(
                      contentPadding: EdgeInsets.only(left:16,right: 16 ),
                      hintText: "Group Name",
                      hintStyle: TextStyle(
                        color: Color(0x66151522),
                        fontSize: w/26,
                      ),
                      border: InputBorder.none,

                    ),
                    controller: groupName,

                    maxLines: 1,
                  ),

                  Container(
                    margin: EdgeInsets.only(left:16),
                    width: w1,
                    height: 1.50,
                    color: ColorPalette.divider,
                  ),

                  TextFormField(
                    style:GoogleFonts.roboto(
                        fontWeight: FontWeight.w600
                    ) ,
                    controller: discription,
                    maxLines: 4,
                    minLines: 1,
                    onChanged: (n){
                      validationCheck();
                      setState(() {

                      });
                    },
                    focusNode: descriptionfocusNode,
                    decoration:  InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16,top: 10,right: 16,bottom: 16),
                      hintText: "Group Description",
                      hintStyle: TextStyle(
                        color: Color(0x66151522),
                        fontSize: w/26,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Group name & description are mandatory",
              style: GoogleFonts.roboto(fontSize: w/30),),
            ),
            SizedBox(height: 10,),
          SizedBox(
            height: h / 1.6,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    BlocBuilder<JobBloc, JobState>(
                      builder: (context, state) {
                        if (state is GetEmployeeListLoading) {
                          return  LottieLoader();
                        }
                        if (state is GetEmployeeListSuccess) {
                          for (int i = 0;
                          i <
                              state
                                  .assignMeList!
                                  .length;) {
                            // print();
                            if (authentication
                                .authenticatedUser
                                .code ==
                                state
                                    .assignMeList?[
                                i]
                                    .userCode) {
                              state.assignMeList
                                  ?.removeAt(i);
                            }
                            i++;
                          }

                          print("Success shifu");

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  "Select from List (${userCodeList.length})",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff151522),
                                    fontSize: w/24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: w1,
                                  child: ListView.separated(
                                      primary: true,
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GroupList(
                                            userUpdateList: userList??[],
                                            userList: userCodeList,
                                            readUser:userCodeList!=null && userCodeList.isNotEmpty? userCodeList.contains(state.assignMeList?[index].userCode):false,

                                              listuser: chaneTable,
                                              employeeList: state
                                                  .assignMeList?[index]),
                                      separatorBuilder:
                                          (context, index) => Container(),
                                      itemCount:
                                      state.assignMeList!.length),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),

                    SizedBox(height: h/10,)
                  ],
                ),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: isValid==true?GradientButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
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
                      ColorPalette.primary,
                      ColorPalette.primary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color:  ColorPalette.primary,
                  child: Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )):
              GradientButton(
                  onPressed: () {
                  },
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffD3D3D3),
                      Color(0xffD3D3D3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: const Color(0xffD3D3D3),
                  child: Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
        ])

),
        ));
  }
}
