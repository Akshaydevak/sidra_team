import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/job_title.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/variables.dart';
import '../../../core/common_snackBar.dart';
import '../../authentication/authentication.dart';
import '../create/model/task_models.dart';
import '../create/task_bloc/task_bloc.dart';
import '../task_title.dart';
import 'model/joblist_model.dart';

class MyJobCard extends StatefulWidget {
  String status;
  final bool isPinned;
  final bool isPending;
  final GetTaskList? tasksList;
  final GetJobList? jobsList;
  final bool isTaskCard;
  final List<StatusListing>? statusList;
   MyJobCard({Key? key,this.status="PENDING", this.tasksList, this.statusList, required this.isPinned,  this.isPending=false, this.jobsList,  this.isTaskCard=false}) : super(key: key);

  @override
  State<MyJobCard> createState() => _MyJobCardState();
}

class _MyJobCardState extends State<MyJobCard> {
  bool isExpanded=false;
  int tappedTile = 0;
  List<StatusListing>? statusList;
  void changeTappedTile(int val) {
    tappedTile = val;

    setState(() {});
  }
  void refresh(){
    context.read<JobBloc>().add(GetJobListEvent());
    setState(() {

    });
  }
  @override
  void initState() {
    context.read<JobBloc>().add(GetStatusListEvent());
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<TaskBloc, TaskState>(
     listener: (context, state) {
       if (state is UpdateTaskLoading) {
         showSnackBar(context,
             message: "Loading...",
             color: Colors.white,
             // icon: HomeSvg().SnackbarIcon,
             autoDismiss: true);
       }

       if (state is UpdateTaskFailed) {
         showSnackBar(
           context,
           message: state.error,
           color: Colors.red,
           // icon: Icons.admin_panel_settings_outlined
         );
       }
       if (state is UpdateTaskSuccess) {
         Fluttertoast.showToast(
             msg: 'Task Updated Successfully',
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             backgroundColor: Colors.white,
             textColor: Colors.black);
         context.read<TaskBloc>().add(
             const GetPinnedTaskListEvent());


       }
  },
),
    BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if (state is PinCreationLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is PinCreationFailed) {
          showSnackBar(
            context,
            message: "Job Not Pinned",
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is PinCreationSuccess) {
          // createJob = state.user;

          Fluttertoast.showToast(
              msg: 'Job UnPinned Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          Navigator.pop(context);
          context.read<TaskBloc>().add(
              const GetPinnedTaskListEvent());
        }
      },

    ),
  ],
  child: GestureDetector(
        onTap: (){
          context.read<TaskBloc>().add(
              GetTaskReadListEvent(widget.tasksList?.id??0));
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: TaskTitle(isMyJob: false,),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        },
          child:
        Container(
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0x4ca9a8a8),
            width: 1,
          ),
          color: const Color(0xfff8f7f5),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.tasksList?.taskName??"",
                            style: GoogleFonts.roboto(
                              color: ColorPalette.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          widget.isPending?Container():GestureDetector(
                            onTap: (){
                              _showModalBottomSheet(context,widget.statusList??[]);
                            },
                            child: Container(
                              // width: 121,
                              // height: 30,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0xffe6ecf0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                widget.status=="ON PROGRESS"?  Text(
                                    "On Progress",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xffff9900),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ):Container(),
                                  widget.status=="COMPLETED"?  Text(
                                    "Completed",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xff4b9c25),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ):Container(),
                                  widget.status=="PENDING"?  Text(
                                    "Pending",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xffe70c0c),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ):Container(),
                                  widget.status=="STARTED"?  Text(
                                    "Started",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xffe70c0c),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ):Container(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.string(TaskSvg().dotIcon)
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          widget.isPinned==true?PopupMenuButton(
                            icon: SvgPicture.string(TaskSvg().moreIcon),
                            //don't specify icon if you want 3 dot menu
                            color: Colors.white,
                            elevation: 2,
                            padding: EdgeInsets.zero,
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            itemBuilder: (context) =>
                            [
                              PopupMenuItem(
                                  padding: const EdgeInsets.all(0),
                                  value: 'a',
                                  enabled: true,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          context.read<JobBloc>().add(
                                              PinAJobPostEvent(
                                                  userCode: authentication.authenticatedUser.code??"",
                                                  taskId: widget.tasksList?.id??0,
                                                  isPinned: false));
                                          context.read<TaskBloc>().add(
                                              const GetPinnedTaskListEvent());
                                          Navigator.pop(context);

                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              SvgPicture.string(TaskSvg().editorIcon),
                                              const SizedBox(width: 10,),
                                              Text(
                                                widget.tasksList?.isPinned==true?'UnPin this Task':'Pin thi Task',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black54,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ))

                            ],
                            onSelected: (value) {

                            },
                          ):Container(),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.tasksList?.description??"",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ]),
              ),
              Divider(
                color: const Color(0xffA9A8A8).withOpacity(0.3),
              ),
              isExpanded?Column(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Row(children: [
                          SizedBox(
                            width: w/3.5,
                            child: const Text(
                              "Assigned By",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                            child: Text(":",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),),
                          ),
                          Text(
                            widget.tasksList?.assignName??"",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],),
                        const SizedBox(height: 5,),
                        Row(children: [
                          Container(
                            width: w/3.5,
                            child: const Text(
                              "Reporting To",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            width: 16,
                            child: const Text(":",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),),
                          ),
                          Text(
                            widget.tasksList?.reportingName.toString()??"",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],),
                        const SizedBox(height: 5,),
                        Row(children: [
                          Container(
                            width: w/3.5,
                            child: const Text(
                              "Assigned On",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            width: 16,
                            child: const Text(":",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),),
                          ),
                          Text(
                            "${widget.tasksList?.createdOn.toString().split("T")[0]}"" "
                                "${widget.tasksList?.createdOn.toString().split("T")[1].split(".")[0]}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],),
                        const SizedBox(height: 5,),
                        Row(children: [
                          Container(
                            width: w/3.5,
                            child: const Text(
                              "Start On",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            width: 16,
                            child: const Text(":",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),),
                          ),
                          Text(
                            "${widget.tasksList?.startDate.toString().split("T")[0]}"" "
                                "${widget.tasksList?.startDate.toString().split("T")[1].split("+")[0]}" ,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],),
                        const SizedBox(height: 5,),
                        Row(children: [
                          Container(
                            width: w/3.5,
                            child: const Text(
                              "Due On",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            width: 16,
                            child: const Text(":",
                              style: TextStyle(
                                color: Color(0xff6d6d6d),
                                fontSize: 15,
                              ),),
                          ),
                          Text(
                            "${widget.tasksList?.endDate.toString().split("T")[0]}"" "
                                "${widget.tasksList?.endDate.toString().split("T")[1].split("+")[0]}",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 15,

                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],),




                      ],
                    ),
                  ),
                  Divider(
                    color: const Color(0xffA9A8A8).withOpacity(0.3),
                  ),
                ],
              ):Container(),
              Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // SvgPicture.string(TaskSvg().attachmIcon),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          // Text(
                          //   "1",
                          //   style: GoogleFonts.roboto(
                          //     color: const Color(0xff939393),
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 15,
                          // ),
                          SvgPicture.string(TaskSvg().timerIcon),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.tasksList?.createdOn.toString().split("T")[0]??"",
                            style: GoogleFonts.roboto(
                              color: const Color(0xff939393),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 1,
                            height: 31,
                            color: const Color(0xff939393),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SvgPicture.string(TaskSvg().priorityIcon,
                            color: widget.tasksList?.priority=="Low"?const Color(0xff50D166):
                          widget.tasksList?.priority=="Medium"?const Color(0xffF18F1C):null)
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          setState((){
                            isExpanded=!isExpanded;
                          });
                        },
                          child: isExpanded?const Icon(Icons.keyboard_arrow_up):const Icon(Icons.keyboard_arrow_down_sharp))
                    ],
                  ))
            ]),
      )),
);
  }

  _showModalBottomSheet(BuildContext context,List<StatusListing> status) {
    
    showModalBottomSheet(

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {

          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                // height: 350,
                // padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(height: 24,),
                    Text(
                      "Change Status To:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListView.separated(
                      padding: const EdgeInsets.only(),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: status.length,
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                          onTap: (){
                            // refresh();

                            changeTappedTile(i);
                            BlocProvider.of<TaskBloc>(context).add(
                                UpdateTaskEvent(
                                  longitude: widget.tasksList?.longitude,
                                  latitude: widget.tasksList?.latitude,
                                  taskType: widget.tasksList?.taskType??0,
                                    discription: widget.tasksList?.description??"",
                                    createdBy: widget.tasksList?.createdPersonCode??"",
                                    isActive: true,
                                    priority: widget.tasksList?.priority??"",
                                    reportingPerson: widget.tasksList?.reportingPersonCode??"",
                                    endDate: "${widget.tasksList?.endDate?.split("T")[0]}"" ""${widget.tasksList?.endDate?.split("T")[1].split("+")[0]}"??"",
                                    startDate: "${widget.tasksList?.startDate?.split("T")[0]}"" ""${widget.tasksList?.startDate?.split("T")[1].split("+")[0]}"??"",
                                  AssigningCode: widget.tasksList?.assigningCode??"",
                                  notas: widget.tasksList?.notes??"",
                                  taskName: widget.tasksList?.taskName??"",
                                  remarks: widget.tasksList?.remarks??"",
                                  priorityLeval: widget.tasksList?.priorityLevel.toString()??"",
                                  createdOn: "${widget.tasksList?.createdOn?.split("T")[0]}"" ""${widget.tasksList?.createdOn?.split("T")[1].split(".")[0]}"??"",
                                  AssigningType: widget.tasksList?.assigningType??"",
                                  statusStagesId: status[i].id,
                                  parant: widget.tasksList?.parent??null,
                                  lastmodified: widget.tasksList?.lastModified??null,
                                  jobid: widget.tasksList?.jobId??0,
                                  id: widget.tasksList?.id??0,
                                    img5: widget.tasksList?.metaData?.image5,
                                    img1: widget.tasksList?.metaData?.image1,
                                    img4: widget.tasksList?.metaData?.image4,
                                    img2: widget.tasksList?.metaData?.image2,
                                    img3: widget.tasksList?.metaData?.image3,
                                    attachmentDescription: widget.tasksList?.metaData?.description,
                                    attachmentNote: widget.tasksList?.metaData?.note


                                ));

                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            color: tappedTile == i
                                ? ColorPalette.cardBackground
                                : ColorPalette.white,
                            child: Row(
                              children: [
                                tappedTile == i
                                    ? SvgPicture.string(TaskSvg().checkActiveIcon)
                                    : SvgPicture.string(TaskSvg().checkInActiveIcon),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  status[i].name??"",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          color: Color(0xffE6ECF0),
                          height: 1,
                          width: w,
                        );
                      },
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
