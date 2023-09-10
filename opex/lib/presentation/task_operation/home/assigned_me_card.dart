import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/home/model/joblist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/utils/variables.dart';
import '../create/task_bloc/task_bloc.dart';
import '../job_title.dart';
import '../task_svg.dart';
import '../task_title.dart';
import 'comments_screen.dart';

class AssignedMeCard extends StatefulWidget {
  final GetJobList? assignedMe;
  const AssignedMeCard({Key? key, this.assignedMe}) : super(key: key);

  @override
  State<AssignedMeCard> createState() => _AssignedMeCardState();
}

class _AssignedMeCardState extends State<AssignedMeCard> {
  String endstdDate='';
  @override
  Widget build(BuildContext context) {
    var date = widget.assignedMe?.endDate;
    var dateTime = DateTime.parse("$date");
    endstdDate =
        DateFormat('dd-MM-yyyy').format(dateTime).toString();
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){

        context.read<TaskBloc>().add(GetTaskListEvent(widget.assignedMe?.id,'','',''));
        context.read<JobBloc>().add(GetJobReadListEvent(widget.assignedMe?.id??0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: JobTitle(isMyJob: true),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0x4ca9a8a8),
            width: 1,
          ),
          color: Color(0xfff8f7f5),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: w/1.8,
                            child: Text(
                              widget.assignedMe?.name??"",
                              maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: w/22,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // Container(
                          //     // width: 121,
                          //     // height: 30,
                          //     padding: EdgeInsets.symmetric(
                          //         vertical: 6, horizontal: 10),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(28),
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Color(0x05000000),
                          //           blurRadius: 8,
                          //           offset: Offset(1, 1),
                          //         ),
                          //       ],
                          //       color: Color(0x19ff9900),
                          //     ),
                          //     child: Text(
                          //       "On Progress",
                          //       style: GoogleFonts.roboto(
                          //         color: Color(0xffff9900),
                          //         fontSize: w/30,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.assignedMe?.description??"",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: w/24,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ]),
              ),
              Divider(
                color: Color(0xffA9A8A8).withOpacity(0.3),
              ),
              Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // SvgPicture.string(TaskSvg().attachmIcon),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Text(
                          //   widget.assignedMe?.imgCount.toString()??"",
                          //   style: GoogleFonts.roboto(
                          //     color: Color(0xff939393),
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 15,
                          // ),
                          SvgPicture.string(TaskSvg().timerIcon),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            endstdDate,
                            style: GoogleFonts.roboto(
                              color: Color(0xff939393),
                              fontSize: w/25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox(
                          //   width: 15,
                          // ),
                          // GestureDetector(
                          //   onTap: (){
                          //     PersistentNavBarNavigator.pushNewScreen(
                          //       context,
                          //       screen: CommentsScreen(),
                          //       withNavBar: true, // OPTIONAL VALUE. True by default.
                          //       pageTransitionAnimation: PageTransitionAnimation.fade,
                          //     );
                          //   },
                          //   child: SvgPicture.string(
                          //     TaskSvg().msgIcon,
                          //     color: Color(0xff939393),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Text(
                          //   "1",
                          //   style: GoogleFonts.roboto(
                          //     color: Color(0xff939393),
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                      // Container(
                      //   height: 30,
                      //   width: 30,
                      //   child:   Image.asset("asset/newprofile.png",height: 20,width: 20,),)

                    ],
                  ))
            ]),
      ),
    );
  }
}
