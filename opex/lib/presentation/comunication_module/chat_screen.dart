import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/comunication_module/audio_state.dart';
import 'package:cluster/presentation/comunication_module/bloc/attachment_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/image_details_screen.dart';
import 'package:cluster/presentation/comunication_module/chat_type_model.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/imagepreview.dart';
import 'package:cluster/presentation/comunication_module/videoplayerscreen.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
import 'package:flutter_image_compress/flutter_image_compress.dart';
class ChatScreen extends StatefulWidget {
  final bool isGroup;
  final bool chat;
  final Socket? socket;
  final String grpchatid;
  final String cmntgrpchatname;
  final String redirectchatid;
  final String redirectchatname;
  final String? token;
  final String? loginUserId;
  final String? redirectionsenduserId;
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
      this.grpchatid="",
      this.cmntgrpchatname="",
      this.redirectchatid="",
      this.redirectchatname="",
      this.redirectionsenduserId="",
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
AudioPlayer? player = AudioPlayer();
bool ismount1=true;
  bool isMount = true;
  bool isSecondMount = true;
  bool isThirdMount = true;
  bool isFourthMount = true;
  bool isFifthMount = true;
  bool issixthMount = true;
  bool isseventhMount = true;
  bool iseigthMount = true;
  bool loadmsg=false;
  bool isadmin=false;
  bool isgrp=true;
  int totpage=0;
  bool showdate=true;
  int activeUsersLength=0;
  Map<String, String> oldestMessageDateMap = {};
  String? roomId;
  String msgdate1='';
  int? indeex;
  List<Chatdate> day=[];
  final ScrollController _controller = ScrollController();
   TextEditingController typedMessageController = TextEditingController();
  int pageNo = 1;
  // Queue<ChatModel> messageQueue = Queue();
  List <ChatModel> messageList = [];
  List<FromUser> seenUsersList = [];
  List<messageSeenList> enter=[];
  List msgfr=[];
   List<ChatModel> msglist=[];
  FromUser? groupTypingUser;
  bool typing = false;
  FilePickerResult? result;
  PlatformFile? file;
  bool micLongPress = false;
  bool voiceCancelled = false;
  bool _playAudio = false;
  var username;
  bool isenter=false;
  List seenuser=[];
  String oldertimestampp="";
  int unreadMessageCount=0;
  int sendMessageCount=0;
  bool isload=false;
  List<GroupUserList> grpmember=[];
  List unseenuser=[];
  String a="";
  // int messageListLimit = 26;
  SharedPreferences? pref;
  AnimationController? _animationController;
  String fromuserids="";
  final ImagePicker picker = ImagePicker();
  XFile? image;
  late File _imageFile;
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

     print("room id listens atleast ${widget.redirectchatid} chatid${widget.grpchatid} ${widget.isGroup}");
    widget.socket?.emit("join.chat", {
      widget.redirectchatid!=""?widget.redirectchatid:
      widget.grpchatid!=""?widget.grpchatid:  
      widget.chat==false && widget.isg==false
    ? widget.communicationUserModel?.chatid:
    widget.chat==true&& widget.isg==false?widget.communicationuser?.id: widget.grpuser?.chatid});
    widget.socket!.emit("update.list",{
                        print("update ")
                      });
    if(widget.isGroup == false && widget.isg==false){
       if(widget.communicationUserModel?.unreadMessages != 0 || widget.communicationuser?.users?[0].chatUser?.unreadMessages != 0) {
        print("unreaded messages....");
        widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.redirectchatid!=""?widget.redirectchatid: widget.chat==false
    ? widget.communicationUserModel?.chatid:
    widget.communicationuser?.id,'userid':widget.chat==false?widget.redirectionsenduserId!.isNotEmpty?widget.redirectionsenduserId: widget.communicationUserModel?.id.toString():widget.communicationuser?.users?[0].id.toString()});  
    }
    }else if(widget.isGroup==true && widget.isg==false){
        print("unreaded messagess....");
        widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid!=""?widget.grpchatid: widget.isg==false
    ? widget.communicationUserModel?.chatid: widget.grpuser?.chatid,'userid':widget.loginUserId});
    }
     
      widget.socket!.on("unread.update1", (data) {
      print("my msg updatess $data");
      String? chatid= widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid!=""?widget.grpchatid: widget.chat==false && widget.isg==false
    ? "${widget.communicationUserModel?.chatid}":
    widget.chat==true&& widget.isg==false?"${widget.communicationuser?.id}": "${widget.grpuser?.chatid}";
    print(chatid);
      saveUnreadMessageCount(0,chatid);
      print("my msg updatess share");
    } );
   
    widget.socket?.on("room.id", (data) {
      print("room id from socket ${data}");
      roomId = data;
     
         widget.socket!.on("msg.seen", (data) {
            print("enter message $data");
            isenter=true;
                print("entered == $isenter");
              setState(() {
              });
         } );
         widget.socket?.emit("check", roomId);
      if (widget.isGroup == true) {
        // widget.socket?.emit("group.message.seen", roomId);
        // widget.socket?.emit("total.in.group", roomId);
     widget.socket!.emit("group.members",
     widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid!=""?widget.grpchatid:  widget.communicationUserModel?.chatid : widget.grpuser?.chatid);
     
    widget.socket!.on("groupmembers.result",datagrpmember);
         
   
      } else{
       
     
      }
         if(isFifthMount){
            widget.socket!.off("get.clients");
        widget.socket!.emit("get.clients",roomId);
         widget.socket!.off("active.length",handleActiveLength);
        print("get ACTIVE length");
          widget.socket!.on("active.length", handleActiveLength //{
        //  activeUsersLength = data; print("ACTIVE length sharedpref");
          // saveactiveusers(data);
          // loadactiveusers();
          // print("ACTIVE length sharedpref");
          // print("ACTIVE length $data");
          //  if(activeUsersLength == 2){
          //     sendMessageCount=0;
          //     saveUnreadMessageCount(0);
          //   }
          //   print("get ACTIVE length");
      //  }
       );
         }
 if(isseventhMount){    
widget.socket?.emit("group.message.seen",roomId);

   widget.socket?.on("msg.seen.by",activeuserlist);
   
   
      }
     
         
    widget.socket?.on("check.result", (data) {
      print("data for check ${data}");
    });
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
      widget.socket?.on("latest.message", (data)  {
        print("total res listened  ${data}");
     
       totpage<=1?messageList.add(ChatModel(
            type: data['type'],
            message: data['message'],
            createdAt: data['createdAt'],
            fromuserid: data['fromuserid'],
            firstMessageOfDay: data['firstMessageOfDay'])): 
            messageList.insert(0,ChatModel(
            type: data['type'],
            message: data['message'],
            createdAt: data['createdAt'],
            fromuserid: data['fromuserid'],
            firstMessageOfDay: data['firstMessageOfDay']
            ));  
            print("...msglist${messageList.length}");
            if(isenter==true){
              // unreadMessageCount++;
              // print("my msg count $unreadMessageCount");
              if(data['fromuserid'] != widget.loginUserId){
              print("other msg");
               player!.setAsset('asset/response.mp3').then((value) {
                return {  
              player!.playerStateStream.listen((state) {
                  if (state.playing) {
                  setState(() {
                    print("audio,,,,");
                  });
                  }
                  else
                  switch (state.processingState) {
                  case ProcessingState.idle:
                  break;
                  case ProcessingState.loading:
                  break;
                  case ProcessingState.buffering:
                  break;
                  case ProcessingState.ready:
                  setState(() {
                  });
                  break;
                  case ProcessingState.completed:
                  setState(() {
                  });
                  break;
                  }
                  }),
                  player!.play(),
                };
              });
              ScrollService.scrollToEnd(
            scrollController: _controller, reversed:totpage<=1? true:true);
            }
            else{
             ScrollService.scrollToEnd(
            scrollController: _controller, reversed:totpage<=1? true:true);
              print("my msg");
            }
            }
            else{
              print("msg");
             
            }    
            print("activeUsersLength $activeUsersLength");

            if(activeUsersLength == 1){
               print("fchgjh $sendMessageCount");
                sendMessageCount+=1;
            }
            else{
              sendMessageCount=0;
              print("lenght 2");
            }
             widget.socket?.emit("unread.messages",{'unreadMessageCount':sendMessageCount,'chatid':widget.chat==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel?.chatid:widget.communicationuser?.id,'userid':widget.loginUserId.toString()});
             widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
            print("my msg count $sendMessageCount,'userid':${widget.communicationUserModel?.id} ");
           
         
         
       if(isMount){
        setState(() {
         
        });
       }
    //    _controller.animateTo(
    //   _controller.position.minScrollExtent,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );
      // ScrollService.scrollToEnd(
      //       scrollController: _controller, reversed: true);
      });
          widget.socket!.on("unread.update", (data) {
            String? chatid= widget.chat==false
    ?widget.redirectchatid!=""?"${widget.redirectchatid}": "${widget.communicationUserModel?.chatid}":
   "${widget.communicationuser?.id}";
           
      print("my msg update $data");
      saveUnreadMessageCount(data,chatid);
       if(isMount){
        setState(() {
         
        });
       }
    } );
widget.socket!.emit("update.list",{
                        print("update")
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
        // activeUsersLength = data;
        if (isFifthMount) {
          setState(() {});
        }
      });
     
      widget.socket?.on("group.latest.message", (data) {
        loadmsg=true;
        print("total ser listened $loadmsg ${widget.loginUserId} ...${data}");
        // print(",,,,,lesting${data['fromuserid']}${widget.loginUserId}");
      totpage<=1?messageList.add(ChatModel(
            message: data['message'],
            fromuserid: data['fromuserid'],
            type: data['type'],
            createdAt: data['createdAt'],
            fromUser: FromUser(
                email: data['fromUser']['email'],
                name: data['fromUser']['name'],
                photo: data['fromUser']['photo']))): messageList.insert(0,ChatModel(
            message: data['message'],
            fromuserid: data['fromuserid'],
            type: data['type'],
            createdAt: data['createdAt'],
            fromUser: FromUser(
                email: data['fromUser']['email'],
                name: data['fromUser']['name'],
                photo: data['fromUser']['photo'])));
              print("...msglist${messageList.length}");
              //  if(isenter==true){
              // unreadMessageCount = 0;
             
              if(data['fromuserid'] != widget.loginUserId){  
                  print(",,,,,lesting${data['fromuserid']}${widget.loginUserId}");  
              print("other msg");
               player!.setAsset('asset/response.mp3').then((value) {
                return {  
              player!.playerStateStream.listen((state) {
                  if (state.playing) {
                  setState(() {
                    print("audio,,,,");
                   
                  });
                  }
                  else
                  switch (state.processingState) {
                  case ProcessingState.idle:
                  break;
                  case ProcessingState.loading:
                  break;
                  case ProcessingState.buffering:
                  break;
                  case ProcessingState.ready:
                  setState(() {
                  });
                  break;
                  case ProcessingState.completed:
                  setState(() {
                  });
                  break;
                  }
                  }),
                  player!.play(),
                };
              });
              ScrollService.scrollToEnd(
            scrollController: _controller, reversed:totpage<=1? true:false);
            }
            else{
              print("my msg");
            }
            // }else{
            // //   unreadMessageCount ++;
            //   print("my msg count ");
             
            // }
               print("activeUsersLength $activeUsersLength");
          if(widget.grpchatid==""){
            print("fchgjh entered ${grpmember.length}");
             if(activeUsersLength < grpmember.length){
              print("fchgjh checked");
                unseenuser.clear();
              for (int i = 0; i < grpmember.length; i++) {
                bool isUserIdInEnterList = false;

                for (int j = 0; j < enter.length; j++) {
                  if (grpmember[i].id == enter[j].userid) {
                    isUserIdInEnterList = true;
                    break;
                  }
                }

                if (!isUserIdInEnterList) {
                  print("fchgjh added");
                  unseenuser.add(grpmember[i].id);
                  for(int i=0;i<unseenuser.length;){
                    if(widget.loginUserId==unseenuser[i]){
                    unseenuser.removeAt(i);
                    break;
                    }
                    i++;
                  }
                  
                  print("fchgjh ${grpmember[i].id} $unseenuser");
                }
               
              }
               print("fchgjh $unseenuser");
                unreadMessageCount =1;
            }
            else {
              unreadMessageCount=0;
              print("lenght 2");
            }
             print("fchgjh $unseenuser");
             widget.socket?.emit("unread.messages.group",{'unreadMessageCount':unreadMessageCount,'chatid':widget.isg==false?widget.grpchatid!=""?widget.grpchatid: widget.redirectchatid!=""?widget.redirectchatid:widget.communicationUserModel?.chatid:widget.grpuser?.chatid,'userids':unseenuser});
             widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
            print("my msg count $unreadMessageCount,'userid':${widget.communicationUserModel?.chatid} ");
          }
            
        if (isMount) {
          setState(() {});
        }

        ScrollService.scrollToEnd(
            scrollController: _controller, reversed: totpage<=1?true:true);
      });
        widget.socket!.on("unread.update", (data) {
            // ignore: unused_local_variable
            String? chatid= widget.isg==false
    ? widget.grpchatid!=""?"${widget.grpchatid}":  widget.redirectchatid!=""?widget.redirectchatid:"${widget.communicationUserModel?.chatid}":
   "${widget.grpuser?.chatid}";            
      print("my msg update $data");
      // saveUnreadMessageCount(data,chatid);
       if(isMount){
        setState(() {
         
        });
       }
    } );
widget.socket!.emit("update.list",{
                        print("update")
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

    print("777777777777") ;
loadUnreadMessageCount();
    super.initState();
  }
 
  Future<void> loadUnreadMessageCount() async {
    String? chatid=widget.chat==false && widget.isg==false
    ?widget.grpchatid!=""?"${widget.grpchatid}":  widget.redirectchatid!=""?"${widget.redirectchatid}": "${widget.communicationUserModel?.chatid}":
    widget.chat==true&& widget.isg==false?"${widget.communicationuser?.id}": "${widget.grpuser?.chatid}";
     pref = await SharedPreferences.getInstance();
    setState(() {
      print("my msg update count1 ${chatid} ${pref!.getInt(widget.communicationUserModel?.chatid??"")}");
      if(widget.isGroup==false){
      sendMessageCount = pref!.getInt(chatid) ??0;
      }
      else{
        unreadMessageCount = 0;
      }
      print("my msg update count1 $sendMessageCount");
    });
  }
Future<void> saveUnreadMessageCount(int count,String chatt) async {
  setState(() {
     print("my msg update counta $count $chatt");
   
  });
   pref = await SharedPreferences.getInstance();
    await pref!.setInt(chatt, count);
 
  }
  void handleActiveLength(data) {
  print("ACTIVE length sharedpref  $data");
  saveactiveusers(data);
  loadactiveusers();
  print("ACTIVE length sharedpref");
  String? chatid= widget.chat==false && widget.isg==false
    ?widget.grpchatid!=""?"${widget.grpchatid}": widget.redirectchatid!=""?"${widget.redirectchatid}": "${widget.communicationUserModel?.chatid}":
    widget.chat==true&& widget.isg==false?"${widget.communicationuser?.id}": "${widget.grpuser?.chatid}";
  if(activeUsersLength == 2){
              sendMessageCount=0;
              saveUnreadMessageCount(0,chatid);
            }
            if(isMount){
      setState(() {
        
      });
            }
}
FocusNode focus=FocusNode();
void datagrpmember(data){
print("group members1: $data");
print("jhdgfkjhgkrng");
      grpmember.clear();
    (data as List).forEach((element) {
    grpmember.add(GroupUserList.fromJson(element));
      });
 print("jhdgfkjhgkrng${grpmember.length}");
 for(int i=0;i<grpmember.length;i++){
  if(widget.loginUserId==grpmember[i].id){
      isadmin=grpmember[i].isAdmin!;
      
      break;
  }
  print("isadmin+ $isadmin");
 
 }
 if(isgrp){
  setState(() {
    
  });
 }
}
  void activeuserlist(data) {
   print("active usersss $data");
   enter.clear();
    (data as List).forEach((element) {  
    enter.add(messageSeenList.fromJson(element));
      });
    print("active userssss ${enter.length}");
    if(isMount){
      setState(() {
        
      });
    }
}

    Future<void> loadactiveusers() async {
     
     pref = await SharedPreferences.getInstance();
    setState(() {
      activeUsersLength = pref!.getInt('activeuser')??0;
      print("ACTIVE length sharepref$activeUsersLength");
    });
  }
Future<void> saveactiveusers(int count) async {
  print("my msg active count $count");
     pref = await SharedPreferences.getInstance();
    await pref!.setInt('activeuser', count);
  }
  void sendMessage(String message, String chatId, bool day) {
   
    widget.socket?.emit(
        "new.message", {"type": "text", "chatid": chatId, "content": message ,"firstMessageOfDay":day});
     
            widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));


            print("uodate.chat.list");
  }

  void sendGroupMessage(String message, String chatId) {
    print("enter the grp $message , $chatId ");
    widget.socket?.emit("group.message",
        {"type": "text","chatid": chatId, "content": message});
       
        widget.socket?.on("update.chat.list", (data) => print("fxgf1  $data"));
       
             widget.socket!.emit("update.list",{
     
                        print("update")
                      });
                      // widget.socket!.on("friends.update", (data) => print(data));
                      widget.socket!.emit("update.list",{
     
                        print("update")
                      });
      //                 widget.socket!.on("friends.update", (data) {
      //   print(data);
      //   setState(() {
         
      //   });
      // } );
  }
   Future<void> saveUnreadMessageCount1(int count,String chatt) async {
 print("inside the funcion");
   pref = await SharedPreferences.getInstance();
    await pref!.setInt(chatt,0);
     setState(() {
     print("my msg update counta $count $chatt");
   
  });
 
  }
   double currentVisibleItemIndex=0.0;
  @override
  void dispose() {
    _controller.dispose();
    isMount = false;
    ismount1=false;
    isgrp=false;
    isSecondMount = false;
    isThirdMount = false;
    isFourthMount = false;
    isFifthMount = false;
    isseventhMount=false;
    iseigthMount=false;
    widget.socket!.off("get.clients");
    widget.socket!.off("active.length",handleActiveLength);
    _animationController?.dispose();
    widget.socket!.off('latest.message');
    widget.socket!.off('group.latest.message');
    widget.socket!.off('groupmembers.result');
    widget.socket!.off('group.members');
    super.dispose();
  }
double currentScrollPosition= 0.0;
 

  @override
  Widget build(BuildContext context) {
    // print("homescreen latest widget.id ${widget.communicationUserModel?.id}");
    // print("token ${widget.token}");
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    
    return WillPopScope(
      onWillPop: () {
        if(widget.isGroup==false){
          if(widget.redirectchatid != ""){
                        print("push notificstion redirection");
                       widget.socket!.emit("update.list",{
                        print("update")
                      });
                      widget.socket!.emit("leave.chat",{
                        "room": roomId??"",
                        "userid":widget.communicationUserModel?.id??""
                      }
                       );
                       print("user left too");
                     
    print("user left too");
                  widget.socket!.on("left.room", (data) {
                    print("room left $data");
                   
                    if(mounted){
                    widget.socket!.off("get.clients");
                     widget.socket!.emit("get.clients",roomId);
                     widget.socket!.off("active.length");
                      widget.socket!.on("active.length", (data) {
                      saveactiveusers(data);
                    print("ACTIVE ...length1 $data");
                  } );
                    }
                   widget.socket!.on("msg1.seen", (data) {
                    print("room leave message $data");
                 
                   
                   } );
                  });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data){
                          print("user left");
                         
                          if(data["userid"] == widget.loginUserId){
                             print("ACTIVE length sharedprefww");
                              saveUnreadMessageCount1(0,roomId??"");
                          print("user left the room1 ${data["chatid"]}");
                          setState(() {
                           
                          });
                        }else{
                          print("same user id");
                        }
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                        PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DashBoard(
              // token: widget.token ?? ""
              // socket: widget.socket,
            ),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
                      }
                    else if( widget.chat==false){
                       widget.socket!.emit("update.list",{
                        print("update")
                      });
                      widget.socket!.emit("leave.chat",{
                        "room": roomId??"",
                        "userid":widget.communicationUserModel?.id??""
                      }
                       );
                       print("user left too");
                     
    print("user left too");
                  widget.socket!.on("left.room", (data) {
                    print("room left $data");
                   
                    if(mounted){
                    widget.socket!.off("get.clients");
                     widget.socket!.emit("get.clients",roomId);
                     widget.socket!.off("active.length");
                      widget.socket!.on("active.length", (data) {
                      saveactiveusers(data);
                    print("ACTIVE ...length1 $data");
                  } );
                    }
                   widget.socket!.on("msg1.seen", (data) {
                    print("room leave message $data");
                 
                   
                   } );
                  });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data){
                          print("user left");
                         
                          if(data["userid"] == widget.loginUserId){
                             print("ACTIVE length sharedprefww");
                              saveUnreadMessageCount1(0,roomId??"");
                          print("user left the room1 ${data["chatid"]}");
                          setState(() {
                           
                          });
                        }else{
                          print("same user id");
                        }
                        });
                   
                  Navigator.pop(context);
                     }else{
                       BlocProvider.of<CommunicationBloc>(context).add(
                  GetFilterdChatListEvent(
                    token: widget.token ?? "",
                    chatFilter: "chats"
                  ));
                  Navigator.pop(context);
                  widget.socket!.emit("update.list",{
                        print("update")
                      });
                      widget.socket!.emit("leave.chat",{
                        "room": roomId??"",
                        "userid":widget.communicationuser?.users?[0].id??""
                      }
                       );
                       print("user left too");
                     
    print("user left too");
                  widget.socket!.on("left.room", (data) {
                    print("room left $data");
                   
                    if(mounted){
                    widget.socket!.off("get.clients");
                     widget.socket!.emit("get.clients",roomId);
                     widget.socket!.off("active.length");
                      widget.socket!.on("active.length", (data) {
                      saveactiveusers(data);
                    print("ACTIVE ...length1 $data");
                  } );
                    }
                   widget.socket!.on("msg1.seen", (data) {
                    print("room leave message $data");
                 
                   
                   } );
                  });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data){
                          print("user left");
                         
                          if(data["userid"] == widget.loginUserId){
                             print("ACTIVE length sharedprefww");
                              saveUnreadMessageCount1(0,roomId??"");
                          print("user left the room1 ${data["chatid"]}");
                          setState(() {
                           
                          });
                        }else{
                          print("same user id");
                        }
                        });
                  Navigator.pop(context);
                     }
                   
                    }
                    else{
                      if(widget.redirectchatid != ""){
                        print("push notificstion redirection");
                       widget.socket!.emit("update.list",{
                        print("update")
                      });
                      widget.socket!.emit("leave.chat",{
                        "room": roomId??"",
                        "userid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid:widget.redirectchatid!=""?"${widget.redirectchatid}": widget.communicationUserModel?.id??"":widget.loginUserId??""
                      }
                       );
                       print("user left too");
                     
    print("user left too");
                  widget.socket!.on("left.room", (data) {
                    print("room left $data");
                   
                    if(mounted){
                    widget.socket!.off("get.clients");
                     widget.socket!.emit("get.clients",roomId);
                     widget.socket!.off("active.length");
                      widget.socket!.on("active.length", (data) {
                      saveactiveusers(data);
                    print("ACTIVE ...length1 $data");
                  } );
                    }
                    if(ismount1){
                      widget.socket?.emit("group.message.seen",roomId);
                    widget.socket?.on("msg.seen.by", (data){
                      print("active userss $data");
                      setState(() {
                        
                      });
                      });
                    }
                   
                   widget.socket!.on("msg1.seen", (data) {
                    print("room leave message $data");
                 
                   
                   } );
                  });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data){
                          print("user left");
                         
                          if(data["userid"] == widget.loginUserId){
                             print("ACTIVE length sharedprefww");
                              saveUnreadMessageCount1(0,roomId??"");
                          print("user left the room1 ${data["chatid"]}");
                          setState(() {
                           
                          });
                        }else{
                          print("same user id");
                        }
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                        PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DashBoard(
              // token: widget.token ?? ""
              // socket: widget.socket,
            ),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
                      }
                    else if( widget.isg==false){
                       widget.socket!.emit("update.list",{
                        print("update")
                      });
                      widget.socket!.emit("leave.chat",{
                        "room": roomId??"",
                        "userid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid:widget.redirectchatid!=""?"${widget.redirectchatid}": widget.communicationUserModel?.id??"":widget.loginUserId??""
                      }
                       );
                       print("user left too");
                     
    print("user left too");
                  widget.socket!.on("left.room", (data) {
                    print("room left $data");
                   
                    if(mounted){
                    widget.socket!.off("get.clients");
                     widget.socket!.emit("get.clients",roomId);
                     widget.socket!.off("active.length");
                      widget.socket!.on("active.length", (data) {
                      saveactiveusers(data);
                    print("ACTIVE ...length1 $data");
                  } );
                    }
                    if(ismount1){
                      widget.socket?.emit("group.message.seen",roomId);
                    widget.socket?.on("msg.seen.by", (data){
                      print("active userss $data");
                      setState(() {
                        
                      });
                      });
                    }
                   
                   widget.socket!.on("msg1.seen", (data) {
                    print("room leave message $data");
                 
                   
                   } );
                  });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data){
                          print("user left");
                         
                          if(data["userid"] == widget.loginUserId){
                             print("ACTIVE length sharedprefww");
                              saveUnreadMessageCount1(0,roomId??"");
                          print("user left the room1 ${data["chatid"]}");
                          setState(() {
                           
                          });
                        }else{
                          print("same user id");
                        }
                        });
                   
                  Navigator.pop(context);
                     }else{
                  widget.socket!.emit("update.list",{
                        print("update")
                      });
                      widget.socket!.emit("leave.chat",{
                        "room": roomId??"",
                        "userid":widget.loginUserId ??""
                      }
                       );
                       print("user left too");
                  widget.socket!.on("left.room", (data) {
                    print("room left $data");
                   
                    if(mounted){
                    widget.socket!.off("get.clients");
                     widget.socket!.emit("get.clients",roomId);
                     widget.socket!.off("active.length");
                      widget.socket!.on("active.length", (data) {
                      saveactiveusers(data);
                    print("ACTIVE ...length1 $data");
                  } );
                    }
                   widget.socket!.on("msg1.seen", (data) {
                    print("room leave message $data");
                 
                   
                   } );
                  });
                        widget.socket!.off("user.left");
                        widget.socket!.on("user.left", (data){
                          print("user left");
                         
                          if(data["userid"] == widget.loginUserId){
                             print("ACTIVE length sharedprefww");
                              saveUnreadMessageCount1(0,roomId??"");
                          print("user left the room1 ${data["chatid"]}");
                          setState(() {
                           
                          });
                        }else{
                          print("same user id");
                        }
                        });
                  Navigator.pop(context);
                     }
                      PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: CommunicationModule(),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
                    }
        return Future.value(false);
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<ChatBloc, ChatState>(
            listener: (context, state) {
              print("the message state //");
              if (state is ChatScreenGetLoading) {

              } else if (state is ChatScreenGetSuccess) {
                totpage=state.chatData[0].pagination!.totalpages;
                for (int i = 0; i < state.chatData[0].messages!.length; i++) {
               
                 if(widget.communicationUserModel?.isDeleted  == false && widget.communicationUserModel?.deletedAt == null||widget.communicationuser?.users![0].chatUser?.isDeleted ==false && widget.communicationuser?.users![0].chatUser?.deletedAt == null)
                 {
                   messageList.add(state.chatData[0].messages![i]);
                   msglist.add(state.chatData[0].messages![i]);
                 }
                   else if(widget.communicationUserModel?.isDeleted == false && widget.communicationUserModel?.deletedAt != null||widget.communicationuser?.users![0].chatUser?.isDeleted ==false && widget.communicationuser?.users![0].chatUser?.deletedAt != null){
                  String? timestamp = widget.communicationUserModel!.deletedAt.toString();
                  DateTime dateTime = DateTime.parse(timestamp);
                  int formattedTime = dateTime.millisecondsSinceEpoch;              // Combine hours and minutes into a single integer
               

                if( state.chatData[0].messages?[i].createdAt == null )
                  {
                    messageList.add(state.chatData[0].messages![i]);
                    msglist.add(state.chatData[0].messages![i]);
                 }
                 else {
                 String? timestamp1 = state.chatData[0].messages![i].createdAt;
                DateTime dateTime1 = DateTime.parse(timestamp1!);
                int formattedTime1 = dateTime1.millisecondsSinceEpoch;

                  if(formattedTime1 > formattedTime){
                messageList.add(state.chatData[0].messages![i]);
                msglist.add(state.chatData[0].messages![i]);
              }
                 }
               
                }else if(widget.communicationUserModel?.isDeleted == true && widget.communicationUserModel?.deletedAt != null ||widget.communicationuser?.users![0].chatUser?.isDeleted ==true && widget.communicationuser?.users![0].chatUser?.deletedAt != null){
                  messageList.clear();
                }
               
                else{
                  messageList.add(state.chatData[0].messages![i]);
                  msglist.add(state.chatData[0].messages![i]);
                }

                 }
              //    
                 setState(() {
                   totpage=state.chatData[0].pagination!.totalpages;
                print("totalpagess$totpage");
                loadmsg=true;
          //       if(messageList.isNotEmpty){
          //   msglist=msglist.reversed.toList();
          //   for(int index=0;index<msglist.length;){
          //   String? timestamp = msglist[index].createdAt.toString();
          //   DateTime dateTime = DateTime.parse(timestamp); 
          // String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);print("getey$formattedDate $msgdate1");
          //   String msgdate = formatMessageTimestamp(dateTime,index,msgdate1!=formattedDate?true:false);
          //   print("dayyyyyy$msgdate");
          //   day.add(Chatdate(day: msgdate));
          //   print("dayyyyyy ${day[index].day}");
          //   msgdate1=formattedDate;
          //   setState(() {
          //     index++;
          //   });
          // }
      
          // }
                  
                });
               
               state.chatData[0].pagination!.totalpages<=1? 
               messageList = messageList.reversed.toList()
               :null;
              totpage<=1?  _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ):  ScrollService.scrollToEnd(
              scrollController: _controller, reversed:true);
              
              }

              else if (state is ChatScreenGetFailed){
               setState(() {
                  loadmsg=true;
                });
              }
     
             
            },
          ),
          BlocListener<PaginatedchatBloc, PaginatedchatState>(
            listener: (context, state) {
              if (state is PaginatedChatLoading) {
                 
              } else if (state is PaginatedChatSuccess) {
                
              
              //  _insertMessagesWithDelay(state.chatData.messages!);
          for (int i = 0; i < state.chatData[0].messages!.length; i++) {
            // messageList.insertAll(0, [state.chatData.messages![i]]);
               if(widget.communicationUserModel?.isDeleted ==false && widget.communicationUserModel?.deletedAt == null || widget.communicationuser?.users![0].chatUser?.isDeleted ==false && widget.communicationuser?.users![0].chatUser?.deletedAt == null)
            {
              messageList.add(state.chatData[0].messages![i]);
              //  messageList.insertAll(0, [state.chatData.messages![i]]);
           
    setState(() {});
            }
            else if(widget.communicationUserModel?.isDeleted == false && widget.communicationUserModel?.deletedAt != null ||widget.communicationuser?.users![0].chatUser?.isDeleted ==false && widget.communicationuser?.users![0].chatUser?.deletedAt != null){
            String? timestamp = widget.communicationUserModel!.deletedAt.toString();
            DateTime dateTime = DateTime.parse(timestamp);
            int formattedTime = dateTime.millisecondsSinceEpoch;  

          if( state.chatData[0].messages![i].createdAt == null )
            {
              
              messageList.add(state.chatData[0].messages![i]);
             
    setState(() {});
            }
            else {
            String? timestamp1 = state.chatData[0].messages![i].createdAt;
          DateTime dateTime1 = DateTime.parse(timestamp1!);
          int formattedTime1 = dateTime1.millisecondsSinceEpoch;
            if(formattedTime1 > formattedTime){
               messageList.add(state.chatData[0].messages![i]);
          // messageList.insertAll(0, [state.chatData.messages![i]]);
         
    setState(() {});
        }
            }
         
          }else if(widget.communicationUserModel?.isDeleted == true && widget.communicationUserModel?.deletedAt != null ||widget.communicationuser?.users![0].chatUser?.isDeleted ==true && widget.communicationuser?.users![0].chatUser?.deletedAt != null){
            
          }
          else{
             messageList.add(state.chatData[0].messages![i]);
            // messageList.insertAll(0, [state.chatData.messages![i]]);
           
    setState(() {});
          }
          }
          // if(messageList.isNotEmpty){
          //   List<ChatModel> msglist=messageList.reversed.toList();
          //   for(int index=0;index<msglist.length;index++){
          //   String? timestamp = msglist[index].createdAt.toString();
          //   DateTime dateTime = DateTime.parse(timestamp); 
          // String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);print("getey$formattedDate $msgdate1");
          //   String msgdate = formatMessageTimestamp(dateTime,index,msgdate1!=formattedDate?true:false);
          //   print("dayyyyyy$msgdate");
          //   msglist.add(ChatModel(day: "$msgdate"));
          //   msgdate1=formattedDate;
          // }
          // messageList=msglist.reversed.toList();
          // }
          
          
           
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
                  "chatid":widget.chat==false?widget.redirectchatid!=""?"${widget.redirectchatid}":widget.communicationUserModel?.chatid:widget.communicationuser?.id,
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
                  "chatid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid:widget.redirectchatid!=""?widget.redirectchatid:widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
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
              setState(() {
                
              });
            } else if (state is UploadPictureFailed) {
              print("failed");
            } else if (state is UploadVideoLoading) {
              print("video Loading");
            } else if (state is UploadVideoSuccess) {
              if (widget.isGroup != true) {
                widget.socket?.emit("new.message", {
                  "type": "video",
                  "chatid": widget.chat==false?widget.redirectchatid!=""?widget.redirectchatid:widget.communicationUserModel?.chatid : widget.communicationuser?.id,
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
                  "chatid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid: widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
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
              setState(() {
                
              });
            } else if (state is UploadVideoFailed) {
              print("video failed");
            } else if (state is UploadFilesLoading) {
              print("files Loading");
            } else if (state is UploadFilesSuccess) {
              if (widget.isGroup != true) {
                widget.socket?.emit("new.message", {
                  "type": "file",
                  "chatid": widget.chat==false?widget.grpchatid!=""?widget.grpchatid: widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel?.chatid:widget.communicationuser?.id,
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
                  "chatid": widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid!=""?widget.grpchatid:  widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
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
              setState(() {
                
              });
            } else if (state is UploadAudioLoading) {
              print("audio loading");
            } else if (state is UploadAudioSuccess) {
              if (widget.isGroup != true) {
                widget.socket?.emit("new.message", {
                  "type": "audio",
                  "chatid": widget.chat==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel?.chatid:widget.communicationuser?.id,
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
                  "chatid": widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid: widget.grpchatid!=""?widget.grpchatid:  widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
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
              setState(() {
                
              });
            } else if (state is UploadAudioFailed) {
              print("audio failed");
            } else if (state is UploadLiveAudioLoading) {
              print("live audio loading");
            } else if (state is UploadLiveAudioSuccess) {
              if (widget.isGroup != true) {
                widget.socket?.emit("new.message", {
                  "type": "audio",
                  "chatid": widget.chat==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel?.chatid:widget.communicationuser?.id,
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
                  "chatid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid: widget.redirectchatid!=""?widget.redirectchatid:widget.communicationUserModel?.chatid : widget.grpuser?.chatid,
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
              setState(() {
                
              });
            } else if (state is UploadLiveAudioFailed) {
              print("live audio failed");
            }
          })
        ],
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print("unFocus trigger");
            focus.unfocus();
            setState(() {
              
            });
          },
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
              child:loadmsg==false?LottieLoader(): Column(
                children: [
                  ChatAppBar(
                    chat: widget.chat,
                    isGroup: widget.isGroup,
                    roomId: roomId,
                    cmntgrpid: widget.grpchatid,
                    cmntgrpname: widget.cmntgrpchatname,
                    redirectchatid: widget.redirectchatid,
                    redirectchatname: widget.redirectchatname,
                    socket: widget.socket,
                    token: widget.token,
                    loginUserId: widget.loginUserId,
                    typing: typing,
                    isadmin: isadmin,
                    groupTypingUser: groupTypingUser,
                    communicationUserModel: widget.communicationUserModel,
                    communicationuser: widget.communicationuser,
                    isgrp: widget.isg,
                    grpuser: widget.grpuser,
                    grpmember: grpmember,
                   
                  ),
                  SizedBox(height:3),
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
                            onNotification: (ScrollEndNotification notification) {
                              final metrics = notification.metrics;
                              if (metrics.atEdge) {
                                // bool isTop = metrics.pixels == 0;
                                if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent &&
                                    _controller.position.userScrollDirection
                                    ==
                                        ScrollDirection.reverse && totpage > 1 && totpage != pageNo) {
                                         
                                  pageNo++;
                                  if(widget.isGroup==false){
                                  BlocProvider.of<PaginatedchatBloc>(context).add(
                                      PaginatedChatGetEvent(
                                          token: widget.token ?? "",
                                          chatId: widget.chat==false?
                                          widget.redirectchatid!=""?widget.redirectchatid:
                                              widget.communicationUserModel?.chatid ??
                                                  "": widget.communicationuser?.id??"",
                                              grpchatId: "",
                                          pageNo: pageNo));
                                  }else{
                                     BlocProvider.of<PaginatedchatBloc>(context).add(
                                      PaginatedChatGetEvent(
                                          token: widget.token ?? "",
                                          chatId: widget.isg==false?widget.grpchatid!=""?widget.grpchatid:
                                          widget.redirectchatid!=""?widget.redirectchatid:
                                              widget.communicationUserModel?.chatid ??
                                                  "": widget.grpuser?.chatid??"",
                                              grpchatId:widget.grpchatid!=""?widget.grpchatid:"" ,
                                          pageNo: pageNo));
                                  }
                                       
                                } else {
                                  print('At the bottom');
                                }
                              }
                              return false;
                            },
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ListView.separated(
                                reverse:totpage<=1?false: true,
                                shrinkWrap: true,
                                controller: _controller,
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(left: 8, right: 8,top:5,bottom: 5),
                                itemCount: messageList.length,
                                itemBuilder: (context, index) {
                                  String msgdate = "";
                                 
                                 int today=0;
                                  String? timestamp = messageList[index].createdAt.toString();
                                  DateTime dateTime = DateTime.parse(timestamp); 
                                  String formattedTime = DateFormat('h:mm a').format(dateTime.toLocal());
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);print("getey$formattedDate $msgdate1");
                                    msgdate = formatMessageTimestamp(dateTime,index);
                                    print("list view reload firstMessageOfDay $msgdate ${messageList[index].message}");
                                 if( totpage<=1){
                                  if(messageList.last.firstMessageOfDay==false || messageList.last.firstMessageOfDay==true && msgdate != "Today"){
                                    showdate=true;
                                   }else{
                                    showdate=false;
                                   }
                                  }else{
                                    if(messageList.first.firstMessageOfDay==false || messageList.last.firstMessageOfDay==true && msgdate != "Today"){
                                    showdate=true;
                                   }else{
                                    showdate=false;
                                   }
                                  }
                                  return  Column(
                                    crossAxisAlignment:
                                        messageList[index].fromuserid !=
                                                widget.loginUserId
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.end,
                                    children: [
                                     messageList[index].firstMessageOfDay == true ?
                                      Padding(
                                           padding: const EdgeInsets.only(top:5,left: 25,right: 25,bottom: 10),
                                           child: Center(
                                             child: Container(
                                               padding: EdgeInsets.only(top:5,bottom:5,right: 10,left: 10),
                                               
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(20),
                                                 color: Color.fromARGB(236, 233, 232, 232)
                                               ),
                                               child: Column(
                                                 children:[ 
                                                  
                                                  Text(
                                                      "$msgdate",
                                                               textAlign: TextAlign.center,
                                                               softWrap: true,
                                                           style: const TextStyle(
                                                             color: Color(0xff151522),
                                                             fontSize: 12,
                                                           ),
                                                         )
                                                         ,]
                                               ),
                                             ),
                                           ),
                                         ):Container(),
                                         
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
                                                                        .circular(0),
                                                                    topRight: Radius
                                                                        .circular(6),
                                                                    bottomLeft: Radius
                                                                        .circular(6),
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
                                                              MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                                        formattedTime,
                                                                        style: const TextStyle(
                                                                          fontSize: 8,
                                                                          color: Color(0xFF6D6D6D),
                                                                        ),
                                                                      ),
                                                                      
                                                          ],
                                                        ),
                                                      ],
                                                    )))
                                          } else if (messageList[index].type ==
                                              "audio") ...{
                                                Stack(
                                                  children:[
                                                    VoiceMessage(
                                              audioSrc:
                                                  messageList[index].message ?? "",
                                              played:
                                                  false, // To show played badge or not.
                                              me: false, // Set message side.
                                              onPlay:
                                                  () {}, // Do something when voice played.
                                            ),
                                            Positioned(
                                                        right: 6,
                                                        bottom: 5,
                                                        child: Text(
                                                      formattedTime,
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          color: Color(0xFF6D6D6D),
                                                        ),                                                           ),
                                                      ),
                                                  ]
                                                )
                                            
                                          } else if (messageList[index].type ==
                                              "video") ...{
                                                Container(
                                                   constraints:  BoxConstraints(
                                                  maxWidth: 277,
                                                 maxHeight:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height /
                                                                  2.5,
                                              ),
                                              decoration: BoxDecoration(
                                                
                                                      // RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                          
                                                    ),
                                                    boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
                                                  // ),
                                                 color: Colors.white,
                                                  ),
                                                  child:Stack(
                                                  children:[
                                                    VideoPlayerScreen(
                                              autoplay: false,
                                              looping: true,
                                              me: false,
                                              videoUrl: messageList[index].message ?? "",
                                              alignmentGeometry: Alignment.topLeft,
                                              // videoPlayerController:
                                              //     VideoPlayerController.network(
                                              //   messageList[index].message ?? "",
                                              // ),
                                            ),
                                            Positioned(
                                                        right: 6,
                                                        bottom: 0,
                                                        child: Text(
                                                      formattedTime,
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          color: Color(0xFF6D6D6D),
                                                        ),                                                           ),
                                                      ),
                                                  ]
                                                ),
                                                )
                                                
                                            
                                          } else if (messageList[index].type ==
                                              "file") ...{
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: w / 1.63,
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 10, horizontal: 8),
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(11),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 45,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        8),
                                                                color: Colors.white),
                                                            child: SvgPicture.string(
                                                                CommunicationSvg().docIcon2),
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
                                                                  // messageList[index].message ??
                                                                      "${ messageList[index].message!.split('?').first.split('/').last}",
                                                                      overflow: TextOverflow.ellipsis,
                                                                  style: GoogleFonts.roboto(textStyle:TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 13,
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
                                                      Positioned(
                                                        right: 3,
                                                        bottom: -4,
                                                        child: Text(
                                                      formattedTime,
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          color: Color(0xFF6D6D6D),
                                                        ),                                                           ),
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
                                                        CommunicationSvg().dwnldIcon)),
                                              ],
                                            ),
                                          } else ...{
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      300,
                                                  maxWidth: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      95,
                                                ),
                                                child: Container(
                                                  // elevation: 1,
                                                  decoration: BoxDecoration(
                                                      // RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                    boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
                                                  // ),
                                                  color: Colors.white,
                                                  ),
                                                  // shape:
                                                     
                                                  // margin: const EdgeInsets.symmetric(
                                                  //     horizontal: 15, vertical: 5),
                                                  child: Stack(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                          left: 10,
                                                          right:20,
                                                          top:7,
                                                          bottom: 17,
                                                        ),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                            messageList[index]
                                                                    .message ??
                                                                "",
                                                                textAlign: TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black),
                                                            ),
                                                            SizedBox(height: 5,),
                                                           
                                                          ],
                                                        ),
                                                      ),
                                                       Positioned(
                                                               right: 5,
                                                               bottom: 5,
                                                               child: Text(
                                                              formattedTime,
                                                                style: const TextStyle(
                                                                  fontSize: 8,
                                                                  color: Color(0xFF6D6D6D),
                                                                ),                                                           ),
                                                             ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          }
                                        } else ...{
                                          if(messageList[index].type=="notify")...{
                                                   Padding(
                                           padding: const EdgeInsets.only(top:10,left: 25,right: 25,bottom: 10),
                                           child: Center(
                                             child: Container(
                                               padding: EdgeInsets.only(top:5,bottom:5),
                                               constraints: const BoxConstraints(
                                                  maxWidth: 250,
                                              ),
                                               
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(20),
                                                 color: Color.fromARGB(236, 233, 232, 232)
                                               ),
                                               child: Text(
                                                "${messageList[index]
                                                                 .message.toString()}"
                                                         ,
                                                             textAlign: TextAlign.center,
                                                             softWrap: true,
                                                             maxLines: 5,
                                                         style: const TextStyle(
                                                           color: Color(0xff151522),
                                                           fontSize: 12,
                                                         ),
                                                       ),
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
                                                      radius:18,
                                                      child: TextAvatar(
                                                    shape: Shape.Circular,
                                                    size: 14,
                                                    numberLetters: 2,
                                                    fontSize: w/23,
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    text:"${messageList[index].fromUser?.name.toString().toTitleCase()}" ,
                                                  )
                                                  )
                                                      ),
                                                      SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    messageList[index]
                                                            .fromUser
                                                            ?.name.toString().toTitleCase() ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
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
                                                                        0),
                                                                topRight:
                                                                    Radius.circular(
                                                                        10),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                        10),
                                                              ),
                                                              color: Colors.white
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
                                                                                0),
                                                                        topRight: Radius
                                                                            .circular(
                                                                                6),
                                                                        bottomLeft: Radius
                                                                            .circular(
                                                                                6),
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
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                        formattedTime,
                                                                        style: const TextStyle(
                                                                          fontSize: 8,
                                                                          color: Color(0xFF6D6D6D),
                                                                        ),
                                                                      ),
                                                                     
                                                                  ],
                                                                ),
                                                              ],
                                                            )))
                                                  } else if (messageList[index]
                                                          .type ==
                                                      "audio") ...{
                                                        Stack(
                                                          children:[
                                                            VoiceMessage(
                                                      audioSrc: messageList[index]
                                                              .message ??
                                                          "",
                                                      played:
                                                          false, // To show played badge or not.
                                                      me: false, // Set message side.
                                                      onPlay:
                                                          () {}, // Do something when voice played.
                                                    ),
                                                    Positioned(
                                                                 right: 6,
                                                                 bottom: 5,
                                                                 child: Text(
                                                                  formattedTime,
                                                                //   messageList[index]
                                                                //     .createdAt ??
                                                                // "",
                                                                  style: const TextStyle(
                                                                    fontSize: 8,
                                                                    color: Color(0xFF6D6D6D),
                                                                  ),
                                                                                                                            ),
                                                               ),
                                                          ]
                                                        )
                                                    
                                                  } else if (messageList[index]
                                                          .type ==
                                                      "file") ...{
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: w / 1.6,
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 10,
                                                              horizontal: 8),
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(0),
                                                              topRight:
                                                                  Radius.circular(10),
                                                              bottomLeft:
                                                                  Radius.circular(10),
                                                              bottomRight:
                                                                  Radius.circular(10),
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Row(
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
                                                                            CommunicationSvg()
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
                                                                          // messageList[index]
                                                                          //         .message ??
                                                                              "${ messageList[index].message!.split('?').first.split('/').last}",
                                                                              overflow: TextOverflow.ellipsis,
                                                                          style:
                                                                              GoogleFonts.roboto(textStyle: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:13,
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
                                                              Positioned(
                                                                 right: 3,
                                                                 bottom: -4,
                                                                 child: Text(
                                                                  formattedTime,
                                                                //   messageList[index]
                                                                //     .createdAt ??
                                                                // "",
                                                                  style: const TextStyle(
                                                                    fontSize: 8,
                                                                    color: Color(0xFF6D6D6D),
                                                                  ),
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
                                                              CommunicationSvg().dwnldIcon,)),
                                                      ],
                                                    ),
                                                  } else if (messageList[index]
                                                          .type ==
                                                      "video") ...{
                                                        Container(
                                                   constraints:  BoxConstraints(
                                                  maxWidth: 277,
                                                 maxHeight:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height /
                                                                  2.5,
                                              ),
                                              decoration: BoxDecoration(
                                                
                                                      // RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                          
                                                    ),
                                                    boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
                                                  // ),
                                                 color: Colors.white,
                                                  ),
                                                  child:Stack(
                                                  children:[
                                                    VideoPlayerScreen(
                                              autoplay: false,
                                              looping: true,
                                              me: false,
                                              videoUrl: messageList[index].message ?? "",
                                              alignmentGeometry: Alignment.topLeft,
                                              // videoPlayerController:
                                              //     VideoPlayerController.network(
                                              //   messageList[index].message ?? "",
                                              // ),
                                            ),
                                            Positioned(
                                                        right: 6,
                                                        bottom: 0,
                                                        child: Text(
                                                      formattedTime,
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          color: Color(0xFF6D6D6D),
                                                        ),                                                           ),
                                                      ),
                                                  ]
                                                ),
                                                )
                                                    
                                                  } else ...{
                                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                      ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                             minWidth:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  300,
                                                          maxWidth:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  90,
                                                        ),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                      // RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        offset: Offset(0, 1), // changes position of shadow
                                                      ),
                                                    ],
                                                  // ),
                                                  color: Colors.white,
                                                  ),
                                                          // margin: const EdgeInsets
                                                          //         .symmetric(
                                                          //     horizontal: 15,
                                                          //     vertical: 5),
                                                          child:  Stack(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                            left: 10,
                                                            right:20,
                                                            top:7,
                                                            bottom: 17,
                                                          ),
                                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                              messageList[index]
                                                                      .message ??
                                                                  "",
                                                                  softWrap: true,
                                                                  textAlign: TextAlign.left,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.black),
                                                              ),
                                                              SizedBox(height: 5,),
                                                             
                                                            ],
                                                          ),
                                                        ),
                                                         Positioned(
                                                                 right: 6,
                                                                 bottom: 5,
                                                                 child: Text(
                                                                  formattedTime,
                                                                //   messageList[index]
                                                                //     .createdAt ??
                                                                // "",
                                                                  style: const TextStyle(
                                                                    fontSize: 8,
                                                                    color: Color(0xFF6D6D6D),
                                                                  ),
                                                                                                                            ),
                                                               ),
                                                      ],
                                                    ),
                                                        ),
                                                      ),
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Text(
                                                      //       messageList[index]
                                                      //               .createdAt ??
                                                      //           "",
                                                      //       style: const TextStyle(
                                                      //           fontSize: 13,
                                                      //           color: Color(
                                                      //               0xFF6D6D6D)),
                                                      //     ),
                                                      //   ],
                                                      // ),
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
                                         Padding(
                                           padding:  EdgeInsets.only(top:10,left: 25,right: 25,bottom:10),
                                           child: Center(
                                             child: Container(
                                               padding: EdgeInsets.only(top:5,bottom:5,right: 10,left: 10),
                                               constraints: const BoxConstraints(
                                                  maxWidth: 250,
                                              ),
                                                                                      
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(20),
                                                 color: Color.fromARGB(236, 233, 232, 232)
                                               ),
                                               child: Center(
                                                 child: Text(
                                                  "${messageList[index]
                                                                   .message.toString()}"
                                                  
                                                                   ,
                                                               textAlign: TextAlign.center,
                                                               softWrap: true,
                                                               maxLines: 5,
                                                           style: const TextStyle(
                                                             color: Color(0xff151522),
                                                             fontSize: 12,
                                                           ),
                                                         ),
                                               ),
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
                                                                        formattedTime,
                                                                        style: const TextStyle(
                                                                          fontSize: 8,
                                                                          color: Color.fromARGB(255, 211, 209, 209),
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5,),
                                                                      if(widget.grpchatid=="")...{
                                                                        if(activeUsersLength >= 2)...{
                                                                        Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                      }
                                                                      else if(activeUsersLength ==1 && messageList[index].seenBy == null )...{
                                                                        SizedBox()
                                                                      }
                                                                      else...{
                                                                        messageList[index].seenBy!.isEmpty?
                                                                        SizedBox():
                                                                      Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                                         
                                                                      }
                                                                      } else...{
                                                                        SizedBox()
                                                                      }
                                                        ],
                                                      ),
                                                    ],
                                                  )))
                                        } else if (messageList[index].type ==
                                            "audio") ...{
                                              Stack(
                                                children:[
                                                   VoiceMessage(
                                            audioSrc:
                                                messageList[index].message ?? "",
                                            played:
                                                true, // To show played badge or not.
                                            me: true, // Set message side.
                                            onPlay:
                                                () {}, // Do something when voice played.
                                          ),
                                           Positioned(
                                                                   right: 5,
                                                                   bottom: 5,
                                                                   child: Row(
                                                                     children: [
                                                                       Text(
                                                                        formattedTime,
                                                                        style: const TextStyle(
                                                                          fontSize: 8,
                                                                          color: Color.fromARGB(255, 211, 209, 209),
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5,),
                                                                      if(widget.grpchatid=="")...{
                                                                        if(activeUsersLength <= 2)...{
                                                                        Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                      }
                                                                      else if(activeUsersLength ==1 && messageList[index].seenBy == null )...{
                                                                        SizedBox()
                                                                      }
                                                                      else...{
                                                                        messageList[index].seenBy!.isEmpty?
                                                                        SizedBox():
                                                                      Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                                         
                                                                      }
                                                                      } else...{
                                                                        SizedBox()
                                                                      }
                                                                      
                                                                     
                                                                     ],
                                                                   ),
                                                                 ),
                                                ]
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
                                                        messageList[index].message.toString();
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: SvgPicture.string(
                                                      CommunicationSvg().dwnldIcon,)),
                                                       const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(0),
                                                ),
                                                          color: ColorPalette.primary),
                                                child: Stack(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 8,),
                                                        SizedBox(
                                                          width: 34,
                                                          height: 36,
                                                          child: SvgPicture.string(
                                                              CommunicationSvg().docIcon2,color: Colors.white,),
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
                                                              SizedBox(height: 15,),
                                                              Text(
                                                                // messageList[index]
                                                                //         .message ??
                                                                    "${ messageList[index].message!.split('?').first.split('/').last}",
                                                                    overflow:TextOverflow.ellipsis ,
                                                                    // textScaler:TextScaler.linear(textScaleFactor) ,
                                                                style:GoogleFonts.roboto (textStyle: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize:13,
                                                                ),)
                                                              ),
                                                              Text(
                                                                "${ messageList[index].message!.split('?').first.split('.').last.toString().toUpperCase()}",
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize:8,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                          Positioned(
                                                                   right: 5,
                                                                   bottom: 5,
                                                                   child: Row(
                                                                     children: [
                                                                       Text(
                                                                        formattedTime,
                                                                        style: const TextStyle(
                                                                          fontSize: 8,
                                                                          color: Color.fromARGB(255, 211, 209, 209),
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5,),
                                                                      if(widget.grpchatid=="")...{
                                                                        if(activeUsersLength >= 2)...{
                                                                        Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                      }
                                                                      else if(activeUsersLength ==1 && messageList[index].seenBy == null )...{
                                                                        SizedBox()
                                                                      }
                                                                      else...{
                                                                        messageList[index].seenBy!.isEmpty?
                                                                        SizedBox():
                                                                      Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                                         
                                                                      }
                                                                      } else...{
                                                                        SizedBox()
                                                                      }
                                                                      
                                                                     
                                                                     ],
                                                                   ),
                                                                 ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          
                                            ]),
                                        } else if (messageList[index].type ==
                                            "video") ...{
                                              Container(
                                               constraints:  BoxConstraints(
                                                  maxWidth: 277,
                                                 maxHeight:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height /
                                                                  2.5,
                                              ),
                                              decoration: BoxDecoration(
                                                
                                                      // RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                          
                                                    ),
                                                    boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
                                                  // ),
                                                 color: ColorPalette.primary,
                                                  ),
                                                key: new PageStorageKey(
                                  "keydata$index",
                                ),
                                              child: Stack(
                                                children:[
                                                  VideoPlayerScreen(
                                            me:true,
                                            autoplay: false,
                                            looping: true,
                                            alignmentGeometry: Alignment.topRight,
                                            videoUrl: messageList[index].message ??
                                                            "",
                                            // videoPlayerController:
                                            //     VideoPlayerController.network(
                                            //   messageList[index].message ?? "",
                                            // ),
                                          ),
                                          Positioned(
                                                                   right: 5,
                                                                   bottom: 0,
                                                                   child: Row(
                                                                     children: [
                                                                       Text(
                                                                        formattedTime,
                                                                        style: const TextStyle(
                                                                          fontSize: 8,
                                                                          color: Color.fromARGB(255, 211, 209, 209),
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5,),
                                                                      if(widget.grpchatid=="")...{
                                                                        if(activeUsersLength >= 2)...{
                                                                        Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                      }
                                                                      else if(activeUsersLength ==1 && messageList[index].seenBy == null )...{
                                                                        SizedBox()
                                                                      }
                                                                      else...{
                                                                        messageList[index].seenBy!.isEmpty?
                                                                        SizedBox():
                                                                      Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                                         
                                                                      }
                                                                      } else...{
                                                                        SizedBox()
                                                                      }
                                                                      
                                                                     
                                                                     ],
                                                                   ),
                                                                 ),
                                                ]
                                              ),
                                              ),
                                              
                                          
                                        } else ...{
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width - 300,
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width - 100,
                                              ),
                                              child: GestureDetector(
                                                onLongPress: (){
                                                  if(widget.isGroup==true){
                                                    // showMenu(context: context, position: RelativeRect.fill, 
                                                    // items: [
                                                    //   PopupMenuItem(child: Row(
                                                    //     children: [
                                                    //       Text("Read by"),
                                                    //       IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                                                    //     ],
                                                    //   ))
                                                                        
                                                    // ]);
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      // RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                    ),
                                                    boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
                                                  // ),
                                                 color: ColorPalette.primary,
                                                  ),
                                                  
                                                  // margin:
                                                  //     const EdgeInsets.symmetric(
                                                  //         horizontal: 10,
                                                  //         vertical: 5),
                                                  child:  Stack(
                                                    // mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                          left: 10,
                                                          right:20,
                                                          top:7,
                                                          bottom:16,
                                                        ),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                            messageList[index]
                                                                    .message ??
                                                                "",
                                                                textAlign: TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Color.fromARGB(255, 255, 255, 255)),
                                                            ),
                                                            
                                                           SizedBox(height: 5,)
                                                          ],
                                                        ),
                                                      ),
                                                       Positioned(
                                                               right: 5,
                                                               bottom: 5,
                                                               child: Row(
                                                                 children: [
                                                                   Text(
                                                                    formattedTime,
                                                                    style: const TextStyle(
                                                                      fontSize: 8,
                                                                      color: Color.fromARGB(255, 211, 209, 209),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5,),
                                                                  if(widget.grpchatid=="")...{
                                                                    if(activeUsersLength >= 2)...{
                                                                    Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                  }
                                                                  else if(activeUsersLength ==1 && messageList[index].seenBy == null )...{
                                                                    SizedBox()
                                                                  }
                                                                  else...{
                                                                    messageList[index].seenBy!.isEmpty?
                                                                    SizedBox():
                                                                  Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                                                                     
                                                                  }
                                                                  } else...{
                                                                    SizedBox()
                                                                  }
                                                                  
                                                                 
                                                                 ],
                                                               ),
                                                             ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        }
                                      },
                                      // totpage>1 &&  messageList[index].lastMessageOfDay == true?
                                      // Padding(
                                      //      padding: const EdgeInsets.only(top:5,left: 25,right: 25,bottom: 10),
                                      //      child: Center(
                                      //        child: Container(
                                      //          padding: EdgeInsets.only(top:5,bottom:5,right: 10,left: 10),
                                               
                                      //          decoration: BoxDecoration(
                                      //            borderRadius: BorderRadius.circular(20),
                                      //            color: Color.fromARGB(236, 233, 232, 232)
                                      //          ),
                                      //          child: Column(
                                      //            children:[ 
                                                  
                                      //             Text(
                                      //                     "$msgdate",
                                      //                          textAlign: TextAlign.center,
                                      //                          softWrap: true,
                                      //                          maxLines: 3,
                                      //                      style: const TextStyle(
                                      //                        color: Color(0xff151522),
                                      //                        fontSize: 12,
                                      //                      ),
                                      //                    )
                                      //                    ,]
                                      //          ),
                                      //        ),
                                      //      ),
                                      //    ):Container(),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  fromuserids=messageList[index+1].fromuserid!;
                                  oldertimestampp=messageList[index].createdAt??"";
                                    return messageList[index].fromuserid!=fromuserids?  Container(
                                    height: 8,
                                    //  color:Colors.green
                                  ):Container(height:3, 
                                  // color:Colors.red
                                  );
                                  
                                },
                              ),
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
                  // const SizedBox(height: 4),
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
                      ? Align(
                        alignment: Alignment.bottomLeft,
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
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
                              ),
                              // Text(
                              //   "${groupTypingUser?.name} typing",
                              //   style: const TextStyle(
                              //     color: Color(0xff151522),
                              //     fontSize: 16,
                              //   ),
                              // ),
                            ],
                          ),
                      )
                      : typing == true
                          ? Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "asset/typinggif.gif",
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                ],
                              ),
                          )
                          : SizedBox(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: const Color(0xffFFFFFF),
                        width: w,
                        padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              // width: w / 1.09,
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
                                        width: w / 1.25,
                                        child: TextFormField(
                                          focusNode: focus,
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
                                                    color: ColorPalette.primary,
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
                                              hintText:widget.isGroup==true?  micLongPress == true
                                                      ? "Recording, < slide to cancel "
                                                      : "Message ${activeUsersLength.toString()} active users":micLongPress == true
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
                                  SizedBox(width: 8,),
                                  Row(
                                    children: [
                                      if (typedMessageController
                                          .text.isNotEmpty) ...{
                                        Container(
                                            // margin: const EdgeInsets.only(left: 16, right: 16),
             
                                            child: GestureDetector(
                                                onTap: () async{
                                                  print("sending....");
                                                  player!.setAsset('asset/send.mp3').then((value) {
                                                        return {  
                                                      player!.playerStateStream.listen((state) {
                                                          if (state.playing) {
                                                          setState(() {
                                                            print("audio,,,,");
                                                          });
                                                          }
                                                          else
                                                          switch (state.processingState) {
                                                          case ProcessingState.idle:
                                                          break;
                                                          case ProcessingState.loading:
                                                          break;
                                                          case ProcessingState.buffering:
                                                          break;
                                                          case ProcessingState.ready:
                                                          setState(() {
                                                          });
                                                          break;
                                                          case ProcessingState.completed:
                                                          setState(() {
                                                          });
                                                          break;
                                                          }
                                                          }),
                                                          player!.play(),
                                                        };
                                                      });
                                                  // HapticFeedback.heavyImpact();
                                                  if (widget.isGroup == false) {
                                                          sendMessage(
                                                        typedMessageController.text,
                                                       widget.chat==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel
                                                                ?.chatid ??
                                                            "":widget.communicationuser?.id??"",
                                                            showdate);
                                                    widget.socket?.emit(
                                                        "stopped.typing", roomId);    
                                                       
                                                  } else {
                                                    print("commentgrpid${widget.grpchatid}");
                                                    if(widget.grpchatid==""){
                                                      
                                                      sendGroupMessage(
                                                        typedMessageController.text,
                                                        widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel
                                                                ?.chatid ??
                                                            "":widget.grpuser?.chatid??"");
                                                    }else{
                                                      print("commentgrppid${widget.grpchatid}");
                                                      sendGroupMessage(
                                                        typedMessageController.text,
                                                        widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid.toString());
                                                    }
                                                    widget.socket?.emit(
                                                        "group.stopped.typing",
                                                        roomId);
                                                    seenUsersList.clear();
                                                  }
             
                                                  typedMessageController.clear();
                                                 
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(width:4,),
                                                    SvgPicture.string(
                                                        height: 33,
                                                        width: w / 5,
                                                        CommunicationSvg().sendIcon,color: Color(0xFF2871AF),),
                                                  ],
                                                )))
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
                                                print("file is theee $path");
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
                                                          CommunicationSvg().mic),
                                                    ),
                                                ],
                                              )
                                              : SvgPicture.string(
                                                  // height: 51,
                                                  width: w / 8.5,
                                                  CommunicationSvg().micIcon2),
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
        ),
      ),
    );
  }
String formatMessageTimestamp(DateTime timestamp,int index){
  DateTime now = DateTime.now();
  DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
  DateTime lastWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday + 6));
  // if (!checkUniqueness==true) {
  //   // If checkUniqueness is false, return null without checking the uniqueness of the date.
  //   return "";
  // }
  if (timestamp.year == now.year && timestamp.month == now.month && timestamp.day == now.day) {
   
    return ' Today ';
  } else if (timestamp.year == yesterday.year && timestamp.month == yesterday.month && timestamp.day == yesterday.day) {
   
    return 'Yesterday ';
  } else if (timestamp.isAfter(lastWeek)) {
    return DateFormat('EEEE').format(timestamp);
  } else {
    return DateFormat('d MMM yyyy').format(timestamp);
  }
  
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
                   
       Navigator.pop(context);
                     showDialog(
      context: context, builder: (BuildContext parentcontext) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height/8,
            child: Padding(
              padding: const EdgeInsets.only(top:8),
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      
                      pickFiles("Image",parentcontext,"camera");
                    },
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            pickFiles("Image", parentcontext,"camera");
                            
                          }, icon: Icon(Icons.camera_alt_outlined,color: ColorPalette.primary,size:25,),),
                          Text("Camera")
                        ],
                      ),
                    ),
                    
                  ),
                  InkWell(
                    onTap: (){
                      pickFiles("Image", parentcontext,"gallery");
                    },
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            pickFiles("Image", parentcontext,"gallery");
                          }, icon: Icon(Icons.photo_library_outlined,color: ColorPalette.primary,size:25)),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // actions: [
          //   Row( mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       TextButton(onPressed: (){
          //         Navigator.pop(context);
          //       }, child: Text("Cancel")),

          //     ],
          //   )
          // ],
        );
      },
      );
                    // pickFiles("Image", context);
                  },
                ),
                InkWell(
                  onTap: () {
                    pickFiles("Video", context,"");
                  },
                  child: iconCreation(
                      icon: Icons.video_call, text: "Video", color: Colors.red),
                ),
                InkWell(
                  onTap: () {
                    pickFiles("MultipleFile", context,"");
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

  void pickFiles(String? filetype, BuildContext context,String? source) async {
    print("inside the case");
    switch (filetype) {
      case 'Image':
      print("inside the case");
        // result = await FilePicker.platform
        //     .pickFiles(type: FileType.image, allowMultiple: false,allowCompression: true);
        image = await picker.pickImage(source:source=="gallery"? ImageSource.gallery:ImageSource.camera,imageQuality: 50 );
        _imageFile = File(image!.path);
      // result= await  
      int sized =1024;
      if (image != null) {
  // for (PlatformFile file in image!.files) {
    final fileSizeInBytes =await image!.length();
    final fileSizeInKB = fileSizeInBytes / sized;
    final fileSizeInMB = fileSizeInKB / sized;
    print('File size: $fileSizeInKB KB ($fileSizeInMB MB)');
    int maxSizeBytes = 5 * 1024 * 1024;
    print("File size: $maxSizeBytes"); 
    if (fileSizeInMB <= maxSizeBytes) {
      print('File pathinside: ${image!.path}');
      setState(() {
        showDialog(
          barrierColor: Color.fromARGB(255, 238, 230, 230),
      context: context, builder: (BuildContext context) {
        return Builder(
          builder: (context) {
            return Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
                     child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row( mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.pop(context);
                                }, icon: Icon(Icons.close,color: Colors.white,size: 30,)),
                              ],
                            ),
                          ),
                          
                           Container(
                            height: MediaQuery.of(context).size.height/1.35,
                            child: Center(child: Image.file(_imageFile,fit:BoxFit.fitHeight ,))),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 20),
                             child: CircleAvatar(
                              backgroundColor: Colors.white,
                               child: IconButton(onPressed: (){
                                BlocProvider.of<AttachmentBloc>(context)
                                             .add(UploadPictureEvent(image: _imageFile));
                                             Navigator.pop(context);
                               }, icon:Icon(Icons.done),color: Colors.blue,),
                             ),
                           )
                         ],
                       ),
                   );
          }
        );
       
      },
      );
      });
         
      
    } else {
      print('File path: ${image!.path}');
      print('File size: ${image!.length()}');
      // File size exceeds the allowed limit
      print('File size exceeds the limit.');
      showDialog(
      context: context, builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Image size exceeds the limit"),
          actions: [
            Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),

              ],
            )
          ],
        );
      },
      );
      // Handle accordingly, for example, show an error message.
    }
  // }
} else {
  Navigator.pop(context);
  // User canceled the file picking
}
        // BlocProvider.of<AttachmentBloc>(context)
        //     .add(UploadPictureEvent(image: result!));
        // loadSelectedFiles(result!.files);
  
        setState(() {
        });
        break;
      case 'Video':
        result = await FilePicker.platform
            .pickFiles(type: FileType.video, allowMultiple: false,allowCompression: true);
        // if (result == null) return;
        // file = result!.files.first;
        
             if (result != null) {
  for (PlatformFile file in result!.files) {
    int maxSizeBytes =15 * 1024 * 1024; // Set the maximum size to 1 MB
    if (file.size <= maxSizeBytes) {
      
      // File size is within the allowed limit
      print('File path: ${file.path}');
      print('File size: ${file.size}');
      BlocProvider.of<AttachmentBloc>(context)
            .add(UploadVideoEvent(video: result!));
    } else {
      print('File path: ${file.path}');
      print('File size: ${file.size}');
      // File size exceeds the allowed limit
      print('File size exceeds the limit.');
      showDialog(
      context: context, builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Vedio size exceeds the limit"),
          actions: [
            Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),

              ],
            )
          ],
        );
      },
      );
      // Handle accordingly, for example, show an error message.
    }
  }
} else {
  // User canceled the file picking
}
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform
            .pickFiles(type: FileType.audio, allowMultiple: false,allowCompression: true );
            
        if (result == null) return;
        file = result!.files.first;
        
                if (result != null) {
  for (PlatformFile file in result!.files) {
    int maxSizeBytes =10 * 1024 * 1024; // Set the maximum size to 1 MB
    if (file.size <= maxSizeBytes) {
      
      // File size is within the allowed limit
      print('File path: ${file.path}');
      print('File size: ${file.size}');
      BlocProvider.of<AttachmentBloc>(context)
            .add(UploadAudioEvent(audio: result!));
    } else {
      print('File path: ${file.path}');
      print('File size: ${file.size}');
      // File size exceeds the allowed limit
      print('File size exceeds the limit.');
      showDialog(
      context: context, builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Audio size exceeds the limit"),
          actions: [
            Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),

              ],
            )
          ],
        );
      },
      );
      // Handle accordingly, for example, show an error message.
    }
  }
} else {
  // User canceled the file picking
}
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: false,allowCompression: true);
       
                if (result != null) {
  for (PlatformFile file in result!.files) {
    int maxSizeBytes =5 * 1024 * 1024; // Set the maximum size to 1 MB
    if (file.size <= maxSizeBytes) {
      
      // File size is within the allowed limit
      print('File path: ${file.path}');
      print('File size: ${file.size}');
      BlocProvider.of<AttachmentBloc>(context)
            .add(UploadFilesEvent(files: result!));
    } else {
      print('File path: ${file.path}');
      print('File size: ${file.size}');
      // File size exceeds the allowed limit
      print('File size exceeds the limit.');
      showDialog(
      context: context, builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Media size exceeds the limit"),
          actions: [
            Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),

              ],
            )
          ],
        );
      },
      );
      // Handle accordingly, for example, show an error message.
    }
  }
} else {
  // User canceled the file picking
}
        // if (result == null) return;
        // loadSelectedFiles(result!.files);
        break;
    }
  }
  

Future<XFile> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88,
        rotate: 180,
      );

    print(file.lengthSync());
    print(result!.length());

    return result;
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
  void _recordingFinishedCallback(
  String path,
  BuildContext context,
) {
  print("file is thee $path");
  final uri = Uri.parse(path);
  File file = File(uri.path);

  file.length().then(
    (fileSize) {
      print("files is this ${file}");
      BlocProvider.of<AttachmentBloc>(context)
          .add(UploadLiveAudioEvent(audio: file,comment: widget.grpchatid==""?false:true));
    },
  );
}
}

class ScrollService {
 
  static scrollToEnd(
      {required ScrollController scrollController,required reversed}) {
        print("print Scrolll.......");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // if(scrollController.hasClients){
         scrollController.animateTo(
        reversed
            ? scrollController.position.minScrollExtent:
             scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds:100),
        curve: Curves.easeOut,
      );
      // }
     
    });
  }
}

class PositionRetainedScrollPhysics extends ScrollPhysics {
  final bool shouldRetain;
  const PositionRetainedScrollPhysics({super.parent, this.shouldRetain = true});

  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
      shouldRetain: shouldRetain,
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    final diff = newPosition.minScrollExtent - 1;

    if (1 > oldPosition.maxScrollExtent &&
        diff < 0 &&
        shouldRetain) {
      return position - diff;
    } else {
      return position;
    }
  }
}

