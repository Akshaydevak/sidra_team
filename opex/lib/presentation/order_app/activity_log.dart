import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/order_app/order_svg.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/color_palatte.dart';

class ActivityLog extends StatefulWidget {
  const ActivityLog({Key? key}) : super(key: key);

  @override
  State<ActivityLog> createState() => _ActivityLogState();
}

class _ActivityLogState extends State<ActivityLog> {
  List<ActivityList> activityList=[];
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        print(state);
        if(state is GetActivityLogListLoading){
          customCupertinoLoading();
        }
        if(state is GetActivityLogListSuccess){

          activityList=state.activity;
          setState(() {

          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            label: "Activity Logs",
          ),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: activityList.length,
                      itemBuilder: (context, index) {

                        if (index == activityList.length-1) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: ColorPalette.primary,
                                      child: SvgPicture.string(
                                        OrderSvg().locationIcon,color: Colors.white,),

                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      activityList[index].createdOn!.split("T")[0]??"",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.subtextGrey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: w/1.3,
                                      child: Text(
                                        activityList[index].title??"",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        SvgPicture.string(TaskSvg().timeIcon),SizedBox(width: 10,),
                                        Text(
                                          "Scheduled Activity",
                                          style: GoogleFonts.roboto(
                                            color: ColorPalette.subtextGrey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ]);
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: ColorPalette.primary,
                                  child:
                                  SvgPicture.string(OrderSvg().locationIcon,color: Colors.white),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  width: 2,
                                  height: 80,
                                  color: ColorPalette.divider,
                                )
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activityList[index].createdOn!.split("T")[0]??"",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.subtextGrey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: w/1.3,
                                  child: Text(
                                    activityList[index].title??"",
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SvgPicture.string(TaskSvg().timeIcon),SizedBox(width: 10,),
                                    Text(
                                      "Scheduled Activity",
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.subtextGrey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),

                          ],
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
