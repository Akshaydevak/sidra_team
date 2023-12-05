import 'dart:io';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../inventory/inventory_new_list.dart';
import '../create/model/task_models.dart';
import '../create/task_bloc/task_bloc.dart';
import '../employee_bloc/employee_bloc.dart';
import '../image_preview_task.dart';
import '../lottieLoader.dart';

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
  dynamic imageId;
  dynamic imageUrl;
  FocusNode focusNode = FocusNode();
  bool reviewUpdate = false;
  int reviewid = 0;
  List<ReviewModel> reviewList = [];
  List<String> startTime = [];
  bool onChanged = false;
  TextEditingController review = TextEditingController();


  @override
  void initState() {
    context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
    super.initState();
  }

  bool isUpoloading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  bool isLongPress = false;

  int reviewId1 = 0;
  String imageId1 = '';
  String imageUrl1 = "";
  String reviewText1 = "";
  List<ChatModel> chatModel = [];
  List<String> chatList = [];

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        print("will pop scope");
        context.read<TaskBloc>().add(GetTopicListEvent());
        return true;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if (state is PicSuccess) {
                print("Inside Success${state.data}\t${state.url}");
                setState(() {
                  // picModel.replaceRange(indexImage, indexImage+1,
                  //      [PicModel(data: state.data,url: state.url)]);
                  imageId = state.data;
                  imageUrl = state.url;
                  isUpoloading = false;
                });
                print("pic model length${picModel.length}");
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is CreateReviewFailed) {
                Fluttertoast.showToast(
                    msg: state.error,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
              }
              if (state is CreateReviewSuccess) {
                Fluttertoast.showToast(
                    msg: 'Comments Added Successfully',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                imageId = null;
                imageUrl = null;
                review.clear();
                focusNode.unfocus();
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is UpdateReviewFailed) {
                Fluttertoast.showToast(
                    msg: state.error,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
              }
              if (state is UpdateReviewSuccess) {
                isLongPress = false;
                Fluttertoast.showToast(
                    msg: 'Comments Edited Successfully',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
                reviewUpdate = false;
                review.clear();
                focusNode.unfocus();
                imageUrl = null;
                imageId = null;
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              print("the state of delete$state");

              if (state is DeleteReviewFailed) {
                Fluttertoast.showToast(
                    msg: 'Review Not Deleted',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);
              }
              if (state is DeleteReviewSuccess) {
                isLongPress = false;
                print("delete res${state.status}");
                Fluttertoast.showToast(
                    msg: 'Comment Deleted Successfully',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black);

                context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
                setState(() {});
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              print('StateCreate$state');
              if (state is GetReviewListSuccess) {
                reviewList.clear();
                chatModel.clear();
                reviewList = state.reviewList;
                _isLoading = false;
                print("REVIEW LIST$reviewList");
                String currentName = '';
                List<MsgModel> msgModel = [];
                String currentMsg = '';

                for (final entry in reviewList) {
                  if (entry.reviewedPersonName == currentName) {
                    print("CAME HERE");
                    msgModel.add(MsgModel(
                      img: entry.reviewMeta?.image1,
                      msg: entry.review.toString(),
                      msgId: entry.id,
                    ));
                  } else {
                    currentName = entry.reviewedPersonName ?? "";
                    currentMsg = entry.reviewedPersonCode ?? "";
                    msgModel = [
                      MsgModel(
                          img: entry.reviewMeta?.image1,
                          msg: entry.review.toString(),
                          msgId: entry.id)
                    ];
                    chatModel.add(ChatModel(
                        name: currentName, msg: msgModel, code: currentMsg));
                  }
                }
                print("revvvvvvvv$currentMsg");
                print("chat model length${chatModel.length}");
                for (final entry in chatModel) {
                  print("Name: ${entry.name}");
                  print("Name: ${entry.msg}");
                  print("Name: ${entry.code}");
                }

                setState(() {});
              }
              if (state is GetReviewListFailed) {
                reviewList = [];
                _isLoading = false;
                setState(() {});
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
              width: w1,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                color: Color(0xfff6f6f6),
                // color: Colors.red
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: w1 / 1.32,
                    child: TextFormField(
                      controller: review,
                      focusNode: focusNode,
                      onChanged: (da) {
                        if (da != "") {
                          onChanged = true;
                        } else {
                          onChanged = false;
                        }
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 16, right: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Color(0xffe6ecf0),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Color(0xffe6ecf0),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Color(0xffe6ecf0),
                            )),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "your message ...",

                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xffd7d7d7),

                          fontSize: w / 24,
                        ),
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  getCoverImage(ImageSource.gallery);

                                  setState(() {});
                                  isUpoloading = true;
                                },
                                child: SvgPicture.string(
                                  TaskSvg().shareIcon,
                                  height: 20,
                                  color: Color(0xff6D6D6D),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () async {
                       if(review.text==""&&imageId==null){
                         Fluttertoast.showToast(
                             msg: "Add text or image",
                             toastLength:
                             Toast.LENGTH_SHORT,
                             gravity:
                             ToastGravity.BOTTOM,
                             backgroundColor:
                             ColorPalette.black,
                             textColor: Colors.white);
                       }
                       else{
                         if (reviewUpdate == true) {
                           BlocProvider.of<TaskBloc>(context)
                               .add(UpdateReviewTaskEvent(
                             taskId: widget.taskId ?? 0,
                             image: imageId??null,
                             id: reviewid,
                             notes: review.text ?? null,
                             review: review.text ?? null,
                             reviewdBy:
                             authentication.authenticatedUser.code ?? "",
                             parant: null,
                             isActive: true,
                           ));
                           context
                               .read<TaskBloc>()
                               .add(GetReviewListEvent(widget.taskId));
                         } else {
                           BlocProvider.of<TaskBloc>(context)
                               .add(CreateReviewTaskEvent(
                             image: imageId ?? null,
                             taskId: widget.taskId ?? 0,
                             notes: review.text ?? null,
                             review: review.text ?? null,
                             reviewdBy:
                             authentication.authenticatedUser.code ?? "",
                             parant: null,
                           ));
                           context
                               .read<TaskBloc>()
                               .add(GetReviewListEvent(widget.taskId));
                         }
                       }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorPalette.primary,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(12),
                        child: SvgPicture.string(
                          TaskSvg().sendIcon,
                          color: ColorPalette.white,
                        ),
                      ))
                ],
              )),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: BackAppBar(
              label: "Comments",
              isAction: false,
              action: isLongPress == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              review.text = reviewText1 ?? "";
                              imageId = imageId1 ?? "";
                              reviewid = reviewId1 ?? 0;
                              reviewUpdate = true;
                              imageUrl = imageUrl1;
                              //  Navigator.pop(context);
                              setState(() {});
                            },
                            child: SvgPicture.string(
                              HomeSvg().penIcon,
                              height: 18,
                              width: 18,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
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
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "Did you wants to delete this comment",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ColorPalette.subtextGrey,
                                              fontSize: w / 27,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    width: w / 3.3,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color: ColorPalette
                                                            .primary,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: ColorPalette
                                                            .primary,
                                                        fontSize: w / 22,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    BlocProvider.of<TaskBloc>(
                                                            context)
                                                        .add(DeleteReviewEvent(
                                                            reviewId1 ?? 0));
                                                    Navigator.pop(context);
                                                    context
                                                        .read<TaskBloc>()
                                                        .add(GetReviewListEvent(
                                                            widget.taskId));
                                                  },
                                                  child: Container(
                                                      width: w / 3.1,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: ColorPalette
                                                            .primary,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: w / 22,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ])
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: SvgPicture.string(
                              HomeSvg().deleteBox,
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              isBack: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<TaskBloc>().add(GetReviewListEvent(widget.taskId));
              return Future<void>.delayed(const Duration(seconds: 2));
            },
            key: _refreshIndicatorKey,
            color: ColorPalette.primary,
            // backgroundColor: Colors.transparent,

            strokeWidth: 2.0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_isLoading) ...[
                    LottieLoader()
                  ] else ...[
                    ScrollConfiguration(
                      behavior: NoGlow(),
                      child: SafeArea(
                          child: Stack(
                            children: [
                              ListView.separated(
                        primary: true,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 100, left: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: chatModel.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 15,
                        ),
                        itemBuilder: (context, index) => Container(
                              // color: Colors.blue,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SvgPicture.string(TaskSvg().profileReporting),
                                    TextAvatar(
                                      shape: Shape.Circular,
                                      size: 32,
                                      numberLetters: 2,
                                      fontSize: w / 28,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      text: chatModel[index].name?.toUpperCase(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: w / 1.28,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5,),
                                          Text(
                                            chatModel[index]
                                                    .name
                                                    .toString()
                                                    .toTitleCase(),
                                            style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: w / 26,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          ListView.separated(
                                            primary: true,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, position) {
                                              return GestureDetector(
                                                onLongPress: () {
                                                  if (authentication
                                                          .authenticatedUser.code ==
                                                      chatModel[index].code) {
                                                    isLongPress = true;
                                                    reviewText1 = chatModel[index]
                                                            .msg?[position]
                                                            .msg ??
                                                        "";
                                                    imageId1 = chatModel[index]
                                                            .msg?[position]
                                                            .img ??
                                                        "";
                                                    reviewId1 = chatModel[index]
                                                            .msg?[position]
                                                            .msgId ??
                                                        0;
                                                    imageUrl1 = chatModel[index]
                                                            .msg?[position]
                                                            .img ??
                                                        "";
                                                    //  Navigator.pop(context);
                                                    setState(() {});
                                                  } else {
                                                    isLongPress = false;
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "You can't edit this message",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            ColorPalette.black,
                                                        textColor: Colors.white);
                                                    print("LONG PRESS");
                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10, vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(
                                                                      10),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      10),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      10)),
                                                      color: authentication
                                                                  .authenticatedUser
                                                                  .code ==
                                                              chatModel[index].code
                                                          ? Color(0xffF7F7F7)
                                                          : Color(0xff086DB5)
                                                              .withOpacity(0.08)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      chatModel[index]
                                                                  .msg?[position]
                                                                  .msg ==
                                                              ""
                                                          ? Container()
                                                          : Text(
                                                              chatModel[index]
                                                                      .msg?[
                                                                          position]
                                                                      .msg ??
                                                                  "",
                                                              style: TextStyle(
                                                                color: ColorPalette
                                                                    .black,
                                                                fontSize: w / 24,
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      chatModel[index]
                                                                  .msg?[position]
                                                                  .img ==
                                                              null
                                                          ? Container()
                                                          : GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            ImagePreview(
                                                                          assetName:
                                                                              chatModel[index].msg?[position].img ??
                                                                                  "",
                                                                        ),
                                                                      );
                                                                    });
                                                              },
                                                              child: Container(
                                                                height: 90,
                                                                width: 90,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            chatModel[index].msg?[position].img ??
                                                                                ""),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, position) {
                                              return SizedBox(
                                                height: 5,
                                              );
                                            },
                                            itemCount: chatModel[index].msg!.length,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                        ),
                      ),
                              isUpoloading==true?Positioned(
                                top: 220,
                                left: 140,
                                child: Container(
                                  padding: EdgeInsets.all(25),
                                  color: Colors.white,
                                  child: CircularProgressIndicator(color: ColorPalette.primary,strokeWidth: 3,),
                                ),
                              ):Container()
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
      final pickedFile =
          await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        // BlocProvider.of<DiscountBloc>(context)
        //     .add(PostImageDiscountEvent(cropImage!));
        BlocProvider.of<EmployeeBloc>(context)
            .add(PostImageAllEvent(cropImage!));
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class ChatModel {
  final String? name;
  final String? code;
  final List<MsgModel>? msg;
  ChatModel({this.name, this.msg, this.code});
}

class MsgModel {
  final int? msgId;
  final String? img;
  final String? msg;
  MsgModel({this.img, this.msgId, this.msg});
}
