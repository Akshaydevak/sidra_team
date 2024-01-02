import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/audio_state.dart';
import 'package:cluster/presentation/comunication_module/bloc/attachment_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/image_details_screen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/videoplayerscreen.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/paginatedchat_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:video_player/video_player.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'chat_screen/chat_appbar.dart';
import 'unread.dart';
import 'globals.dart';

class ChatScreen extends StatefulWidget {
  final bool  isGroup;
  final bool chat;
  final Socket? socket;
  final String? token;
  final String? loginUserId;
  final UserDummyList? communicationUserModel;
  final CommunicationUserModel? communicationuser;
  final GroupList? grpuser;
  final bool isg;
  // final Function(bool val)? refresh;
  ChatScreen(
      {Key? key,
      this.socket,
      this.loginUserId,
      this.token,
      this.isGroup = false,
      this.isg=false,
      this.chat=false,
      this.communicationUserModel,
      this.communicationuser,
      this.grpuser
      })
      : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final _audioRecorder = Record();

  bool isMount = true;
  bool isSecondMount = true;
  bool isThirdMount = true;
  bool isFourthMount = true;
  bool isFifthMount = true;
  int activeUsersLength = 0;
  String? roomId;
  final ScrollController _controller = ScrollController();
  int pageNo = 1;
  List<ChatModel> messageList = [];
  List<FromUser> seenUsersList = [];
  List<UserSeenList> enter=[];
  List msgfr=[];
  FromUser? groupTypingUser;
  bool typing = false;
  FilePickerResult? result;
  PlatformFile? file;
  bool micLongPress = false;
  bool voiceCancelled = false;
  bool _playAudio = false;
  var username;
  List seenuser=[];
  var unread=0;
  int unreadMessageCount = 0;
  bool isload=false;
  SharedPreferences? pref;
  AnimationController? _animationController;
  //Mic Animation
  Animation<double>? _micTranslateTop;
  Animation<double>? _micRotationFirst;
  Animation<double>? micTranslateRight;
  Animation<double>? micTranslateLeft;
  Animation<double>? _micRotationSecond;
  Animation<double>? _micTranslateDown;
  Animation<double>? micInsideTrashTranslateDown;

  // trash animation
  Animation<double>? _trashContainerWithCoverTrasnlateTop;
  Animation<double>? _trashCoverRotationFirst;
  Animation<double>? _trashCoverTranslateLeft;
  Animation<double>? _trashCoverRotationSecond;
  Animation<double>? _trashCoverTranslateRight;
  Animation<double>? trashContainerWithCoverTranslateDown;
  String seenTimestamp="";

  @override
  void initState() {
    
    print("room id listens atleast ${widget.loginUserId}");
    widget.socket?.emit("join.chat", {
      widget.chat==false && widget.isg==false
    ? widget.communicationUserModel?.chatid:
    widget.chat==true&& widget.isg==false?widget.communicationuser?.id: widget.grpuser?.chatid});
    
    widget.socket?.on("room.id", (data) {
      print("room id from socket ${data}");
      roomId = data;
     
         widget.socket!.on("msg.seen", (data) {
          print("enter message $data");
          seenTimestamp=data['timestamp'];
          
         } );
         
      widget.socket!.emit("get.clients",roomId);
      
      widget.socket!.on("active.length", (data) {
         print("ACTIVE length $data");
         activeUsersLength=data;

      } );
         
      widget.socket?.emit("check", roomId);
      if (widget.isGroup == true) {
        widget.socket?.emit("group.message.seen", roomId);
        widget.socket?.emit("total.in.group", roomId);
      }
    });
   
    widget.socket?.on("check.result", (data) {
      print("data for check ${data}");
    });
    

    if (widget.isGroup == false) {
      print("hello $roomId");
      
         
      widget.socket?.on("typing", (data) {
        typing = true;
        if (isSecondMount) {
          setState(() {});
        }
      });
    
      widget.socket?.on("stopped", (data) {
        typing = false;
        if (isThirdMount) {
          setState(() {});
        }
      });
      widget.socket?.on("latest.message", (data)async{
        print("total res listened  ${data}");
         
        messageList.add(ChatModel(
            type: data['type'],
            message: data['message'],
            createdAt: data['createdAt'],
            fromuserid: data['fromuserid'])); 
          // updateMessageSeenStatus();
          if(widget.loginUserId==data['fromuserid']){
          _incrementUnreadMessageCount();
          }
          else{
            print("mmm. no");
          }
        if (isMount) {
          setState(() {

          });
        }
        ScrollService.scrollToEnd(
            scrollController: _controller, reversed: false);
      });
          
    } else {
      widget.socket?.on("group.typing", (data) {
        groupTypingUser = FromUser(
            name: data['name'], email: data['email'], photo: data['photo']);
        if (isSecondMount) {
          setState(() {});
        }
      });
     
      widget.socket?.on("group.stopped", (data) {
        groupTypingUser = null;
        if (isThirdMount) {
          setState(() {});
        }
      });
      // widget.socket?.on("memberAddedToGroup", (data) => null)
      // widget.socket?.on("msg.seen.by", (data) {
      //   print("total seen users ${data}");
      //   seenUsersList.clear();
      //   for (int i = 0; i <= data.length; i++) {
      //     print("total seen users forrr lopp ${data[i]['photo']}");
      //crash issue so commented ***-----****
      //     seenUsersList.add(
      //         FromUser(photo: data[i]['photo'], name: data[i]['username']));
      //     print("total seen users list ${seenUsersList}");
      //   }
      //   if (isFourthMount) {
      //     setState(() {});
      //   }
      // });
      widget.socket?.on("total.active.users", (data) {
        activeUsersLength = data;
        if (isFifthMount) {
          setState(() {});
        }
      });
    
      widget.socket?.on("group.latest.message", (data) {
        print("total ser listened ${widget.loginUserId} ...${data}");

        messageList.add(ChatModel(
            message: data['message'],
            fromuserid: data['fromuserid'],
            type: data['type'],
            createdAt: data['createdAt'],
            fromUser: FromUser(
                email: data['fromUser']['email'],
                name: data['fromUser']['name'],
                photo: data['fromUser']['photo'])));

              
                
        if (isMount) {
          setState(() {});
        }

        ScrollService.scrollToEnd(
            scrollController: _controller, reversed: false);
      });
          
    }
    print(file);
    widget.socket?.on("image.download", (data) {
      print("image download listened ${data}");
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    _micTranslateTop = Tween(begin: 0.0, end: -150.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut)));
    _micRotationFirst = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.0,
          0.2,
        )));
    micTranslateRight = Tween(begin: 0.0, end: 13.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.0,
          0.1,
        )));
    micTranslateLeft = Tween(begin: 0.0, end: -13.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.1,
          0.2,
        )));
    _micRotationSecond = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.2,
          0.45,
        )));
    _micTranslateDown = Tween(begin: 0.0, end: 150.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.45,
          0.79,
          curve: Curves.easeInOut,
        )));
    _trashContainerWithCoverTrasnlateTop =
        Tween(begin: 40.0, end: -25.0).animate(CurvedAnimation(
            parent: _animationController!,
            curve: const Interval(
              0.45,
              0.6,
            )));
    _trashCoverRotationFirst =
        Tween(begin: 0.0, end: -pi / 3).animate(CurvedAnimation(
            parent: _animationController!,
            curve: const Interval(
              0.6,
              0.7,
            )));
    _trashCoverTranslateLeft =
        Tween(begin: 0.0, end: -18.0).animate(CurvedAnimation(
            parent: _animationController!,
            curve: const Interval(
              0.6,
              0.7,
            )));
    _trashCoverRotationSecond =
        Tween(begin: 0.0, end: pi / 3).animate(CurvedAnimation(
            parent: _animationController!,
            curve: const Interval(
              0.8,
              0.9,
            )));
    _trashCoverTranslateRight =
        Tween(begin: 0.0, end: 18.0).animate(CurvedAnimation(
            parent: _animationController!,
            curve: const Interval(
              0.8,
              0.9,
            )));
    micInsideTrashTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
        CurvedAnimation(
            parent: _animationController!,
            curve: const Interval(0.95, 1.0, curve: Curves.easeInOut)));
    trashContainerWithCoverTranslateDown = Tween(begin: 2.0, end: 55.0).animate(
        CurvedAnimation(
            parent: _animationController!,
            curve: const Interval(0.95, 1.0, curve: Curves.easeInOut)));

          

            super.initState();
  }

  void sendMessage(String message, String chatId) {
    
    widget.socket?.emit(
        "new.message", {"type": "text", "chatid": chatId, "content": message});
      
            widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));


            print("uodate.chat.list");
  }

  void sendGroupMessage(String message, String chatId) {
    widget.socket?.emit("group.message",
        {"type": "text", "chatid": chatId, "content": message});
       
        widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
       
             widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) => print(data));
                      widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
        setState(() {
          
        });
      } );
  }
   

  _incrementUnreadMessageCount() async {
    await UnreadMessagesManager.incrementUnreadMessageCount(widget.communicationUserModel?.chatid??"");
    // _loadUnreadMessageCount();
  }

  _resetUnreadMessageCount() async {
    await UnreadMessagesManager.resetUnreadMessageCount(widget.communicationUserModel?.chatid??"");
    // _loadUnreadMessageCount();
  }
  void updateMessageSeenStatus() {
    print("seeeen daaaata");
    bool hasMatch = false;
    // if(activeUsersLength!=2){
      for (int i = 0; i < messageList.length; i++) {
        if (messageList[i].fromuserid == widget.loginUserId) {
         unread ++;// Exit the inner loop once a match is found
        }    
     }
    print("rrrrrr $unread");
  //   if (!hasMatch) {
  //     unread --;
  //     print("unread messages $unread");
  //   }else{
  //    unread++;
  //    print("rrrrrr $unread");
  //  }
    // }
    // else {
    //   unread=0;
    //   print("rrrrrr $unread");
    // }
    
}



  @override
  void dispose() {
    _controller.dispose();
    isMount = false;
    isSecondMount = false;
    isThirdMount = false;
    isFourthMount = false;
    isFifthMount = false;
    _animationController?.dispose();
    super.dispose();
  }

  TextEditingController typedMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print("homescreen latest widget.id ${widget.communicationUserModel?.id}");
    // print("token ${widget.token}");
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            print("the message state //");
            if (state is ChatScreenGetLoading) {
            } else if (state is ChatScreenGetSuccess) {

              for (int i = 0; i < state.chatData.messages!.length; i++) {
              
              //  if(widget.communicationUserModel?.isDeleted ==false && widget.communicationUserModel?.deletedAt == null)
              //  {
                 messageList.add(state.chatData.messages![i]);
              //  }
              //  else if(widget.communicationUserModel?.isDeleted ==false && widget.communicationUserModel?.deletedAt != null){
                
              //     messageList.add(state.chatData.messages![i]);
              //  }
             
              }
               
              messageList = messageList.reversed.toList();
              _resetUnreadMessageCount();
              ScrollService.scrollToEnd(
            scrollController: _controller, reversed: false);
               
              setState(() {});
            }
            
          },
        ),
        BlocListener<PaginatedchatBloc, PaginatedchatState>(
          listener: (context, state) {
            if (state is PaginatedChatLoading) {
                
            } else if (state is PaginatedChatSuccess) {
             
              for (int i = 0; i < state.chatData.messages!.length; i++) {
                messageList.insertAll(0, [state.chatData.messages![i]]);
           
                setState(() {});
              }
              ScrollService.scrollToEnd(
            scrollController: _controller, reversed:true);
              //  updateMessageSeenStatus();
            }
          },
        ),
        BlocListener<AttachmentBloc, AttachmentState>(
            listener: (context, state) {
          if (state is UploadPictureLoading) {
            print("Loading");
          } else if (state is UploadPictureSuccess) {
            if (widget.isGroup != true) {
              widget.socket?.emit("new.message", {
                "type": "image",
                "chatid":widget.chat==false?widget.communicationUserModel?.chatid:widget.communicationuser?.id,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
    
      } );
            } else {
              widget.socket?.emit("group.message", {
                "type": "image",
                "chatid":widget.isg==false?widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
       
      } );
            }
            Navigator.of(context).pop(true);
          } else if (state is UploadPictureFailed) {
            print("failed");
          } else if (state is UploadVideoLoading) {
            print("video Loading");
          } else if (state is UploadVideoSuccess) {
            if (widget.isGroup != true) {
              widget.socket?.emit("new.message", {
                "type": "video",
                "chatid": widget.chat==false?widget.communicationUserModel?.chatid : widget.communicationuser?.id,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
       
      } );
            } else {
              widget.socket?.emit("group.message", {
                "type": "video",
                "chatid":widget.isg==false? widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
       
      } );
            }
            Navigator.of(context).pop(true);
          } else if (state is UploadVideoFailed) {
            print("video failed");
          } else if (state is UploadFilesLoading) {
            print("files Loading");
          } else if (state is UploadFilesSuccess) {
            if (widget.isGroup != true) {
              widget.socket?.emit("new.message", {
                "type": "file",
                "chatid": widget.chat==false? widget.communicationUserModel?.chatid:widget.communicationuser?.id,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
        
      } );
            } else {
              widget.socket?.emit("group.message", {
                "type": "file",
                "chatid": widget.isg==false? widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
        
      } );
            }
            Navigator.of(context).pop(true);
          } else if (state is UploadAudioLoading) {
            print("audio loading");
          } else if (state is UploadAudioSuccess) {
            if (widget.isGroup != true) {
              widget.socket?.emit("new.message", {
                "type": "audio",
                "chatid": widget.chat==false? widget.communicationUserModel?.chatid:widget.communicationuser?.id,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
        
      } );
            } else {
              widget.socket?.emit("group.message", {
                "type": "audio",
                "chatid": widget.isg==false? widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
        
      } );
            }
            Navigator.of(context).pop(true);
          } else if (state is UploadAudioFailed) {
            print("audio failed");
          } else if (state is UploadLiveAudioLoading) {
            print("live audio loading");
          } else if (state is UploadLiveAudioSuccess) {
            if (widget.isGroup != true) {
              widget.socket?.emit("new.message", {
                "type": "audio",
                "chatid": widget.chat==false? widget.communicationUserModel?.chatid:widget.communicationuser?.id,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
        
      } );
            } else {
              widget.socket?.emit("group.message", {
                "type": "audio",
                "chatid": widget.isg==false? widget.communicationUserModel?.chatid : widget.grpuser?.chatid,
                "content": state.upload
              });
              
              widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
              widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print(data);
      
      } );
            }
          } else if (state is UploadLiveAudioFailed) {
            print("live audio failed");
          }
        })
      ],
      child: Scaffold(
        backgroundColor: Color(0xffEFF1F3),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white,
              statusBarColor: ColorPalette.primary,
            ),
            elevation: 0,
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ChatAppBar(
                chat: widget.chat,
                isGroup: widget.isGroup,
                roomId: roomId,
                socket: widget.socket,
                token: widget.token,
                typing: typing,
                groupTypingUser: groupTypingUser,
                communicationUserModel: widget.communicationUserModel,
                communicationuser: widget.communicationuser,
                isgrp: widget.isg,
                grpuser: widget.grpuser,
              ),
              SizedBox(height:10,),
              messageList.isEmpty
                  ? Expanded(
                      // height: h / 1.5,
                      child: Padding(
                        padding: EdgeInsets.only(top:170,left:62,right:62,bottom:h/2),
                        child: Container(
                        // width: w / 1.5,
                        // height: h/9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFFFFFF),
                        ),
                        child:Center(
                        child: Text(
                          "This conversation\ncurrently has no messages...",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(textStyle: TextStyle(
                        color: Color(0xFF151522),
                        fontSize: 14,
                          ),
                          ),
                        )),
                                          ),
                      ))
                  : Expanded(
                      child: NotificationListener<ScrollEndNotification>(
                        onNotification: (scrollEnd) {
                          final metrics = scrollEnd.metrics;
                          if (metrics.atEdge) {
                            bool isTop = metrics.pixels == 0;
                            if (isTop &&
                                _controller.position.userScrollDirection 
                                ==
                                    ScrollDirection.forward) {
                                      
                              pageNo++;
                              if(widget.isGroup==false){
                              BlocProvider.of<PaginatedchatBloc>(context).add(
                                  PaginatedChatGetEvent(
                                      token: widget.token ?? "",
                                      chatId: widget.chat==false?
                                          widget.communicationUserModel?.chatid ??
                                              "": widget.communicationuser?.id??"",
                                          // userId:  widget.chat==false?
                                          // widget.communicationUserModel?.id ??
                                          //     "":widget.communicationuser?.id??"",
                                      pageNo: pageNo));
                              }else{
                                 BlocProvider.of<PaginatedchatBloc>(context).add(
                                  PaginatedChatGetEvent(
                                      token: widget.token ?? "",
                                      chatId: widget.isg==false?
                                          widget.communicationUserModel?.chatid ??
                                              "": widget.grpuser?.chatid??"",
                                          // userId:  widget.chat==false?
                                          // widget.communicationUserModel?.id ??
                                          //     "":widget.communicationuser?.id??"",
                                      pageNo: pageNo));
                              }
                                    
                            } else {
                              print('At the bottom');
                            }
                          }
                          return false;
                        },
                        child: ListView.separated(
                          reverse: false,
                          // shrinkWrap: true,
                          controller: _controller,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: messageList.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment:
                                  messageList[index].fromuserid !=
                                          widget.loginUserId
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                if (messageList[index].fromuserid !=
                                    widget.loginUserId) ...{
                                  if (widget.isGroup == false ) ...{
                                    if (messageList[index].type == "image")...{
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return DetailScreen(
                                                image: messageList[index]
                                                        .message ??
                                                    "",
                                              );
                                            }));
                                          },
                                          child: Container(
                                              width: w / 1.5,
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                color: Colors.white,
                                              ),
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                    ),
                                                    width: w,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(6),
                                                              topRight: Radius
                                                                  .circular(6),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                      child: Image(
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return const SizedBox(
                                                              child: Center(
                                                                  child: CircularProgressIndicator(
                                                                      color: Colors
                                                                          .white)),
                                                            );
                                                          },
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              messageList[index]
                                                                      .message ??
                                                                  "")),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        messageList[index]
                                                                .createdAt ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color(0xFF6D6D6D)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )))
                                    } else if (messageList[index].type ==
                                        "audio") ...{
                                      VoiceMessage(
                                        audioSrc:
                                            messageList[index].message ?? "",
                                        played:
                                            false, // To show played badge or not.
                                        me: false, // Set message side.
                                        onPlay:
                                            () {}, // Do something when voice played.
                                      )
                                    } else if (messageList[index].type ==
                                        "video") ...{
                                      VideoPlayerScreen(
                                        autoplay: false, 
                                        looping: false,
                                        alignmentGeometry: Alignment.topLeft,
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                          messageList[index].message ?? "",
                                        ),
                                      )
                                    } else if (messageList[index].type ==
                                        "file") ...{
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: w / 1.75,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 8),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: Color(0xfff8f7f5),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white),
                                                  child: SvgPicture.string(
                                                      TaskSvg().docIcon2),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: w / 2,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      const BoxShadow(
                                                        color:
                                                            Color(0x05000000),
                                                        blurRadius: 8,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        messageList[index]
                                                                .message ??
                                                            "",
                                                        style: GoogleFonts.roboto(textStyle:TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 8,
                                                        ),)
                                                      ),
                                                      const SizedBox(height: 4),
                                                      // Text(
                                                      //   "21.54 Mb",
                                                      //   style: TextStyle(
                                                      //     color: Color(0xff333333),
                                                      //     fontSize: 12,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                              onTap: () async {
                                                final url = messageList[index]
                                                        .message ??
                                                    "";
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              },
                                              child: SvgPicture.string(
                                                  TaskSvg().dwnldIcon)),
                                        ],
                                      ),
                                    } else ...{
                                      Column(children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  45,
                                            ),
                                            child: Card(
                                              elevation: 1,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              color: Colors.white,
                                              // margin: const EdgeInsets.symmetric(
                                              //     horizontal: 15, vertical: 5),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 10,
                                                      bottom: 10,
                                                    ),
                                                    child: Text(
                                                      messageList[index]
                                                              .message ??
                                                          "",
                                                          textAlign: TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              messageList[index].createdAt ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF6D6D6D)),
                                            ),
                                          ],
                                        ),
                                      ])
                                    }
                                  } else ...{
                                    if(messageList[index].type=="notify")...{
                                              Container(
                                                width: w/1.15,
                                                child: Text(
                                              messageList[index]
                                                      .message??
                                                  "",
                                                  maxLines: 3,
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xff151522),
                                                fontSize: 12,
                                              ),
                                            ),
                                              )
                                              
                                             } else...{
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 14,
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      messageList[index]
                                                              .fromUser
                                                              ?.photo ??
                                                          ""),
                                                  radius: 12,
                                                ))),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              messageList[index]
                                                      .fromUser
                                                      ?.name ??
                                                  "",
                                              style: const TextStyle(
                                                color: Color(0xff151522),
                                                fontSize: 12,
                                              ),
                                            ),
                                            
                                           if (messageList[index].type ==
                                                "image") ...{
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return DetailScreen(
                                                        image:
                                                            messageList[index]
                                                                    .message ??
                                                                "",
                                                      );
                                                    }));
                                                  },
                                                  child: Container(
                                                      width: w / 1.5,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        color: ColorPalette
                                                            .primary,
                                                      ),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxHeight: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  3,
                                                            ),
                                                            width: w,
                                                            child: ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          6),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          6),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          6)),
                                                              child: Image(
                                                                  loadingBuilder:
                                                                      (context,
                                                                          child,
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null)
                                                                      return child;
                                                                    return const SizedBox(
                                                                      child: Center(
                                                                          child: CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                    );
                                                                  },
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      messageList[index]
                                                                              .message ??
                                                                          "")),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                messageList[index]
                                                                        .createdAt ??
                                                                    "",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )))
                                            } else if (messageList[index]
                                                    .type ==
                                                "audio") ...{
                                              VoiceMessage(
                                                audioSrc: messageList[index]
                                                        .message ??
                                                    "",
                                                played:
                                                    false, // To show played badge or not.
                                                me: false, // Set message side.
                                                onPlay:
                                                    () {}, // Do something when voice played.
                                              )
                                            } else if (messageList[index]
                                                    .type ==
                                                "file") ...{
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: w / 1.75,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10,
                                                        horizontal: 8),
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: Color(0xfff8f7f5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color:
                                                                  Colors.white),
                                                          child:
                                                              SvgPicture.string(
                                                                  TaskSvg()
                                                                      .docIcon2),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          width: w / 2,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              const BoxShadow(
                                                                color: Color(
                                                                    0x05000000),
                                                                blurRadius: 8,
                                                                offset: Offset(
                                                                    1, 1),
                                                              ),
                                                            ],
                                                            color: Colors.white,
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                messageList[index]
                                                                        .message ??
                                                                    "",
                                                                style:
                                                                    GoogleFonts.roboto(textStyle: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 8,
                                                                ),
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              // Text(
                                                              //   "21.54 Mb",
                                                              //   style: TextStyle(
                                                              //     color: Color(0xff333333),
                                                              //     fontSize: 12,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                      onTap: () async {
                                                        final url =
                                                            messageList[index]
                                                                    .message ??
                                                                "";
                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: SvgPicture.string(
                                                          TaskSvg()
                                                              .downloadIcon)),
                                                ],
                                              ),
                                            } else if (messageList[index]
                                                    .type ==
                                                "video") ...{
                                              VideoPlayerScreen(
                                                autoplay: false,
                                                looping: false,
                                                alignmentGeometry:
                                                    Alignment.topLeft,
                                                videoPlayerController:
                                                    VideoPlayerController
                                                        .network(
                                                  messageList[index].message ??
                                                      "",
                                                ),
                                              )
                                            } else ...{
                                              Column(children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              45,
                                                    ),
                                                    child: Card(
                                                      elevation: 1,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      color:
                                                          ColorPalette.primary,
                                                      // margin: const EdgeInsets
                                                      //         .symmetric(
                                                      //     horizontal: 15,
                                                      //     vertical: 5),
                                                      child: Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 10,
                                                              right: 10,
                                                              top: 10,
                                                              bottom: 10,
                                                            ),
                                                            child: Text(
                                                              messageList[index]
                                                                      .message ??
                                                                  "",
                                                              style: GoogleFonts.roboto(textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      messageList[index]
                                                              .createdAt ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Color(
                                                              0xFF6D6D6D)),
                                                    ),
                                                  ],
                                                ),
                                              ])
                                            }
                                          ],
                                        ),
                                      ],
                                    )
                                  }
                                  }
                                } 
                                
                                else ...{
                                  if(messageList[index].type=="notify")...{
                                   Container(
                                    width: w,
                                    child: Text(
                                              messageList[index]
                                                      .message??
                                                  "",
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                  maxLines: 3,
                                              style: const TextStyle(
                                                color: Color(0xff151522),
                                                fontSize: 12,
                                              ),
                                            ),
                                   )  
                                    }
                                 else if (messageList[index].type == "image") ...{
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return DetailScreen(
                                              image:
                                                  messageList[index].message ??
                                                      "",
                                            );
                                          }));
                                        },
                                        child: Container(
                                            width: w / 1.5,
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(0),
                                              ),
                                              color: ColorPalette.primary,
                                            ),
                                            alignment: Alignment.topRight,
                                            child: Column(
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            3,
                                                  ),
                                                  width: w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    6),
                                                            topRight:
                                                                Radius.circular(
                                                                    6),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    6),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0)),
                                                    child: Image(
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return const SizedBox(
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                          );
                                                        },
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            messageList[index]
                                                                    .message ??
                                                                "")),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      messageList[index]
                                                              .createdAt ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )))
                                  } else if (messageList[index].type ==
                                      "audio") ...{
                                    VoiceMessage(
                                      audioSrc:
                                          messageList[index].message ?? "",
                                      played:
                                          false, // To show played badge or not.
                                      me: true, // Set message side.
                                      onPlay:
                                          () {}, // Do something when voice played.
                                    )
                                  } else if (messageList[index].type ==
                                      "file") ...{
                                    Column(
                                      children: [
                                  
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              final url =
                                                  messageList[index].message ??
                                                      "";
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch $url';
                                              }
                                            },
                                            child: SvgPicture.string(
                                                TaskSvg().dwnldIcon,)),
                                                 const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(0),
                                          ),
                                                    color: ColorPalette.primary),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 8,),
                                              SizedBox(
                                                width: 34,
                                                height: 36,
                                                child: SvgPicture.string(
                                                    TaskSvg().docIcon2,color: Colors.white,),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: w / 1.8,
                                                height: 52,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    const BoxShadow(
                                                      color: Color(0x05000000),
                                                      blurRadius: 8,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                  color: ColorPalette.primary,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      messageList[index]
                                                              .message ??
                                                          "",
                                                      style:GoogleFonts.roboto (textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:10,
                                                      ),)
                                                    ),
                                                    const SizedBox(height: 4),
                                                    // Text(
                                                    //   "21.54 Mb",
                                                    //   style: TextStyle(
                                                    //     color: Color(0xff333333),
                                                    //     fontSize: 12,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ), 
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              messageList[index].createdAt ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF6D6D6D)),
                                            ),
                                          ],
                                        ),
                                      ]),
                                  } else if (messageList[index].type ==
                                      "video") ...{
                                    VideoPlayerScreen(
                                      autoplay: false,
                                      looping: false,
                                      alignmentGeometry: Alignment.topRight,
                                      videoPlayerController:
                                          VideoPlayerController.network(
                                        messageList[index].message ?? "",
                                      ),
                                    )
                                  } else ...{
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width - 45,
                                            ),
                                            child: Card(
                                              elevation: 1,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                ),
                                              ),
                                              color: ColorPalette.primary,
                                              // margin:
                                              //     const EdgeInsets.symmetric(
                                              //         horizontal: 10,
                                              //         vertical: 5),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 10,
                                                      bottom: 10,
                                                    ),
                                                    child: Text(
                                                      messageList[index]
                                                              .message ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              messageList[index].createdAt ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF6D6D6D)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  }
                                },
                              ],
                            );
                          },
                        ),
                      ),
                    ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     RecordButton(
              //       socket: widget.socket!,
              //       roomId: "",
              //       recordingFinishedCallback: _recordingFinishedCallback,
              //     ),
              //   ],
              // ),
              const SizedBox(height: 4),
              seenUsersList.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(seenUsersList.length, (index) {
                        return CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  seenUsersList[index].photo ?? ""),
                              radius: 12,
                            ));
                      }),
                    )
                  : Container(),
              groupTypingUser != null
                  ? Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(groupTypingUser?.photo ?? ""),
                              radius: 12,
                            )),
    
                        Image.asset(
                          "asset/typinggif.gif",
                          height: 50.0,
                          width: 50.0,
                        )
                        // Text(
                        //   "${groupTypingUser?.name} typing",
                        //   style: const TextStyle(
                        //     color: Color(0xff151522),
                        //     fontSize: 16,
                        //   ),
                        // ),
                      ],
                    )
                  : typing == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "asset/typinggif.gif",
                              height: 50.0,
                              width: 50.0,
                            ),
                          ],
                        )
                      : SizedBox(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: const Color(0xffFFFFFF),
                    width: w,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: w / 1.09,
                          // height: 54,
                          // padding: const EdgeInsets.only(left: 16, right: 16),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: w / 1.27,
                                    child: TextFormField(
                                      style: const TextStyle(
                                        // height: 1.6,
                                      ),
                                      maxLines:4,
                                      minLines: 1,
                                      onChanged: (val) {
                                        if (widget.isGroup == false) {
                                          if (val.length > 0) {
                                            widget.socket
                                                ?.emit("listen.typing", roomId);
                                          } else {
                                            widget.socket?.emit(
                                                "stopped.typing", roomId);

                                               
                                          }
                                        } else if (widget.isGroup == true) {
                                          if (val.length > 0) {
                                            print("the group typing atleaset");
                                            widget.socket?.emit(
                                                "group.listen.typing", roomId);
                                          } else {
                                            widget.socket?.emit(
                                                "group.stopped.typing", roomId);
                                          }
                                        }
                                        setState(() {});
                                      },
                                      scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .top),
                                      controller: typedMessageController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 2),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Color(0xffe6ecf0),
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Color(0xffe6ecf0),
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Color(0xffe6ecf0),
                                              )),
                                          // suffixIconConstraints: BoxConstraints.expand(),
                                          suffixIconConstraints:
                                              const BoxConstraints(
                                                  minHeight: 22, minWidth: 22),
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    // backgroundColor:
                                                    //     Colors.transparent,
                                                    context: context,
                                                    builder: (builder) {
                                                      return bottomSheet(
                                                          context);
                                                    });
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  right: 6,
                                                ),
                                                child: SvgPicture.string(
                                                    TaskSvg().shareIcon),
                                              )),
                                          hintText: activeUsersLength != 0
                                              ? "${activeUsersLength.toString()} active users"
                                              : micLongPress == true
                                                  ? "Recording, < slide to cancel "
                                                  : "Message",
                                          hintStyle: GoogleFonts.roboto(
                                              color: const Color(0xff949494))),
                                    ),
                                  ),
                                  voiceCancelled == true
                                      ? buildMicAnimation()
                                      : Container(),
                                ],
                              ),
                              Row(
                                children: [
                                  if (typedMessageController
                                      .text.isNotEmpty) ...{
                                    Container(
                                        // margin: const EdgeInsets.only(left: 16, right: 16),
    
                                        child: GestureDetector(
                                            onTap: () {
                                                
                                              HapticFeedback.heavyImpact();
                                              if (widget.isGroup == false) {
                                                      sendMessage(
                                                    typedMessageController.text,
                                                   widget.chat==false? widget.communicationUserModel
                                                            ?.chatid ??
                                                        "":widget.communicationuser?.id??"");
                                                widget.socket?.emit(
                                                    "stopped.typing", roomId);    
                                                    
                                              } else {
                                                sendGroupMessage(
                                                    typedMessageController.text,
                                                    widget.isg==false? widget.communicationUserModel
                                                            ?.chatid ??
                                                        "":widget.grpuser?.chatid??"");
                                                widget.socket?.emit(
                                                    "group.stopped.typing",
                                                    roomId);
                                                seenUsersList.clear();
                                              }
    
                                              typedMessageController.clear();
                                              
                                            },
                                            child: SvgPicture.string(
                                                height: 30,
                                                width: w / 7,
                                                TaskSvg().sendIcon,color: Color(0xFF2871AF),)))
                                  } else ...{
                                    GestureDetector(
                                      onLongPressMoveUpdate: (details) {
                                        if (details.offsetFromOrigin.distance >
                                            10) {
                                          voiceCancelled = true;
                                          setState(() {});
                                          _animationController?.forward();
                                        }
                                        Future.delayed(
                                            const Duration(milliseconds: 3000),
                                            () {
                                          voiceCancelled = false;
                                          _animationController?.reset();
                                          setState(() {});
                                        });
                                      },
                                      onLongPressEnd: (details) async {
                                        micLongPress = false;
                                        HapticFeedback.heavyImpact();
                                        final path =
                                            await _audioRecorder.stop();
                                        if (voiceCancelled == false) {
                                          _recordingFinishedCallback(
                                              path ?? "", context);
                                        }
                                        setState(() {});
                                      },
                                      onLongPressStart:  (details) async {
                                        HapticFeedback.heavyImpact();
                                        micLongPress = true;
                                        try {
                                          if (await _audioRecorder
                                              .hasPermission()) {
                                            await _audioRecorder.start();
    
                                            bool isRecording =
                                                await _audioRecorder
                                                    .isRecording();
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                        setState(() {});
                                      },
                                      child: micLongPress == true
                                          ? Row(
                                            children: [
                                              SizedBox(width: 4,),
                                              CircleAvatar(
                                                  radius: w/18,
                                                  backgroundColor: Color(0xFF2871AF),
                                                  child: SvgPicture.string(
                                                      width: w /25,
                                                      // height:28,
                                                      TaskSvg().mic),
                                                ),
                                            ],
                                          )
                                          : SvgPicture.string(
                                              // height: 51,
                                              width: w / 8.5,
                                              TaskSvg().micIcon2),
                                    )
                                  },
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStart() {
    final isRecording = true;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? "STOP" : "START";
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(175, 50),
            primary: primary,
            onPrimary: onPrimary),
        onPressed: () async {},
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  Widget buildMicAnimation() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 9.9)
                    ..translate(0.0, _micTranslateTop!.value)
                    ..translate(micTranslateRight!.value)
                    ..translate(micTranslateLeft!.value)
                    ..translate(0.0, _micTranslateDown!.value)
                    ..translate(0.0, micInsideTrashTranslateDown!.value),
                  child: Transform.rotate(
                      angle: _micRotationFirst!.value,
                      child: Transform.rotate(
                          angle: _micRotationSecond!.value, child: child)),
                );
              },
              child: const Icon(
                Icons.mic,
                color: Color(0xFFef5552),
                size: 30,
              ),
            ),
            AnimatedBuilder(
              animation: _trashContainerWithCoverTrasnlateTop!,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        0.0, _trashContainerWithCoverTrasnlateTop!.value)
                    ..translate(
                        0.0, trashContainerWithCoverTranslateDown!.value),
                  child: child,
                );
              },
              child: Column(children: [
                AnimatedBuilder(
                  animation: _trashCoverRotationFirst!,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(_trashCoverTranslateLeft!.value)
                        ..translate(_trashCoverTranslateRight!.value),
                      child: Transform.rotate(
                        angle: _trashCoverRotationSecond!.value,
                        child: Transform.rotate(
                          angle: _trashCoverRotationFirst!.value,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage('asset/trash_cover.png'),
                    width: 30.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 1.5),
                  child: Image(
                    image: AssetImage('asset/trash_container.png'),
                    width: 30,
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7.5,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: const Color(0xFFf8f7f5),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: iconCreation(
                      icon: Icons.photo,
                      text: "Image",
                      color: const Color(0xFF33C658)),
                  onTap: () {
                    pickFiles("Image", context);
                  },
                ),
                InkWell(
                  onTap: () {
                    pickFiles("Video", context);
                  },
                  child: iconCreation(
                      icon: Icons.video_call, text: "Video", color: Colors.red),
                ),
                InkWell(
                  onTap: () {
                    pickFiles("MultipleFile", context);
                  },
                  child: iconCreation(
                      icon: Icons.insert_drive_file,
                      text: "Document",
                      color: const Color(0xFF62A5A3)),
                ),
                // iconCreation(
                //     icon: Icons.location_pin,
                //     text: "Location",
                //     color: Colors.blue),
                // iconCreation(
                //     icon: Icons.all_inbox,
                //     text: "Task/Job",
                //     color: const Color(0xFF519BE0)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void pickFiles(String? filetype, BuildContext context) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: false);

        BlocProvider.of<AttachmentBloc>(context)
            .add(UploadPictureEvent(image: result!));
        // loadSelectedFiles(result!.files);

        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform
            .pickFiles(type: FileType.video, allowMultiple: false);
        // if (result == null) return;
        // file = result!.files.first;
        BlocProvider.of<AttachmentBloc>(context)
            .add(UploadVideoEvent(video: result!));
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform
            .pickFiles(type: FileType.audio, allowMultiple: false);
        if (result == null) return;
        file = result!.files.first;
        BlocProvider.of<AttachmentBloc>(context)
            .add(UploadAudioEvent(audio: result!));
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: false);
        BlocProvider.of<AttachmentBloc>(context)
            .add(UploadFilesEvent(files: result!));
        // if (result == null) return;
        // loadSelectedFiles(result!.files);
        break;
    }
  }

  void loadSelectedFiles(List<PlatformFile> files) {
    return null;
  }

  Widget iconCreation(
      {required IconData icon, required Color color, required String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: 29,
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class ScrollService {
  static scrollToEnd(
      {required ScrollController scrollController, reversed = false}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        reversed
            ? scrollController.position.minScrollExtent:
             scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

void _recordingFinishedCallback(
  String path,
  BuildContext context,
) {
  final uri = Uri.parse(path);
  File file = File(uri.path);

  file.length().then(
    (fileSize) {
      print("files is this ${file}");
      BlocProvider.of<AttachmentBloc>(context)
          .add(UploadLiveAudioEvent(audio: file));
    },
  );
}
