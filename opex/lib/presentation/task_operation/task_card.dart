import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../core/color_palatte.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';

class TaskCard extends StatelessWidget {
  bool isMylist;
  final GetTaskList? taskList;
  TaskCard({Key? key, this.isMylist = false, this.taskList}) : super(key: key);

  String? endstdDate;
  @override
  Widget build(BuildContext context) {
    var date2 = taskList?.endDate;
    var dateTime = DateTime.parse("$date2");
    endstdDate = DateFormat('dd-MM-yyyy').format(dateTime).toString();
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.read<TaskBloc>().add(GetTaskReadListEvent(taskList?.id ?? 0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TaskTitle(
            isMyJob: true,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
        //  TaskTitle
      },
      child: Container(
        width: w / 2.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: const Color(0x33a9a8a8),
            width: 1,
          ),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color(0x11000000),
          //     blurRadius: 15,
          //     offset: Offset(0, 0),
          //   ),
          // ],
          color: Color(0xfff8f7f5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  taskList?.statusName=="VERIFIED"?
                  Row(
                    children: [
                      Container(
                          // width: 121,
                          // height: 30,
                          padding:
                              const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(1, 1),
                              ),
                            ],
                             color: Color(0xff079B16)
                          ),
                          child: Text(
                            "COMPLETED",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: w / 36,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      SizedBox(width: 3,),
                      SvgPicture.string(
                        TaskSvg().tickIcon,
                        color: Colors.green,
                        width: 15,
                        height: 15,
                      ),
                    ],
                  ):Container(
                      // width: 121,
                      // height: 30,
                      padding:
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                          ),
                        ],
                         color: taskList?.statusName=="STARTED"?
                    Color(0xffFF9900):taskList?.statusName=="ON PROGRESS"?
                    Color(0xff2871AF):taskList?.statusName=="COMPLETED"?
                    Color(0xff079B16):taskList?.statusName=="PENDING"?
                    Color(0xffFF0000):Color(0xffFFE5BE),
                      ),
                      child: Text(
                        taskList?.statusName == null
                            ? "STARTED"
                            : taskList?.statusName ?? "",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w / 36,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: w/2,
                          height: 35,
                          // color: Colors.red,
                          child: Text(
                            taskList?.taskName?.toString().toTitleCase() ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w / 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedBox(height: 10,),
                        // Image.asset("asset/img_7.png",height: 20,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  taskList?.assigningType=="Individual"?Icon(Icons.person,color: ColorPalette.primary,
                    size: 13,):
              Icon(Icons.group,color: ColorPalette.primary,
              size: 13,),
                  SizedBox(width: 2,),
                  Container(width: w/3,
                    // color: Colors.deepOrange,
                    child: Text(taskList?.assignNameCard??"",
                    overflow: TextOverflow.ellipsis,
                     maxLines: 1,
                    style: GoogleFonts.roboto(
                      fontSize: w/36,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  // SvgPicture.string(TaskSvg().attachmIcon),
                  // SizedBox(width: 5,),
                  // Text(
                  //   "1",
                  //   style: GoogleFonts.roboto(
                  //     color: Color(0xff939393),
                  //     fontSize: w/25,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // SizedBox(width: 10,),
                  SvgPicture.string(TaskSvg().startDateIcon,height: 20,width: 20,),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    endstdDate ?? "",
                    style: GoogleFonts.roboto(
                      color:  Colors.black,
                      fontSize: w / 28,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
