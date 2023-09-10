import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/task_operation/task_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../call_center/widgets/order_history_card.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';
import 'home/comments_screen.dart';

class NotificationInSidraTeams extends StatefulWidget {
  final List<NotificationList>? notification;
  const NotificationInSidraTeams({super.key, this.notification});

  @override
  State<NotificationInSidraTeams> createState() => _NotificationInSidraTeamsState();
}

class _NotificationInSidraTeamsState extends State<NotificationInSidraTeams> {
  String notifiicationDate='';
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        context.read<TaskBloc>().add(const GetNotificationListEvent("", "", ""));
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: "Notifications",
            isAction: false,),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // notifiicationDate=widget.notification?[index].createOn??"";
                        var date = widget.notification?[index].createOn;
                        var dateTime =  DateTime.parse("$date");
                        notifiicationDate =  DateFormat('dd-MM-yyyy').format(dateTime).toString();
                          return GestureDetector(
                            onTap: (){
                              if(widget.notification?[index].notificationType=="Comment"){
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: CommentsScreen(
                                    taskId: int.tryParse(widget.notification?[index].notificationTypeId??""),
                                  ),
                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                              }
                              else{
                                context.read<TaskBloc>().add(
                                    GetTaskReadListEvent(int.tryParse(widget.notification?[index].notificationTypeId??"")??0));
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: TaskTitle(isMyJob: false),
                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                              }

                            },
                            child: Container(
                        width: w,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.2,color: Colors.black.withOpacity(0.2))
                        ),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.string(
                                HomeSvg().notificationOneIcon,
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  // Text("Task Created Successfully",
                                  //   style: GoogleFonts.roboto(
                                  //       fontSize: w/24,
                                  //       fontWeight: FontWeight.w500,
                                  //       color: Colors.black
                                  //   ),),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(notifiicationDate,
                                        style: GoogleFonts.roboto(
                                            fontSize: w/30,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff555555)
                                        ),),
                                      SizedBox(width: 5,),
                                      // widget.notification?[index].isNew==true?
                                      Container(
                                        padding: EdgeInsets.only(top: 3,bottom: 3,left: 6,right: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.green.shade50,
                                        ),

                                        child: Text("New",
                                          style: GoogleFonts.roboto(
                                              fontSize: w/28,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green
                                          ),),
                                      )
                                          // :Container(),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                      width: w/1.4,
                                      child: Text(widget.notification?[index].description??""
                                        ,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.roboto(

                                            fontSize: w/26,
                                            height: 1.2,

                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff555555)
                                        ),)),

                                ],
                              ),

                            ],
                        ),
                      ),
                          );},
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3,
                      ),
                      itemCount: widget.notification!.length),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
