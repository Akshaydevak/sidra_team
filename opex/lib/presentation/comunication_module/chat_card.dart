import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
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
      
    _loadUnreadMessageCount();
  }
 _loadUnreadMessageCount() async {
   inputDate = widget.communicationUserModel?.latestMessagecreated.toString()??"";
    DateTime dateTime = DateTime.parse(inputDate).toUtc();
     formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  
  }
  @override
  Widget build(BuildContext context) {
    // print("inside the array is this ${widget.onlineUsers[0]}");
    // print("inside the communi ${widget.communicationUserModel?.id}");
   double w1 = MediaQuery.of(context).size.width ;
    double w = w1 > 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return 
    // SwipeActionCell(
      // backgroundColor: Colors.transparent,
      // key: ObjectKey(widget.communicationUserModel?.chatid),
      // trailingActions: [SwipeAction(
      //   title: "Delete",
      //   onTap: (CompletionHandler){
        //    setState(() {
        // //       print("hello delete${widget.communicationUserModel?.chatid}");
        // // widget.socket?.emit("delete.chat",{
        // // "chatId":widget.communicationUserModel?.chatid??"",
        // // "userId":widget.isGroup==true? widget.loginUserId??"":widget.communicationUserModel?.id??""
        // }
        
        // );
        // print("hello delete"); 
        //   widget.socket!.on("chat.deleted",(data) {
        //       print("......,,...$data");
        //       // data = UserDummyList.fromJson(data);
            
        //           widget.socket!.on("update.chat.list", (data) => print("fxgf  $data"));
              
        //         widget.socket!.emit("update.list",{
        
        //                   print("update")
        //                 });
        //           widget.socket!.on("friends.update", (data) {
        //           print(data);
        //           setState(() {
                    
        //           });
        //         } );
        //   });
        //   });
      // },
      // color: ColorPalette.primary
      // )],
      // child: 
      GestureDetector(
        onTap: () {
          ismsg=true;
          setState(() {
            
          });
        //   widget.socket!.emit("get.clients",roomId);
        // widget.socket!.on("active.length", (data) => print(data));
          //  widget.socket!.on("message.seen", (data) => print("message seen $data"));
          BlocProvider.of<ChatBloc>(context).add(ChatScreenGetEvent(
              token: widget.token ?? "",
              chatId: widget.communicationUserModel?.chatid??"",
              grpchatId: "",
              pageNo: 1,
              userId: widget.loginUserId??""));
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
                         widget.isGroup?
                     CircleAvatar(
                          radius: 24,
                          backgroundColor: ColorPalette.inactiveGrey,
                          backgroundImage:  
                              AssetImage("asset/chatgrpimg.png")
                        ):widget.communicationUserModel?.photoindividual==null||
                        widget.communicationUserModel!.photoindividual!.isEmpty 
                        ?TextAvatar(
                            shape: Shape.Circular,
                            size: 48,
                            numberLetters: 2,
                            fontSize: w1/22,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w500,
                            text:"${widget.communicationUserModel?.name.toString().toUpperCase()}" ,
                          )
                        :
                         CircleAvatar(
                          radius: 24,
                          backgroundColor: ColorPalette.inactiveGrey,
                          backgroundImage:  
                           NetworkImage(
                              widget.communicationUserModel?.photoindividual ?? ""
                              // "https://api-uat-user.sidrabazar.com/media/${widget.communicationUserModel?.users?[0].photo}" 
                              // "${widget.communicationUserModel?.photo}"
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
                  SizedBox(
                    width: w1/1.3,
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w1 /1.8,
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
                                        fontSize: w1/24.3,
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
                                          ?widget.isGroup==true?Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: w1/2.3,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${widget.communicationUserModel?.fromusername.toString().toTitleCase().split(' ')[0]}: ",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Color(0xff151522),
                                                          fontSize: w/30,
                                                          
                                                          fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: w1/4,
                                                        child: Text(
                                                          widget.communicationUserModel
                                                                  ?.latestMessage ??
                                                              "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: Color(0xff151522),
                                                            fontSize: w/30,
                                                            fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.normal
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
                                            ): Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: w1/3,
                                                  child: Text(
                                                    widget.communicationUserModel
                                                            ?.latestMessage ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xff151522),
                                                      fontSize: w/30,
                                                      fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.normal
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
                                            ):widget.communicationUserModel?.type=='image'? 
                                            widget.isGroup==true?Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: w1/3,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${widget.communicationUserModel?.fromusername.toString().toTitleCase().split(' ')[0]}: ",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Color(0xff151522),
                                                          fontSize: w/30,
                                                          
                                                          fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.w400
                                                        ),
                                                      ),
                                                      Icon(
                                                      Icons.image,
                                                      color: Color.fromARGB(255, 2, 2, 2),
                                                      size: w/24,
                                                    ),
                                                    ],
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
                                            ):Row(
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
                                                    
                                                  ],
                                                ),
                                               
                                              ],
                                            ):widget.communicationUserModel?.type =='audio'?
                                            widget.isGroup==true?Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: w1/2.3,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${widget.communicationUserModel?.fromusername.toString().toTitleCase().split(' ')[0]}: ",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Color(0xff151522),
                                                          fontSize: w/30,
                                                          
                                                          fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.w400
                                                        ),
                                                      ),
                                                      Row(
                                              children: [
                                                 Icon(
                                                      Icons.mic,
                                                      color: Color.fromARGB(255, 2, 2, 2),
                                                      size: w1/24,
                                                    ),
                                                Text(
                                                      "voice message",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Color(0xff151522),
                                                    fontSize: w1/30,
                                                  ),
                                                ),
                                              ],
                                            )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ): 
                                            Row(
                                              children: [
                                                 Icon(
                                                      Icons.mic,
                                                      color: Color.fromARGB(255, 2, 2, 2),
                                                      size: w1/24,
                                                    ),
                                                Text(
                                                      "voice message",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Color(0xff151522),
                                                    fontSize: w1/30,
                                                  ),
                                                ),
                                              ],
                                            ):widget.communicationUserModel?.type=='video'?
                                            widget.isGroup==true?Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: w1/2.3,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${widget.communicationUserModel?.fromusername.toString().toTitleCase().split(' ')[0]}: ",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Color(0xff151522),
                                                          fontSize: w/30,
                                                          
                                                          fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.w400
                                                        ),
                                                      ),
                                                      Icon(
                                                      Icons.video_library,
                                                      color: Color.fromARGB(255, 2, 2, 2),
                                                      size: w1/24,
                                                    ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ): Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                 Icon(
                                                      Icons.video_library,
                                                      color: Color.fromARGB(255, 2, 2, 2),
                                                      size: w1/24,
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
                                            ):widget.communicationUserModel?.type=='file'?
                                            widget.isGroup==true?Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: w1/2.3,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${widget.communicationUserModel?.fromusername.toString().toTitleCase().split(' ')[0]}: ",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Color(0xff151522),
                                                          fontSize: w/30,
                                                          
                                                          fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.w400
                                                        ),
                                                      ),
                                                      Row(
                                                   children: [
                                                     Icon(
                                                          Icons.attach_file,
                                                          color: Color.fromARGB(255, 2, 2, 2),
                                                          size: w/24,
                                                        ),
                                                        Text(
                                                    widget.communicationUserModel
                                                            ?.latestMessage!.split('?').first.split('.').last ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xff151522),
                                                      fontSize: w/30,
                                                      fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.normal
                                                    ),
                                                  ),
                                                   ],
                                                 ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ):Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                 Row(
                                                   children: [
                                                     Icon(
                                                          Icons.attach_file,
                                                          color: Color.fromARGB(255, 2, 2, 2),
                                                          size: w/24,
                                                        ),
                                                        Text(
                                                    widget.communicationUserModel
                                                            ?.latestMessage!.split('?').first.split('.').last ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xff151522),
                                                      fontSize: w/30,
                                                      fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.normal
                                                    ),
                                                  ),
                                                   ],
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
                                            ):widget.communicationUserModel?.type=='notify'?Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                 SizedBox(
                                                  width: w1/2,
                                                  child: Text(
                                                    widget.communicationUserModel
                                                            ?.latestMessage ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xff151522),
                                                      fontSize: w/30,
                                                      fontWeight: widget.communicationUserModel?.unreadMessages != 0? FontWeight.bold:FontWeight.normal
                                                    ),
                                                  ),
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
                                                      fontSize: w1/30,
                                                    ),)
                        
                                     
                            ],
                          ),
                        ),
                         Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
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
                                 
                                      ? Column( 
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            widget.communicationUserModel?.unreadMessages != 0?
                                           CircleAvatar(
                                            radius: 10,
                                            backgroundColor: ColorPalette.primary,
                                            child: Text(widget.communicationUserModel
                                                        ?.unreadMessages.toString() ??
                                                    "",
                                                    textAlign: TextAlign.center,
                                                   style: TextStyle(color: Colors.white,fontSize: 10),),
      
                                           ):SizedBox(),
                                           SizedBox(height: 5,),
                                            Text(
                                                // widget.communicationUserModel
                                                //         ?.latestMessagecreated ??
                                                    "$formattedDate",
                                                    softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  color: Color.fromARGB(255, 159, 157, 157),
                                                  fontSize: w1/35,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ],
                                        ):Column( crossAxisAlignment: CrossAxisAlignment.end,
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
                                                  fontSize: w1/35,
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
                  ),
                  
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
      // ),
    );
  }
}
