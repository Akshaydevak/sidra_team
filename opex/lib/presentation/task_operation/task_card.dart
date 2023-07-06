
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';


class TaskCard extends StatelessWidget {
  bool isMylist;
  final GetTaskList? taskList;
   TaskCard({Key? key,this.isMylist=false, this.taskList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        context.read<TaskBloc>().add(
            GetTaskReadListEvent(taskList?.id?? 0));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: TaskTitle(isMyJob: true,),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      //  TaskTitle
      },
      child: Container(
          width: w/2.3,


          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0x33a9a8a8),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 15,
                offset: Offset(0, 0),
              ),
            ],
            color: Colors.white,
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // width: 121,
                    // height: 30,
                      padding: EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
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
                      child: Text(
                        "On Progress",
                        style: GoogleFonts.roboto(
                          color: Color(0xffff9900),
                          fontSize: w/30,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  SizedBox(height: 10,),
                  Container(padding: EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskList?.taskName?.toString()??"",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Image.asset("asset/img_7.png",height: 20,),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child:  Row(
                children: [
                  SvgPicture.string(TaskSvg().attachmIcon),
                  SizedBox(width: 5,),
                  Text(
                    "1",
                    style: GoogleFonts.roboto(
                      color: Color(0xff939393),
                      fontSize: w/25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10,),
                  SvgPicture.string(TaskSvg().calenderIcon),
                  SizedBox(width: 5,),
                  Text(
                    taskList?.createdOn?.toString().split("T")[0]??"",
                    style: GoogleFonts.roboto(
                      color: Color(0xff939393),
                      fontSize: w/25,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
