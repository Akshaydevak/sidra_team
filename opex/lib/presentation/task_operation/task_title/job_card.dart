
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
  final bool? isReporter;
   JobCard({Key? key, this.joblist,this.isReporter=false}) : super(key: key);
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

        context.read<TaskBloc>().add(
            GetTaskReadListEvent(joblist?.id??0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TaskTitle(isReporter: isReporter??false),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.slideUp,
        );
      },
      child: Stack(
        children: [
          Container(
            width: w,

            padding: EdgeInsets.all(12),
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
              color: Color(0xfff8f7f5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: joblist?.statusName=="STARTED"||joblist?.statusName=="PENDING"?
                  w/4.6:joblist?.statusName=="COMPLETED"?w/3.7:joblist?.statusName=="ON PROGRESS"?w/3.5:w/3.6,
                  // height: 25,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    // color: Color(0x19ff9900),
                    color: joblist?.statusName=="STARTED"?
                    Color(0xffFF9900):joblist?.statusName=="ON PROGRESS"?
                    Color(0xff2871AF):joblist?.statusName=="COMPLETED"?
                    Color(0xff079B16):joblist?.statusName=="PENDING"?
                    Color(0xffFF0000):Color(0xffFFE5BE)
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    joblist?.statusName??"NOT INITIATED",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      // joblist?.statusName=="STARTED"?
                      // Color(0xffFFE1B3):joblist?.statusName=="ON PROGRESS"?
                      // Color(0xffBFD5E7):joblist?.statusName=="COMPLETED"?
                      // Color(0xffB5E2BA):joblist?.statusName=="PENDING"?
                      // Color(0xffFFB3B3):Color(0xffFFE1B3),
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
                      fontSize: w/22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  children: [
                    SvgPicture.string(TaskSvg().attachmIcon,height: 18,width: 18,),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      joblist?.imgCount?.toString()??"",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),

                    GestureDetector(
                      onTap: (){

                      },
                      child: SvgPicture.string(
                        TaskSvg().msgIcon,
                          height: 18,width: 18,
                        // color: Color(0xff939393).withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      joblist?.rewCount?.toString()??"",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w/25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    SvgPicture.string(TaskSvg().startDateIcon,height: 20,width: 20,),
                    SizedBox(width: 5,),
                    Text(
                      endstdDate,
                      style: GoogleFonts.roboto(
                        color:  Colors.black,
                        fontSize: w/27,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [

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
