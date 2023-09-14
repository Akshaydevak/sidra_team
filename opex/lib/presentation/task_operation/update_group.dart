import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
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

import '../../common_widgets/custom_checkbox.dart';
import '../../common_widgets/no_glow.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'employee_group_screen.dart';
import 'group_list.dart';

class UpdateGroup extends StatefulWidget {
  final bool edit;
  const UpdateGroup({Key? key,  this.edit=false}) : super(key: key);

  @override
  State<UpdateGroup> createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
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
    newTable.clear();
    newTable=val;
    userList=update;
    isChange=changeVal;
    for(int i=0;i<userList!.length;i++){
      print("GGG${userList?[i].isActive}");
      print("GGG${userList?[i].userCode}");
    }
    validationCheck();
    setState((){});

  }
  @override
  void initState() {

    context.read<JobBloc>().add(const GetEmployeeListEvent('','',''));
    super.initState();
  }

  GetTaskGroupList? taskgroup;
  final TextEditingController groupName = TextEditingController();
  final TextEditingController discription = TextEditingController();
  List<String> emailList=[];
  FocusNode focusNode=FocusNode();
  FocusNode descriptionfocusNode=FocusNode();
  bool? isValid=false;
  bool? isChange=false;
  validationCheck(){
    if(groupName.text!=""&&discription.text!=""||isChange==true){
      isValid=true;
    }
    else{
      isValid=false;
    }
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async {
        context.read<JobBloc>().add(GetGroupListEvent());

        return true;
      },

      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: BackAppBar(label: readGroup?.gName??"",
                onTap: (){
                  context.read<JobBloc>().add(GetGroupListEvent());
                  Navigator.pop(context);
                },
                isBack: false,
                isAction: false),
          ),
          body: MultiBlocListener(
              listeners: [
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
                        emailList.add(state.getGroupRead?.userList?[i].email??"");
                        userCodeList.add(state.getGroupRead.userList?[i].code??"");
                        userList?.add(
                            GetUserList(
                                userCode: state.getGroupRead.userList?[i].code??"",
                                isActive: true));

                      }
                      print("LLLL$emailList");
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
                          msg: 'Successfully Updated Group',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.white,
                          textColor: Colors.black);
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
              child:  SingleChildScrollView(
                child: Column(
                    children: [
                      Container(
                        width: w,
                        // height: 185,
                        margin: EdgeInsets.all(16),
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
                              width: w,
                              height: 1.50,
                              color: ColorPalette.divider,
                            ),

                            TextFormField(
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
                      SizedBox(
                        height: h / 1.6,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(
                                  height: 16,
                                ),
                                Row(crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Users List",
                                      style: GoogleFonts.roboto(
                                        color: Color(0xff151522),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    authentication.isAssociateAdmin?Container(): InkWell(
                                      onTap: (){
                                        _showModalBottomAdditionalRole();
                                      },
                                      child: Text(
                                        "Add or Remove",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.primary,
                                          fontSize: w/26,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x05000000),
                                                  blurRadius: 8,
                                                  offset: Offset(1, 1),
                                                ),
                                              ],
                                              color: Color(0x19ff9900),
                                            ),
                                            child: Text(emailList[index])),
                                    separatorBuilder:
                                        (context, index) => Container(
                                          height: 5,
                                        ),
                                    itemCount:emailList.length),
                                SizedBox(height: h/30,),
                                // GradientButton(
                                //     onPressed: () {
                                //       _showModalBottomAdditionalRole();
                                //     },
                                //     gradient: const LinearGradient(
                                //       colors: [
                                //         Color(0xfffe5762),
                                //         Color(0xfffe5762),
                                //       ],
                                //       begin: Alignment.topCenter,
                                //       end: Alignment.bottomCenter,
                                //     ),
                                //     color: const Color(0xfffe5762),
                                //     child: Text(
                                //       "Add Or Remove",
                                //       textAlign: TextAlign.center,
                                //       style: GoogleFonts.roboto(
                                //         color: Colors.white,
                                //         fontSize: 18,
                                //         fontWeight: FontWeight.w600,
                                //       ),
                                //     )),
                                authentication.isAssociateAdmin?Container(): isValid==true?GradientButton(
                                    onPressed: () {

                                      BlocProvider.of<EmployeeBloc>(context).add(
                                          UpdateGroupEvent(
                                              groupName: groupName.text,
                                              discription: discription.text,
                                              userList: userList??[],
                                              isActive: true,
                                              id: readGroup?.id??0));
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
                                      "Update Group",
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
                                      "Update Group",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                SizedBox(height: h/10,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              )

          )),
    );
  }
  _showModalBottomAdditionalRole() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.3,
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
                          "Select From List",
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
                          height: h/1.7,
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
                                    BlocBuilder<JobBloc, JobState>(
                                      builder: (context, state) {
                                        if (state is GetEmployeeListLoading) {
                                          customCupertinoLoading();
                                        }
                                        if (state is GetEmployeeListSuccess) {

                                          print("Success shifu");

                                          return SingleChildScrollView(
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
                                                              readUser:userCodeList!=null && userCodeList.isNotEmpty? userCodeList.contains(state.assignMeList?[index].code):false,

                                                              listuser: chaneTable,
                                                              employeeList: state
                                                                  .assignMeList?[index]),
                                                      separatorBuilder:
                                                          (context, index) => Divider(),
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
                              // refresh();
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
                              "Update List",
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
