
import 'dart:io';

import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/common_snackBar.dart';
import '../../inventory/inventory_new_list.dart';
import '../create/model/task_models.dart';
import '../create/task_bloc/task_bloc.dart';
import '../employee_bloc/employee_bloc.dart';
import '../task_operation_appbar.dart';
import 'comment_img_card.dart';

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
  bool reviewUpdate=false;
  int reviewid=0;
  List<ReviewModel> reviewList=[];
  TextEditingController review=TextEditingController();
  @override
  void initState() {

    context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
    context.read<ProfileBloc>().add(GetProfilePicEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
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
      });
      print("pic model length${picModel.length}");

    }
  },
),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        print('StateCreate$state');
        if (state is CreateReviewLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
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
              msg: 'Successfully Created',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          review.clear();


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
          review.clear();


        }
      },
    ),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
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
          // createJob = state.user;

          Fluttertoast.showToast(
              msg: 'Successfully Deleted',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          Navigator.pop(context);
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
          setState(() {

          });
        }
      },
    ),
  ],
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.white, // Status bar
          ),

          elevation: 0,

        ),
      ),
      body: SafeArea(
          child: Container(
        height: h,
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: NoGlow(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TaskAndOperationAppBar(
                      label: "Comments",
                    ),
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
                              height: 5,
                            ),
                            itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              CircleAvatar(
                                        backgroundImage:AssetImage("asset/newprofile.png"),
                                      ),
                                  // BlocBuilder<ProfileBloc, ProfileState>(
                                  //     builder: (context, state) {
                                  //       print("..................$state");
                                  //       if(state is ProfilePicSuccess){
                                  //         print(state.profilePic);
                                  //         return CircleAvatar(
                                  //           backgroundImage:NetworkImage(state.profilePic),
                                  //         );
                                  //       }
                                  //     return Image.asset("asset/newprofile.png");
                                  //   }
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: w / 1.3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      reviewList[index].reviewedPersonName??"",
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: w/22,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      reviewList[index].reviewOn?.split("T")[1].split(".")[0]??"",
                                                      style: GoogleFonts.roboto(
                                                        color: ColorPalette.subtextGrey,
                                                        fontSize: w/27,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            PopupMenuButton(
                                              icon: Icon(Icons.more_vert,color: Colors.black,),
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
                                                            review.text=reviewList[index].review??"";
                                                            imageId=reviewList[index].reviewMeta?.image1??"";
                                                            reviewid=reviewList[index].id??0;
                                                            reviewUpdate=true;
                                                            Navigator.pop(context);
                                                            setState(() {

                                                            });
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.only(left: 10),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.string(TaskSvg().editorIcon),
                                                                const SizedBox(width: 10,),
                                                                Text(
                                                                  'Edit Review',
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.black54,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Divider(indent: 30,),
                                                        GestureDetector(
                                                          onTap: (){
                                                            Navigator.pop(context);
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
                                                                            fontSize: 22,

                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 16,),
                                                                        Text(
                                                                          "Did you wants to Job.This process cannot be undone",
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
                                                                                    border: Border.all(color: Color(0xffed4e4e), width: 1, ),
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
                                                                                      color: Color(0xffed4e4e),
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
                                                          child: Container(
                                                            padding: const EdgeInsets.only(left: 10),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.string(TaskSvg().msgSendIcon),
                                                                const SizedBox(width: 10,),
                                                                Text(
                                                                  'Delete Review',
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.black54,
                                                                      fontSize: w/30,
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
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
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
                                        Row(
                                          children: [
                                            Container(
                                              height: h/10,
                                              width: w/3,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          reviewList[index].reviewMeta?.image1 ?? ""),
                                                      fit: BoxFit.fill)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            // GestureDetector(
                                            //   onTap: ()async{
                                            //
                                            //     try {
                                            //       // Saved with this method.
                                            //       var imageId = await ImageDownloader.downloadImage(reviewList[index].image??"");
                                            //       if (imageId == null) {
                                            //         return;
                                            //       }
                                            //
                                            //       // Below is a method of obtaining saved image information.
                                            //       var fileName = await ImageDownloader.findName(imageId);
                                            //       var path = await ImageDownloader.findPath(imageId);
                                            //       var size = await ImageDownloader.findByteSize(imageId);
                                            //       var mimeType = await ImageDownloader.findMimeType(imageId);
                                            //     } on PlatformException catch (error) {
                                            //       print("Shifas$error");
                                            //     }
                                            //   },
                                            //   child: SvgPicture.string(
                                            //       TaskSvg().downloadIcon),
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
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
                padding: EdgeInsets.only(left: 16,top: 16,bottom: 16),
                child:
                    Row(
                      children: [

                        Container(
                          width: w/1.3,

                          padding: EdgeInsets.only(left: 16, right: 0),
                          child: TextFormField(
                            controller: review,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 16,right: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xffe6ecf0),
                                    )
                                ), focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xffe6ecf0),
                                    )
                                ),enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xffe6ecf0),
                                    )
                                ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Message",
                              hintStyle: TextStyle(
                                color: Color(0xffd7d7d7),
                                fontSize: w/22,
                              ),
                              suffixIcon:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        getCoverImage(
                                            ImageSource.gallery);
                                      },
                                      child: SvgPicture.string(TaskSvg().shareIcon,height: 25,)),
                                ],
                              ),
                            ),
                          ),

                        ),
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
                            child: SvgPicture.string(TaskSvg().sendIcon,height: 60,)),
                      ],
                    )


              ),
            )
          ],
        ),
      )),
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
