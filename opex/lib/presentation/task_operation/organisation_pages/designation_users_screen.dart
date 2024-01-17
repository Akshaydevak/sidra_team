import 'package:avatar_stack/avatar_stack.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/task_operation/employee_card.dart';
import 'package:cluster/presentation/task_operation/group_list.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../authentication/authentication.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../create/create_task_user.dart';
import '../employee_bloc/employee_bloc.dart';
import '../employee_model/employee_model.dart';
import '../home/bloc/job_bloc.dart';
import '../lottieLoader.dart';
import 'designation_list_organisation.dart';

class UsersListUnderDesignation extends StatefulWidget {
  const UsersListUnderDesignation({super.key});

  @override
  State<UsersListUnderDesignation> createState() => _UsersListUnderDesignationState();
}

class _UsersListUnderDesignationState extends State<UsersListUnderDesignation> {
  TextEditingController newpassword=TextEditingController();
  TextEditingController cofirempassword=TextEditingController();
  @override
  void initState() {
    context.read<JobBloc>().add( GetEmployeeListEvent('','',''));
    super.initState();
  }
  onRefresh(){
    setState(() {

    });
  }
  List<String> userCodeList=[]  ;
  List<GetUserList>? userList=[];
  GetTaskGroupList? readGroup;
  List<String> newTable=[];
  void chaneTable(List<String> val,List<GetUserList> update,bool changeVal){
    // userList?.clear();
    newTable=val;
    userList=update;
    // isChange=changeVal;
    // validationCheck();
    setState((){});

  }
  GetEmployeeList? readEmployee;
  @override
  Widget build(BuildContext context) {

    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            print("state group$state");
            if(state is GetEmployeeReadLoading){

            }
            if(state is GetEmployeeReadSuccess){
              readEmployee = state.getEmployee;
              authentication.isAssociateAdmin||state.getEmployee?.role=="Admin"?Container():_showModalBottomAdditionalRole(readEmployee);
              setState(() {

              });
            }

          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if(state is DeleteEmployeeLoading){
              // showSnackBar(context,
              //     message: "User Dele Loading",
              //     color: ColorPalette.green);
            }
            if(state is DeleteEmployeeSuccess){
              showSnackBar(context,
                  message:"User Deleted Successfully",
                  color: ColorPalette.green);
              // Navigator.pop(context);
              context.read<JobBloc>().add( GetEmployeeListEvent('','',''));
            }
            if(state is DeleteEmployeeFailed){

              showSnackBar(context,
                  message: "Not Deleted",
                  color: ColorPalette.green);

            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if(state is UpdateEmployeeLoading){
              showSnackBar(context,
                  message: "User Updation Loading",
                  color: ColorPalette.green);
            }
            if(state is UpdateEmployeeSuccess){
              showSnackBar(context,
                  message:state.user,
                  color: ColorPalette.green);
              Navigator.pop(context);
              context.read<JobBloc>().add( GetEmployeeListEvent('','',''));
            }
            if(state is UpdateEmployeeFailed){

              showSnackBar(context,
                  message: state.error,
                  color: ColorPalette.green);

            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            // print(object)
            if(state is ChagePasswordLoading){

            }
            if(state is ChagePasswordSuccess){
              Navigator.pop(context);
              newpassword.clear();
              cofirempassword.clear();
              context.read<JobBloc>().add( GetEmployeeListEvent('','',''));
              showSnackBar(context, message: state.user??"", color: Colors.black);
              setState(() {

              });
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

                title: RichText(
                  text: TextSpan(
                    text: 'Users ',
                    style: GoogleFonts.roboto(
                      color: Colors.black,fontSize: w/22,
                      fontWeight: FontWeight.w500
                    ),
                    children: <TextSpan>[
                      userList!.isEmpty?TextSpan(
                  text: '',
                    style: TextStyle(
                        color: Colors.black,fontSize: w/22
                    ),
                  ):TextSpan(
                        text: '(${userList!.length} Selected)',
                        style: TextStyle(
                            color: Color(0xff108062),fontSize: w/26
                        ),
                      ),
                    ],
                  ),
                ),
                titleSpacing: 0,
                leading: GestureDetector(
                    onTap:() {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                // actions: [
                //   widget.isAction
                //       ? SvgPicture.string(
                //     HomeSvg().msgIcon,
                //     height: 25,
                //     width: 25,
                //   )
                //       : Container(),
                //   widget.isAction
                //       ? const SizedBox(
                //     width: 30,
                //   )
                //       : Container(),
                //   widget.isAction
                //       ? GestureDetector(
                //       onTap: () {
                //         // _showModalBottomSheet();
                //       },
                //       child: SvgPicture.string(
                //         HomeSvg().addIcon,
                //         height: 19,
                //         width: 19,
                //       ))
                //       : widget.action ?? Container(),
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
                width: w1,
                height: 1.50,
                decoration: const BoxDecoration(
                  color: Color(0xb2e6e6e6),
                ),
              ),
            ],
          )
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: w1/1.3,
                        child: SearchCard(
                          hint: "Search a user...",
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: ColorPalette.inactiveGrey),
                          color: Colors.white
                        ),
                        child: SvgPicture.string(TaskSvg().filter),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AvatarStack(
                      height: 35,width: 120,
                      avatars: [
                        for (var n = 0; n < 10; n++)
                          NetworkImage('https://lionsgate.brightspotcdn.com/1d/90/8fc75de5411e985f3a2def98358d/johnwick4-section-promo-double-home-03.jpg'),
                      ],
                    ),
                  ),

                  BlocBuilder<JobBloc, JobState>(
                    builder: (context, state) {
                      if (state is GetEmployeeListLoading) {
                        return  LottieLoader();
                      }
                      if (state is GetEmployeeListSuccess) {

                        print("Success shifu");

                        return Stack(
                          children: [
                            Container(
                              height: h/1.35,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Text(
                                    //   "Select from List (${userCodeList.length})",
                                    //   style: GoogleFonts.roboto(
                                    //     color: Color(0xff151522),
                                    //     fontSize: w/24,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: w1,
                                      // height: h / 2.5,
                                      // decoration: BoxDecoration(
                                      //   borderRadius:
                                      //   BorderRadius.circular(10),
                                      //   border: Border.all(
                                      //     color: Color(0xffe6ecf0),
                                      //     width: 1,
                                      //   ),
                                      //   boxShadow: const [
                                      //     BoxShadow(
                                      //       color: Color(0x05000000),
                                      //       blurRadius: 8,
                                      //       offset: Offset(1, 1),
                                      //     ),
                                      //   ],
                                      //   color: Colors.white,
                                      // ),
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
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: GradientButton(
                                  color: ColorPalette.primary,
                                  onPressed: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: DesignationListInOrganisation(),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.fade,
                                    );
                                    setState(() {});
                                  },
                                  gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        ColorPalette.primary,
                                        ColorPalette.primary
                                      ]),
                                  child: Text(
                                    "Create",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: w / 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            )
                          ],
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
    );
  }
  _showModalBottomAdditionalRole(GetEmployeeList? employee) {
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
                height: h / 2.3,
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
                        // SizedBox(
                        //   height: h / 40,
                        // ),
                        // // Text(
                        // //   "Edit Address",
                        // //   style: GoogleFonts.roboto(
                        // //     color: Colors.black,
                        // //     fontSize: w / 22,
                        // //     fontWeight: FontWeight.w700,
                        // //   ),
                        // // ),
                        SizedBox(
                          height: h / 20,
                        ),
                        SizedBox(
                          height: h/2.8,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        _showModalBottomVieProfile(employee);
                                      },
                                      child: Container(
                                        width: w,
                                        padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                                        child: Text(
                                          "View Profile",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        context.read<EmployeeBloc>().add( GetEmployeeReadEvent(employee?.id??0));
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: CreateUser(edit: true,),
                                          withNavBar: true,
                                          // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation: PageTransitionAnimation.fade,
                                        );
                                      },
                                      child: Container(
                                        width: w,
                                        padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                                        child: Text(
                                          "Edit Profile Details",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    GestureDetector(
                                      onTap: (){
                                        if(employee?.role=="Staff"){
                                          context.read<EmployeeBloc>()
                                              .add( UpdateEmployeeEvent(
                                              profileImg: readEmployee?.userMete?.profile,
                                              contact:readEmployee?.primaryMobile??"",
                                              officialRole: readEmployee?.userMete?.roleId??0,
                                              roleName: readEmployee?.userMete?.roleName??"",
                                              nationality: readEmployee?.country??"",
                                              lastName: readEmployee?.fname??"",
                                              gender: readEmployee?.gender??"",
                                              firstName: readEmployee?.fname??"",
                                              emailID: readEmployee?.email??"",
                                              designationCode: readEmployee?.designation??"",
                                              orgCode: authentication.authenticatedUser.organisationCode??"",
                                              additionalRole: readEmployee?.userMete?.roleListId??[],
                                              roleNameList: readEmployee?.userMete?.roleList??[],
                                              depatCode: readEmployee?.departmentCode??"",
                                              userRole: "Associative Admin",
                                              netCode: readEmployee?.netCode??"",
                                              id: readEmployee?.id??0,
                                              isActive: true

                                          ));
                                        }
                                        else if(employee?.role=="Associative Admin"){
                                          context.read<EmployeeBloc>()
                                              .add( UpdateEmployeeEvent(
                                              profileImg: readEmployee?.userMete?.profile,
                                              contact:readEmployee?.primaryMobile??"",
                                              officialRole: readEmployee?.userMete?.roleId??0,
                                              roleName: readEmployee?.userMete?.roleName??"",
                                              nationality: readEmployee?.country??"",
                                              lastName: readEmployee?.fname??"",
                                              gender: readEmployee?.gender??"",
                                              firstName: readEmployee?.fname??"",
                                              emailID: readEmployee?.email??"",
                                              designationCode: readEmployee?.designation??"",
                                              orgCode: authentication.authenticatedUser.organisationCode??"",
                                              additionalRole: readEmployee?.userMete?.roleListId??[],
                                              roleNameList: readEmployee?.userMete?.roleList??[],
                                              depatCode: readEmployee?.departmentCode??"",
                                              userRole: "Staff",
                                              netCode: readEmployee?.netCode??"",
                                              id: readEmployee?.id??0,
                                              isActive: true

                                          ));
                                        }
                                      },
                                      child: Container(
                                        width: w,
                                        padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                                        child: Text(
                                          employee?.role=="Staff"?"Make As Associate Admin":
                                          employee?.role=="Associative Admin"?"Make As Normal User":"",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Container(
                                      width: w,
                                      padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                                      child: Text(
                                        "Message User",
                                        style: GoogleFonts.roboto(
                                          color: Colors.grey,
                                          fontSize: w / 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        _showModalBottomChagePass(employee);
                                      },
                                      child: Container(
                                        width: w,
                                        padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                                        child: Text(
                                          "Change Password",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
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
                                                    const Divider(),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Are you sure you want to delete ${employee?.fname} from this list ?",
                                                      style: GoogleFonts.roboto(
                                                        color: ColorPalette.black,
                                                        fontSize: w / 28,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Container(
                                                              width: w / 3.3,
                                                              padding: const EdgeInsets.symmetric(
                                                                  vertical: 10),
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: const Color(0x26000000)
                                                                        .withOpacity(0.05)),
                                                                // boxShadow: [
                                                                //   BoxShadow(
                                                                //     color: Color(0x26000000),
                                                                //     blurRadius: 0,
                                                                //     offset: Offset(0, 0),
                                                                //   ),
                                                                // ],
                                                                color: Colors.white,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "Cancel",
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                  style:
                                                                  GoogleFonts.poppins(
                                                                    color:
                                                                    const Color(0xffa9a8a8),
                                                                    fontSize: w / 26,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                              context.read<EmployeeBloc>().add( DeleteEmployeeEvent(employee?.id??0));

                                                            },
                                                            child: Container(
                                                              width: w / 3.1,
                                                              padding: const EdgeInsets.symmetric(
                                                                  vertical: 13),
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    5),
                                                                gradient: const LinearGradient(
                                                                  begin:
                                                                  Alignment.topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  colors: [
                                                                    ColorPalette.primary,
                                                                    ColorPalette.primary,
                                                                  ],
                                                                ),
                                                              ),
                                                              child: Text(
                                                                "Delete",
                                                                textAlign: TextAlign.center,
                                                                style: GoogleFonts.roboto(
                                                                  color: Colors.white,
                                                                  fontSize: w / 26,
                                                                  fontWeight:
                                                                  FontWeight.w500,
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
                                            });
                                      },
                                      child: Container(
                                        width: w,
                                        padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                                        child: Text(
                                          "Delete User",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           // refresh();
                    //           Navigator.pop(context);
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Update",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomVieProfile(GetEmployeeList? employee) {
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
                height: h / 4,
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
                        // SizedBox(
                        //   height: h / 40,
                        // ),
                        // // Text(
                        // //   "Edit Address",
                        // //   style: GoogleFonts.roboto(
                        // //     color: Colors.black,
                        // //     fontSize: w / 22,
                        // //     fontWeight: FontWeight.w700,
                        // //   ),
                        // // ),
                        SizedBox(
                          height: h / 20,
                        ),
                        SizedBox(
                          height: h/5.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 0.2, color: Colors.grey),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x05000000),
                                            blurRadius: 8,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                        color: Color(0xffffffff),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            employee?.profile==""?
                                            TextAvatar(
                                              shape: Shape.Circular,
                                              size: 55,
                                              numberLetters: 2,
                                              fontSize: w/16,
                                              textColor: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              text: employee?.fname.toString().toUpperCase(),
                                            ):
                                            CircleAvatar(
                                              radius: 28,
                                              backgroundImage: NetworkImage(employee?.profile??"",),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  employee?.fname ?? "",
                                                  style: TextStyle(
                                                      fontSize: w / 22,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.email_sharp,
                                                      size: 16,
                                                      color:
                                                      Color(0xffD3D3D3),
                                                    ),
                                                    SizedBox(
                                                      width: w / 30,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                          // width: w/1.5,
                                                          child: Text(
                                                            employee?.email ??
                                                                "",
                                                            maxLines: 2,
                                                            style: GoogleFonts.roboto(
                                                                color: const Color(
                                                                    0xff777777),
                                                                fontSize:
                                                                w / 26),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .phone_android_sharp,
                                                      size: 16,
                                                      color:
                                                      Color(0xffD3D3D3),
                                                    ),
                                                    SizedBox(
                                                      width: w / 30,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        SizedBox(
                                                          child: Text(
                                                            employee?.primaryMobile ??
                                                                "",
                                                            maxLines: 2,
                                                            style: GoogleFonts.roboto(
                                                                color: const Color(0xff777777),
                                                                fontSize:
                                                                w / 26),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           // refresh();
                    //           Navigator.pop(context);
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Update",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          );
        });
  }
  _showModalBottomChagePass(GetEmployeeList? employee) {
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
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: h / 2.5,
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
                        mainAxisSize: MainAxisSize.min,
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
                            "Change Password",
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
                            height: h/3.5,
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
                                      TextFormReusable(
                                        label: "New Password",
                                        hint: "eg.Tom",
                                        controller: newpassword,
                                        isMandatory: false,
                                        onchange: (dd){
                                          onRefresh();
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormReusable(
                                        label: "Confirm Password",
                                        hint: "eg.Tom",
                                        controller: cofirempassword,
                                        isMandatory: false,
                                        onchange: (dd){
                                          onRefresh();
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
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
                          child: newpassword.text==cofirempassword.text&&
                              newpassword.text!=""||cofirempassword.text!=""
                              ?GradientButton(
                              color: ColorPalette.primary,
                              onPressed: () {
                                context.read<EmployeeBloc>().add(ChangeUserPasswordEvent(
                                    employeeCode: employee?.userCode??"",
                                    newPassword: newpassword.text));

                              },
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ColorPalette.primary,
                                    ColorPalette.primary
                                  ]),
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              )):
                          GradientButton(
                              color: Color(0xffD3D3D3),
                              onPressed: () {

                              },
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffD3D3D3),
                                    Color(0xffD3D3D3)
                                  ]),
                              child: Text(
                                "Save",
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
            ),
          );
        });
  }
}
