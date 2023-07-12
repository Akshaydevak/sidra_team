import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../common_widgets/loading.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'employee_card.dart';
import 'groups_card.dart';

class EmployeesGroupScreen extends StatefulWidget {
  final int? newIndex;
  const EmployeesGroupScreen({Key? key, this.newIndex}) : super(key: key);

  @override
  State<EmployeesGroupScreen> createState() => _EmployeesGroupScreenState();
}

class _EmployeesGroupScreenState extends State<EmployeesGroupScreen> {
  var _listGenderText = ["Employees", "Groups"];
  var _tabTextIconIndexSelected = 0;
@override
  void initState() {
  _tabTextIconIndexSelected = widget.newIndex??0;
  _tabTextIconIndexSelected==0?context.read<JobBloc>().add( GetEmployeeListEvent()):
  context.read<JobBloc>().add(GetGroupListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: _tabTextIconIndexSelected==0? "Employees":"Groups",isAction: false,),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                FlutterToggleTab(
                  width: w / 4,
                  height: 60,
                  borderRadius: 15,
                  selectedBackgroundColors: [
                    Colors.white
                  ],
                  unSelectedBackgroundColors: [
                    Color(0xfffdf2f2)
                  ],
                  selectedTextStyle: GoogleFonts.readexPro(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  unSelectedTextStyle: TextStyle(
                    color: Color(0xff7d7d7d),
                    fontSize: 18,
                  ),
                  labels: _listGenderText,
                  // icons: _listIconTabToggle,
                  selectedIndex: _tabTextIconIndexSelected,
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabTextIconIndexSelected = index;
                      print(".........."+_tabTextIconIndexSelected.toString());
                      _tabTextIconIndexSelected==0?context.read<JobBloc>().add( const GetEmployeeListEvent()):
                      context.read<JobBloc>().add(const GetGroupListEvent());
                    });
                  },
                  marginSelected:
                      EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                ),
                SizedBox(height: 16,),
                _tabTextIconIndexSelected==0?
                BlocBuilder<JobBloc, JobState>(
                 builder: (context, state) {
                 if (state is GetEmployeeListLoading) {
                   return Container(
                       height: 300,
                       width: w,
                       alignment: Alignment.center,
                       child: LoadingAnimationWidget.threeRotatingDots(
                         color: Colors.red,
                         size: 30,
                       ));
                }
                if (state is GetEmployeeListSuccess) {
                  print("Sucsess shifu");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.employeeList.length} Employees",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w/22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
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

                                },
                                child:  EmployeeCard(employeeList: state.employeeList[i],),
                              );
                            },
                            itemCount: state.employeeList.length),
                      ),
                    ],
                  );
                }
                return Container();
  },
):
                BlocBuilder<JobBloc, JobState>(
                builder: (context, state) {
                if (state is GetGroupListLoading) {
                  return Container(
                      height: 300,
                      width: w,
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.threeRotatingDots(
                        color: Colors.red,
                        size: 30,
                      ));
                }
                if (state is GetGroupListSuccess) {
                  print("Sucsess shifu");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.groupList.length} Groups",
                        style: GoogleFonts.roboto(
                          color: Color(0xff151522),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
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

                                  print("tapped grou");
                                },
                                child: GroupCard(groupList:state.groupList[i] ),
                              );
                            },
                            itemCount: state.groupList.length),
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
