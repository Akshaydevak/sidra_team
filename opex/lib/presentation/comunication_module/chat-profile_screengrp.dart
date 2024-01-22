import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/comunication_module/add_group_member.dart';
import 'package:cluster/presentation/comunication_module/bloc/attachment_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/media_list.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';

class ChatProfileScreen2 extends StatefulWidget {
  bool isGroup;
  final UserDummyList? communicationUserModel;
  final GroupList? communicationuser;
  final String? token;
  final Socket? socket;
  final String? roomId;
  final bool chat;
  ChatProfileScreen2(
      {Key? key,
      this.isGroup = false,
      this.communicationuser,
      this.chat=false,
      this.communicationUserModel,
      this.socket,
      this.roomId,
      required this.token})
      : super(key: key);

  @override
  State<ChatProfileScreen2> createState() => _ChatProfileScreen2State();
}

class _ChatProfileScreen2State extends State<ChatProfileScreen2> {
  bool isMute = false;
  List<GroupUserList> grpmember=[];
  bool isM=true;
  String uid='';
    @override
  void initState() {

 widget.socket!.emit("group.members", 
     widget.chat==false? widget.communicationUserModel?.chatid : widget.communicationuser?.chatid);
     
    widget.socket!.on("groupmembers.result", (data){ 
      print("group members: $data");
      grpmember.clear();
    (data as List).forEach((element) {
    grpmember.add(GroupUserList.fromJson(element));
   
      });
      isM=false;
 print(grpmember.length);
 if(this.mounted){
    setState(() {
      
    });
 }
    });
     
widget.socket?.on("memberAddedToGroup", (data) => print("member added to grp :$data"));
    // TODO: implement initState
    super.initState();
  }

  @override


  @override
  Widget build(BuildContext context) {
    // print("chat id ${widget.communicationUserModel?.chatid} ${widget.communicationuser?.chatid}");
    var w = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => GroupBloc()
          //     ..add(GroupProfileGet(
          //         chatid: widget.communicationUserModel?.chatid ?? "",
          //         token: widget.token ?? "")),
          // ),
          BlocProvider(
            create: (context) => AttachmentBloc()
              ..add(GroupProfileAttachmentsGet(
                  chatId: widget.chat==false? widget.communicationUserModel?.chatid ?? "":widget.communicationuser?.chatid??"",
                  token: widget.token ?? "")),
          )
        ],
    
    child: MultiBlocListener(
      listeners: [
    BlocListener<GroupBloc, GroupState>(
      listener: (context, state) {
        if (state is GroupLeaveLoading) {
          print("group leave loading");
        } else if (state is GroupLeaveSuccess) {
          showSnackBar(context,
              message: state.successMessage, color: Colors.green);
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CommunicationModule(
              // token: widget.token ?? ""
              socket: widget.socket,
            ),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        } else if (state is GroupLeaveFailed) {
          showSnackBar(context, message: state.error, color: Colors.green);
        }
      },
    ),
    BlocListener<GroupBloc, GroupState>(
      listener: (context, state) {
        print("state found ${state}");
        if (state is GroupMemberDeleteLoading) {
          print("group delete loading");
        } else if (state is GroupMemberDeleteSuccess){
          print("success");
           
        widget.socket!.emit("group.members",{widget.chat==false? widget.communicationUserModel?.chatid:widget.communicationuser?.chatid,uid});
                     widget.socket!.on("groupmembers.result", (data) => print("update"));
       
                    showSnackBar(context,
              message: state.successmsg, color: Colors.green);
              BlocProvider.of<CommunicationBloc>(context).add(
                GetChatListEvent(token: widget.token??"")
              );
              //   BlocProvider.of<AttachmentBloc>(context)
              // .add(GroupProfileAttachmentsGet(
              //     chatId: widget.communicationUserModel?.id ?? "",
              //     token: widget.token ?? "")
          // );
              setState(() {
                
              });
        } else if (state is GroupMemberDeleteFailed) {
          showSnackBar(context, message: state.error, color: Colors.green);
        }
      },
    ),
    ],
      
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // Navigation bar
              statusBarColor: Colors.white, // Status bar
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body:isM==true?LottieLoader(): SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    // width: w,
                    child: widget.communicationUserModel?.photo==null||
                      widget.communicationUserModel!.photo!.isEmpty 
                      ?TextAvatar(
               shape: Shape.Circular,
               size: 120,
               numberLetters: 2,
               fontSize: w/11,
               textColor: Colors.white,
               fontWeight: FontWeight.w500,
               text:widget.chat==false?"${widget.communicationUserModel?.name.toString().toUpperCase()}":"${widget.communicationuser?.gname.toString().toUpperCase()}" ,
             ):
                    
                    CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          widget.isGroup?
                          widget.chat==false?widget.communicationUserModel?.photo ?? "":widget.communicationuser?.gphoto ?? "":
                          //  "https://api-uat-user.sidrabazar.com/media/${widget.communicationUserModel?.users?[0].photo}"
                          // "${widget.communicationUserModel?.photo}"
                          widget.chat==false?widget.communicationUserModel?.photo ?? "":widget.communicationuser?.gphoto ?? ""
                          ,
                          
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.communicationUserModel?.isgrp == false
                      ? Text(
                          widget.chat==false?widget.communicationUserModel?.name ?? "":widget.communicationuser?.gname ?? "",
                          style: GoogleFonts.roboto(
                            color: const Color(0xff151522),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Text(
                          widget.chat==false?widget.communicationUserModel?.name ?? "":widget.communicationuser?.gname ?? "",
                          style: GoogleFonts.roboto(
                            color: const Color(0xff151522),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                   
                    widget.isGroup
                        ? "Created by ${grpmember[0].createdBy.toString().toTitleCase()}"
                        : "",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 188, 212, 233),
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    width: w,
                    height: 6,
                    color: const Color(0xfff8f7f5),
                  ),
                  SizedBox(
                      width: w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.isGroup
                              ? BlocBuilder<AttachmentBloc, AttachmentState>(
                                  builder: (context, state) {
                                    if (state
                                        is GetGroupAttachmentsInProfileLoading) {
                                      customCupertinoLoading();
                                    } else if (state
                                        is GetGroupAttachmentsInProfileSuccess) {
                                      return Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 16, top: 25),
                                              child: Text(
                                                "Attachments",
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff151522),
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MediaList(
                                              messages: state.groupProfileGet
                                                  .media?.messages),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 16,
                                                top: 30,
                                                bottom: 10,
                                                right: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${grpmember.length} Members",
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        const Color(0xff151522),
                                                    fontSize: w / 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    print(widget.token);
                                                     BlocProvider.of<
                                                      GroupBloc>(context).add(
                                                        GetAllRegisteredUsersEvent("")
                                                      );
                                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                                  AddGroupMembers(
                                                    token: widget.token,
                                                    chatid:widget.communicationUserModel?.chatid,
                                                    socket: widget.socket,
                                                    isGroup: widget.isGroup,
                                                    communicationUserModel: widget.communicationUserModel,
                                                  )));
                                                  },
                                                  child: Text(
                                                    "Add Member",
                                                    style: GoogleFonts.roboto(
                                                      color:
                                                          ColorPalette.primary,
                                                      fontSize: w / 20,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:16,right: 16),
                                            child: Divider(
                                              color: const Color(0xffA9A8A8)
                                                  .withOpacity(0.3),
                                              thickness: 1.1,
                                            ),
                                          ),
                                          ListView.separated(
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: const EdgeInsets.all(16),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  itemCount: grpmember.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                      TextAvatar(
                                                        shape: Shape.Circular,
                                                        size: 48,
                                                        numberLetters: 2,
                                                        fontSize: w/22,
                                                        textColor: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        text:"${grpmember[index].name.toString().toUpperCase()}" ,
                                                      ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              
                                                                  "${grpmember[index].name.toString().toTitleCase()}",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff151522),
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            index == 0
                                                                ? const Text(
                                                                    "Moderator",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorPalette.primary,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  )
                                                                : Container()
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    // IconButton(onPressed: (){
                                                    //     print("hello");
                                                    //               uid=grpmember[index].name!;
                                                                 
                                                    //                setState(() {

                                                    //               widget.socket!.emit("removeUserFromGroup",
                                                    //               {"userId":grpmember[index].id??"",
                                                    //               "chatId":widget.communicationUserModel!.chatid??""
                                                    //               }
                                                    //               );
                                                    //                widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
                                                    //                widget.socket!.on("userRemovedFromGroup", (data) {
                                                    //                  widget.socket!.emit("group.members",{widget.chat==false? widget.communicationUserModel?.chatid:widget.communicationuser?.chatid,uid});
                                                    //                 showSnackBar(context, message: data, color: Colors.black);
                                                    //               } );
                                                    //               widget.socket!.emit("group.message",{
                                                    //                 "type": "notify", "chatid": widget.communicationUserModel?.chatid, "content": "${grpmember[index].name} is deleted from group"
                                                    //               }); 
                                                    //                 });
                                                    // }, icon: Icon(Icons.delete)),
                                                    PopupMenuButton(
                                                      icon: SvgPicture.string(
                                                          TaskSvg().moreIcon),
                                                      //don't specify icon if you want 3 dot menu
                                                      color: Colors.white,
                                                      elevation: 2,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      itemBuilder: (context) =>
                                                          [
                                                        PopupMenuItem(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            value: 'a',
                                                            enabled: true,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                // Container(
                                                                //   padding: const EdgeInsets
                                                                //           .only(
                                                                //       left: 10),
                                                                //   child: Text(
                                                                //     'Edit this Job',
                                                                //     style: GoogleFonts.poppins(
                                                                //         color: Colors
                                                                //             .black54,
                                                                //         fontSize:
                                                                //             13,
                                                                //         fontWeight:
                                                                //             FontWeight.w500),
                                                                //   ),
                                                                // ),
                                                                // const Divider(
                                                                //   indent: 30,
                                                                // ),
                                                                GestureDetector(
                                                                onTap: (){
                                                                  print("hello");
                                                                  uid=grpmember[index].name!;
                                                                 
                                                                   showDialog(
                                                                            context: context, builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                insetPadding: EdgeInsets.symmetric(vertical:20),
                                                                                content: Text("Delete ${grpmember[index].name?.toLowerCase().toTitleCase()} from this group"),
                                                                                actions: [
                                                                                  Row( mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      TextButton(onPressed: (){
                                                                                        Navigator.pop(context);
                                                                                      }, child: Text("Cancel")),
                                                                                      TextButton(onPressed: (){
                                                                                         setState(() {
                                                                                        widget.socket!.emit("removeUserFromGroup",
                                                                                    {"userId":grpmember[index].id??"",
                                                                                    "chatId":widget.communicationUserModel!.chatid??""
                                                                                    }
                                                                                    );
                                                                                    widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
                                                                                    widget.socket!.on("userRemovedFromGroup", (data) {
                                                                                      widget.socket!.emit("group.members",{widget.chat==false? widget.communicationUserModel?.chatid:widget.communicationuser?.chatid,uid});
                                                                                      showSnackBar(context, message: data, color: Colors.black);
                                                                                    } );
                                                                                    widget.socket!.emit("group.message",{
                                                                                      "type": "notify", "chatid": widget.communicationUserModel?.chatid, "content": "${grpmember[index].name.toString().toTitleCase()} is deleted from group"
                                                                                    }); 
                                                                                    Navigator.pop(context);
                                                                                      });
                                                                              
                                                                                      }, child: Text("Delete"))
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              );
                                                                            },
                                                                            );
                                                                
                                                                },
                                                                child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10),
                                                                  child: Text(
                                                                    'Delete',
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            w/26,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
                                                                ),
                                                              ),
                                                              ],
                                                            ))
                                                      ],
                                                      onSelected: (value) {},
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(
                                                        indent: 50,
                                                        thickness: 1.1,
                                                      ),
                                              ),
                                        ],
                                      );
                                    }
                                    return Column(
                                      children: [
                                        // Align(
                                        //   alignment: Alignment.centerLeft,
                                        //   child: Container(
                                        //     padding: const EdgeInsets.only(
                                        //         left: 16, top: 25),
                                        //     child: Text(
                                        //       "Attachments",
                                        //       style: GoogleFonts.roboto(
                                        //         color: const Color(0xff151522),
                                        //         fontSize: w / 22,
                                        //         fontWeight: FontWeight.w500,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // const MediaList(),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 18,
                                              top: 30,
                                              bottom: 10,
                                              right: 18),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${grpmember.length} Members",
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff151522),
                                                  fontSize: w / 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  print(widget.token);
                                                  context.read<GroupBloc>().add(GetAllRegisteredUsersEvent(""));
                                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                                  AddGroupMembers(
                                                    token: widget.token,
                                                    chatid:widget.communicationUserModel?.chatid,
                                                    socket: widget.socket,
                                                    isGroup: widget.isGroup,
                                                    // communicationUserModel: widget.communicationUserModel,
                                                  )));
                                                },
                                                child: Text(
                                                  "Add Member",
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        ColorPalette.primary,
                                                    fontSize: w / 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:16,right: 16),
                                          child: Divider(
                                            color: const Color(0xffA9A8A8)
                                                .withOpacity(0.3),
                                            thickness: 1.1,
                                          ),
                                        ),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            primary: false,
                                            padding: const EdgeInsets.all(16),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemCount: grpmember.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      TextAvatar(
                                                        shape: Shape.Circular,
                                                        size: 48,
                                                        numberLetters: 2,
                                                        fontSize: w/22,
                                                        textColor: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        text:"${grpmember[index].name.toString().toUpperCase()}" ,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                        "${grpmember[index].name.toString().toTitleCase()}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff151522),
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          index == 0
                                                              ? const Text(
                                                                  "Moderator",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorPalette.primary,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                )
                                                              : Container()
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  
                                                  PopupMenuButton(
                                                    icon: SvgPicture.string(
                                                        TaskSvg().moreIcon),
                                                    //don't specify icon if you want 3 dot menu
                                                    color: Colors.white,
                                                    elevation: 2,
                                                    padding: EdgeInsets.zero,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          value: 'a',
                                                          enabled: true,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Container(
                                                              //   padding:
                                                              //       const EdgeInsets
                                                              //               .only(
                                                              //           left:
                                                              //               10),
                                                              //   child: Text(
                                                              //     'Edit this Job',
                                                              //     style: GoogleFonts.poppins(
                                                              //         color: Colors
                                                              //             .black54,
                                                              //         fontSize:
                                                              //             13,
                                                              //         fontWeight:
                                                              //             FontWeight
                                                              //                 .w500),
                                                              //   ),
                                                              // ),
                                                              // const Divider(
                                                              //   indent: 30,
                                                              // ),
                                                              GestureDetector(
                                                                onTap: (){
                                                                  print("hello");
                                                                  widget.socket!.emit("update.list",{
                                                                    
                                                                                      print("update")
                                                                                    });
                                                                                    widget.socket!.on("friends.update", (data) {
                                                                      print(data);
                                                                      setState(() {
                                                                        
                                                                      });
                                                                    } );
                                                                  uid=grpmember[index].id!;
                                                                  // BlocProvider.of<GroupBloc>(context).add(

                                                                    //   GroupMemberDeleteEvent(
                                                                    //     token:widget.token??"", 
                                                                    //     chatId: widget.communicationUserModel!.chatid??"", 
                                                                    //     userId:grpmember[index].id??"")
                                                                    // );
                                                                    showDialog(
                                                                            context: context, builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                content: Text("Delete ${grpmember[index].name?.toLowerCase().toTitleCase()} from this group?"),
                                                                                actions: [
                                                                                  Row( mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      TextButton(onPressed: (){
                                                                                        Navigator.pop(context);
                                                                                      }, child: Text("Cancel",style: TextStyle(color: ColorPalette.primary),)),
                                                                                      TextButton(onPressed: (){
                                                                                         setState(() {
                                                                                        widget.socket!.emit("removeUserFromGroup",
                                                                                    {"userId":grpmember[index].id??"",
                                                                                    "chatId":widget.communicationUserModel!.chatid??""
                                                                                    }
                                                                                    );
                                                                                    widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
                                                                                    widget.socket!.on("userRemovedFromGroup", (data) {
                                                                                      widget.socket!.emit("group.members",{widget.chat==false? widget.communicationUserModel?.chatid:widget.communicationuser?.chatid,uid});
                                                                                      showSnackBar(context, message: data, color: Colors.black);
                                                                                    } );
                                                                                    widget.socket!.emit("group.message",{
                                                                                      "type": "notify", "chatid": widget.communicationUserModel?.chatid, "content":"${grpmember[index].name.toString().toTitleCase()} is deleted from group "
                                                                                    }); 
                                                                                    Navigator.pop(context);
                                                                                      });

                                                                                      }, child: Text("Delete",style: TextStyle(color: ColorPalette.primary),))
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              );
                                                                            },
                                                                            );
                                                                
                                                                  
                                                                },
                                                                child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10),
                                                                  child: Text(
                                                                    'Delete',
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            w/26,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                    onSelected: (value) {},
                                                  ),
                                                ],
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                                      indent: 50,
                                                      thickness: 1.1,
                                                    ),
                                            
                                            ),
                                      ],
                                    );
                                  },
                                )
                              : BlocBuilder<GroupBloc, GroupState>(
                                  builder: (context, state) {
                                    print("check the state $state");
                                    if (state
                                        is GetGroupProfileDetailsLoading) {
                                      customCupertinoLoading();
                                    } else if (state
                                        is GetGroupProfileDetailsSuccess) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 25),
                                            child: Text(
                                              "Attachments",
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff151522),
                                                fontSize: w / 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MediaList(
                                              messages: state.profileGetModel
                                                  .media?.messages),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 16, top: 20),
                                            child: Text(
                                              "Groups",
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff151522),
                                                fontSize: w / 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: const Color(0xffA9A8A8)
                                                .withOpacity(0.3),
                                            thickness: 1.1,
                                          ),
                                          ListView.separated(
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: const EdgeInsets.all(16),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor:
                                                          const Color(
                                                              0xff1ECAC0),
                                                      child: Text(
                                                        "R",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: Colors.white,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state
                                                                  .profileGetModel
                                                                  .groups?[
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xff151522),
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        const Text(
                                                          "Moderator",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: ColorPalette.primary,
                                                            fontSize: 15,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(
                                                        indent: 50,
                                                        thickness: 1.1,
                                                      ),
                                              itemCount: state.profileGetModel
                                                      .groups?.length ??
                                                  0),
                                        ],
                                      );
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 25),
                                          child: Text(
                                            "Attachments",
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff151522),
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const MediaList(),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 20),
                                          child: Text(
                                            "Groups",
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff151522),
                                              fontSize: w / 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: const Color(0xffA9A8A8)
                                              .withOpacity(0.3),
                                          thickness: 1.1,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          Container(
                            width: w,
                            height: 6,
                            color: const Color(0xfff8f7f5),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: const EdgeInsets.all(16),
                              width: w,
                              // padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xffe6ecf0),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16, top: 16),
                                  child: SingleRow(
                                    label: widget.isGroup
                                        ? "Notify me on due date"
                                        : "Mute Notifications",
                                    color: const Color(0xffFFC800),
                                    svg: TaskSvg().notificationIcon,
                                    endIcon: isMute
                                        ? SvgPicture.string(
                                            HomeSvg().toggleActive)
                                        : SvgPicture.string(
                                            HomeSvg().toggleInActive),
                                    onTap: () {
                                      setState(() {
                                        isMute = !isMute;
                                      });
                                    },
                                  ),
                                ),
                              ])),
                          widget.isGroup
                              ? InkWell(
                                  onTap: () {
                                    alertbox();
                                    
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(16),
                                    width: 382,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0xffe6ecf0),
                                        width: 1,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Leave Chat",
                                      style: GoogleFonts.roboto(
                                        color: const Color(0xfffe5762),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  // margin: const EdgeInsets.all(16),
                                  // width: 382,
                                  // height: 60,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   border: Border.all(
                                  //     color: const Color(0xffe6ecf0),
                                  //     width: 1,
                                  //   ),
                                  //   boxShadow: const [
                                  //     BoxShadow(
                                  //       color: Color(0x05000000),
                                  //       blurRadius: 8,
                                  //       offset: Offset(1, 1),
                                  //     ),
                                  //   ],
                                  //   color: Colors.white,
                                  // ),
                                  // alignment: Alignment.center,
                                  // child: Text(
                                  //   "Block @name",
                                  //   style: GoogleFonts.roboto(
                                  //     color: const Color(0xfffe5762),
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                  )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  alertbox(){
    showDialog(
      context: context, builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Do you want to leave this group",textAlign: TextAlign.center,),
          actions: [
            Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),
                TextButton(onPressed: (){
                  BlocProvider.of<GroupBloc>(context).add(
                    GroupLeaveEvent(
                      roomId: widget.roomId ?? "",
                      token: widget.token ?? ""
                    )
                  );

                }, child: Text("Leave"))
              ],
            )
          ],
        );
      },
      );
  }
    alertbox2(){
    showDialog(
      context: context, builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Remove to leave this group"),
          actions: [
            Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),
                TextButton(onPressed: (){
                  BlocProvider.of<GroupBloc>(context).add(
                    GroupLeaveEvent(
                      roomId: widget.roomId ?? "",
                      token: widget.token ?? ""
                    )
                  );

                }, child: Text("Leave"))
              ],
            )
          ],
        );
      },
      );
  }
}
