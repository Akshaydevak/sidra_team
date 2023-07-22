
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/home/model/joblist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/utils/variables.dart';
import '../job_title.dart';
import '../task_svg.dart';
import '../task_title.dart';

class JobCard extends StatelessWidget {
  final GetJobList? joblist;
   JobCard({Key? key, this.joblist}) : super(key: key);
  String endstdDate='';

  @override
  Widget build(BuildContext context) {
    var date = joblist?.endDate;
    var dateTime =  DateTime.parse("$date");
    endstdDate =  DateFormat('dd-MM-yyyy').format(dateTime).toString();
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        print("object");
        Variable.jobReadId=joblist?.id??0;
        print("HHH${Variable.jobReadId}");
        context.read<TaskBloc>().add(
            GetTaskReadListEvent(joblist?.id??0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TaskTitle(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Stack(
        children: [
          Container(
            width: w,

            padding: EdgeInsets.all(12),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w/3.5,
                  // height: 25,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Color(0x19ff9900),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    joblist?.statusName??"STARTED",
                    style: GoogleFonts.roboto(
                      color: Color(0xffff9900),
                      fontSize: w/28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 2),
                  child: Text(
                    joblist?.taskName??"",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    SvgPicture.string(TaskSvg().attachmIcon,height: 14,),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      joblist?.imgCount?.toString()??"",
                      style: GoogleFonts.roboto(
                        color: Color(0xff939393),
                        fontSize: w/25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),

                    GestureDetector(
                      onTap: (){

                      },
                      child: SvgPicture.string(
                        TaskSvg().msgIcon,
                        height: 12,
                        color: Color(0xff939393).withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      joblist?.rewCount?.toString()??"",
                      style: GoogleFonts.roboto(
                        color: Color(0xff939393),
                        fontSize: w/25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SvgPicture.string(TaskSvg().startDateIcon,height: 14,),
                      SizedBox(width: 8,),
                      Text(
                        endstdDate,
                        style: GoogleFonts.roboto(
                          color:  Color(0xff939393),
                          fontSize: w/27,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],),


                  ],
                )

              ],
            ),
          ),
          // Positioned(
          //     top: 0,
          //     right: 10,
          //     child: Image.asset("asset/img_10.png",height: 55,width: 55,))
        ],
      ),
    );
  }
}
