import 'package:avatar_stack/avatar_stack.dart';
import 'package:cluster/presentation/task_operation/group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../mpos/search_card.dart';
import '../employee_bloc/employee_bloc.dart';
import '../employee_model/employee_model.dart';
import '../home/bloc/job_bloc.dart';
import '../lottieLoader.dart';
import '../task_svg.dart';

class AddUserInOrganisation extends StatefulWidget {
  const AddUserInOrganisation({super.key});

  @override
  State<AddUserInOrganisation> createState() => _AddUserInOrganisationState();
}

class _AddUserInOrganisationState extends State<AddUserInOrganisation> {
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
              // authentication.isAssociateAdmin||state.getEmployee?.role=="Admin"?Container():_showModalBottomAdditionalRole(readEmployee);
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
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Add User",

            isAction: false,
            action: GestureDetector(child:
            Text("+ Add User",
              style: GoogleFonts.roboto(
                  color: ColorPalette.primary,
                  fontSize: w/24,
                  fontWeight: FontWeight.w500
              ),)),
            onTap: () {
              // PersistentNavBarNavigator.pushNewScreen(
              //   context,
              //   screen: AddUserInOrganisation(),
              //   withNavBar: false, // OPTIONAL VALUE. True by default.
              //   pageTransitionAnimation: PageTransitionAnimation.fade,
              // );
            },
          ),
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
                                    // PersistentNavBarNavigator.pushNewScreen(
                                    //   context,
                                    //   screen: DesignationListInOrganisation(),
                                    //   withNavBar: false, // OPTIONAL VALUE. True by default.
                                    //   pageTransitionAnimation: PageTransitionAnimation.fade,
                                    // );
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
}
