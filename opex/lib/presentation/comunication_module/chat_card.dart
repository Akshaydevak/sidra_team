import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'unread.dart';
import 'chat_profile_screen.dart';
import 'chat_screen.dart';

class ChatCard extends StatefulWidget {
  bool isGroup;
  List<String> onlineUsers;
  final String? token;
  final Socket? socket;
  final String? loginUserId;
  final UserDummyList? communicationUserModel;
  ChatCard(
      {Key? key,
      this.isGroup = false,
      required this.onlineUsers,
      this.token,
      this.socket,
      this.loginUserId,
      this.communicationUserModel})
      : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
UserDummyList? data;
bool ismsg=false;
String deleteAt='';
int unreadCount=0;
 String formattedDate ="";
  String inputDate="";
@override
  void initState() {
    super.initState();
    //   inputDate = widget.communicationUserModel?.latestMessagecreated.toString()??"";
    // DateTime dateTime = DateTime.parse(inputDate);
    //  formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    // _loadUnreadMessageCount();
  }
 _loadUnreadMessageCount() async {
    int count = await UnreadMessagesManager.getUnreadMessageCount(widget.communicationUserModel?.chatid??"");
    setState(() {
      unreadCount = count;
      print("unreadMessageCount $unreadCount");
    });
  }
  @override
  Widget build(BuildContext context) {
    // print("inside the array is this ${widget.onlineUsers[0]}");
    // print("inside the communi ${widget.communicationUserModel?.id}");
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        ismsg=true;
        setState(() {
          
        });
      //   widget.socket!.emit("get.clients",roomId);
      // widget.socket!.on("active.length", (data) => print(data));
        //  widget.socket!.on("message.seen", (data) => print("message seen $data"));
        BlocProvider.of<ChatBloc>(context).add(ChatScreenGetEvent(
            token: widget.token ?? "",
            // userId: widget.communicationUserModel?.id ?? "",
            chatId: widget.communicationUserModel?.chatid??"",
            pageNo: 1));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ChatScreen(
            token: widget.token,
            loginUserId: widget.loginUserId,
            socket: widget.socket,
            isGroup: widget.isGroup,
            communicationUserModel: widget.communicationUserModel,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: ChatProfileScreen(
                        //       token: widget.token,
                        //       isGroup: widget.isGroup,
                        //       communicationUserModel:
                        //           widget.communicationUserModel),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      },
                      child:
                      widget.communicationUserModel?.photo==null||
                      widget.communicationUserModel!.photo!.isEmpty 
                      ?TextAvatar(
               shape: Shape.Circular,
               size: 48,
               numberLetters: 2,
               fontSize: w/22,
               textColor: Colors.white,
               fontWeight: FontWeight.w500,
               text:"${widget.communicationUserModel?.name.toString().toUpperCase()}" ,
             )
                      : 
                   CircleAvatar(
                        radius: 24,
                        backgroundColor: ColorPalette.inactiveGrey,
                        backgroundImage: NetworkImage(
                          widget.isGroup?
                            widget.communicationUserModel?.photo ?? "":
                            // "https://api-uat-user.sidrabazar.com/media/${widget.communicationUserModel?.users?[0].photo}" 
                            "${widget.communicationUserModel?.photo}"
                            ),
                      ),
                    ),
                    widget.communicationUserModel?.connect ==
                                true ||
                            widget.onlineUsers.contains(
                                widget.communicationUserModel?.id)
                        ? const Positioned(
                            right: 3,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 6,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff079b15),
                                  radius: 5,
                                )))
                        : Container()
                  ],
                ),
                const SizedBox(
                  width: 14,
                ),
                Container(
                  width: w /1.83,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.communicationUserModel?.isgrp == false
                          ? Text(
                              widget.communicationUserModel?.name
                                      ?.toTitleCase() ??
                                  "",
                                  overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: const Color(0xff151522),
                                fontSize: w/24.3,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Text(
                              widget.communicationUserModel?.name
                                      ?.toTitleCase() ??
                                  "",
                                  overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: const Color(0xff151522),
                                fontSize: w/24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      widget.communicationUserModel != null &&
                              widget.communicationUserModel?.latestMessage != null
                          ? widget.communicationUserModel!.latestMessage!.isNotEmpty
                              ? widget.communicationUserModel!
                                          .type == "text"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: w/3,
                                          child: Text(
                                            widget.communicationUserModel
                                                    ?.latestMessage ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xff151522),
                                              fontSize: w/30,
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //     widget.communicationUserModel
                                        //             ?.latestMessagecreated ??
                                        //         "",
                                        //         softWrap: true,
                                        //     overflow: TextOverflow.fade,
                                        //     style: GoogleFonts.roboto(
                                        //       color: const Color(0xff6d6d6d),
                                        //       fontSize: w/35,
                                        //       fontWeight: FontWeight.w500,
                                              
                                        //     )),
                                      ],
                                    ):widget.communicationUserModel?.type=='image'? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: Color.fromARGB(255, 2, 2, 2),
                                              size: w/24,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            // Text(
                                            //   widget.communicationUserModel!
                                            //         .latestMessage ??
                                            //     "",
                                            //     maxLines: 1,
                                            //     overflow: TextOverflow.ellipsis,
                                            //     style: TextStyle(
                                            //       fontWeight:ismsg==false? FontWeight.bold:FontWeight.normal
                                            //     ),
                                            //     )
                                          ],
                                        ),
                                        // Text(
                                        //     widget.communicationUserModel
                                        //             ?.latestMessagecreated ??
                                        //         "",
                                        //         softWrap: true,
                                        //     overflow: TextOverflow.clip,
                                        //     style: GoogleFonts.roboto(
                                        //       color: Color.fromARGB(255, 159, 157, 157),
                                        //       fontSize: w/35,
                                        //       fontWeight: FontWeight.w500,
                                        //     )),
                                      ],
                                    ):widget.communicationUserModel?.type =='audio'? 
                                    Row(
                                      children: [
                                         Icon(
                                              Icons.mic,
                                              color: Color.fromARGB(255, 2, 2, 2),
                                              size: w/24,
                                            ),
                                        Text(
                                              "You have new voice message",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xff151522),
                                            fontSize: w/30,
                                          ),
                                        ),
                                        // Text(
                                        //     widget.communicationUserModel
                                        //             ?.latestMessagecreated ??
                                        //         "",
                                        //         softWrap: true,
                                        //     overflow: TextOverflow.fade,
                                        //     style: GoogleFonts.roboto(
                                        //       color: const Color(0xff6d6d6d),
                                        //       fontSize: w/35,
                                        //       fontWeight: FontWeight.w500,
                                              
                                        //     )),
                                      ],
                                    ):widget.communicationUserModel?.type=='video'?Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         Icon(
                                              Icons.video_library,
                                              color: Color.fromARGB(255, 2, 2, 2),
                                              size: w/24,
                                            ),
                                        // SizedBox(
                                        //   width: w/3,
                                          
                                        //   child: Text(
                                        //         "You have new voice",
                                        //     maxLines: 1,
                                        //     overflow: TextOverflow.ellipsis,
                                        //     style: TextStyle(
                                        //       color: Color(0xff151522),
                                        //       fontSize: w/30,
                                        //     ),
                                        //   ),
                                        // ),
                                        // Text(
                                        //     widget.communicationUserModel
                                        //             ?.latestMessagecreated ??
                                        //         "",
                                        //         softWrap: true,
                                        //     overflow: TextOverflow.fade,
                                        //     style: GoogleFonts.roboto(
                                        //       color: const Color(0xff6d6d6d),
                                        //       fontSize: w/35,
                                        //       fontWeight: FontWeight.w500,
                                              
                                        //     )),
                                      ],
                                    ):widget.communicationUserModel?.type=='file'?Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         Icon(
                                              Icons.attach_file,
                                              color: Color.fromARGB(255, 2, 2, 2),
                                              size: w/24,
                                            ),
                                        // SizedBox(
                                        //   width: w/3,
                                          
                                        //   child: Text(
                                        //         "You have new voice",
                                        //     maxLines: 1,
                                        //     overflow: TextOverflow.ellipsis,
                                        //     style: TextStyle(
                                        //       color: Color(0xff151522),
                                        //       fontSize: w/30,
                                        //     ),
                                        //   ),
                                        // ),
                                        // Text(
                                        //     widget.communicationUserModel
                                        //             ?.latestMessagecreated ??
                                        //         "",
                                        //         softWrap: true,
                                        //     overflow: TextOverflow.fade,
                                        //     style: GoogleFonts.roboto(
                                        //       color: const Color(0xff6d6d6d),
                                        //       fontSize: w/35,
                                        //       fontWeight: FontWeight.w500,
                                              
                                        //     )),
                                      ],
                                    ):Text("You have new message")
                                  
                              : Text(""):Text("${widget.communicationUserModel?.createdBy} created group ${widget.communicationUserModel?.name}",
                              overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xff151522),
                                              fontSize: w/30,
                                            ),)

                             
                    ],
                  ),
                ),
                 Container(
                  width: w /4.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // IconButton(onPressed: (){
                            
                      //       setState(() {
                      //         print("hello delete${widget.communicationUserModel?.chatid}");
                      //   widget.socket?.emit("delete.chat",{
                      //   "chatId":widget.communicationUserModel?.chatid??"",
                      //   "userId":widget.isGroup==true? widget.loginUserId??"":widget.communicationUserModel?.id??""
                      //   }
                        
                      //   );
                      //   print("hello delete"); 
                      //    widget.socket!.on("chat.deleted",(data) {
                      //        print("......,,...$data");
                      //         // data = UserDummyList.fromJson(data);
                            
                      //            widget.socket!.on("update.chat.list", (data) => print("fxgf  $data"));
                             
                      //           widget.socket!.emit("update.list",{
                        
                      //                     print("update")
                      //                   });
                      //             widget.socket!.on("friends.update", (data) {
                      //             print(data);
                      //             setState(() {
                                    
                      //             });
                      //           } );
                      //     });
                      //     });
                           
                      // }, icon: Icon(Icons.delete))
                      
                      widget.communicationUserModel != null &&
                              widget.communicationUserModel?.latestMessage != null
                          ? widget.communicationUserModel!.latestMessage!.isNotEmpty
                             
                                  ? Column(crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                      //  CircleAvatar(
                                      //   radius: 10,
                                      //   backgroundColor: Colors.green,
                                      //   child: Text('$unreadCount'),
                                      //  ),
                                       
                                        Text(
                                            widget.communicationUserModel
                                                    ?.latestMessagecreated ??
                                                "",
                                                softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              color: Color.fromARGB(255, 159, 157, 157),
                                              fontSize: w/35,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    ):Column(
                                      children: [
                                        // SizedBox(
                                        //   width: w/3,
                                        //   child: 
                                        //   Text(
                                        //     widget.communicationUserModel
                                        //             ?.latestMessage ??
                                        //         "",
                                        //     maxLines: 1,
                                        //     overflow: TextOverflow.ellipsis,
                                        //     style: TextStyle(
                                        //       color: Color(0xff151522),
                                        //       fontSize: w/30,
                                        //     ),
                                        //   ),
                                        // ),
                                        Text(
                                            widget.communicationUserModel
                                                    ?.latestMessagecreated ??
                                                "",
                                                softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff6d6d6d),
                                              fontSize: w/35,
                                              fontWeight: FontWeight.w500,
                                              
                                            )),
                                      ],
                                    )
                                  
                              : Text(""),
                    ],
                  ),
                )
              ],
            ),
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       if (widget.communicationUserModel?.messages != null) ...{
            //         widget.communicationUserModel!.messages!.isNotEmpty
            //             ? Row(
            //                 children: [
            //                   SizedBox(
            //                     // width: w/7,
            //                     child: Text(
            //                         widget.communicationUserModel?.messages?[0]
            //                                 .createdAt ??
            //                             "",
            //                         overflow: TextOverflow.fade,
            //                         style: GoogleFonts.roboto(
            //                           color: const Color(0xff6d6d6d),
            //                           fontSize: 13,
            //                           fontWeight: FontWeight.w500,
            //                         )),
            //                   ),
            //                 ],
            //               )
            //             : Container()
            //       }
            //       // widget.isGroup
            //       //     ? Column(
            //       //         children: [
            //       //           const SizedBox(
            //       //             height: 5,
            //       //           ),
            //       //           CircleAvatar(
            //       //             radius: 15,
            //       //             backgroundColor: const Color(0xffFE5762),
            //       //             child: Text(
            //       //               "15",
            //       //               style: GoogleFonts.outfit(
            //       //                 color: Colors.white,
            //       //                 fontSize: 14,
            //       //                 fontWeight: FontWeight.w600,
            //       //               ),
            //       //             ),
            //       //           )
            //       //         ],
            //       //       )
            //       //     : Container(),
            //     ],
            //   ),
            // )
                
          ],
        ),
        ),
    );
  }
}
