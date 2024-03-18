import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/create_group.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/comunication_module/web_chat_screen.dart';
import 'package:cluster/presentation/dashboard_screen/profile/new_profile_screen.dart';
import 'package:cluster/presentation/sidra_learning/sidra_learning_home_page.dart';
import 'package:cluster/presentation/task_operation/task_operation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:html' as html;

var widgetList=[
  CommunicationModule(),
  const TaskAndOperation(),
  const SidraLearningHomePage(),
];
ValueNotifier< int> slectedTab=ValueNotifier(0);

final ValueNotifier<CenrerScereenSwitch> screenNotifier =
    ValueNotifier(CenrerScereenSwitch());



chabeTAbIndex(int val,{  bool? isGroup,
 bool? chat,
 Socket? socket,
 String? grpchatid,
 String? cmntgrpchatname,
 String? redirectchatid,
 String? redirectchatname,
 String? token,
 String? loginUserId,
 String? redirectionsenduserId,
 UserDummyList? communicationUserModel,
 dynamic? communicationuser,
 GroupList? grpuser,
//WEBCHATESCREEN







  final String? roomId,
  final String? loginuserid,
  final bool? isadmin,

 bool? isg}){
  slectedTab.value=val;
  screenNotifier.value = CenrerScereenSwitch(tab:val,isGroup: isGroup,chat: chat,socket: socket, grpchatid: grpchatid,cmntgrpchatname: cmntgrpchatname,
  redirectchatid: redirectchatid,redirectchatname: redirectchatname,token: token,loginUserId: loginUserId,redirectionsenduserId: redirectionsenduserId,
  communicationUserModel: communicationUserModel,communicationuser: communicationuser,isg: isg,);
}
 bool getTAbIndex(int val){

return val==slectedTab.value;

}

class CenrerScereenSwitch extends StatefulWidget {
  final int? tab;
  final bool? isGroup;
  final bool? chat;
  final Socket? socket;
  final String? grpchatid;
  final String? cmntgrpchatname;
  final String? redirectchatid;
  final String? redirectchatname;
  final String? token;
  final String? loginUserId;
  final String? redirectionsenduserId;
  final UserDummyList? communicationUserModel;
  final CommunicationUserModel? communicationuser;
  final GroupList? grpuser;
  final bool? isg;

  const CenrerScereenSwitch({super.key,this.tab, this.isGroup, this.chat, this.socket, this.grpchatid, this.cmntgrpchatname, this.redirectchatid, this.redirectchatname, this.token, this.loginUserId, this.redirectionsenduserId, this.communicationUserModel, this.communicationuser, this.grpuser, this.isg});

  @override
  State<CenrerScereenSwitch> createState() => _CenrerScereenSwitchState();
}

class _CenrerScereenSwitchState extends State<CenrerScereenSwitch> {
  @override
  Widget build(BuildContext context) {
    Widget data=Container();
    switch (slectedTab.value) {
      case 0:
        {
          data =CommunicationModule();
        }
        break;
      case 1:
        {
          data =TaskAndOperation();
        }break;
      case 2:
        {
          data =SidraLearningHomePage();
        }break;
      case 3:
        {
          data =WebChatScreen(
          token: widget.token,
        loginUserId: widget.loginUserId,
        socket: widget.socket,
        isGroup: widget.isGroup!,
        chat: widget.chat??false,
        communicationuser: widget.communicationuser,
        communicationUserModel: widget.communicationUserModel,
        );
        }break;
      case 4:
        {
          data =CreateAGroup(
          token: widget.token,
          loginUserId: widget.loginUserId,
        socket: widget.socket,
        );
        }break;
      default:}
    return data ;
  }
}
