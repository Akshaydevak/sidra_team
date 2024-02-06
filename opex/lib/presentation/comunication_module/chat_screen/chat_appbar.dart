import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat-profile_screengrp.dart';
import 'package:cluster/presentation/comunication_module/chat_profile_screen.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart';

class ChatAppBar extends StatefulWidget {
  final UserDummyList? communicationUserModel;
  final CommunicationUserModel? communicationuser;
  final bool? typing;
  final bool chat;
  final bool isgrp;
  final String? loginUserId;
  final FromUser? groupTypingUser;
  final String redirectchatid;
  final String redirectchatname;
  final String? token;
  final Socket? socket;
  final String? roomId;
  final bool? isGroup;
  final String cmntgrpid;
  final String cmntgrpname;
  final GroupList? grpuser;
  List<GroupUserList>? grpmember = [];
  final bool? isadmin;
  // final VoidCallback ontap;
  ChatAppBar(
      {Key? key,
      this.communicationUserModel,
      this.communicationuser,
      this.grpuser,
      this.isadmin,
      this.cmntgrpid = "",
      this.cmntgrpname = "",
      this.redirectchatid="",
      this.redirectchatname="",
      this.loginUserId,
      this.typing,
      this.socket,
      this.isGroup,
      this.token,
      this.roomId,
      this.chat = false,
      this.isgrp = false,
      this.groupTypingUser,
      this.grpmember
      // required this.ontap
      })
      : super(key: key);

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  bool mounted = true;
  bool ismounted = true;
  bool ismount = true;
  SharedPreferences? pref;
  List<messageSeenList> left = [];
  Future<void> saveactiveusers(int count) async {
    print("my msg update count $count");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('activeuser', count);
  }

  @override
  void initState() {
    print("isadminn ${widget.isadmin} name ${widget.redirectchatname} ame ${widget.redirectchatid} ${widget.isGroup}");
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    widget.socket!.off('active.length');
    mounted = false;
    ismounted = false;
    ismount = false;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("shifas${widget.cmntgrpid}");
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      color: ColorPalette.primary,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (widget.isGroup == false) {
                      if (widget.chat == false) {
                        widget.socket!.emit("update.list", {print("update")});
                        widget.socket!.emit("leave.chat", {
                          "room": widget.roomId ?? "",
                          "userid":widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel?.id ?? ""
                        });
                        print("user left too");

                        print("user left too");
                        widget.socket!.on("left.room", (data) {
                          print("room left $data");

                          if (mounted) {
                            widget.socket!.off("get.clients");
                            widget.socket!.emit("get.clients", widget.roomId);
                            widget.socket!.off("active.length");
                            widget.socket!.on("active.length", (data) {
                              saveactiveusers(data);
                              print("ACTIVE ...length1 $data");
                            });
                          }
                          widget.socket!.on("msg1.seen", (data) {
                            print("room leave message $data");
                          });
                        });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data) {
                          print("user left");

                          if (data["userid"] == widget.loginUserId) {
                            print("ACTIVE length sharedprefww");
                            saveUnreadMessageCount(0, widget.roomId ?? "");
                            print("user left the room1 ${data["chatid"]}");
                            setState(() {});
                          } else {
                            print("same user id");
                          }
                        });

                        Navigator.pop(context);
                      } else {
                        BlocProvider.of<CommunicationBloc>(context).add(
                            GetFilterdChatListEvent(
                                token: widget.token ?? "",
                                chatFilter: "chats"));
                        Navigator.pop(context);
                        widget.socket!.emit("update.list", {print("update")});
                        widget.socket!.emit("leave.chat", {
                          "room": widget.roomId ?? "",
                          "userid":widget.redirectchatid!=""?widget.redirectchatid: widget.communicationuser?.users?[0].id ?? ""
                        });
                        print("user left too");

                        print("user left too");
                        widget.socket!.on("left.room", (data) {
                          print("room left $data");

                          if (mounted) {
                            widget.socket!.off("get.clients");
                            widget.socket!.emit("get.clients", widget.roomId);
                            widget.socket!.off("active.length");
                            widget.socket!.on("active.length", (data) {
                              saveactiveusers(data);
                              print("ACTIVE ...length1 $data");
                            });
                          }
                          widget.socket!.on("msg1.seen", (data) {
                            print("room leave message $data");
                          });
                        });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data) {
                          print("user left");

                          if (data["userid"] == widget.loginUserId) {
                            print("ACTIVE length sharedprefww");
                            saveUnreadMessageCount(0, widget.roomId ?? "");
                            print("user left the room1 ${data["chatid"]}");
                            setState(() {});
                          } else {
                            print("same user id");
                          }
                        });
                        Navigator.pop(context);
                      }
                    } else {
                      if (widget.isgrp == false) {
                        widget.socket!.emit("update.list", {print("update")});
                        widget.socket!.emit("leave.chat", {
                          "room": widget.roomId ?? "",
                          "userid": widget.redirectchatid!=""?widget.redirectchatid:widget.cmntgrpid!=""?widget.cmntgrpid: widget.communicationUserModel?.id ?? ""
                        });
                        print("user left too");

                        print("user left too");
                        widget.socket!.on("left.room", (data) {
                          print("room left $data");

                          if (mounted) {
                            widget.socket!.off("get.clients");
                            widget.socket!.emit("get.clients", widget.roomId);
                            widget.socket!.off("active.length");
                            widget.socket!.on("active.length", (data) {
                              saveactiveusers(data);
                              print("ACTIVE ...length1 $data");
                            });
                          }
                          if (ismount) {
                            widget.socket
                                ?.emit("group.message.seen", widget.roomId);
                            widget.socket?.on("msg.seen.by",
                                (data) => print("active userss $data"));
                          }

                          widget.socket!.on("msg1.seen", (data) {
                            print("room leave message $data");
                          });
                        });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data) {
                          print("user left");

                          if (data["userid"] == widget.loginUserId) {
                            print("ACTIVE length sharedprefww");
                            saveUnreadMessageCount(0, widget.roomId ?? "");
                            print("user left the room1 ${data["chatid"]}");
                            setState(() {});
                          } else {
                            print("same user id");
                          }
                        });

                        Navigator.pop(context);
                      } else {
                        widget.socket!.emit("update.list", {print("update")});
                        widget.socket!.emit("leave.chat", {
                          "room": widget.roomId ?? "",
                          "userid": widget.loginUserId ?? ""
                        });
                        print("user left too");

                        print("user left too");
                        widget.socket!.on("left.room", (data) {
                          print("room left $data");

                          if (mounted) {
                            widget.socket!.off("get.clients");
                            widget.socket!.emit("get.clients", widget.roomId);
                            widget.socket!.off("active.length");
                            widget.socket!.on("active.length", (data) {
                              saveactiveusers(data);
                              print("ACTIVE ...length1 $data");
                            });
                          }
                          widget.socket!.on("msg1.seen", (data) {
                            print("room leave message $data");
                          });
                        });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data) {
                          print("user left");

                          if (data["userid"] == widget.loginUserId) {
                            print("ACTIVE length sharedprefww");
                            saveUnreadMessageCount(0, widget.roomId ?? "");
                            print("user left the room1 ${data["chatid"]}");
                            setState(() {});
                          } else {
                            print("same user id");
                          }
                        });
                        Navigator.pop(context);
                      }
                      //           PersistentNavBarNavigator.pushNewScreen(
                      //   context,
                      //   screen: CommunicationModule(),
                      //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      // );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  )),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.isGroup == false) {
                    // PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: ChatProfileScreen(
                    //     chat: widget.chat,
                    //     token: widget.token,
                    //     roomId: widget.roomId,
                    //     socket: widget.socket,
                    //     isGroup: widget.communicationUserModel?.isgrp ?? false,
                    //     communicationUserModel: widget.communicationUserModel,
                    //     communicationuser: widget.communicationuser,
                    //   ),
                    //   withNavBar: true, // OPTIONAL VALUE. True by default.
                    //   pageTransitionAnimation: PageTransitionAnimation.fade,
                    // );
                  } else if(widget.cmntgrpid=="") {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ChatProfileScreen2(
                        chat: widget.isgrp,
                        token: widget.token,
                        roomId: widget.roomId,
                        socket: widget.socket,
                        loginuserid: widget.loginUserId,
                        isGroup: true,
                        isadmin: widget.isadmin,
                        redirectchatid: widget.redirectchatid,
                        redirectchatname: widget.redirectchatname,
                        communicationUserModel: widget.communicationUserModel,
                        communicationuser: widget.grpuser,
                        grpmember: widget.grpmember,

                      ),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  }
                },
                child:widget.isGroup==false? widget.communicationUserModel?.photo == null ||
                        widget.communicationUserModel!.photo!.isEmpty 
                    ? TextAvatar(
                        shape: Shape.Circular,
                        size: h / 95,
                        numberLetters: 2,
                        fontSize: w / 22,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w500,
                        text: widget.isGroup == false
                            ? widget.chat == false
                                ? "${widget.communicationUserModel?.name.toString().toUpperCase()}"
                                : "${widget.communicationuser?.name.toString().toUpperCase()}"
                            : widget.isgrp == false
                                ? "${widget.communicationUserModel?.name.toString().toUpperCase()}"
                                : widget.cmntgrpid == ""
                                    ? "${widget.grpuser?.gname.toString().toUpperCase()}"
                                    : "${widget.cmntgrpname.toString().toUpperCase()}",
                      )
                    : widget.isGroup == false
                        ? CircleAvatar(
                            radius: w / 23,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(widget.chat == false
                                    ? widget.communicationUserModel?.photo ?? ""
                                    : widget.communicationuser?.photoUrl ?? ""
                                //  "https://api-uat-user.sidrabazar.com/media/${communicationUserModel?.users?[0].photo}"
                                // "${widget.communicationUserModel?.photo}"
                                // widget.isgrp==false ? widget.communicationUserModel?.photo?? "": widget.grpuser?.gphoto??"",
                                ))
                        : CircleAvatar(
                            radius: w / 23,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage("asset/chatgrpimg.png")):CircleAvatar(
                            radius: w / 23,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage("asset/chatgrpimg.png")),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.isGroup == false) {
                    //    PersistentNavBarNavigator.pushNewScreen(
                    //   context,
                    //   screen: ChatProfileScreen(
                    //     chat: widget.chat,
                    //     token: widget.token,
                    //     roomId: widget.roomId,
                    //     socket: widget.socket,
                    //     isGroup: widget.communicationUserModel?.isgrp ?? false,
                    //     communicationUserModel:widget.communicationUserModel,
                    //     communicationuser: widget.communicationuser,
                    //   ),
                    //   withNavBar: true, // OPTIONAL VALUE. True by default.
                    //   pageTransitionAnimation: PageTransitionAnimation.fade,
                    // );
                  } else if (widget.cmntgrpid == "") {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: ChatProfileScreen2(
                        chat: widget.isgrp,
                        token: widget.token,
                        roomId: widget.roomId,
                        socket: widget.socket,
                        isGroup: true,
                        redirectchatid: widget.redirectchatid,
                        redirectchatname: widget.redirectchatname,
                        isadmin: widget.isadmin,
                        communicationUserModel: widget.communicationUserModel,
                        communicationuser: widget.grpuser,
                        grpmember: widget.grpmember,
                      ),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isGroup == false
                        ? Container(
                            // color: Colors.green,
                            width: w / 1.9,
                            child: Text(
                              widget.chat == false
                                  ?  widget.redirectchatid!=""?"${widget.redirectchatname.toTitleCase()}":"${widget.communicationUserModel?.name?.toTitleCase()}"
                                  : widget.redirectchatid!=""?"${widget.redirectchatname.toTitleCase()}":"${widget.communicationuser?.users![0].name?.toTitleCase()}",
                              // maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : widget.cmntgrpid == ""
                            ? Text(
                                widget.isgrp == false
                                    ? widget.redirectchatid!=""?"${widget.redirectchatname.toTitleCase()}":"${widget.communicationUserModel?.name?.toTitleCase()}"
                                    : widget.redirectchatid!=""?"${widget.redirectchatname.toTitleCase()}":"${widget.grpuser?.gname?.toTitleCase()}",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: w / 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Container(
                                width: w / 1.8,
                                child: Text(
                                 widget.redirectchatid!=""?"${widget.redirectchatname.toTitleCase()}": "${widget.cmntgrpname.toTitleCase()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w / 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )

                    // groupTypingUser != null
                    //     ? Row(
                    //         children: [
                    //           CircleAvatar(
                    //               backgroundColor: Colors.white,
                    //               radius: 14,
                    //               child: CircleAvatar(
                    //                 backgroundImage: NetworkImage(
                    //                     groupTypingUser?.photo ?? ""),
                    //                 radius: 12,
                    //               )),
                    //           Text(
                    //             "${groupTypingUser?.name} typing",
                    //             style: const TextStyle(
                    //               color: Color(0xff151522),
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     : Text(
                    //         typing == true ? "typing" : "",
                    //         style: const TextStyle(
                    //           color: Color(0xff151522),
                    //           fontSize: 16,
                    //         ),
                    //       )
                  ],
                ),
              )
            ],
          ),
          // PopupMenuButton(
          //   icon: SvgPicture.string(TaskSvg().moreIcon2,height: w/14,),
          //  offset: Offset(-9,45),
          //   //don't specify icon if you want 3 dot menu
          //   color: Color.fromARGB(255, 255, 255, 255),
          //   elevation: 2,
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //         padding: const EdgeInsets.symmetric(horizontal:9),
          //         value: 'a',
          //         enabled: true,
          //         child: Padding(
          //           padding: const EdgeInsets.only(top: 5,bottom: 5),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 width: w/2.735,
          //                 child: Row(
          //                   children: [
          //                     SvgPicture.string(TaskSvg().profileIcon,width: w/13,),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'Profile Details',
          //                       style: GoogleFonts.roboto(
          //                           color: Color(0xFF151522),
          //                           fontSize: w/26.5,
          //                           fontWeight: FontWeight.w400),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               SizedBox(
          //                 height:20,
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(left: 40),
          //                   child: const Divider(),
          //                 ),
          //               ),
          //               Container(
          //                 child: Row(
          //                   children: [
          //                     SvgPicture.string(TaskSvg().shareIcon2,width: w/13),
          //                     // SvgPicture.string(TaskSvg().msgSendIcon),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'Share Profile',
          //                       style: GoogleFonts.roboto(
          //                           color: Color(0xFF151522),
          //                           fontSize: w/26.5,
          //                           fontWeight: FontWeight.w400),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //                SizedBox(
          //                 height: 20,
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(left:40),
          //                   child: const Divider(),
          //                 ),
          //               ),
          //               Container(
          //                 child: Row(
          //                   children: [
          //                     SvgPicture.string(TaskSvg().pinICon,width: w/13),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'Pin this chat',
          //                       style: GoogleFonts.roboto(
          //                           color: Color(0xFF151522),
          //                           fontSize:w/26.5,
          //                           fontWeight: FontWeight.w400),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ))
          //   ],
          //   onSelected: (value) {},
          // ),
        ],
      ),
    );
  }

  void handleActiveLength(data) {}
  Future<void> saveUnreadMessageCount(int count, String chatt) async {
    print("inside the funcion");
    pref = await SharedPreferences.getInstance();
    await pref!.setInt(chatt, 0);
    setState(() {
      print("my msg update counta $count $chatt");
    });
  }
}
