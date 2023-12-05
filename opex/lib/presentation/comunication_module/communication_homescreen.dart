import 'dart:convert';

import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/search_screen.dart';
import 'package:cluster/presentation/comunication_module/communication_urls.dart';
import 'package:cluster/presentation/comunication_module/create_group.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummychatscreen.dart';
import 'package:cluster/presentation/comunication_module/pinned_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'appbar_cmtn.dart';
import 'chat_card.dart';
import 'chat_type_list.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class CommunicationModule extends StatefulWidget {
  final String token;
  const CommunicationModule({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<CommunicationModule> createState() => _CommunicationModuleState();
}

class _CommunicationModuleState extends State<CommunicationModule> {
  bool isHomeMount = true;
  Dio client = Dio();
  String _data = '';

  UserDummyList? ulist;
  List< UserDummyList> userlist=[];

  final List<String> onlineUsers = [];
  IO.Socket? socketCon;
  String? loginuserId;
  Future<void> _getData() async {
    print("hi");
    final response = await client.get(CommunicationUrls.getChatList,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${widget.token}',
          },
        ));

    if (response.statusCode == 200) {
      print("hello");

      setState(() {
        _data = json.decode(response.data)['data'];
      });
    }
    // Start the long polling process again
    _getData();
  }

  @override
  void initState() {
    IO.Socket socket = IO.io(
        'https://api-communication-application.hilalcart.com/',
        // 'https://6af7-116-68-110-250.ngrok-free.app/',
        // OptionBuilder().setTransports(['websocket']).setQuery({
        //   'transports': ['websocket', 'polling'],
        //   'auth': {'token': widget.token},
        //   'autoConnect': false,
        // }).build());
        <String, dynamic>{
          'transports': ['websocket', 'polling'],
          'auth': {'token': widget.token},
          'autoConnect': false,
        });
    socket.connect();
    // Handle socket events
    socket.on('connect', (_) => print('connect success: ${socket.id}'));

//---------------------------------------
    // socket.on('user.connected',(data){
    //     print("...user.connected : $data");
    //     ulist=UserDummyList.fromJson(data['user']);
    //     userlist.add(ulist!);
    // //     (data['user'] as List).forEach((element) {
    // //   ulist!.add(UserDummyList.fromJson(element));
    // // });
    //     // print("userlist : ${ulist!.id}");
    // });

    //   socket.on('user.id',(data){
    //     print("!!!!!!!!user.id : $data");

    // });
//-------------------------------------------

    socket.on('online', (data) {
      print("online anutto ${data}");
      onlineUsers.add(data['id']);
      // if (isHomeMount) {
      setState(() {});
      // }
      print("online anutto users data ${onlineUsers}");
    });
    socket.on('offline', (data) {
      // print("online anutto poyetto  ${data}");
      onlineUsers.remove(data['id']);
      // if (isHomeMount) {
      setState(() {});
      // }
    });
    socket.on('user.id', (data) {
      loginuserId = data;
      setState(() {});
    });
    
    // socket.on("latest.message", (data) => print("homescreen latest message $data"));
    // socket.on('latest.message', (data) => streamSocket.addResponse);
    // socket.onDisconnect((_) => print('disconnect happened'));

    socketCon = socket;
    // socket.disconnect();
    BlocProvider.of<CommunicationBloc>(context)
        .add(GetChatListEvent(token: widget.token));
    // _getData();
    super.initState();
  }

  // @override
  // void dispose() {
  //   isHomeMount = false;
  //   super.dispose();
  // }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("builddd");
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.primary,
        tooltip: "Create group",
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CreateAGroup(
              token: widget.token,
              loginUserId: loginuserId,
              socket: socketCon,
            ),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        },
        child: const Icon(Icons.add,
        size: 33,
        color:Colors.white,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Color(0xFF2870AE), // Status bar
          ),
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarCommunication(token: widget.token),
              Container(
                width: w,
                height: 1.50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xb2e6e6e6),
                    width: 0.50,
                  ),
                ),
              ), 
              Padding(
                padding: const EdgeInsets.all(10),
                child: const PinnedProfile(),),
                 Divider(
                  thickness: 4,
                  color: Color(0xffEFF1F3),
                 ),
                 
                Container(
                  padding: EdgeInsets.all(10),
                  width: w,
                  child: Row(
                    children: [
                      // Container(
                      //   width: 36,
                      //   height: 36,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(
                      //       color: const Color(0x4ca9a8a8),
                      //       width: 1,
                      //     ),
                      //     color: const Color(0xfff8f7f5),
                      //   ),
                      //   child: const Icon(Icons.add),
                      // ),
                      ChatTypeList(
                        token: widget.token,
                      )
                    ],
                  ),
                ), 
                
                const SizedBox(
                  height: 16,
                ),
                                                     
              Container(
                width: w,
                // padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<CommunicationBloc, CommunicationState>(
                      builder: (context, state) {
                        if (state is GetChatListLoading) {
                          return customCupertinoLoading();
                        } else if (state is GetChatListSuccess) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Recent Chat",
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xff151522),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return ChatCard(
                                          onlineUsers: onlineUsers,
                                          loginUserId: loginuserId,
                                          token: widget.token,
                                          socket: socketCon,
                                          communicationUserModel:
                                              state.chatList[index],
                                          isGroup:
                                              state.chatList[index].isGroupChat ??
                                                  false,
                                        );
                                      }
                                      return ChatCard(
                                        onlineUsers: onlineUsers,
                                        loginUserId: loginuserId,
                                        socket: socketCon,
                                        isGroup:
                                            state.chatList[index].isGroupChat ??
                                                false,
                                        token: widget.token,
                                        communicationUserModel:
                                            state.chatList[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          height: 22,
                                        ),
                                    itemCount: state.chatList.length),
                              ],
                            ),
                          );
                        } else if (state is GetChatListFailed) {}
                        return Container(
                          color: Color(0xffEFF1F3),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: h/5),
                                child: const Center(
                                  child: SizedBox(
                                    // width: 197,
                                    // height: 23,
                                    child: Text(
                                      "You have’nt chat yet",
                                      style: TextStyle(
                                        color: Color(0xff151522),
                                        fontSize: 20,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CmtnSearch(token: widget.token),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade,
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      "Start Chatting",
                                      style:GoogleFonts.roboto(textStyle:TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                        ), ) ,
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFF2871AF),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:h/2.75,
                                ),
                              Column(
                              children: [
                              Text("Sidrateams LLC",
                              style:GoogleFonts.roboto(
                                textStyle:TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                )
                                )
                              ),
                              Text("version 1.1.5",
                              style:GoogleFonts.roboto(
                                textStyle:TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                                )
                                )
                                ),
                              ],)
                              
                            ],
                          ),
                        );
                      },
                    ),
                    //-----------------
                    // ChatCard(isGroup: true,),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // ChatCard(),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // ChatCard(),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // ChatCard(),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // ChatCard(),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    //  ChatCard(),
                    //------------
                    // SizedBox(
                    //   height: h,
                    //   child: ListView.builder(
                    //     itemCount:userlist.length,
                    //     shrinkWrap: true,
                    //     itemBuilder:(context, index) {
                    //       return ListTile(
                    //         leading: Image.network("${userlist[index].photo}"),
                    //         title: Text("${userlist[index].username}"),

                    //       );
                          
                        // }),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LongPolling {
  String token;
  LongPolling({required this.token});
  Dio client = Dio();

  Future<Response> longPoll() async {
    final response = await client.get(CommunicationUrls.getChatList,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ));
    return response;
  }
}
