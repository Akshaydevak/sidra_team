import 'dart:io';
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/common_snackBar.dart';
import '../../inventory/inventory_new_list.dart';
import '../create/model/task_models.dart';
import '../create/task_bloc/task_bloc.dart';
import '../employee_bloc/employee_bloc.dart';
import '../image_preview_task.dart';
import '../lottieLoader.dart';
import '../task_operation_appbar.dart';

class CommentsScreen extends StatefulWidget {
  final int? taskId;
  const CommentsScreen({Key? key, this.taskId}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  dynamic? imageUrl;
  FocusNode focusNode=FocusNode();
  bool reviewUpdate=false;
  int reviewid=0;
  List<ReviewModel> reviewList=[];
  List<String> startTime=[];
  bool onChanged=false;
  TextEditingController review=TextEditingController();
  Future<void> _refreshData() async {
    // Simulate a network request or data refreshing
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      showSnackBar(context, message: "message", color: Colors.black);
      // Update the data here
      // items = List.generate(20, (index) => 'Refreshed Item $index');
    });
  }
  @override
  void initState() {

    context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
    // context.read<ProfileBloc>().add(GetProfilePicEvent());
    super.initState();
  }
  bool isUpoloading=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async{
        print("will pop scope");
context.read<TaskBloc>().add(GetTopicListEvent());
return true;
      },
      child: MultiBlocListener(
      listeners: [
      BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
      if(state is PicLoading){
        print("Inside Loading");
      }
      if(state is PicSuccess){
        print("Inside Success${state.data}\t${state.url}");
        setState(() {
         // picModel.replaceRange(indexImage, indexImage+1,
         //      [PicModel(data: state.data,url: state.url)]);
          imageId=state.data;
          imageUrl=state.url;
          isUpoloading=false;
        });
        print("pic model length${picModel.length}");
    
      }
      },
    ),
      BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          print('StateCreate$state');
          if (state is CreateReviewLoading) {
            // showSnackBar(context,
                // message: "Loading...",
                // color: Colors.white,
                // // icon: HomeSvg().SnackbarIcon,
                // autoDismiss: true);
          }
    
          if (state is CreateReviewFailed) {
            showSnackBar(
              context,
              message: state.error,
              color: Colors.red,
              // icon: Icons.admin_panel_settings_outlined
            );
          }
          if (state is CreateReviewSuccess) {
            Fluttertoast.showToast(
                msg: 'Comments Added Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.white,
                textColor: Colors.black);
            imageId=null;
            imageUrl=null;
            review.clear();
            focusNode.unfocus();
    
    
          }
        },
      ),
      BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          print('StateCreate$state');
          if (state is UpdateReviewLoading) {
            showSnackBar(context,
                message: "Loading...",
                color: Colors.white,
                // icon: HomeSvg().SnackbarIcon,
                autoDismiss: true);
          }
    
          if (state is UpdateReviewFailed) {
            showSnackBar(
              context,
              message: state.error,
              color: Colors.red,
              // icon: Icons.admin_panel_settings_outlined
            );
          }
          if (state is UpdateReviewSuccess) {
            Fluttertoast.showToast(
                msg: 'Successfully Updated',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.white,
                textColor: Colors.black);
                reviewUpdate=false;
            review.clear();
            focusNode.unfocus();
            imageUrl=null;
            imageId=null;
    
          }
        },
      ),
      BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          print("the state of delete$state");
          if (state is DeleteReviewLoading) {
            showSnackBar(context,
                message: "Loading...",
                color: Colors.white,
                // icon: HomeSvg().SnackbarIcon,
                autoDismiss: true);
          }
    
          if (state is DeleteReviewFailed) {
            showSnackBar(
              context,
              message: "Review Not Deleted",
              color: Colors.red,
              // icon: Icons.admin_panel_settings_outlined
            );
          }
          if (state is DeleteReviewSuccess) {
            print("delete res${state.status}");
            // createJob = state.user;
    
            Fluttertoast.showToast(
                msg: 'Successfully Deleted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.white,
                textColor: Colors.black);
    
            context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
            setState(() {
    
            });
          }
        },
    
      ),
      BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          print('StateCreate$state');
          if (state is GetReviewListLoading) {
          }
          if (state is GetReviewListSuccess) {
            reviewList=state.reviewList;
            _isLoading=false;
            for(var i=0;i<reviewList.length;i++){
    
              final timeOfDay = TimeOfDay(hour: int.tryParse(reviewList[i].reviewOn?.split("T")[1].split(".")[0]??"".split(":")[0])??0, minute: int.tryParse(reviewList[i].reviewOn?.split("T")[1].split(".")[0]??"".split(":")[0])??0); // Example time of day (3:30 PM)
    
              final twentyFourHourFormat = DateFormat('HH:mm:00');
              final twelveHourFormat = DateFormat('h:mm a');
    
              final dateTimet = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
    
              startTime.add(twelveHourFormat.format(dateTimet));
              print("FFFFF${startTime}");
            }
            setState(() {
    
            });
          }
          if(state is GetReviewListFailed){
            reviewList=[];
            _isLoading=false;
            setState(() {

            });
          }
        },
      ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: BackAppBar(
            label: "Comments",
            isAction: false,
            isBack: false,
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          key: _refreshIndicatorKey,
          color: ColorPalette.primary,
          // backgroundColor: Colors.transparent,
    
          strokeWidth: 2.0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(_isLoading)...[
              LottieLoader()
            ]
            else...[
                ScrollConfiguration(
                  behavior: NoGlow(),
                  child: SafeArea(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: h/1.11,
                                child: ScrollConfiguration(
                                  behavior: NoGlow(),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
    
                                        reviewList.isEmpty?
                                        Padding(
                                          padding: const EdgeInsets.only(top: 100),
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: SvgPicture.string(TaskSvg().noComment,height: 170,width: 170,),
                                          ),
                                        ):
                                        Container(
    
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            children: [
    
                                              ListView.separated(
                                                padding: EdgeInsets.only(bottom: 100),
                                                primary: true,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: reviewList.length,
                                                separatorBuilder: (context, index) => const SizedBox(
                                                  height: 15,
                                                ),
                                                itemBuilder: (context, index) =>
                                                    Container(
                                                      // color: Colors.blue,
                                                      child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                  // SvgPicture.string(TaskSvg().profileReporting),
                                                        TextAvatar(
                                                          shape: Shape.Circular,
                                                          size: 35,
                                                          numberLetters: 2,
                                                          fontSize: w/24,
                                                          textColor: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          text:reviewList[index].reviewedPersonName?.toUpperCase() ,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          width: w / 1.28,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              
                                                              SizedBox(height: 10,),
    
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    reviewList[index].reviewedPersonName??"",
                                                                    style: GoogleFonts.roboto(
                                                                      color: Colors.black,
                                                                      fontSize: w/24,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                  // PopupMenuButton(
                                                                  //   icon: Icon(Icons.more_vert,color: Colors.black,),
                                                                  //   color: Colors.white,
                                                                  //   elevation: 2,
                                                                  //   padding: EdgeInsets.zero,
                                                                  //   shape:
                                                                  //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                  //   itemBuilder: (context) =>
                                                                  //   [
                                                                  //     PopupMenuItem(
                                                                  //         padding: const EdgeInsets.all(0),
                                                                  //         value: 'a',
                                                                  //         enabled: true,
                                                                  //         child: Column(
                                                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                                                  //           children: [
                                                                  //             GestureDetector(
                                                                  //               onTap: (){
                                                                  //                 review.text=reviewList[index].review??"";
                                                                  //                 imageId=reviewList[index].reviewMeta?.image1??"";
                                                                  //                 reviewid=reviewList[index].id??0;
                                                                  //                 reviewUpdate=true;
                                                                  //                 Navigator.pop(context);
                                                                  //                 setState(() {
                                                                  //
                                                                  //                 });
                                                                  //               },
                                                                  //               child: Container(
                                                                  //                 padding: const EdgeInsets.only(left: 10),
                                                                  //                 child: Row(
                                                                  //                   children: [
                                                                  //                     // SvgPicture.string(TaskSvg().editorIcon),
                                                                  //
                                                                  //                     // const SizedBox(width: 10,),
                                                                  //                     Text(
                                                                  //                       'Edit Comment',
                                                                  //                       style: GoogleFonts.poppins(
                                                                  //                           color: Colors.black54,
                                                                  //                           fontSize: 13,
                                                                  //                           fontWeight: FontWeight.w500),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //               ),
                                                                  //             ),
                                                                  //             const Divider(indent: 20,height: 15,),
                                                                  //             GestureDetector(
                                                                  //               onTap: (){
                                                                  //                 Navigator.pop(context);
                                                                  //                 showDialog(
                                                                  //                     context: context,
                                                                  //                     builder: (BuildContext context) {
                                                                  //                       return AlertDialog(
                                                                  //                         content: Column(
                                                                  //                           mainAxisSize: MainAxisSize.min,
                                                                  //                           children: <Widget>[
                                                                  //                             Text(
                                                                  //                               "Are you Sure ?",
                                                                  //                               textAlign: TextAlign.center,
                                                                  //                               style: GoogleFonts.roboto(
                                                                  //                                 color: Color(0xff151522),
                                                                  //                                 fontSize: w/22,
                                                                  //
                                                                  //                                 fontWeight: FontWeight.w600,
                                                                  //                               ),
                                                                  //                             ),
                                                                  //                             SizedBox(height: 16,),
                                                                  //                             Text(
                                                                  //                               "Did you wants to delete this comment",
                                                                  //                               textAlign: TextAlign.center,
                                                                  //                               style: TextStyle(
                                                                  //                                 color: ColorPalette.subtextGrey,
                                                                  //                                 fontSize: w/27,
                                                                  //                               ),
                                                                  //                             ),
                                                                  //                             SizedBox(height: 16,),
                                                                  //                             Row(
                                                                  //                                 mainAxisAlignment:
                                                                  //                                 MainAxisAlignment.spaceBetween,
                                                                  //                                 children: <Widget>[
                                                                  //                                   GestureDetector(
                                                                  //                                     onTap: () {
                                                                  //                                       Navigator.of(context).pop();
                                                                  //                                     },
                                                                  //                                     child: Container(
                                                                  //                                       width: w / 3.3,
                                                                  //                                       padding:
                                                                  //                                       EdgeInsets.symmetric(vertical: 10),
                                                                  //
                                                                  //                                       decoration: BoxDecoration(
                                                                  //                                         borderRadius: BorderRadius.circular(5),
                                                                  //                                         border: Border.all(color: ColorPalette.primary, width: 1, ),
                                                                  //                                       ),
                                                                  //                                       child:  Center(
                                                                  //                                           child: Text(
                                                                  //                                             "Cancel",
                                                                  //                                             style: TextStyle(
                                                                  //                                               color: ColorPalette.primary,
                                                                  //                                               fontSize: w/22,
                                                                  //                                             ),
                                                                  //                                           )
                                                                  //                                       ),
                                                                  //                                     ),
                                                                  //                                   ),
                                                                  //                                   GestureDetector(
                                                                  //                                     onTap: () {
                                                                  //                                       BlocProvider.of<TaskBloc>(context)
                                                                  //                                           .add(DeleteReviewEvent(reviewList[index].id??0));
                                                                  //                                       Navigator.pop(context);
                                                                  //                                       context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
                                                                  //                                     },
                                                                  //                                     child: Container(
                                                                  //                                         width: w / 3.1,
                                                                  //                                         padding: EdgeInsets.symmetric(vertical: 10),
                                                                  //                                         decoration: BoxDecoration(
                                                                  //                                           borderRadius: BorderRadius.circular(5),
                                                                  //                                           color: ColorPalette.primary,
                                                                  //                                         ),
                                                                  //
                                                                  //                                         child: Center(
                                                                  //                                           child: Text(
                                                                  //                                             "Delete",
                                                                  //                                             style: TextStyle(
                                                                  //                                               color: Colors.white,
                                                                  //                                               fontSize: w/22,
                                                                  //                                             ),
                                                                  //                                           ),
                                                                  //                                         )
                                                                  //                                     ),
                                                                  //                                   ),
                                                                  //                                 ])
                                                                  //                           ],
                                                                  //                         ),
                                                                  //                       );
                                                                  //                     });
                                                                  //               },
                                                                  //               child: Container(
                                                                  //                 padding: const EdgeInsets.only(left: 10),
                                                                  //                 child: Row(
                                                                  //                   children: [
                                                                  //                     // SvgPicture.string(TaskSvg().msgSendIcon),
                                                                  //                     // const SizedBox(width: 10,),
                                                                  //                     Text(
                                                                  //                       'Delete Comment',
                                                                  //                       style: GoogleFonts.poppins(
                                                                  //                           color: Colors.black54,
                                                                  //                           fontSize: w/30,
                                                                  //                           fontWeight: FontWeight.w500),
                                                                  //                     ),
                                                                  //                   ],
                                                                  //                 ),
                                                                  //               ),
                                                                  //             ),
                                                                  //
                                                                  //           ],
                                                                  //         ))
                                                                  //
                                                                  //   ],
                                                                  //   onSelected: (value) {
                                                                  //
                                                                  //   },
                                                                  // ),
                                                                ],
                                                              ),
                                                              Container(
                                                                // color: Colors.yellow,
                                                                width:w,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      reviewList[index].review??"",
                                                                      style: TextStyle(
                                                                        color: ColorPalette.black,
                                                                        fontSize: w/24,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    reviewList[index].reviewMeta?.image1==null?Container():
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                        showDialog(
                                                                            context: context,
                                                                            barrierDismissible: true,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                content: ImagePreview(
                                                                                  assetName: reviewList[index].reviewMeta?.image1??"",
                                                                                ),
                                                                              );
                                                                            }
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        height: h/10,
                                                                        width: w/3,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(
                                                                                image: NetworkImage(
                                                                                    reviewList[index].reviewMeta?.image1 ?? ""),
                                                                                fit: BoxFit.fill)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
    
                                                              SizedBox(
    
    
                                                                height: 20,
                                                              ),
    
                                                              reviewList[index].reviewedPersonCode==authentication.authenticatedUser.code?Container(
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                    onTap: (){
                                                                               review.text=reviewList[index].review??"";
                                                                               imageId=reviewList[index].reviewMeta?.image1??"";
                                                                                reviewid=reviewList[index].id??0;
                                                                                reviewUpdate=true;
                                                                                imageUrl=reviewList[index].reviewMeta?.image1;
                                                                                //  Navigator.pop(context);
                                                                                setState(() {
    
                                                                                });
                                                                              },
                                                                      child: Text("Edit",style: GoogleFonts.roboto(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: w/30
                                                                      ),),
                                                                    ),
                                                                    SizedBox(width: 15,),
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                         showDialog(
                                                                                      context: context,
                                                                                      builder: (BuildContext context) {
                                                                                        return AlertDialog(
                                                                                          content: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                "Are you Sure ?",
                                                                                                textAlign: TextAlign.center,
                                                                                                style: GoogleFonts.roboto(
                                                                                                  color: Color(0xff151522),
                                                                                                  fontSize: w/22,
                                                                  
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(height: 16,),
                                                                                              Text(
                                                                                                "Did you wants to delete this comment",
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(
                                                                                                  color: ColorPalette.subtextGrey,
                                                                                                  fontSize: w/27,
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(height: 16,),
                                                                                              Row(
                                                                                                  mainAxisAlignment:
                                                                                                  MainAxisAlignment.spaceBetween,
                                                                                                  children: <Widget>[
                                                                                                    GestureDetector(
                                                                                                      onTap: () {
                                                                                                        Navigator.of(context).pop();
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        width: w / 3.3,
                                                                                                        padding:
                                                                                                        EdgeInsets.symmetric(vertical: 10),
                                                                  
                                                                                                        decoration: BoxDecoration(
                                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                                          border: Border.all(color: ColorPalette.primary, width: 1, ),
                                                                                                        ),
                                                                                                        child:  Center(
                                                                                                            child: Text(
                                                                                                              "Cancel",
                                                                                                              style: TextStyle(
                                                                                                                color: ColorPalette.primary,
                                                                                                                fontSize: w/22,
                                                                                                              ),
                                                                                                            )
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    GestureDetector(
                                                                                                      onTap: () {
                                                                                                        BlocProvider.of<TaskBloc>(context)
                                                                                                            .add(DeleteReviewEvent(reviewList[index].id??0));
                                                                                                        Navigator.pop(context);
                                                                                                        context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
                                                                                                      },
                                                                                                      child: Container(
                                                                                                          width: w / 3.1,
                                                                                                          padding: EdgeInsets.symmetric(vertical: 10),
                                                                                                          decoration: BoxDecoration(
                                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                                            color: ColorPalette.primary,
                                                                                                          ),
                                                                  
                                                                                                          child: Center(
                                                                                                            child: Text(
                                                                                                              "Delete",
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.white,
                                                                                                                fontSize: w/22,
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                      ),
                                                                                                    ),
                                                                                                  ])
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      });
                                                                      },
                                                                      child: Text("Delete",style: GoogleFonts.roboto(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: w/30
                                                                      ),),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ):Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                              )
    
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
    
                            ],
                          ),
                          isUpoloading==true?Positioned(
                            top: h/3,
                              left:50,
                              right: 50,
                              child: Container(height: 100,width: 100,color: ColorPalette.white,
                              child: customCupertinoLoading(),)):Container()
                          ,
                          Positioned(
                            bottom: 0,
                            child: Column(
                              children: [
                                imageUrl==null?Container(
                                  height: h/16,
                                ):
                                Container(
                                  height: h/16,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  // color: ColorPalette.primary,
                                  child: Row(
                                    children: [
                                      SvgPicture.string(TaskSvg().shareIcon,height: 20,color: ColorPalette.primary,),
                                      SizedBox(width: 5,),
                                      Container(
                                          width:w/1.35,
                                          child: Text(imageUrl??"",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,)),
                                    ],
                                  ),),
                                Container(
                                    width: w,
                                    // height: 144,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                      ),
                                      color: Color(0xfff6f6f6),
                                    ),
                                    padding: EdgeInsets.only(left: 16,top: 16,bottom: 16,right: 5),
                                    child:
                                    Row(
                                      children: [
    
                                        Container(
                                          width: w/1.3,
    
                                          padding: EdgeInsets.only(left: 0, right: 0),
                                          child: TextFormField(
                                            controller: review,
                                            focusNode: focusNode,
                                            onChanged: (da){
                                              if(da!=""){
                                                onChanged=true;
                                              }
                                              else{
                                                onChanged=false;
                                              }
                                              setState(() {
    
                                              });
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: 16,right: 16),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                  borderSide: BorderSide(
                                                    color: Color(0xffe6ecf0),
                                                  )
                                              ), focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: Color(0xffe6ecf0),
                                                )
                                            ),enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: Color(0xffe6ecf0),
                                                )
                                            ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: "Type Comment",
                                              hintStyle: TextStyle(
                                                color: Color(0xffd7d7d7),
                                                fontSize: w/24,
                                              ),
                                              suffixIcon:  Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        getCoverImage(
                                                            ImageSource.gallery);
                                                        isUpoloading=true;
                                                        setState(() {
    
                                                        });
                                                      },
                                                      child: SvgPicture.string(TaskSvg().shareIcon,height: 20,color: ColorPalette.primary,)),
                                                ],
                                              ),
                                            ),
                                          ),
    
                                        ),
                                        SizedBox(width: 5,),
                                       GestureDetector(
                                            onTap: ()async{
                                              if(reviewUpdate==true){
                                                BlocProvider.of<TaskBloc>(context)
                                                    .add(UpdateReviewTaskEvent(
                                                  taskId: widget.taskId??0,
                                                  image: imageId,
                                                  id: reviewid,
                                                  notes: review.text??"",
                                                  review: review.text??"",
                                                  reviewdBy: authentication.authenticatedUser.code??"",
                                                  parant: null,
                                                  isActive: true,
    
                                                ));
                                                context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
                                              }
                                              else{
                                                BlocProvider.of<TaskBloc>(context)
                                                    .add(CreateReviewTaskEvent(
                                                  image: imageId??0,
                                                  taskId:widget.taskId??0,
                                                  notes: review.text??"",
                                                  review: review.text??"",
                                                  reviewdBy: authentication.authenticatedUser.code??"",
                                                  parant: null,
    
                                                ));
                                                context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
                                              }
    
    
    
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              padding: EdgeInsets.all(12),
                                              child: SvgPicture.string(TaskSvg().sendIcon,
                                                color: ColorPalette.primary,
                                              ),
                                            ))
                                      ],
                                    )
    
    
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
        ]
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
  Future<void> getCoverImage(source) async {
    try {
      final pickedFile = await picker.pickImage(
          source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        // BlocProvider.of<DiscountBloc>(context)
        //     .add(PostImageDiscountEvent(cropImage!));
        BlocProvider.of<EmployeeBloc>(context).add(PostImageAllEvent(cropImage!));

      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
