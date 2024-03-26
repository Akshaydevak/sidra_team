import 'dart:html' as html;
import 'dart:html';
import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:xid/xid.dart';

import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:cluster/common_widgets/switch.dart';
import 'package:cluster/core/utils/platform_check.dart';
import 'package:cluster/core/utils/variables.dart';
import 'package:cluster/presentation/comunication_module/myChatlistWeb.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/base/dashboard.dart';
import 'package:cluster/presentation/comunication_module/audio_state.dart';
import 'package:cluster/presentation/comunication_module/bloc/attachment_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/image_details_screen.dart';
import 'package:cluster/presentation/comunication_module/chat_type_model.dart';
import 'package:cluster/presentation/comunication_module/chatscreen_list.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/imagepreview.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/comunication_module/videoplayerscreen.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_alert/status_alert.dart';
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
import 'communication_urls.dart';
import 'unread.dart';
import 'globals.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/services.dart';
class WebChatScreen extends StatefulWidget {
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
  WebChatScreen(
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
  State<WebChatScreen> createState() => WebChatScreenState();
}

class WebChatScreenState extends State<WebChatScreen>
    with SingleTickerProviderStateMixin {
  bool canFocus=false;
  final _audioRecorder = Record();
  AudioPlayer? player = AudioPlayer();
  FocusNode textformFocusnOde=FocusNode();
  FocusNode focsuNode=FocusNode();
  bool ismount1=true;
  bool isMount = true;
  bool ismounted =true;
  bool msgsendload =false;
  bool mountedactive =true;
  bool mountedis =true;
  bool isactivelen=true;
  bool isSecondMount = true;
  bool isThirdMount = true;
  bool isFourthMount = true;
  bool isFifthMount = true;
  bool issixthMount = true;
  bool isseventhMount = true;
  bool iseigthMount = true;
  bool loadmsg=false;
  String searchtext="";
  bool isadmin=false;
  bool isgrp=true;
  bool isenteruser=true;
  bool mention=false;
  bool isdelete=true;
  int totpage=0;
  bool myoption=true;
  bool chatbar=true;
  bool showdate=true;
  int msgid=0;
  Set<String> mentionuser={};
  String copymsg="";
  DateTime now = DateTime.now();
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
  List<messageSeenList> entereduser=[];
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
  List<String> suggestions = [];
  String oldertimestampp="";
  int unreadMessageCount=0;
  int sendMessageCount=0;
  bool isload=false;
  List<GroupUserList> grpmember=[];
  List unseenuser=[];
  List unseenuseremit=[];
  List<GroupUserList> filteredList=[];
  String a="";
  List<String> removeduser=[];
  final FocusNode focus =FocusNode();
  // int messageListLimit = 26;
  SharedPreferences? pref;
  AnimationController? _animationController;
  String fromuserids="";
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool seentick =false;
  late File _imageFile;
  bool _keyboardVisible =true;
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
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(_focusNode);
    // });
    // Initialize your FocusNode


    print("room id listens atleast ${widget.redirectchatid} userid${widget.redirectionsenduserId} chatid${widget.grpchatid} ${widget.isGroup}");
    widget.socket?.emit("join.chat", {
      widget.redirectchatid!=""?widget.redirectchatid:
      widget.grpchatid!=""?widget.grpchatid:
      widget.chat==false && widget.isg==false
          ? widget.communicationUserModel?.chatid:
      widget.chat==true&& widget.isg==false?widget.communicationuser?.id: widget.grpuser?.chatid});

    if(widget.isGroup == false && widget.isg==false && widget.redirectchatid==""){
      if(widget.communicationUserModel?.unreadMessages != 0 || widget.communicationuser?.users?[0].chatUser?.unreadMessages != 0) {
        print("unreaded messages....");
        widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid': widget.chat==false
            ? widget.communicationUserModel?.chatid:
        widget.communicationuser?.id,'userid':
        widget.chat==false? widget.communicationUserModel?.id.toString():widget.communicationuser?.users?[0].id.toString()
        });
      }
    }else if(widget.isGroup==true && widget.isg==false && widget.redirectchatid==""){
      print("unreaded messagess....");
      widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.grpchatid!=""?widget.grpchatid: widget.isg==false
          ? widget.communicationUserModel?.chatid: widget.grpuser?.chatid,'userid':widget.loginUserId});
    }else if(widget.redirectchatid!=""){
      print("unreaded messagess....");
      widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.redirectchatid,'userid':widget.redirectionsenduserId});
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
        // setState(() {
        // });
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
        widget.socket!.emit("get.clients",roomId);
        print("get ACTIVE length");
        widget.socket!.on("active.length", handleActiveLength,

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
      widget.socket?.on("latest.message", handleLatestMessage);
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

      widget.socket?.on("group.latest.message", handleLatestGroupMessage);
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
    widget.socket!.on("message.deleted",deletemessage);
//  (data){
//                   print("deleted message socket $data ");
    // messageList.removeWhere((message) => message.id == data);

    // });
    widget.socket!.on("user.deleted.done",(data){
      print("user deleted $data");
      removeduser.add(data);
    });
    print("777777777777") ;
    loadUnreadMessageCount();

    super.initState();
  }
  void handleLatestMessage(data) {
    print("total res listened  ${data}");

    ChatModel chatModel = ChatModel(
      type: data['type'],
      id: data['id'],
      message: data['message'],
      createdAt: data['createdAt'],
      fromuserid: data['fromuserid'],
      firstMessageOfDay: data['firstMessageOfDay'],
    );

    if (totpage <= 1) {
      messageList.add(chatModel);
      msgsendload=false;

    } else {
      messageList.insert(0, chatModel);
      msgsendload=false;
    }

    print("...msglist${messageList.toString()}");

    if (isenter) {
      if (data['fromuserid'] != widget.loginUserId) {
        print("other msg");
        playAudio();
        ScrollService.scrollToEnd(scrollController: _controller, reversed: totpage <= 1 ? false : true);
      } else {
        print("my msg");
        ScrollService.scrollToEnd(scrollController: _controller, reversed: totpage <= 1 ? false : true);
      }
    } else {
      print("msg");
    }

    print("activeUsersLength $activeUsersLength");

    if (activeUsersLength == 1) {
      print("fchgjh $sendMessageCount");
      sendMessageCount = 1;
    } else {
      sendMessageCount = 0;
      print("lenght 2");
    }
    widget.socket?.emit("unread.messages.group", {
      'unreadMessageCount': sendMessageCount,
      'chatid': widget.chat == false ? widget.redirectchatid != "" ? widget.redirectchatid : widget.communicationUserModel?.chatid : widget.communicationuser?.id,
      'userids': widget.loginUserId });

    // widget.socket?.emit("unread.messages", {
    //   'unreadMessageCount': sendMessageCount,
    //   'chatid': widget.chat == false ? widget.redirectchatid != "" ? widget.redirectchatid : widget.communicationUserModel?.chatid : widget.communicationuser?.id,
    //   'userid': widget.loginUserId.toString(),
    // });

    widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
    print("my msg count $sendMessageCount,'userid':${widget.communicationUserModel?.id} ");

    if (isMount) {
      setState(() {});
    }

    ScrollService.scrollToEnd(scrollController: _controller, reversed: totpage <= 1 ? false : true);
    widget.socket!.emit("update.list",{
      print("update ")
    });
    widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
  }
  void handleLatestGroupMessage(data) {
    loadmsg = true;
    print("total ser listened $loadmsg ${widget.loginUserId} ...${data}");

    var message = ChatModel(
      message: data['message'],
      fromuserid: data['fromuserid'],
      type: data['type'],
      id: data['id'],
      createdAt: data['createdAt'],
      fromUser: FromUser(
        email: data['fromUser']['email'],
        name: data['fromUser']['name'],
        photo: data['fromUser']['photo'],
      ),
    );

    if (totpage <= 1) {
      messageList.add(message);
      msgsendload=false;
    } else {
      messageList.insert(0, message);
      msgsendload=false;
    }

    print("...msglist${messageList.length}");

    if (data['fromuserid'] != widget.loginUserId) {
      print("other msg");
      playAudio();
      ScrollService.scrollToEnd(scrollController: _controller, reversed: totpage <= 1 ? false : true);
    } else {
      print("my msg");
    }

    if (widget.grpchatid == "") {
      print("fchgjh entered ${grpmember.length}");
      if (activeUsersLength <= grpmember.length) {
        print("fchgjh checked ${entereduser.length}");
        unseenuser.clear();
        for (int i = 0; i < grpmember.length; i++) {
          if (!entereduser.any((element) => element.userid == grpmember[i].id)) {
            print("fchgjh added");
            unseenuser.add(grpmember[i].id);
          }
        }
        print("fchgjh $unseenuser");
        unreadMessageCount = 1;
      } else {
        unreadMessageCount = 0;
        print("lenght 2");
      }
      print("fchgjh $unseenuser");
      if (unseenuser.isNotEmpty) {
        widget.socket?.emit("unread.messages.group", {
          'unreadMessageCount': unreadMessageCount,
          'chatid': widget.isg == false
              ? widget.grpchatid != ""
              ? widget.grpchatid
              : widget.redirectchatid != ""
              ? widget.redirectchatid
              : widget.communicationUserModel?.chatid
              : widget.grpuser?.chatid,
          'userids': unseenuser
        });
      }

      widget.socket!.emit("update.list",{
        print("update ")
      });
      widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
      print("my msg count $unreadMessageCount,'userid':${widget.communicationUserModel?.chatid} ");
    }

    if (isMount) {
      setState(() {});
    }

    ScrollService.scrollToEnd(scrollController: _controller, reversed: totpage <= 1 ? false : true);

  }

  void playAudio() {
    player!.setAsset('asset/response.mp3').then((value) {
      player!.playerStateStream.listen((state) {
        if (state.playing) {
          setState(() {
            print("audio,,,,");
          });
        }
      });
      player!.play();
    });
  }
  void playAudiosend() {
    player!.setAsset('asset/response.mp3').then((value) {
      player!.playerStateStream.listen((state) {
        if (state.playing) {
          setState(() {
            print("audio,,,,");
          });
        }
      });
      player!.play();
    });
  }
  void setTrueAtIndex( int index) {

    print("fghjiokpoji$index");
    for (int i = 0; i < messageList.length; i++) {
      if(index==-1){
        messageList.setAll(i, [ChatModel(type:messageList[i].type,chatid: messageList[i].chatid,createdAt: messageList[i].createdAt,day: messageList[i].day,firstMessageOfDay: messageList[i].firstMessageOfDay,fromUser: messageList[i].fromUser,fromuserid: messageList[i].fromuserid,groupid: messageList[i].groupid,id: messageList[i].id,isSelectable: false,message: messageList[i].message,seenBy: messageList[i].seenBy,time: messageList[i].time,updatedAt: messageList[i].updatedAt, )]);
      }else{
        if (i == index) {
          messageList.setAll(i, [ChatModel(type:messageList[i].type,chatid: messageList[i].chatid,createdAt: messageList[i].createdAt,day: messageList[i].day,firstMessageOfDay: messageList[i].firstMessageOfDay,fromUser: messageList[i].fromUser,fromuserid: messageList[i].fromuserid,groupid: messageList[i].groupid,id: messageList[i].id,isSelectable: true,message: messageList[i].message,seenBy: messageList[i].seenBy,time: messageList[i].time,updatedAt: messageList[i].updatedAt, )]);
          print("messageList${messageList}");
        } else {
          messageList.setAll(i, [ChatModel(type:messageList[i].type,chatid: messageList[i].chatid,createdAt: messageList[i].createdAt,day: messageList[i].day,firstMessageOfDay: messageList[i].firstMessageOfDay,fromUser: messageList[i].fromUser,fromuserid: messageList[i].fromuserid,groupid: messageList[i].groupid,id: messageList[i].id,isSelectable: false,message: messageList[i].message,seenBy: messageList[i].seenBy,time: messageList[i].time,updatedAt: messageList[i].updatedAt, )]);
        }
      }

      setState(() {

      });
    }
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
      print("my msg update count1 $sendMessageCount ");
    });
  }
  void handleActiveLength(data) {
    print("ACTIVE length sharedpref  $data");
    saveactiveusers(data);
    print("load the active $activeUsersLength");
    loadactiveusers();
    print("ACTIVE load");
    String? chatid= widget.chat==false && widget.isg==false
        ?widget.grpchatid!=""?"${widget.grpchatid}": widget.redirectchatid!=""?"${widget.redirectchatid}": "${widget.communicationUserModel?.chatid}":
    widget.chat==true&& widget.isg==false?"${widget.communicationuser?.id}": "${widget.grpuser?.chatid}";
    if(activeUsersLength == 2){
      print("ACTIVE load $chatid");
      sendMessageCount=0;
      saveUnreadMessageCount(0,chatid);
    }
    if(isactivelen){
      setState(() {

      });
    }

  }
  void deletemessage(data){
    messageList.removeWhere((message) => message.id == data);
    if(isdelete){
      setState(() {

      });
    }
  }
  Future<void> saveUnreadMessageCount(int count,String chatt) async {
    print("my msg update counta $count $chatt");
    pref = await SharedPreferences.getInstance();
    await pref!.setInt(chatt, count);

  }


  void datagrpmember(data){
    print("group members1: $data");
    print("jhdgfkjhgkrng");
    grpmember.clear();
    (data as List).forEach((element) {
      grpmember.add(GroupUserList.fromJson(element));
    });
    print("jhdgfkjhgkrng${grpmember.length}");
    for(int i=0;i<=grpmember.length;i++){
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
    entereduser.clear();
    (data as List).forEach((element) {
      entereduser.add(messageSeenList.fromJson(element));
    });
    print("active userssss ${entereduser.length}");
    if(isenteruser){
      setState(() {

      });
    }

  }

  Future<void> loadactiveusers() async {

    pref = await SharedPreferences.getInstance();

    activeUsersLength = pref!.getInt('activeuser')??0;
    print("ACTIVE length load $activeUsersLength");

  }
  Future<void> saveactiveusers(int count) async {
    print("my msg active count $count");
    pref = await SharedPreferences.getInstance();
    await pref!.setInt('activeuser', count);
  }


  void sendMessage(String message, String chatId, bool day) {

    widget.socket?.emit(

        "new.message", {"type": "text", "chatid": chatId, "content": message ,"firstMessageOfDay":day,"activeLength":activeUsersLength});

    widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
    widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));

    print("uodate.chat.list");
  }

  void sendGroupMessage(String message, String chatId) {
    bool otherMentions = false;
    List unseenUserEmit = [];
// widget.socket?.emit("group.message.seen",roomId);
//  widget.socket?.on("msg.seen.by",activeuserlist);
    if (activeUsersLength <= grpmember.length) {
      for (int i = 0; i < grpmember.length; i++) {
        bool isUserIdInEnterList = false;
        print("Debug: grpmember ID: ${grpmember[i].id}");
        print("Debug: enter length: ${entereduser.length}");
        print("qwerty3 ${entereduser.length}");
        for (int j = 0; j < entereduser.length; j++) {
          print("Debug: enter[$j].userid: ${entereduser[j].userid}");
          if (grpmember[i].id == entereduser[j].userid) {
            print("qwerty33${grpmember[i].id}");
            isUserIdInEnterList = true;
            break;
          }
        }

        if (!isUserIdInEnterList) {
          unseenUserEmit.add(grpmember[i].usercode);
          print("qwerty3$unseenUserEmit ${entereduser.length}");
        }
      }
    }

    if (mentionuser.isNotEmpty) {
      for (String mention in mentionuser) {
        if (message.contains('@$mention')) {
          otherMentions = true;
          break;
        }
      }
    }

    widget.socket?.emit("group.message", {
      "type": otherMentions ? "mention" : "text",
      "chatid": chatId,
      "content": message,
      "unseenUserList": unseenUserEmit.isEmpty ? 0 : unseenUserEmit
    });


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


  double currentScrollPosition= 0.0;


  @override
  Widget build(BuildContext context) {

    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(textformFocusnOde);
    // });
    //
    // if (textformFocusnOde.hasFocus) {
    //   // Forcefully open the keyboard to activate the cursor
    //   FocusManager.instance.primaryFocus?.unfocus();
    //   FocusScope.of(context).requestFocus(textformFocusnOde);
    // } else {
    //   // Print a message if the text field doesn't have focus
    //   print("anjjj");
    // }


    // FocusScope.of(context).requestFocus(textformFocusnOde);
    // print("homescreen latest widget.id ${widget.communicationUserModel?.id}");
    // print("token ${widget.token}");
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1 > 700
        ? 400
        : w1;
    var h = MediaQuery.of(context).size.height;

    return MultiBlocListener(
      listeners: [
        BlocListener<ChatBloc,ChatState>(
            listener: (context, state) {

              if(state is MessagedeleteLoading){
                print("loading");
              }
              else if(state is MessagedeleteSuccess){
                Fluttertoast.showToast(msg: state.msg1);
              }else if(state is MessagedeleteFailed){
                Fluttertoast.showToast(msg: "Failed");
              }

            }),

        BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            print("the message state // (state.chatData[0].pagination!.totalpages)");
            if (state is ChatScreenGetLoading) {

            } else if (state is ChatScreenGetSuccess) {
              print("the message state // ${state.chatData[0].pagination!.totalpages}");
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
              state.chatData[0].pagination!.totalpages<=1?
              messageList = messageList.reversed.toList()
                  :null;
              // messageList.length>11 && totpage<=1?
              ScrollService.scrollToEnd(
                  scrollController: _controller, reversed:totpage<=1?false:true);
              setState(() {
                totpage=state.chatData[0].pagination!.totalpages;
                print("totalpagess$totpage");

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
                loadmsg=true;

              });



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
                msgsendload=true;
                setState(() {

                });
                print("Loading");
              } else if (state is UploadPictureSuccess) {
                if (widget.isGroup != true) {
                  print("state.upload${state.upload}");
                  widget.socket?.emit("new.message", {
                    "type": "image",
                    "chatid":widget.chat==false?widget.redirectchatid!=""?"${widget.redirectchatid}":widget.communicationUserModel?.chatid:widget.communicationuser?.id,
                    "content": state.upload
                  });


                } else {
                  List unseenUserEmit = [];
    // widget.socket?.emit("group.message.seen",roomId);
    //  widget.socket?.on("msg.seen.by",activeuserlist);
                  if (activeUsersLength <= grpmember.length) {
                    for (int i = 0; i < grpmember.length; i++) {
                      bool isUserIdInEnterList = false;
                      print("Debug: grpmember ID: ${grpmember[i].id}");
                      print("Debug: enter length: ${entereduser.length}");
                      print("qwerty3 ${entereduser.length}");
                      for (int j = 0; j < entereduser.length; j++) {
                        print("Debug: enter[$j].userid: ${entereduser[j].userid}");
                        if (grpmember[i].id == entereduser[j].userid) {
                          print("qwerty33${grpmember[i].id}");
                          isUserIdInEnterList = true;
                          break;
                        }
                      }

                      if (!isUserIdInEnterList) {
                        unseenUserEmit.add(grpmember[i].usercode);
                        print("qwerty3$unseenUserEmit ${entereduser.length}");
                      }
                    }
                  }
                  widget.socket?.emit("group.message", {
                    "type": "image",
                    "chatid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid:widget.redirectchatid!=""?widget.redirectchatid:widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                    "content": state.upload,
                    "unseenUserList": unseenUserEmit.isEmpty ? 0 : unseenUserEmit
                  });


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


                } else {
                  List unseenUserEmit = [];
    // widget.socket?.emit("group.message.seen",roomId);
    //  widget.socket?.on("msg.seen.by",activeuserlist);
                  if (activeUsersLength <= grpmember.length) {
                    for (int i = 0; i < grpmember.length; i++) {
                      bool isUserIdInEnterList = false;
                      print("Debug: grpmember ID: ${grpmember[i].id}");
                      print("Debug: enter length: ${entereduser.length}");
                      print("qwerty3 ${entereduser.length}");
                      for (int j = 0; j < entereduser.length; j++) {
                        print("Debug: enter[$j].userid: ${entereduser[j].userid}");
                        if (grpmember[i].id == entereduser[j].userid) {
                          print("qwerty33${grpmember[i].id}");
                          isUserIdInEnterList = true;
                          break;
                        }
                      }

                      if (!isUserIdInEnterList) {
                        unseenUserEmit.add(grpmember[i].usercode);
                        print("qwerty3$unseenUserEmit ${entereduser.length}");
                      }
                    }
                  }
                  widget.socket?.emit("group.message", {
                    "type": "video",
                    "chatid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid: widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                    "content": state.upload,
                    "unseenUserList": unseenUserEmit.isEmpty ? 0 : unseenUserEmit
                  });


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


                } else {
                  List unseenUserEmit = [];
    // widget.socket?.emit("group.message.seen",roomId);
    //  widget.socket?.on("msg.seen.by",activeuserlist);
                  if (activeUsersLength <= grpmember.length) {
                    for (int i = 0; i < grpmember.length; i++) {
                      bool isUserIdInEnterList = false;
                      print("Debug: grpmember ID: ${grpmember[i].id}");
                      print("Debug: enter length: ${entereduser.length}");
                      print("qwerty3 ${entereduser.length}");
                      for (int j = 0; j < entereduser.length; j++) {
                        print("Debug: enter[$j].userid: ${entereduser[j].userid}");
                        if (grpmember[i].id == entereduser[j].userid) {
                          print("qwerty33${grpmember[i].id}");
                          isUserIdInEnterList = true;
                          break;
                        }
                      }

                      if (!isUserIdInEnterList) {
                        unseenUserEmit.add(grpmember[i].usercode);
                        print("qwerty3$unseenUserEmit ${entereduser.length}");
                      }
                    }
                  }
                  widget.socket?.emit("group.message", {
                    "type": "file",
                    "chatid": widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid!=""?widget.grpchatid:  widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                    "content": state.upload,
                    "unseenUserList": unseenUserEmit.isEmpty ? 0 : unseenUserEmit
                  });


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


                } else {
                  List unseenUserEmit = [];
    // widget.socket?.emit("group.message.seen",roomId);
    //  widget.socket?.on("msg.seen.by",activeuserlist);
                  if (activeUsersLength <= grpmember.length) {
                    for (int i = 0; i < grpmember.length; i++) {
                      bool isUserIdInEnterList = false;
                      print("Debug: grpmember ID: ${grpmember[i].id}");
                      print("Debug: enter length: ${entereduser.length}");
                      print("qwerty3 ${entereduser.length}");
                      for (int j = 0; j < entereduser.length; j++) {
                        print("Debug: enter[$j].userid: ${entereduser[j].userid}");
                        if (grpmember[i].id == entereduser[j].userid) {
                          print("qwerty33${grpmember[i].id}");
                          isUserIdInEnterList = true;
                          break;
                        }
                      }

                      if (!isUserIdInEnterList) {
                        unseenUserEmit.add(grpmember[i].usercode);
                        print("qwerty3$unseenUserEmit ${entereduser.length}");
                      }
                    }
                  }
                  widget.socket?.emit("group.message", {
                    "type": "audio",
                    "chatid": widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid: widget.grpchatid!=""?widget.grpchatid:  widget.communicationUserModel?.chatid:widget.grpuser?.chatid,
                    "content": state.upload,
                    "unseenUserList": unseenUserEmit.isEmpty ? 0 : unseenUserEmit

                  });

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

                } else {
                  List unseenUserEmit = [];
    // widget.socket?.emit("group.message.seen",roomId);
    //  widget.socket?.on("msg.seen.by",activeuserlist);
                  if (activeUsersLength <= grpmember.length) {
                    for (int i = 0; i < grpmember.length; i++) {
                      bool isUserIdInEnterList = false;
                      print("Debug: grpmember ID: ${grpmember[i].id}");
                      print("Debug: enter length: ${entereduser.length}");
                      print("qwerty3 ${entereduser.length}");
                      for (int j = 0; j < entereduser.length; j++) {
                        print("Debug: enter[$j].userid: ${entereduser[j].userid}");
                        if (grpmember[i].id == entereduser[j].userid) {
                          print("qwerty33${grpmember[i].id}");
                          isUserIdInEnterList = true;
                          break;
                        }
                      }

                      if (!isUserIdInEnterList) {
                        unseenUserEmit.add(grpmember[i].usercode);
                        print("qwerty3$unseenUserEmit ${entereduser.length}");
                      }
                    }
                  }
                  widget.socket?.emit("group.message", {
                    "type": "audio",
                    "chatid":widget.isg==false?widget.grpchatid!=""?widget.grpchatid: widget.redirectchatid!=""?widget.redirectchatid:widget.communicationUserModel?.chatid : widget.grpuser?.chatid,
                    "content": state.upload,
                    "unseenUserList": unseenUserEmit.isEmpty ? 0 : unseenUserEmit
                  });

                }
                setState(() {

                });
              } else if (state is UploadLiveAudioFailed) {
                print("live audio failed");
              }
            })
      ],
      child: GestureDetector(
        onTap: () {
          // myFocusNode.unfocus();
          // FocusManager.instance.primaryFocus?.unfocus();
          chatbar=true;
          mention=false;
          setTrueAtIndex(-1);
          setState(() {

          });
          //  FocusScope.of(context).requestFocus(new FocusNode());

        },
        child: Scaffold(
          backgroundColor:ColorPalette.webBagroundClr ,
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
          body :RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: handleKeyPress,
            child: Container
              (
              color: Color(0xffEFF1F3),
              // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:loadmsg==false?LottieLoader(): Column(
                children: [
                  chatbar==true?
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
                    redirectionsenduserId: widget.redirectionsenduserId,
                    typing: typing,
                    isadmin: isadmin,
                    groupTypingUser: groupTypingUser,
                    communicationUserModel: widget.communicationUserModel,
                    communicationuser: widget.communicationuser,
                    isgrp: widget.isg,
                    grpuser: widget.grpuser,
                    grpmember: grpmember,
                    ontap: (){

                      widget.socket!.emit("update.list",{
                        print("update")
                      });
                      if(widget.isGroup==false){
                        print("Leave chat");
                      //   if(widget.redirectchatid != ""){
                      //     print("push notificstion redirection");
                      //
                      //     widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.redirectchatid.toString(),'userid':widget.redirectionsenduserId??""});
                      //     widget.socket!.emit("leave.chat",{
                      //       "room": roomId??"",
                      //       "userid":widget.loginUserId??""
                      //     }
                      //     );
                      //
                      //     print("user left too");
                      //
                      //     print("user left too");
                      //
                      //     widget.socket!.on("left.room", (data) {
                      //       print("room left $data");
                      //       if(ismounted){
                      //         print("roooom left $data");
                      //         widget.socket!.emit("get.clients",roomId);
                      //         widget.socket!.on("active.length", handleActiveLength
                      //         );
                      //       }
                      //
                      //       widget.socket!.on("msg1.seen", (data) {
                      //         print("room leave message $data");
                      //
                      //
                      //       } );
                      //     });
                      //
                      //
                      //     widget.socket!.on("user.left", (data){
                      //       print("user left $data");
                      //
                      //       if(data["userid"] == widget.loginUserId){
                      //         print("ACTIVE length sharedprefww");
                      //         saveUnreadMessageCount(0,roomId??"");
                      //         print("user left the room1 ${data["chatid"]}");
                      //
                      //       }else{
                      //         print("same user id");
                      //       }
                      //     });
                      //     // Navigator.pop(context);
                      //     // Navigator.pop(context);
                      // if(isMobile)   {
                      //   Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => DashBoard(index: 1,)), (route) => false);
                      // }
                      // else{
                      //   // chabeTAbIndex(0) ;
                      //   objectGlobal=   objectGlobal.changeScreen(current: CommunicationModule(),previous: this.widget,tabIndex: 0);
                      //   print(objectGlobal.existing);
                      //   objectGlobal.changeData();
                      //
                      // }
                      //
                      //     //               PersistentNavBarNavigator.pushNewScreen(
                      //     //   context,
                      //     //   screen: DashBoard(
                      //     //     // token: widget.token ?? ""
                      //     //     // socket: widget.socket,
                      //     //   ),
                      //     //   withNavBar: true, // OPTIONAL VALUE. True by default.
                      //     //   pageTransitionAnimation: PageTransitionAnimation.fade,
                      //     // );
                      //   }
                      //
                        if( widget.chat==false){
                          widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.communicationUserModel?.chatid,'userid':widget.communicationUserModel?.id.toString()});
                          widget.socket!.emit("leave.chat",{
                            "room": roomId??"",
                            "userid":widget.communicationUserModel?.id??""
                          }
                          );

                          print("user left too");

                          print("user left too");
                          widget.socket!.on("left.room", (data) {
                            print("room left $mounted $data");
                            // mountedactive = true;
                            // if(mounted) {
                              widget.socket!.emit("get.clients", roomId);
                            widget.socket!.on("active.length", handleActiveLength
                               );
                            // }
                            // mountedactive = false;

                            widget.socket!.on("msg1.seen", (data) {
                              print("room leave message $data");


                            } );
                            setState(() {

                            });
                          });    widget.socket!.on("user.left", (data){
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
                          isMobile? Navigator.pop(context):
                          objectGlobal=   objectGlobal.changeScreen(current: CommunicationModule(),previous: this.widget,tabIndex: 0);
                          print(objectGlobal.existing);
                          objectGlobal.changeData();
                          // chabeTAbIndex(0) ;
                        }
                        else{
                          BlocProvider.of<CommunicationBloc>(context).add(
                              GetFilterdChatListEvent(
                                  token: widget.token ?? "",
                                  chatFilter: "chats"
                              ));
                          // Navigator.pop(context);

                          widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':roomId,'userid':widget.communicationuser?.users?[0].id.toString()});
                          widget.socket!.emit("leave.chat",{
                            "room": roomId??"",
                            "userid":widget.communicationuser?.users?[0].id??""
                          }
                          );

                          print("user left too");

                          print("user left too");
                          widget.socket!.on("left.room", (data) {
                            print("room left $data");
                            //  if(mounted){
                            widget.socket!.emit("get.clients",roomId);
                            widget.socket!.on("active.length", handleActiveLength
                            );
                            // }

                            widget.socket!.on("msg1.seen", (data) {
                              print("room leave message $data");


                            } );
                          });

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
                         isMobile? Navigator.pop(context):
                         objectGlobal=   objectGlobal.changeScreen(current: CommunicationModule(),previous: this.widget,tabIndex: 0);
                          print(objectGlobal.existing);
                          objectGlobal.changeData();
                        }

                      }
                      else{
                       //  if(widget.redirectchatid != ""){
                       //    print("push notificstion redirection");
                       //
                       //    widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.redirectchatid,'userid':widget.loginUserId});
                       //    widget.socket!.emit("leave.chat",{
                       //      "room": roomId??"",
                       //      "userid": widget.redirectionsenduserId??""                             //widget.isg==false?widget.grpchatid!=""?widget.grpchatid:widget.redirectchatid!=""?"${widget.redirectchatid}": widget.communicationUserModel?.id??"":widget.loginUserId??""
                       //    }
                       //    );
                       //
                       //    print("user left too");
                       //
                       //    print("user left too");
                       //    widget.socket!.on("left.room", (data) {
                       //      print("room left $data");
                       //      if(mounted){
                       //        widget.socket!.emit("get.clients",roomId);
                       //        widget.socket!.on("active.length", handleActiveLength
                       //        );
                       //      }
                       //      if(ismount1){
                       //        widget.socket?.emit("group.message.seen",roomId);
                       //        widget.socket?.on("msg.seen.by",activeuserlist);
                       //      }
                       //
                       //    });
                       //
                       //    widget.socket!.on("msg1.seen", (data) {
                       //      print("room leave message $data");
                       //
                       //
                       //    } );
                       //    widget.socket!.on("user.left", (data){
                       //      print("user left");
                       //
                       //      if(data["userid"] == widget.loginUserId){
                       //        print("ACTIVE length sharedprefww");
                       //        saveUnreadMessageCount1(0,roomId??"");
                       //        print("user left the room1 ${data["chatid"]}");
                       //        setState(() {
                       //
                       //        });
                       //      }else{
                       //        print("same user id");
                       //      }
                       //    });
                       //
                       // isMobile?   Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => DashBoard(index: 1,)), (route) => false):chabeTAbIndex(0) ;
                       //    //               Navigator.pop(context);
                       //    //               PersistentNavBarNavigator.pushNewScreen(
                       //    //   context,
                       //    //   screen: DashBoard(
                       //    //     // token: widget.token ?? ""
                       //    //     // socket: widget.socket,
                       //    //   ),
                       //    //   withNavBar: true, // OPTIONAL VALUE. True by default.
                       //    //   pageTransitionAnimation: PageTransitionAnimation.fade,
                       //    // );
                       //  }
                       //
                         if( widget.isg==false){
                          widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid': widget.grpchatid!=""?widget.grpchatid: widget.communicationUserModel?.chatid,'userid':widget.loginUserId});
                          widget.socket!.emit("leave.chat",{
                            "room": roomId??"",
                            "userid": widget.loginUserId??""               //widget.isg==false?widget.grpchatid!=""?widget.grpchatid:widget.redirectchatid!=""?"${widget.redirectchatid}": widget.communicationUserModel?.id??"":widget.loginUserId??""
                          }
                          );

                          print("user left too");

                          print("user left too");
                          widget.socket!.on("left.room", (data) {
                            print("room left $data");
                            if(mounted){
                              widget.socket!.emit("get.clients",roomId);
                              widget.socket!.on("active.length", handleActiveLength
                              );
                            }

                            if(ismount1){
                              widget.socket?.emit("group.message.seen",roomId);
                              widget.socket?.on("msg.seen.by",activeuserlist);
                            }

                            widget.socket!.on("msg1.seen", (data) {
                              print("room leave message $data");


                            } );
                          });


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

                          isMobile? Navigator.pop(context):
                          // chabeTAbIndex(0) ;
                          objectGlobal=   objectGlobal.changeScreen(current: CommunicationModule(),previous: this.widget,tabIndex: 0);
                          print(objectGlobal.existing);
                          objectGlobal.changeData();
                        }else{
                          widget.socket?.emit("unread.messages.chat",{'unreadMessageCount':0,'chatid':widget.grpchatid!=""?widget.grpchatid: widget.grpuser?.chatid,'userid':widget.loginUserId});
                          widget.socket!.emit("leave.chat",{
                            "room": roomId??"",
                            "userid":widget.loginUserId ?? ""
                          }
                          );
                          widget.socket!.on("left.room", (data) {
                            print("active length left room");
                            if(mounted){
                              widget.socket!.emit("get.clients",roomId);
                              widget.socket!.on("active.length", handleActiveLength
                              );
                            }

                            if(ismount1){
                              widget.socket?.emit("group.message.seen",roomId);
                              widget.socket?.on("msg.seen.by",activeuserlist);
                            }
                            print("room left $data");

                            widget.socket!.on("msg1.seen", (data) {
                              print("room leave message $data");


                            } );
                          });

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

                          isMobile? Navigator.pop(context):
                          objectGlobal=   objectGlobal.changeScreen(current: CommunicationModule(),previous: this.widget,tabIndex: 0);
                          print(objectGlobal.existing);
                          objectGlobal.changeData();
                          // chabeTAbIndex(0) ;
                          //                  PersistentNavBarNavigator.pushNewScreen(
                          //   context,
                          //   screen: CommunicationModule(),
                          //   withNavBar: true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation: PageTransitionAnimation.fade,
                          // );
                        }

                      }

                    },
                  ):Container(
                    width: w1,
                    color: ColorPalette.primary,
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          chatbar=true;
                          myoption=true;
                          setState(() {

                          });
                        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                        myoption==true?  Row(
                          children: [
                            IconButton(onPressed: (){
                              Clipboard.setData(ClipboardData(text:copymsg));
                              Fluttertoast.showToast(msg: "message copied");
                              chatbar = true;
                              myoption=true;
                              setState(() {

                              });
                            }, icon: Icon(Icons.copy,color: Colors.white,)),

                            IconButton(onPressed: (){

                              // context.read<ChatBloc>().add(Messagedeleteevent(token: widget.token??"", chatId:roomId??"", msgId: msgid));
                              widget.socket!.emit("delete.message",{"messageId":msgid,"chatId":roomId});

                              chatbar = true;
                              myoption=true;
                              setState(() {
                                Fluttertoast.showToast(msg:"message deleted");
                              });

                            }, icon: Icon(Icons.delete,size: 30,color: Colors.white))
                          ],
                        ):IconButton(onPressed: (){
                          Clipboard.setData(ClipboardData(text:copymsg));
                          Fluttertoast.showToast(msg: "message copied");
                          chatbar = true;
                          myoption=true;
                          setState(() {

                          });
                        }, icon: Icon(Icons.copy,color: Colors.white,)),


                      ],
                    ),
                  ),
                  SizedBox(height:3),
                  messageList.isEmpty
                      ? Expanded(
                    // height: h / 1.5,
                      child: Padding(
                        padding: EdgeInsets.only(top:170,left:62,right:62,bottom: h/2.3),
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
                                      pageNo: pageNo,
                                      userId: widget.loginUserId??""));
                            }else{
                              BlocProvider.of<PaginatedchatBloc>(context).add(
                                  PaginatedChatGetEvent(
                                      token: widget.token ?? "",
                                      chatId: widget.isg==false?widget.grpchatid!=""?widget.grpchatid:
                                      widget.redirectchatid!=""?widget.redirectchatid:
                                      widget.communicationUserModel?.chatid ??
                                          "": widget.grpuser?.chatid??"",
                                      grpchatId:widget.grpchatid!=""?widget.grpchatid:"" ,
                                      pageNo: pageNo,
                                      userId: widget.loginUserId??""));
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
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          cacheExtent: 999999999,
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
                            String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                            msgdate = formatMessageTimestamp(dateTime,index);

                            return isMobile?MyChatList(
                              loginUserId: widget.loginUserId,
                              messageList: messageList[index],
                              msgdate: msgdate,
                              isGroup: widget.isGroup,
                              formattedTime: formattedTime,
                              activeUsersLength: activeUsersLength,
                              grpchatid: widget.grpchatid,
                              index: index,
                              roomid: roomId,
                              grpmember: grpmember,

                              ontap: (){
                                print("coooppppyyy ${messageList[index].fromuserid} ${widget.loginUserId}");
                                if(messageList[index].fromuserid!=widget.loginUserId){
                                  print("coooppppyyy false enterd");

                                  myoption=false;
                                  setState(() {

                                  });
                                }
                                else{
                                  myoption=true;
                                  print("coooppppyyy true enterd");
                                  msgid = messageList[index].id!;
                                  print("coooppppyyy false enterd $msgid");
                                  setState(() {

                                  });
                                }
                                copymsg=messageList[index].message??"";
                                chatbar=false;
                                setState(() {

                                });
                                // showMenu(
                                //               initialValue: 0,
                                //               constraints: BoxConstraints(maxWidth: w/3.3),
                                //               context: context, position: RelativeRect.fromLTRB(200, 0, 0,0),
                                //             color: ColorPalette.primary,
                                //             items: [
                                //               PopupMenuItem(
                                //                 height: 25,
                                //                 child: Center(
                                //                 child: Row(
                                //                   children: [
                                //                     IconButton(onPressed: (){
                                //                       Clipboard.setData(ClipboardData(text:messageList[index]
                                //                               .message??"" ));
                                //         //  snackBar(message: "Copied", color: Colors.black,icon: Icon(Icons.copy));
                                //         // StatusAlert.show(
                                //         //   context,
                                //         //   duration: Duration(seconds:1),
                                //         //   maxWidth: 100,
                                //         //   subtitle: "copied text",
                                //         //   subtitleOptions: StatusAlertTextConfiguration(
                                //         //     style: TextStyle(fontSize:10)
                                //         //   )
                                //         // );
                                //         Fluttertoast.showToast(msg: "message copied");
                                //         Navigator.pop(context);
                                //                     }, icon: Icon(Icons.copy,color: Colors.white,)),
                                //                     IconButton(onPressed: (){

                                //                       context.read<ChatBloc>().add(Messagedeleteevent(token: widget.token??"", chatId:messageList[index].chatid??"", msgId: messageList[index].id!));
                                //                     }, icon: Icon(Icons.delete,color: Colors.white,))
                                //                   ],
                                //                 ),
                                //               )),


                                //             ]);
                              },
                            ):WebMyChatList(
                              loginUserId: widget.loginUserId,
                              messageList: messageList[index],
                              msgdate: msgdate,
                              isGroup: widget.isGroup,
                              formattedTime: formattedTime,
                              activeUsersLength: activeUsersLength,
                              grpchatid: widget.grpchatid,
                              index: index,
                              roomid: roomId,
                              selectionChange:(index){setTrueAtIndex(index);} ,
                              grpmember: grpmember,
                              ontap: (String text){
                                FlutterClipboard.copy(text).then((result) {
                                  final snackBar = SnackBar(
                                    content: Text('Text copied to clipboard'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                });
                                print("coooppppyyy ${messageList[index].fromuserid} ${widget.loginUserId}");
                                if(messageList[index].fromuserid!=widget.loginUserId){
                                  print("coooppppyyy false enterd");

                                  myoption=false;
                                  setState(() {

                                  });
                                }
                                else{
                                  myoption=true;
                                  print("coooppppyyy true enterd");
                                  msgid = messageList[index].id!;
                                  print("coooppppyyy false enterd $msgid");
                                  setState(() {

                                  });
                                }
                                copymsg=messageList[index].message??"";
                                chatbar=false;
                                setState(() {

                                });
                                // showMenu(
                                //               initialValue: 0,
                                //               constraints: BoxConstraints(maxWidth: w/3.3),
                                //               context: context, position: RelativeRect.fromLTRB(200, 0, 0,0),
                                //             color: ColorPalette.primary,
                                //             items: [
                                //               PopupMenuItem(
                                //                 height: 25,
                                //                 child: Center(
                                //                 child: Row(
                                //                   children: [
                                //                     IconButton(onPressed: (){
                                //                       Clipboard.setData(ClipboardData(text:messageList[index]
                                //                               .message??"" ));
                                //         //  snackBar(message: "Copied", color: Colors.black,icon: Icon(Icons.copy));
                                //         // StatusAlert.show(
                                //         //   context,
                                //         //   duration: Duration(seconds:1),
                                //         //   maxWidth: 100,
                                //         //   subtitle: "copied text",
                                //         //   subtitleOptions: StatusAlertTextConfiguration(
                                //         //     style: TextStyle(fontSize:10)
                                //         //   )
                                //         // );
                                //         Fluttertoast.showToast(msg: "message copied");
                                //         Navigator.pop(context);
                                //                     }, icon: Icon(Icons.copy,color: Colors.white,)),
                                //                     IconButton(onPressed: (){

                                //                       context.read<ChatBloc>().add(Messagedeleteevent(token: widget.token??"", chatId:messageList[index].chatid??"", msgId: messageList[index].id!));
                                //                     }, icon: Icon(Icons.delete,color: Colors.white,))
                                //                   ],
                                //                 ),
                                //               )),


                                //             ]);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            fromuserids=messageList[index+1].fromuserid!;
                            oldertimestampp=messageList[index].createdAt??"";
                            return messageList[index].fromuserid!=fromuserids?  Container(
                              height: 8,
                              // color: Colors.red,
                              //  color:Colors.green
                            ):Container(
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
                    child: Row( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CircleAvatar(
                        //     backgroundColor: Colors.white,
                        //     radius: 14,
                        //     child: CircleAvatar(
                        //       backgroundImage:
                        //           NetworkImage(groupTypingUser?.photo ?? ""),
                        //       radius: 12,
                        //     )),

                        Image.asset(
                          "asset/typinggif.gif",
                          height: 50.0,
                          width: 50.0,
                        ),
                        Text(
                          "${groupTypingUser?.name} typing",
                          style: const TextStyle(
                            color: Color(0xff151522),
                            fontSize:12,
                          ),
                        ),
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
              mention==true?

              Padding(
                padding:  EdgeInsets.only(left:w/22,right:w/5.5,bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) ),
                  ),
                  child:LayoutBuilder(builder: (context, constraints){
                    return searchtext==""?
                    SizedBox(
                      height: h/4,
                      child:
                      ListView.separated(
                        // physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          itemCount:grpmember.length,
                          shrinkWrap: true,
                          itemBuilder:(context, index) {
                            return GestureDetector(
                              onTap: (){
                                final int atIndex = typedMessageController.text.indexOf('@');
                                if (atIndex != -1) {
                                  List<String> names = grpmember[index].name!.toTitleCase().split(" ");
                                  String fullName = '';
                                  if (names.length >= 2) {
                                    fullName = names[0].replaceAll('.', '') + names[1].replaceAll('.', '');
                                  } else if (names.length == 1) {
                                    fullName = names[0].replaceAll('.', '');
                                  }

                                  // Trim initials like "k.k"
                                  fullName = fullName.replaceAll(RegExp(r'\b\w\.\w\b'), '');
                                  final String textBeforeMention = typedMessageController.text;
                                  final String newText = textBeforeMention + "$fullName" + ' ';
                                  typedMessageController.value =
                                      TextEditingValue(
                                        text: newText,
                                        selection: TextSelection.collapsed(offset: newText.length),
                                      );
                                  mentionuser.add(fullName);
                                  setState(() {
                                    searchtext = '';
                                    mention=false;
                                  });
                                }
                              },
                              child: Container(
                                color: Colors.transparent,
                                child:    Row(
                                  children: [
                                    grpmember[index].photo==null||
                                        grpmember[index].photo!.isEmpty
                                        ?Container(
                                      height: h/26,
                                      width: w/12,
                                      decoration: ShapeDecoration(
                                          shape: CircleBorder(side: BorderSide.none)
                                      ),
                                      child: TextAvatar(
                                        shape: Shape.Circular,
                                        size: 18,
                                        numberLetters: 2,
                                        fontSize: w1/30,
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        text:"${grpmember[index].name.toString().toUpperCase()}" ,
                                      ),
                                    ):
                                    CircleAvatar(
                                      radius: 14.5,
                                      backgroundImage: NetworkImage("${grpmember[index].photo}"),
                                    ),
                                    SizedBox(width: 5,),
                                    Text("${grpmember[index].name.toString().toTitleCase()}",
                                      softWrap: true,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: w/29,),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),

                                // ],
                              ),
                            );

                          }                     ,
                          separatorBuilder: ( context,index)=>
                              Divider(indent: w/13,thickness: 1,)
                      )
                      ,
                    ):SizedBox(
                      height:h/9,
                      child:
                      ListView.separated(
                        reverse: true,
                        padding: EdgeInsets.all(10),
                        scrollDirection: Axis.vertical,
                        itemCount: filteredList.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              final int atIndex = typedMessageController.text.lastIndexOf('@');
                              if (atIndex != -1) {
                                // Get the selected user's name and split it into parts
                                List<String> names = filteredList[index].name!.toTitleCase().split(" ");

                                // Concatenate the first two names without spaces and remove dots and initials like "k.k"
                                String fullName = '';
                                if (names.length >= 2) {
                                  fullName = names[0].replaceAll('.', '') + names[1].replaceAll('.', '');
                                } else if (names.length == 1) {
                                  fullName = names[0].replaceAll('.', '');
                                }

                                // Trim initials like "k.k"
                                fullName = fullName.replaceAll(RegExp(r'\b\w\.\w\b'), '');

                                final String textBeforeMention = typedMessageController.text.substring(0, atIndex);
                                final String newText = textBeforeMention + "@$fullName" + ' ';
                                typedMessageController.value = TextEditingValue(
                                  text: newText,
                                  selection: TextSelection.collapsed(offset: newText.length),
                                );
                                mentionuser.add(fullName);
                                setState(() {
                                  searchtext = '';
                                  mention=false;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // children: [
                              child:    Row(
                                children: [
                                  filteredList[index].photo==null||
                                      filteredList[index].photo!.isEmpty
                                      ?Container(
                                    height: h/26,
                                    width: w/12,
                                    decoration: ShapeDecoration(
                                        shape: CircleBorder(side: BorderSide.none)
                                    ),
                                    child: TextAvatar(
                                      shape: Shape.Circular,
                                      size: 18,
                                      numberLetters: 2,
                                      fontSize: w1/30,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      text:"${grpmember[index].name.toString().toUpperCase()}" ,
                                    ),
                                  ):CircleAvatar(
                                    radius: 14.5,
                                    backgroundImage: NetworkImage("${filteredList[index].photo}"),
                                  ),
                                  SizedBox(width: 5,),
                                  Text("${filteredList[index].name.toString().toTitleCase()}",
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: w/29),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ), ),
                          );

                        },
                        separatorBuilder: (context, index) {
                          return Divider(indent: w/13,thickness: 1,);
                        },
                      ),
                    );
                  } ),






                ),
              )

                  :Container(),
                  msgsendload==true?Container(
                    width: w1,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 35,
                    decoration: BoxDecoration(color: Color(0xFFFFD279),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15,),
                        Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors
                                  .black),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          'Your message is being sent...',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          color: const Color(0xffFFFFFF),
                          width: w1,
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
                                  child:removeduser.contains(widget.loginUserId)?Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(width: w/1.15,
                                        child: Center(child: Text("You can't send messages to this group because you're no longer a member",
                                          textAlign:TextAlign.center ,
                                          style: TextStyle(fontSize: 12),
                                          softWrap: true,
                                        ))),
                                  ) :Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: w1/2,
                                            child: TextField(
                                             enabled: true,
                                              focusNode: textformFocusnOde,
                                                minLines: 1,
                                                maxLines: 4,
                                              autofocus: true,
                                              onSubmitted: (va){
                                               print("testing purposeeeeeeeee");
                                               typedMessageController.clear();

                                                FocusScope.of(context).requestFocus(textformFocusnOde);



                                              },
                                              // focusNode: FocusNode(descendantsAreFocusable: _keyboardVisible),
                                              // focusNode: FocusNode(skipTraversal: true),
                                              // focusNode:FocusNode(onKey: (node, event) => ,),

                                              style: const TextStyle(
                                                // height: 1.6,
                                              ),
                                              // maxLines:4,
                                              // minLines: 1,
                                              onChanged: (val) {
                                                if (widget.isGroup == false) {
                                                  if (val.length > 0){
                                                    widget.socket
                                                        ?.emit("listen.typing", roomId);

                                                  } else {
                                                    widget.socket?.emit(
                                                        "stopped.typing", roomId);
                                                  }
                                                } else if (widget.isGroup == true) {
                                                  if (val.length > 0 ) {
                                                    print("the group typing atleaset");
                                                    widget.socket?.emit(
                                                        "group.listen.typing", roomId);
                                                    if(typedMessageController.text.contains('@')){

                                                      mention = true;
                                                      searchtext = typedMessageController.text.split("@").last; // Exclude the '@' symbol
                                                      print("Entered the @mention $searchtext");
                                                      filteredList = grpmember.where((user) {
                                                        bool nameMatches = user.name?.toLowerCase().contains(searchtext.toLowerCase()) ?? false;
                                                        bool photoMatches = user.photo?.toLowerCase().contains(searchtext.toLowerCase()) ?? false;
                                                        return nameMatches || photoMatches;
                                                      }).toList();
                                                      // }
                                                      if (filteredList.isEmpty) {
                                                        mention = false; // Set mention to false if filteredList is empty
                                                      }
                                                      setState(() {

                                                      });
                                                    }else{
                                                      mention = false;
                                                      setState(() {

                                                      });
                                                    }
                                                  } else {
                                                    mention=false;
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
                                                      minHeight: 25, minWidth: 20),
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
                                                      : "Message${activeUsersLength.toString()} ",
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
                                              .text.trim().isNotEmpty) ...{
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
                                                    print("recording start");
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
                                  )
                              )
                            ],
                          ),
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
  void handleKeyPress(event) {
    print("Akshayyyyyyyyyyyy");

    if (event is RawKeyUpEvent && event.data is RawKeyEventDataWeb) {

      var data = event.data as RawKeyEventDataWeb;

      if (data.code == "Enter" && event.isShiftPressed) {
        print("Shift + Enter pressed");
        final val = typedMessageController.value;
        final cursorPosition = typedMessageController.selection.baseOffset;
        final newCursorPosition = cursorPosition + 1;
        print("Shift + Enter pressed$cursorPosition");
        final newValue = val.text.replaceRange(
          cursorPosition,
          cursorPosition,
           "\n",

        );
        typedMessageController.value = TextEditingValue(
          text: newValue,
          selection: TextSelection.collapsed(
            offset: cursorPosition,
          ),
        );
      }

      else if(data.code=="Enter" && !event.isShiftPressed){
        print("only enter case");

        if(typedMessageController.text.trim().isNotEmpty){
          print("sending....");
          player!.setAsset('asset/send.mp3').then((value) {
            return {
              player!.playerStateStream.listen((state) {
                if (state.playing) {
                  setState(() {
                    print("audio,,,,");
                  });
                }
                else switch (state.processingState) {
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
            print("ssssssssssssssst${typedMessageController.text.split('\n').length}");
            var val=typedMessageController.text.split('\n').length/2;
            print("ssssssssssssssst${typedMessageController.text.substring(0,typedMessageController.text.length-val.toInt())}");
            // print("isGroupFalse${typedMessageController.text[ typedMessageController.text.split('\n')typedMessageController.text.length-3]}");
            // sendMessage(
            //     typedMessageController.text .substring(0,typedMessageController.text.split('\n').length>2?typedMessageController.text.length-val.toInt():typedMessageController.text.length-1),
            //     widget.chat==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel
            //         ?.chatid ??
            //         "":widget.communicationuser?.id??"",
            //     showdate);
            // widget.socket?.emit(
            //     "stopped.typing", roomId);

          } else {
            print("commentgrpid${widget.grpchatid}");
            if(widget.grpchatid==""){

              sendGroupMessage(
                  typedMessageController.text.substring(0,typedMessageController.text.length-1),
                  widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel
                      ?.chatid ??
                      "":widget.grpuser?.chatid??"");
            }else{
              print("commentgrppid${widget.grpchatid}");
              sendGroupMessage(
                  typedMessageController.text.substring(0,typedMessageController.text.length-1),
                  widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid.toString());
            }
            widget.socket?.emit(
                "group.stopped.typing",
                roomId);
            seenUsersList.clear();
          }

          typedMessageController.clear();

        }
      }
    }
    // else  if (event is RawKeyDownEvent) {
    //   if(event.logicalKey==LogicalKeyboardKey.enter ){
    //     print("typedMessageController.text.isNotEmpty)${typedMessageController.text.isNotEmpty}");
    //     if(typedMessageController.text.trim().isNotEmpty){
    //       print("sending....");
    //       print(typedMessageController.text);
    //       player!.setAsset('asset/send.mp3').then((value) {
    //         return {
    //           player!.playerStateStream.listen((state) {
    //             if (state.playing) {
    //               setState(() {
    //                 print("audio,,,,");
    //               });
    //             }
    //             else
    //               switch (state.processingState) {
    //                 case ProcessingState.idle:
    //                   break;
    //                 case ProcessingState.loading:
    //                   break;
    //                 case ProcessingState.buffering:
    //                   break;
    //                 case ProcessingState.ready:
    //                   setState(() {
    //                   });
    //                   break;
    //                 case ProcessingState.completed:
    //                   setState(() {
    //                   });
    //                   break;
    //               }
    //           }),
    //           player!.play(),
    //         };
    //       });
    //       // HapticFeedback.heavyImpact();
    //       if (widget.isGroup == false) {
    //
    //         sendMessage(
    //             typedMessageController.text,
    //             widget.chat==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel
    //                 ?.chatid ??
    //                 "":widget.communicationuser?.id??"",
    //             showdate);
    //         widget.socket?.emit(
    //             "stopped.typing", roomId);
    //
    //       } else {
    //         print("commentgrpid${widget.grpchatid}");
    //         if(widget.grpchatid==""){
    //
    //           sendGroupMessage(
    //               typedMessageController.text,
    //               widget.isg==false?widget.redirectchatid!=""?widget.redirectchatid: widget.communicationUserModel
    //                   ?.chatid ??
    //                   "":widget.grpuser?.chatid??"");
    //         }else{
    //           print("commentgrppid${widget.grpchatid}");
    //           sendGroupMessage(
    //               typedMessageController.text,
    //               widget.redirectchatid!=""?widget.redirectchatid:widget.grpchatid.toString());
    //         }
    //         widget.socket?.emit(
    //             "group.stopped.typing",
    //             roomId);
    //         seenUsersList.clear();
    //       }
    //
    //       typedMessageController.clear();
    //     }
    //
    //     // FocusScope.of(context).requestFocus(textformFocusnOde);
    //   }
    // }
  }

  String formatMessageTimestamp(DateTime timestamp,int index){
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    DateTime lastWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday + 6));
    // if (!checkUniqueness==true) {
    //   // If checkUniqueness is false, return null without checking the uniqueness of the date.
    //   return "";
    // }
    print("date $now");
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
                      text: "ImagSe",
                      color: const Color(0xFF33C658)),
                  onTap: () {
                    pickFiles("image", context,"gallery");

                    // Navigator.pop(context);
                    // showDialog(
                    //   context: context, builder: (BuildContext parentcontext) {
                    //   return AlertDialog(
                    //     content: Container(
                    //       height: MediaQuery.of(context).size.height/8,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(top:8),
                    //         child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             // InkWell(
                    //             //   onTap: (){
                    //             //
                    //             //     // pickFiles("image",parentcontext,"image");
                    //             //   },
                    //             //   child: Container(
                    //             //     child: Row(
                    //             //       children: [
                    //             //         IconButton(onPressed: (){
                    //             //           // pickFiles("image",parentcontext,"image");
                    //             //
                    //             //         }, icon: Icon(Icons.camera_alt_outlined,color: ColorPalette.primary,size:25,),),
                    //             //         Text("Camera")
                    //             //       ],
                    //             //     ),
                    //             //   ),
                    //             //
                    //             // ),
                    //             InkWell(
                    //               onTap: (){
                    //                 pickFiles("image", parentcontext,"gallery");
                    //               },
                    //               child: Container(
                    //                 child: Row(
                    //                   children: [
                    //                     IconButton(onPressed: (){
                    //                       // pickFiles("Image", parentcontext,"gallery");
                    //                     }, icon: Icon(Icons.photo_library_outlined,color: ColorPalette.primary,size:25)),
                    //                     Text("Gallery")
                    //                   ],
                    //                 ),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     // actions: [
                    //     //   Row( mainAxisAlignment: MainAxisAlignment.end,
                    //     //     children: [
                    //     //       TextButton(onPressed: (){
                    //     //         Navigator.pop(context);
                    //     //       }, child: Text("Cancel")),
                    //
                    //     //     ],
                    //     //   )
                    //     // ],
                    //   );
                    // },
                    // );
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
  void dispose() {
    _controller.dispose();
    isMount = false;
    ismount1=false;
    isgrp=false;
    ismounted=false;
    mountedis=false;
    isdelete=false;
    isSecondMount = false;
    isThirdMount = false;
    isFourthMount = false;
    isseventhMount=false;
    iseigthMount=false;
    isactivelen=false;
    isenteruser=false;
    _animationController?.dispose();
    widget.socket!.off('latest.message');
    widget.socket!.off('group.latest.message');
    widget.socket!.off('groupmembers.result');
    widget.socket!.off('group.members');
    widget.socket!.off('message.deleted',deletemessage);
    isFifthMount=false;
    widget.socket!.off("user.left");
    mountedactive=false;
    super.dispose();
  }
  Future<Uint8List> imageFileSelection({List<String>?allowedExtensions}) async {
    Uint8List? bytes;


      final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom,
          allowedExtensions:allowedExtensions?? ['jpg' ],
          withData: true);
      print(pickedFile?.files.first.name);
      // print(pickedFile?.files.first.mimeType);

      Variable.imageName=pickedFile?.files.first.name??"";




      if (pickedFile != null) {
        bytes = pickedFile.files.first.bytes;

      }
    print(bytes);
    return  bytes??Uint8List(0);


  }
  void pickFiles(String? filetype, BuildContext context,String? source)async{

    switch(filetype){
      case 'image':{
        Uint8List? bytes =await imageFileSelection(allowedExtensions:  ['jpg','png' ]);
        if(bytes.isNotEmpty)
        BlocProvider.of<AttachmentBloc>(context)
            .add(UploadPictureEvent(image:bytes!));
      }break;
      case 'MultipleFile':{
        Uint8List? bytes =await imageFileSelection(allowedExtensions:  ['xlsx','xls','pdf',"csv",'docs','zip',"txt" ]);
        print("checking case$bytes");
        if(bytes.isNotEmpty){ BlocProvider.of<AttachmentBloc>(context)
            .add(UploadFilesEvent(files: bytes!,name:Variable.imageName ));}
        else{
          // Navigator.of(context);
        }

      }
      break;      case 'Video':{
        print("thisssssssssssssssss");
        Uint8List? bytes =await imageFileSelection(allowedExtensions:   ['mp4', 'mov', 'avi']);
        uploadFileChunks(bytes);
        print("thisssssssssssssssss$bytes");
        // BlocProvider.of<AttachmentBloc>(context)
        //     .add(UploadVideoEvent(video: bytes!));
      }
      break;
    }

  }




  }


Future<void> uploadFileChunks(Uint8List fileBytes) async {
  const chunkSize = 1024 * 1024; // 1 MB chunk size
  int offset = 0;

  while (offset < fileBytes.length) {
    final end = offset + chunkSize < fileBytes.length ? offset + chunkSize : fileBytes.length;
    final chunk = fileBytes.sublist(offset, end);
    print("chunkssssssssssssssssss$chunk");

    // Send chunk to the server
    try {
      final response = await http.post(
     Uri.parse(   CommunicationUrls.uploadImageUrl), // Replace with your server endpoint
        body:{"filename": Variable.imageName, "file": chunk} ,
        // headers: {'Content-Type': 'application/octet-stream'},
      );
      if (response.statusCode == 200) {
        print('Uploaded chunk: ${chunk.length} bytes');
      } else {
        throw Exception('Failed to upload chunk: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading chunk: $e');
      // Handle error (e.g., retry or show error message)
      return;
    }

    offset += chunkSize;
  }
}

//   void pickFiles(String? filetype, BuildContext context,String? source) async {
//     print("inside the case");
//     switch (filetype) {
//       case 'Image':
//       print("inside the case");
//         // result = await FilePicker.platform
//         //     .pickFiles(type: FileType.image, allowMultiple: false,allowCompression: true);
//         image = await picker.pickImage(source:source=="gallery"? ImageSource.gallery:ImageSource.camera );
//       _imageFile = File(image!.path);
//          var results = await compressFile(_imageFile);
//       _imageFile = File(results.path);
//       // result= await  
//       int sized =1024;
//       if (image != null) {
//   // for (PlatformFile file in image!.files) {
//     final fileSizeInBytes =await results.length();
//     final fileSizeInKB = fileSizeInBytes / sized;
//     final fileSizeInMB = fileSizeInKB / sized;
//     print('File size: $fileSizeInKB KB ($fileSizeInMB MB)');
//     int maxSizeBytes = 10 * 1024 * 1024;
//     print("File size: $maxSizeBytes");
//     if (fileSizeInMB <= maxSizeBytes) {
//       print('File pathinside: ${image!.path}');
//       setState(() {
//         if(source=="camera"){
//           BlocProvider.of<AttachmentBloc>(context)
//            .add(UploadPictureEvent(image:_imageFile));
//         } else{
//         showDialog(
//           barrierColor: Color.fromARGB(255, 238, 230, 230),
//       context: context, builder: (BuildContext context) {
//         return Builder(
//           builder: (context) {
//             return Container(
//               color: Colors.black,
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Row( mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(onPressed: (){
//                                   Navigator.pop(context);
//                                 }, icon: Icon(Icons.close,color: Colors.white,size: 30,)),
//                               ],
//                             ),
//                           ),
//
//                            Container(
//                             height: MediaQuery.of(context).size.height/1.35,
//                             child: Center(child: Image.file(_imageFile,fit:BoxFit.fitHeight ,))),
//                            Padding(
//                              padding: const EdgeInsets.only(bottom: 20),
//                              child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                                child: IconButton(onPressed: (){
//                                 BlocProvider.of<AttachmentBloc>(context)
//                                              .add(UploadPictureEvent(image: _imageFile));
//                                              Navigator.pop(context);
//                                }, icon:Icon(Icons.done),color: Colors.blue,),
//                              ),
//                            )
//                          ],
//                        ),
//                    );
//           }
//         );
//
//       },
//       );
//         }
//       });
//
//
//     } else {
//       print('File path: ${image!.path}');
//       print('File size: ${image!.length()}');
//       // File size exceeds the allowed limit
//       print('File size exceeds the limit.');
//       showDialog(
//       context: context, builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text("Image size exceeds the limit"),
//           actions: [
//             Row( mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(onPressed: (){
//                   Navigator.pop(context);
//                 }, child: Text("Cancel")),
//
//               ],
//             )
//           ],
//         );
//       },
//       );
//       // Handle accordingly, for example, show an error message.
//     }
//   // }
// } else {
//   Navigator.pop(context);
//   // User canceled the file picking
// }
//         // BlocProvider.of<AttachmentBloc>(context)
//         //     .add(UploadPictureEvent(image: result!));
//         // loadSelectedFiles(result!.files);
//
//         setState(() {
//         });
//         break;
//       case 'Video':
//         result = await FilePicker.platform
//             .pickFiles(type: FileType.video, allowMultiple: false,allowCompression: true);
//         // if (result == null) return;
//         // file = result!.files.first;
//
//              if (result != null) {
//   for (PlatformFile file in result!.files) {
//     int maxSizeBytes =15 * 1024 * 1024; // Set the maximum size to 1 MB
//     if (file.size <= maxSizeBytes) {
//
//       // File size is within the allowed limit
//       print('File path: ${file.path}');
//       print('File size: ${file.size}');
//       BlocProvider.of<AttachmentBloc>(context)
//             .add(UploadVideoEvent(video: result!));
//     } else {
//       print('File path: ${file.path}');
//       print('File size: ${file.size}');
//       // File size exceeds the allowed limit
//       print('File size exceeds the limit.');
//       showDialog(
//       context: context, builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text("Vedio size exceeds the limit"),
//           actions: [
//             Row( mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(onPressed: (){
//                   Navigator.pop(context);
//                 }, child: Text("Cancel")),
//
//               ],
//             )
//           ],
//         );
//       },
//       );
//       // Handle accordingly, for example, show an error message.
//     }
//   }
// } else {
//   // User canceled the file picking
// }
//         setState(() {});
//         break;
//       case 'Audio':
//         result = await FilePicker.platform
//             .pickFiles(type: FileType.audio, allowMultiple: false,allowCompression: true );
//
//         if (result == null) return;
//         file = result!.files.first;
//
//                 if (result != null) {
//   for (PlatformFile file in result!.files) {
//     int maxSizeBytes =10 * 1024 * 1024; // Set the maximum size to 1 MB
//     if (file.size <= maxSizeBytes) {
//
//       // File size is within the allowed limit
//       print('File path: ${file.path}');
//       print('File size: ${file.size}');
//       BlocProvider.of<AttachmentBloc>(context)
//             .add(UploadAudioEvent(audio: result!));
//     } else {
//       print('File path: ${file.path}');
//       print('File size: ${file.size}');
//       // File size exceeds the allowed limit
//       print('File size exceeds the limit.');
//       showDialog(
//       context: context, builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text("Audio size exceeds the limit"),
//           actions: [
//             Row( mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(onPressed: (){
//                   Navigator.pop(context);
//                 }, child: Text("Cancel")),
//
//               ],
//             )
//           ],
//         );
//       },
//       );
//       // Handle accordingly, for example, show an error message.
//     }
//   }
// } else {
//   // User canceled the file picking
// }
//         setState(() {});
//         break;
//       case 'All':
//         result = await FilePicker.platform.pickFiles();
//         if (result == null) return;
//         file = result!.files.first;
//         setState(() {});
//         break;
//       case 'MultipleFile':
//         result = await FilePicker.platform.pickFiles(allowMultiple: false,allowCompression: true);
//
//                 if (result != null) {
//   for (PlatformFile file in result!.files) {
//     int maxSizeBytes =5 * 1024 * 1024; // Set the maximum size to 1 MB
//     if (file.size <= maxSizeBytes) {
//
//       // File size is within the allowed limit
//       print('File path: ${file.path}');
//       print('File size: ${file.size}');
//       BlocProvider.of<AttachmentBloc>(context)
//             .add(UploadFilesEvent(files: result!));
//     } else {
//       print('File path: ${file.path}');
//       print('File size: ${file.size}');
//       // File size exceeds the allowed limit
//       print('File size exceeds the limit.');
//       showDialog(
//       context: context, builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text("Media size exceeds the limit"),
//           actions: [
//             Row( mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(onPressed: (){
//                   Navigator.pop(context);
//                 }, child: Text("Cancel")),
//
//               ],
//             )
//           ],
//         );
//       },
//       );
//       // Handle accordingly, for example, show an error message.
//     }
//   }
// } else {
//   // User canceled the file picking
// }
//         // if (result == null) return;
//         // loadSelectedFiles(result!.files);
//         break;
//     }
//   }


// Future<XFile> compressFile(File file) async {
//   final filePath = file.absolute.path;
//   // Create output file path
//   // eg:- "Volume/VM/abcd_out.jpeg"
//   final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
//   final splitted = filePath.substring(0, (lastIndex));
//   final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
//   var result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path, outPath,
//     quality: 15,
//   );
//   print(file.lengthSync());
//   print(result!.length());
//   return result;
//  }


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
//   void _recordingFinishedCallback(
//   String path,
//   BuildContext context,
// ) {
//
//   final uri = Uri.parse(path);
//   print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$uri");
//
//   // File file = File(uri.path);
//   // Create a Blob from the recorded data
//   final blob = html.Blob([html.File([path], 'audio/wav')]);
//
//   final reader = html.FileReader();
//   reader.readAsArrayBuffer(blob);
//
//   reader.onLoadEnd.listen((_) {
//     final uint8List = Uint8List.fromList(reader.result as List<int>);
//
//     // Use the Uint8List for further processing or upload
//     // For example, you can create a File from Uint8List
//     final  File file = html.File([uint8List], 'audio.wav');
//
//     // Access file size
//     final fileSize = file.size;
//     print("File size: ${file.runtimeType}");
//
//     // Dispatch your Bloc event or perform other actions
//     BlocProvider.of<AttachmentBloc>(context)
//         .add(UploadLiveAudioEvent(audio: uint8List, comment: true));
//   });
//
//   // file.length().then(
//   //   (fileSize) {
//   //     print("files is this ${file}");
//   //     BlocProvider.of<AttachmentBloc>(context)
//   //         .add(UploadLiveAudioEvent(audio: file,comment: widget.grpchatid==""?false:true));
//   //   },
//   // );
// }
Future<void> _recordingFinishedCallback(
  String path,
  BuildContext context,
) async {

  final uri = Uri.parse(path);
  print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$uri");

  // final blobUrl = 'blob:http://localhost:57539/f3793822-b6cf-4764-8932-8c1eaf81c5ca';

  try{
    final blob = await HttpRequest.request(uri.toString(), responseType: 'blob').then((request) => request.response);
    print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii1$blob");

    // Create a FileReader instance to read the blob data
    final reader = FileReader();
    print("sss");

    // Register an onLoadEnd event handler to process the blob data after it's loaded
    reader.onLoadEnd.listen((e) {
      print("ss1s");
      // Convert blob data to bytes
      final blobBytes = reader.result as List<int>;
      print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii1$blob");
      // Convert bytes to base64 string
      final blobBase64 = base64Encode(blobBytes);
      print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii3$blob");

      // Send the base64 string to the backend
      final apiUrl =Uri.parse(  CommunicationUrls.uploadImageUrl);
      http.post(apiUrl, body: {'file': blobBase64,"filename":"audio.mp3"}).then((response) {
        // Handle response from backend
        if (response.statusCode == 200) {
          print('Blob data successfully sent to the backend.');
        } else {
          print('Failed to send blob data to the backend. Status code: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error sending blob data to the backend: $error');
      });
    });
  }catch(e){

    print("the error is her$e");
  }
  // final blob = await HttpRequest.request(uri.toString(), responseType: 'blob').then((request) => request.response);
  // print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii1$blob");
  //
  // // Create a FileReader instance to read the blob data
  // final reader = FileReader();
  //
  // // Register an onLoadEnd event handler to process the blob data after it's loaded
  // reader.onLoadEnd.listen((e) {
  //   // Convert blob data to bytes
  //   final blobBytes = reader.result as List<int>;
  //   print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii1$blob");
  //   // Convert bytes to base64 string
  //   final blobBase64 = base64Encode(blobBytes);
  //   print("uriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii3$blob");
  //
  //   // Send the base64 string to the backend
  //   final apiUrl =Uri.parse(  CommunicationUrls.uploadImageUrl);
  //   http.post(apiUrl, body: {'file': blobBase64,"filename":"audio.mp3"}).then((response) {
  //     // Handle response from backend
  //     if (response.statusCode == 200) {
  //       print('Blob data successfully sent to the backend.');
  //     } else {
  //       print('Failed to send blob data to the backend. Status code: ${response.statusCode}');
  //     }
  //   }).catchError((error) {
  //     print('Error sending blob data to the backend: $error');
  //   });
  // });

  // File file = File(uri.path);
  // Create a Blob from the recorded data
  // final blob = html.Blob([html.File([path], 'audio/wav')]);
  //
  // final reader = html.FileReader();
  // reader.readAsArrayBuffer(blob);
  //
  // reader.onLoadEnd.listen((_) {
  //   final uint8List = Uint8List.fromList(reader.result as List<int>);
  //
  //   // Use the Uint8List for further processing or upload
  //   // For example, you can create a File from Uint8List
  //   final  File file = html.File([uint8List], 'audio.wav');
  //
  //   // Access file size
  //   final fileSize = file.size;
  //   print("File size: ${file.runtimeType}");
  //
  //   // Dispatch your Bloc event or perform other actions
  //   BlocProvider.of<AttachmentBloc>(context)
  //       .add(UploadLiveAudioEvent(audio: uint8List, comment: true));
  // });

  // file.length().then(
  //   (fileSize) {
  //     print("files is this ${file}");
  //     BlocProvider.of<AttachmentBloc>(context)
  //         .add(UploadLiveAudioEvent(audio: file,comment: widget.grpchatid==""?false:true));
  //   },
  // );
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

