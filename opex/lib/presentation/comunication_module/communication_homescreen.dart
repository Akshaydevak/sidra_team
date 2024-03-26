// import 'dart:convert';

// import 'package:cluster/common_widgets/loading.dart';
// import 'package:cluster/core/color_palatte.dart';
// import 'package:cluster/core/common_snackBar.dart';
// import 'package:cluster/presentation/authentication/authentication.dart';
// import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
// import 'package:cluster/presentation/comunication_module/chat_screen.dart';
// import 'package:cluster/presentation/comunication_module/chat_screen/search_screen.dart';
// import 'package:cluster/presentation/comunication_module/communication_urls.dart';
// import 'package:cluster/presentation/comunication_module/create_group.dart';
// import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
// import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
// import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummychatscreen.dart';
// import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
// import 'package:cluster/presentation/comunication_module/pinned_profile.dart';
// import 'package:cluster/presentation/dashboard_screen/home_screen.dart';
// import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
// import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
// import 'package:cluster/presentation/task_operation/lottieLoader.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'appbar_cmtn.dart';
// import 'chat_card.dart';
// import 'chat_type_list.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;

// class CommunicationModule extends StatefulWidget {
//   final String token;
//   const CommunicationModule({
//     Key? key,
//     required this.token,
//   }) : super(key: key);

//   @override
//   State<CommunicationModule> createState() => _CommunicationModuleState();
// }

// class _CommunicationModuleState extends State<CommunicationModule> {
//   bool isHomeMount = true;
//   Dio client = Dio();
//   String _data = '';
//   String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVhMTYzZTNhLWI0NjAtNGNjYy1iNDg0LTRlMjFlNDkxZDY5ZiIsInVzZXJuYW1lIjoiUkdDIER5bmFtaWNzIEFQSSBVc2VyIiwiZW1haWwiOiJhZG1pbkByZ2NkeW5hbWljcy5jb20iLCJwaG90byI6Imh0dHBzOi8vYXBpLXVhdC11c2VyLnNpZHJhYmF6YXIuY29tL21lZGlhL1VzZXIvSW1hZ2VzL1Byb2ZpbGVQaWMvc2NhbGVkX2ltYWdlc181SnRQWFJCLmpwZyIsImlhdCI6MTcwMjYxOTMwOCwiZXhwIjoxNzAyNzA1NzA4fQ.8vc8pQxzuQfNnU4_bHNSf-E-ysfuI56WJlor9vQFwFk';
//     // String token="";
//   UserDummyList? ulist;
//   List<UserDummyList> userlist = [];
//   bool isloading = true;
//   bool isload = true;
//   final List<String> onlineUsers = [];
//   IO.Socket? socketCon;
//   String? loginuserId;
//   Future<void> _getData() async {
//     print("hi");
//     final response = await client.get(CommunicationUrls.getChatList,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer ${token}',
//           },
//         ));

//     if (response.statusCode == 200) {
//       print("hello");

//       setState(() {
//         _data = json.decode(response.data)['data'];
//       });
//     }
//     // Start the long polling process again
//     _getData();
//   }

//   @override
//   void initState() {
//      IO.Socket socket = IO.io(
//         'https://api-communication-application.hilalcart.com/',
//         // 'https://5a19-116-68-110-250.ngrok-free.app/',
//         // "https://135c-116-68-110-250.ngrok-free.app/home",
//         // OptionBuilder().setTransports(['websocket']).setQuery({
//         //   'transports': ['websocket', 'polling'],
//         //   'auth': {'token': widget.token},
//         //   'autoConnect': false,
//         // }).build());
//         <String, dynamic>{
//           'transports': ['websocket', 'polling'],
//           'auth': {'token': widget.token},
//           'autoConnect': false,
//         });
//     socket.connect();
//     // Handle socket events
//     socket.on('connect', (_) => print('connect success: ${socket.id}'));
//     socket.on('online', (data) {
//       print("online anutto ${data}");
//       onlineUsers.add(data['id']);
//       // if (isHomeMount) {
//       setState(() {});
//       // }
//       print("online anutto users data ${onlineUsers}");
//     });
//     socket.on('offline', (data) {
//       // print("online anutto poyetto  ${data}");
//       onlineUsers.remove(data['id']);
//       // if (isHomeMount) {
//       setState(() {});
//       // }
//     });
//     socket.on('user.id', (data) {
//       loginuserId = data;
//       setState(() {});
//     });
//     // socket.on("latest.message", (data) => print("homescreen latest message $data"));
//     // socket.on('latest.message', (data) => streamSocket.addResponse);
//     // socket.onDisconnect((_) => print('disconnect happened'));

//     socketCon = socket;
//     // socket.disconnect();
//     BlocProvider.of<CommunicationBloc>(context)
//         .add(GetChatListEvent(token: widget.token));
//     _getData();
//     super.initState();
//     // print("fghjk ${widget.token}");
//     // IO.Socket socket = IO.io(
//     //               // 'https://135c-116-68-110-250.ngrok-free.app/home',
//     //               "https://api-communication-application.hilalcart.com/",
//     //               <String, dynamic>{
//     //                 'transports': ['websocket','polling'],
//     //                 'auth': {'token':widget.token},
//     //                 'autoConnect':false,
//     //               });
              
//     //           socket.connect();
              
//     //           // Handle socket events
//     //           socket.on('connect', (_)=>print("connect success : ${socket.id}")
//     //           );
//     //            socket.on('friends.list',(data){
//     //               print("Friends list $data");
//     //             //   ulist = UserDummyList.fromJson(data);
//     //             // userlist.add(ulist!);
//     //               (data as List).forEach((element) {
//     //               userlist.add(UserDummyList.fromJson(element));
//     //               setState(() {
                    
//     //               });
//     //             });
                
//     //             print("mkkk ${userlist[0].id}");
//     //           });
         
//     //           socket.on('online', (data) {
//     //             print("online anutto ${data}");
//     //             onlineUsers.add(data['id']);
//     //             // if (isHomeMount) {
//     //             setState(() {});
//     //             // }
//     //             print("online anutto users data ${onlineUsers}");
//     //           });
//     //           socket.on('offline', (data) {
//     //             // print("online anutto poyetto  ${data}");
//     //             onlineUsers.remove(data['id']);
//     //             // if (isHomeMount) {
//     //             setState(() {});
//     //             // }
//     //           });
//     //           socket.on('user.id', (data) {
//     //             loginuserId = data;
//     //             setState(() {});
//     //           });

//     //           // socket.on("latest.message", (data) => print("homescreen latest message $data"));
//     //           // socket.on('latest.message', (data) => streamSocket.addResponse);
//     //           // socket.onDisconnect((_) => print('disconnect happened'));

              

//     //           socketCon = socket;
              
//     //           socket.disconnect();
              
//     // // print("bgghbvfrt${authentication.authenticatedUser.token}");
//     // // BlocProvider.of<DummyLoginBloc>(context)
//     // //     .add(TokenCreationCommunicationEvent());
//     // // _getData();
//     // super.initState();
//   }

//   // @override
//   // void dispose() {
//   //   isHomeMount = false;
//   //   super.dispose();
//   // }

//   TextEditingController searchController = TextEditingController();
//     bool isrefresh= false;
//   void refresh(bool val){
//     isrefresh=val;
//     setState(() {
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("builddd");
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.height;
//     return MultiBlocListener(
//       listeners: [
//         // BlocListener<DummyLoginBloc, DummyLoginState>(
//         //   listener: (context, state) {
//         //     if (state is TokenCreationCommunicationLoading) {
//         //       customCupertinoLoading();
//         //     } else if (state is TokenCreationCommunicationSuccess) {
//         //       token = state.token;
//         //       print("print token ${state.token}");
              
//         //       IO.Socket socket = IO.io(
//         //           // 'https://api-communication-application.hilalcart.com/',
//         //           'https://135c-116-68-110-250.ngrok-free.app/home',
//         //           // OptionBuilder().setTransports(['websocket']).setQuery({
//         //           //   'transports': ['websocket', 'polling'],
//         //           //   'auth': {'token': widget.token},
//         //           //   'autoConnect': false,
//         //           // }).build());
//         //           <String, dynamic>{
//         //             'transports': ['websocket','polling'],
//         //             'auth': {'token':state.token},
//         //             'autoConnect': true,

//         //           });
              
//         //       socket.connect();
              
//         //       // Handle socket events
//         //       socket.on(
//         //           'connect', (_){ print('connect success: ${socket.id}');
//         //           setState(() {
                    
//         //           });
//         //           }
                  
//         //           );
//         //           socket.on('friends.list',(data){
//         //           print("Friends list $data");
//         //         //   ulist = UserDummyList.fromJson(data);
//         //         // userlist.add(ulist!);
//         //           (data as List).forEach((element) {
//         //           userlist.add(UserDummyList.fromJson(element));
//         //           setState(() {
                    
//         //           });
//         //         });
                
//         //         print("mkkk ${userlist[0].id}");
//         //       });
         
//         //       socket.on('online', (data) {
//         //         print("online anutto ${data}");
//         //         onlineUsers.add(data['id']);
//         //         // if (isHomeMount) {
//         //         setState(() {});
//         //         // }
//         //         print("online anutto users data ${onlineUsers}");
//         //       });
//         //       socket.on('offline', (data) {
//         //         // print("online anutto poyetto  ${data}");
//         //         onlineUsers.remove(data['id']);
//         //         // if (isHomeMount) {
//         //         setState(() {});
//         //         // }
//         //       });
//         //       socket.on('user.id', (data) {
//         //         loginuserId = data;
//         //         setState(() {});
//         //       });

//         //       // socket.on("latest.message", (data) => print("homescreen latest message $data"));
//         //       // socket.on('latest.message', (data) => streamSocket.addResponse);
//         //       // socket.onDisconnect((_) => print('disconnect happened'));

              

//         //       socketCon = socket;
              
//         //       socket.disconnect();
//         //       // BlocProvider.of<CommunicationBloc>(context)
//         //       //     .add(GetChatListEvent(token: state.token));
              
                
            
//         //     } else if (state is TokenCreationCommunicationFailed) {
//         //       PersistentNavBarNavigator.pushNewScreen(
//         //         context,
//         //         screen: HomeScreen(),
//         //         withNavBar: true, // OPTIONAL VALUE. True by default.
//         //         pageTransitionAnimation: PageTransitionAnimation.fade,
//         //       );
//         //     }
//         //   },
//         // ),
//         BlocListener<CommunicationBloc, CommunicationState>(
//           listener: (context, state) {
//             if (state is GetChatListLoading) {
//              customCupertinoLoading();
//              isload=false;
//             } else if (state is GetChatListSuccess) {
//               isloading=false;
//               isload=false;
//               setState(() {

//               });
//               }
//               else if(state is GetChatListFailed){
//                 isloading=true;
//                 isload=false;
//                 setState(() {
                  
//                 });
//               }
//           }
//           ),
          
//       ],
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: ColorPalette.primary,
//           tooltip: "Create group",
//           onPressed: () {
             
//             PersistentNavBarNavigator.pushNewScreen(
//               context,
//               screen: CreateAGroup(
//                 token: token,
//                 loginUserId: loginuserId,
//                 socket: socketCon,
//               ),
//               withNavBar: false, // OPTIONAL VALUE. True by default.
//               pageTransitionAnimation: PageTransitionAnimation.fade,
//             );
//           },
//           child: const Icon(
//             Icons.add,
//             size: 33,
//             color: Colors.white,
//           ),
//         ),
//        appBar: PreferredSize(
//   preferredSize: Size.fromHeight(60),
//   child: Column(
//     children: [
//       AppBar(
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           systemNavigationBarColor: Colors.white, // Navigation bar
//           statusBarColor: Colors.white, // Status bar
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: false,

//         title: Text(
//           "Communication",
//           style:  TextStyle(color: Colors.black,fontSize: w/22),
//         ),
//         titleSpacing: 10,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: SvgPicture.string(
//             AppsSvg().appbarIcon,
//           ),
//         ),
//         leadingWidth: 28,
        
//         actions: [
//           GestureDetector(
//             onTap: () {},
//             child: SvgPicture.string(
//               HomeSvg().addIcon2,
//               color: Colors.black,
//               height: h/45,
//               // width: 19,
//             )
//           ),
//         ],
//       ),
//       Container(
//         width: w,
//         height: 1.50,
//         decoration: const BoxDecoration(
//           color: Color(0xb2e6e6e6),
//         ),
//       ),
//     ],
//   ),
// ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: isload==false?
//             Column(
//               children: [
//               //  AppBarCommunication(token: token),
//                   Container(
//                     width: w,
//                     height: 1.50,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: const Color(0xb2e6e6e6),
//                         width: 0.80,
//                       ),
                   
//                     ),
//                   ),
//                   isloading==false?Column(
//                     children: [
                       
//                       // Padding(
//                       //   padding: const EdgeInsets.only(
//                       //       top: 12, bottom: 10, left: 10, right: 10),
//                       //   child: const PinnedProfile(),
//                       // ),
//                       // Divider(
//                       //   thickness: 4,
//                       //   color: Color(0xffEFF1F3),
//                       // ),
//                     Container(
//                     padding: EdgeInsets.all(10),
//                     width: w,
//                     child: Row(
//                       children: [
//                         // Container(
//                         //   width: 36,
//                         //   height: 36,
//                         //   decoration: BoxDecoration(
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     border: Border.all(
//                         //       color: const Color(0x4ca9a8a8),
//                         //       width: 1,
//                         //     ),
//                         //     color: const Color(0xfff8f7f5),
//                         //   ),
//                         //   child: const Icon(Icons.add),
//                         // ),
//                         ChatTypeList(
//                           token: token,
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                     ],
//                   ):Container(color: Color(0xffEFF1F3),),
                 
                 
//                   isloading==false? BlocBuilder<CommunicationBloc,
//                         CommunicationState>(
//                       builder: (context, state) {
//                         if (state is GetChatListLoading) {
//                           return customCupertinoLoading();
//                         } else if (state
//                             is GetChatListSuccess) {

//                       return  Container(
//                             width: w,
//                             // padding: const EdgeInsets.all(10),
//                             child:Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                  Padding(
//                                         padding: const EdgeInsets.all(10),
//                                         child: Column(
//                                           children: [
//                                             Align(
//                                               alignment:
//                                                   Alignment.centerLeft,
//                                               child: Text(
//                                                 "Recent Chat",
//                                                 style: GoogleFonts.roboto(
//                                                   color: const Color(
//                                                       0xff151522),
//                                                   fontSize: 18,
//                                                   fontWeight:
//                                                       FontWeight.w500,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 20,
//                                             ),
//                                             ListView.separated(
//                                               padding: EdgeInsets.zero,
//                                                 shrinkWrap: true,
//                                                 primary: false,
//                                                 itemCount:
//                                                     state.chatList.length,
//                                                 itemBuilder:
//                                                     (context, index) {
//                                                   // if (index == 0) {
//                                                   //   return ChatCard(
//                                                   //     onlineUsers:
//                                                   //         onlineUsers,
//                                                   //     loginUserId:
//                                                   //         loginuserId,
//                                                   //     token: token,
//                                                   //     socket: socketCon,
//                                                   //     communicationUserModel:
//                                                   //         state.chatList[
//                                                   //             index],
//                                                   //     isGroup: state
//                                                   //             .chatList[
//                                                   //                 index]
//                                                   //             .isGroupChat ??
//                                                   //         false,
//                                                   //   );
//                                                   // }
// //                                                   if(state.chatList[index].messages!.isEmpty){
// // return Container();
// //                                                   }

//                                                   return //state.chatList[index].messages!.isNotEmpty?
//                                                    ChatCard(
//                                                     onlineUsers:
//                                                         onlineUsers,
//                                                     loginUserId:
//                                                         loginuserId,
//                                                     socket: socketCon,
//                                                     isGroup: state
//                                                             .chatList[index]
//                                                             .isGroupChat ??
//                                                         false,
//                                                     token: token,
//                                                     communicationUserModel:
//                                                         state.chatList[
//                                                             index],
//                                                   );//:Container();
//                                                 },
//                                                 separatorBuilder:
//                                                     (context, index) =>
//                                                    // state.chatList[index].messages!.isNotEmpty?    
//                                                     Container(
//                                                           height: 22,
//                                                         )
//                                                         // :Container(
//                                                         //   // height: 22,
//                                                         // ),
//                                                 ),
//                                           ],
//                                         ),
//                                       ),
                          
//                               ])
//                                   );

//                                     } else if (state
//                                         is GetChatListFailed) {}
//                                     return LottieLoader();
//                                   },
//                                 ):Container(
//                                       color: Color(0xffEFF1F3),
//                                       height: MediaQuery.of(context)
//                                           .size
//                                           .height,
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 EdgeInsets.only(top: h / 5),
//                                             child: const Center(
//                                               child: SizedBox(
//                                                 // width: 197,
//                                                 // height: 23,
//                                                 child: Text(
//                                                   "You have’nt chat yet",
//                                                   style: TextStyle(
//                                                     color:
//                                                         Color(0xff151522),
//                                                     fontSize: 20,
//                                                     fontFamily: "Roboto",
//                                                     fontWeight:
//                                                         FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           InkWell(
//                                             onTap: () {
//                                               PersistentNavBarNavigator
//                                                   .pushNewScreen(
//                                                 context,
//                                                 screen: CmtnSearch(
//                                                     token: token),
//                                                 withNavBar:
//                                                     true, // OPTIONAL VALUE. True by default.
//                                                 pageTransitionAnimation:
//                                                     PageTransitionAnimation
//                                                         .fade,
//                                               );
//                                             },
//                                             child: Center(
//                                               child: Container(
//                                                 width: 150,
//                                                 height: 50,
//                                                 child: Center(
//                                                     child: Text(
//                                                   "Start Chatting",
//                                                   style: GoogleFonts.roboto(
//                                                     textStyle: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight
//                                                                 .w500),
//                                                   ),
//                                                 )),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           8),
//                                                   color: const Color(
//                                                       0xFF2871AF),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: h / 2.75,
//                                           ),
//                                           Column(
//                                             children: [
//                                               Text("Sidrateams LLC",
//                                                   style: GoogleFonts.roboto(
//                                                       textStyle: TextStyle(
//                                                           color:
//                                                               Colors.black,
//                                                           fontWeight:
//                                                               FontWeight
//                                                                   .w500,
//                                                           fontSize: 16))),
//                                               Text("version 1.1.5",
//                                                   style: GoogleFonts.roboto(
//                                                       textStyle: TextStyle(
//                                                           color:
//                                                               Colors.black,
//                                                           fontWeight:
//                                                               FontWeight
//                                                                   .w500,
//                                                           fontSize: 12))),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),

//                                 // //-----------------
//                                 // // ChatCard(isGroup: true,),
//                                 // SizedBox(
//                                 //   height: 16,
//                                 // ),
//                                 // ChatCard(),
//                                 // SizedBox(
//                                 //   height: 16,
//                                 // ),
//                                 // ChatCard(),
//                                 // SizedBox(
//                                 //   height: 16,
//                                 // ),
//                                 // ChatCard(),
//                                 // SizedBox(
//                                 //   height: 16,
//                                 // ),
//                                 // ChatCard(),
//                                 // SizedBox(
//                                 //   height: 16,
//                                 // ),
//                                 //  ChatCard(),
//                                 //------------
//         //                       body:  
//         //                           // SizedBox(height: 10,),
//         //                           // Text("Recent Chat"),
//         //                           ListView.separated(
//         //                             padding: EdgeInsets.all(10),
//         //                             itemCount:userlist.length,
//         //                             shrinkWrap: true,
//         //                             itemBuilder:(context, index) {
//         //                               return 
//         //                               userlist[index].isgrp != false?
//         //                               GestureDetector(
//         //                                 onTap: (){
//         //                                    PersistentNavBarNavigator.pushNewScreen(
//         //   context,
//         //   screen: ChatScreen(
//         //     token: token,
//         //     loginUserId: loginuserId,
//         //     socket: socketCon,
//         //     isGroup: false,
//         //     communicationUserModel: userlist[index],
//         //     refresh: refresh,
//         //   ),
//         //   withNavBar: false, // OPTIONAL VALUE. True by default.
//         //   pageTransitionAnimation: PageTransitionAnimation.fade,
//         // );
//         //                                 },
//         //                                 child: Card(
//         //                                   child: ListTile(
//         //                                     leading: Icon(Icons.person),
//         //                                     title: Text("${userlist[index].name}"),
                                                            
//         //                                   ),
//         //                                 ),
//         //                               ):Text("no data");
                                                        
//         //                                 }
//         //                                 ,
//         //                                 separatorBuilder: ( context,index)=>
//         //                                 userlist[index].id == userlist[index].id?
//         //                                 SizedBox(height:2,):SizedBox(),),
                                
//                               ],
//                       ):LottieLoader(),
//         ),
//       ),
//       )
//     );

//   }
// }

// class LongPolling {
//   String token;
//   LongPolling({required this.token});
//   Dio client = Dio();

//   Future<Response> longPoll() async {
//     final response = await client.get(CommunicationUrls.getChatList,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//           },
//         ));
//     return response;
//   }
// }

import 'dart:convert';
 
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/switch.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/core/utils/platform_check.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/search_screen.dart';
import 'package:cluster/presentation/comunication_module/communication_urls.dart';
import 'package:cluster/presentation/comunication_module/create_group.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummychatscreen.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/comunication_module/pinned_profile.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'appbar_cmtn.dart';
import 'chat_card.dart';
import 'chat_type_list.dart';
import 'dart:async';
import 'unread.dart';
import 'package:http/http.dart' as http;
 
class CommunicationModule extends StatefulWidget {
  // final String? token;
  final Socket? socket;
  const CommunicationModule({
    Key? key,
     this.socket,
  }) : super(key: key);
 
  @override
  State<CommunicationModule> createState() => _CommunicationModuleState();
}
 
class _CommunicationModuleState extends State<CommunicationModule> {
  Future<void>? _initializeSocket;
  List<UserDummyList> filteredList=[];
  bool isHomeMount = true;
  Dio client = Dio();
  String _data = '';
  List<CommunicationUserModel> chatList=[];
  List<UserDummyList>  ulist=[];
  List<UserDummyList> userlist = [];
 bool isMount = true;
 bool isloop=false;
  final List<String> onlineUsers = [];
  IO.Socket? socketCon;
  String? loginuserId;
 bool isload=false;
 String? token="";
 SharedPreferences? pref;
  Future<void> _getData() async {
    print("hi");
    final response = await client.get(CommunicationUrls.getChatList,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          },
        ));
 
    if (response.statusCode == 200) {
      print("hello");
          print("....${response}");
      // setState(() {
      //   _data = json.decode(response.data)['data'];
      // });
    }
    // Start the long polling process again
    // _getData();
  }
 
  @override
  void didChangeDependencies()  {
   
   _initializeSocket = getsocketconnect();
   
    super.didChangeDependencies();
  }

  Future<void> getsocketconnect() async {
    final socketpro =context.watch<scoketProvider>();
        socketCon =socketpro.socket;
    pref=await SharedPreferences.getInstance();
    token = pref!.getString("token");
    loginuserId=pref!.getString("loginuserid");
    print("tooken ${token}");
  // IO.Socket socket = IO.io(
  //       'https://api-communication-application.hilalcart.com/home',
  //       // "http://192.168.1.20:5500/home",
  //       // 'https://baf9-103-179-197-125.ngrok-free.app/',
  //       // OptionBuilder().setTransports(['websocket']).setQuery({
  //       //   'transports': ['websocket', 'polling'],
  //       //   'auth': {'token': token.toString()},
  //       //   'autoConnect': false,
  //       // }).build());
  //       <String, dynamic>{
  //         'transports': ['websocket'],
  //         'auth': {'token': token.toString()},
  //         'autoConnect': false,
  //       });
    // socket.connect();
  // IO.Socket socket = IO.io(
  //       'https://api-communication-application.hilalcart.com/home',
  //       // "http://192.168.1.20:5500/home",
  //       // 'https://baf9-103-179-197-125.ngrok-free.app/',
  //       // OptionBuilder().setTransports(['websocket']).setQuery({
  //       //   'transports': ['websocket', 'polling'],
  //       //   'auth': {'token': token.toString()},
  //       //   'autoConnect': false,
  //       // }).build());
  //       <String, dynamic>{
  //         'transports': ['websocket'],
  //         'auth': {'token': token.toString()},
  //         'autoConnect': false,
  //       });
  //   socket.connect();

  //   setState(() {
  //     print("ccccconneccct");
  //   });
    // Handle socket events
  
 
 
    socketCon!.on('online', (data) {
      print("online anutto ${data}");
      onlineUsers.add(data['id']);
      // if (isHomeMount) {
      setState(() {});
      // }
      print("online anutto users data ${onlineUsers}");
    });
    print(onlineUsers);
    socketCon!.on('offline', (data) {
      // print("online anutto poyetto  ${data}");
      onlineUsers.remove(data['id']);
      // if (isHomeMount) {
      setState(() {});
      // }
    });
    socketCon!.on('user.id', (data) {
      loginuserId = data;
      print("vgyvgvh$loginuserId");
      setState(() {});
    });
     socketCon!.on('friends.list',(data){
       print("hello");
                  print("Friends list $data");
                //   ulist = UserDummyList.fromJson(data);
                // userlist.add(ulist!);
                userlist.clear();
                  (data as List).forEach((element) { 
                  userlist.add(UserDummyList.fromJson(element));
                  
                   });
                  if(mounted){
                     print("hgfjh");
                     
                    setState(() {
                      
                      if(userlist.isNotEmpty){

                      isload=true;
                      isloop=true;
                          
                      }else{
                        isload=false;
                        isloop=true;
                      }
                       
                  });
                  }
               
                // userlist=userlist.toSet().toList();
               
                // print("mkkk ${userlist}");
              });
    socketCon!.emit("update.list",{
      
                        print("update")

                        
                      });
   
   socketCon!.on("update.chat.list", (data) {
      print("updata.chat.list $data");
       
    print("friends..chatlist");
      socketCon!.emit("update.list",{
      
                        print("update")
                        
                      });
  //  socket.on("friends.update", (data) {
  //       print(data);
  //       print("upppppdate,,,,,");
         setState(() {
       socketCon!.on('friends.list',(data){
       
       print("hello");
       print("upppppdate,,,,,");
                  print("Friends list $data");
                //   ulist = UserDummyList.fromJson(data);
                // userlist.add(ulist!);
                userlist.clear();
                  (data as List).forEach((element) {
                    
                  userlist.add(UserDummyList.fromJson(element));
                   });
                  if(mounted){
                     print("hgfjh");
                    setState(() {
                      if(userlist.isNotEmpty){
                          isload=true;
                          isloop=true;
                      }else{
                        isload=false;
                        isloop=true;
                      }
                       
                  });
                  }
               
                // userlist=userlist.toSet().toList();
               
                // print("mkkk ${userlist}");
              // });
              print("upppppdate,,,,,1");
       if(isMount){
        setState(() {
          
        });
       }
          
        });
          });
      } );
   
   
   

    // socket.on('move.chat.to.top', (data) {
    //   // print("online anutto poyetto  ${data}");
    //   onlineUsers.remove(data['id']);
    //   // if (isHomeMount) {
    //   setState(() {});
    //   // }
    // });
    // socket.on("latest.message", (data) => print("homescreen latest message $data"));
    // socket.on('latest.message', (data) => streamSocket.addResponse);
    // socket.onDisconnect((_) => print('disconnect happened'));

    // socket.disconnect();
setState(() {
  
});
  }

  @override
  void dispose() {
    isMount = false;
    super.dispose();
  }
  String searchtext="";
  TextEditingController searchController = TextEditingController();
  // bool isrefresh= false;
  // void refresh(bool val){
  //   isrefresh=val;
  //   setState(() {
  //    socketCon!.emit("update.list",{
  //                       print("update")
  //                     });
  //   });
  // }
 
  @override
  Widget build(BuildContext context) {
    print("builddd");
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF2871AF),
          tooltip: "Create group",
          onPressed: () {
        isMobile?    PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: CreateAGroup(
                token: token,
                loginUserId: loginuserId,
                socket: socketCon,
              ),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            ):
        objectGlobal=   objectGlobal.changeScreen(current:
        CreateAGroup(
          token: token,
          loginUserId: loginuserId,
          socket: socketCon,
        ),
            previous: this.widget,tabIndex: -1);
        print(objectGlobal.existing);
        objectGlobal.changeData();


        // chabeTAbIndex(4,
        //     token: token,
        //     loginUserId: loginuserId,
        //     socket: socketCon,);
          },
          child: const Icon(Icons.add,size: 32,color: Colors.white,),
        ),
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(60),
        //     child: Column(
        //       children: [
        //         AppBar(
        //           surfaceTintColor: Colors.white,
        //           systemOverlayStyle: const SystemUiOverlayStyle(
        //             systemNavigationBarColor: Colors.white, // Navigation bar
        //             statusBarColor: Colors.white, // Status bar
        //           ),
        //           elevation: 0,
        //           backgroundColor: Colors.white,
        //           centerTitle: false,
        //
        //           title: Text(
        //             "Communication",
        //             style:  TextStyle(color: Colors.black,fontSize: w/22),
        //           ),
        //           titleSpacing: 10,
        //           leading: Padding(
        //             padding: const EdgeInsets.only(left: 10),
        //             child: SvgPicture.string(
        //               AppsSvg().appbarIcon,
        //             ),
        //           ),
        //           leadingWidth: 28,
        //           // actions: [
        //           //   // Padding(
        //           //   //   padding: const EdgeInsets.only(top: 12,left: 16),
        //           //   //   child: InkWell(
        //           //   //     onTap: (){},
        //           //   //     //   if(activeTextfield==true){
        //           //   //     //     context.read<ProfileBloc>().add(UpdateProfileEvent(
        //           //   //     //       mobile: mobileController.text,
        //           //   //     //       lname: "",
        //           //   //     //       fname: nameController.text,
        //           //   //     //       dob: "",
        //           //   //     //       email: emailController.text,
        //           //   //     //
        //           //   //     //     ));
        //           //   //     //   }
        //           //   //     //   else{
        //           //   //     //
        //           //   //     //   }
        //           //   //     //   myfocus.unfocus();
        //           //   //     //   myfocus1.unfocus();
        //           //   //     //   myfocus2.unfocus();
        //           //   //     //   activeTextfield=false;
        //           //   //     // },
        //           //   //     child: Text(
        //           //   //       "Save",
        //           //   //       style: GoogleFonts.roboto(
        //           //   //         color: activeTextfield==true?Color(0xFF2871AF):Color(0xFFD3D3D3),
        //           //   //         fontSize: 18,
        //           //   //         fontWeight: FontWeight.w500,
        //           //   //         height: 1.56,
        //           //   //       ),
        //           //   //     ),
        //           //   //   ),
        //           //   // ),
        //           //
        //           //
        //           //   // SvgPicture.string(HomeSvg().msgIcon),
        //           //   //         const SizedBox(
        //           //   //           width: 16,
        //           //   //         ),
        //           //   //         GestureDetector(
        //           //   //           onTap: widget.onTap,
        //           //   //             child: SvgPicture.string(HomeSvg().addIcon)),
        //           //
        //           //   const SizedBox(
        //           //     width: 16,
        //           //   )
        //           // ],
        //         ),
        //         Container(
        //           width: w,
        //           height: 1.50,
        //           decoration: const BoxDecoration(
        //             color: Color(0xb2e6e6e6),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // body: SafeArea(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
                // AppBarCommunication(token: widget.token),
        //         Container(
        //           width: w,
        //           height: 1.50,
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //               color: const Color(0xb2e6e6e6),
        //               width: 0.50,
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 16,
        //         ),
        //         const PinnedProfile(),
        //         const SizedBox(
        //           height: 16,
        //           child: Divider(
        //             thickness:4,
        //             color: Color(0x33D3D3D3),
        //             ),
        //         ),
        //         Container(
        //           width: w,
        //           padding: const EdgeInsets.only(left: 8),
        //           child: Row(
        //             children: [
        //               // Container(
        //               //   width: 36,
        //               //   height: 36,
        //               //   decoration: BoxDecoration(
        //               //     borderRadius: BorderRadius.circular(10),
        //               //     border: Border.all(
        //               //       color: const Color(0x4ca9a8a8),
        //               //       width: 1,
        //               //     ),
        //               //     color: const Color(0xfff8f7f5),
        //               //   ),
        //               //   child: const Icon(Icons.add),
        //               // ),
                     
        //               ChatTypeList(
        //                 token: widget.token,
        //               )
        //             ],
        //           ),
        //         ),
        //          const SizedBox(
        //           height: 16,
        //         ),
        //         Container(
        //           width: w,
        //           padding: const EdgeInsets.only(top:16,right:5,left:10,bottom: 10),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               BlocBuilder<CommunicationBloc, CommunicationState>(
        //                 builder: (context, state) {
        //                   if (state is GetChatListLoading) {
        //                     return customCupertinoLoading();
        //                   } else if (state is GetChatListSuccess) {
        //                     return Column(
        //                       children: [
        //                         Align(
        //                           alignment: Alignment.centerLeft,
        //                           child: Text(
        //                             "Recent Chat",
        //                             style: GoogleFonts.roboto(
        //                               color: const Color(0xff151522),
        //                               fontSize: 18,
        //                               fontWeight: FontWeight.w500,
        //                             ),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           height: 20,
        //                         ),
        //                         ListView.separated(
        //                             shrinkWrap: true,
        //                             primary: false,
        //                             itemBuilder: (context, index) {
        //                               if (index == 0) {
       
        //                                 return
        //                                 ChatCard(
        //                                   onlineUsers: onlineUsers,
        //                                   loginUserId: loginuserId,
        //                                   token: widget.token,
        //                                   socket: socketCon,
        //                                   communicationUserModel:
        //                                       state.chatList[index],
        //                                   isGroup:
        //                                       state.chatList[index].isGroupChat ??
        //                                           false,
        //                                 );
        //                               }
        //                               return ChatCard(
        //                                 onlineUsers: onlineUsers,
        //                                 loginUserId: loginuserId,
        //                                 socket: socketCon,
        //                                 isGroup:
        //                                     state.chatList[index].isGroupChat ??
        //                                         false,
        //                                 token: widget.token,
        //                                 communicationUserModel:
        //                                     state.chatList[index],
        //                               );
        //                             },
        //                             separatorBuilder: (context, index) =>
        //                                 Container(
        //                                   height: 22,
        //                                 ),
        //                             itemCount: state.chatList.length),
        //                       ],
        //                     );
        //                   } else if (state is GetChatListFailed) {}
        //                   return SizedBox(
        //                     height: MediaQuery.of(context).size.height / 2,
        //                     child: Column(
        //                       // crossAxisAlignment: CrossAxisAlignment.center,
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         const Center(
        //                           child: SizedBox(
        //                             // width: 197,
        //                             // height: 23,
        //                             child: Text(
        //                               "You have’nt chat yet",
        //                               style: TextStyle(
        //                                 color: Color(0xff151522),
        //                                 fontSize: 19,
        //                                 fontFamily: "Roboto",
        //                                 fontWeight: FontWeight.w500,
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           height: 20,
        //                         ),
        //                         InkWell(
        //                           onTap: () {
        //                             PersistentNavBarNavigator.pushNewScreen(
        //                               context,
        //                               screen: CmtnSearch(token: widget.token),
        //                               withNavBar:
        //                                   true, // OPTIONAL VALUE. True by default.
        //                               pageTransitionAnimation:
        //                                   PageTransitionAnimation.fade,
        //                             );
        //                           },
        //                           child: Center(
        //                             child: Container(
        //                               width: 150,
        //                               height: 50,
        //                               child: Center(
        //                                   child: Text(
        //                                 "Start Chatting",
        //                                 style:GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
        //                               )),
        //                               decoration: BoxDecoration(
        //                                 borderRadius: BorderRadius.circular(8),
        //                                 color: const Color(0xFF2871AF),
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   );
        //                 },
        //               ),
        //               // ChatCard(isGroup: true,),
        //               // SizedBox(
        //               //   height: 16,
        //               // ),
        //               // ChatCard(),
        //               // SizedBox(
        //               //   height: 16,
        //               // ),
        //               // ChatCard(),
        //               // SizedBox(
        //               //   height: 16,
        //               // ),
        //               // ChatCard(),
        //               // SizedBox(
        //               //   height: 16,
        //               // ),
        //               // ChatCard(),
        //               // SizedBox(
        //               //   height: 16,
        //               // ),
        //               //  ChatCard(),
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
         body:  
                         isloop==false?LottieLoader():           // SizedBox(height: 10,),
                                    // Text("Recent Chat"),
                               SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:10,left:10,bottom:10,right:5),
                                        child:isload==true? SizedBox(
                                          // height: MediaQuery.of(context).size.height*1,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: SearchCard(hint: "Search User ...",
                                                    controller: searchController,
                                                    onchange: (val){
                                                      setState(() {
                                                        searchtext=val;

                                                        filteredList = userlist.where((user) {
                                                          return user.name?.toLowerCase().contains(searchtext.toLowerCase()) ?? false;
                                                        }).toList();
                                                      });
                                                    },
                                                    isCollection: true,
                                                    onTap1: (){
                                                      searchtext="";
                                                      searchController.clear();
                                                      setState(() {

                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              // AppBarCommunication(token: widget.token),
                                              // SizedBox(height: 10,),
                                              // ChatTypeList(
                                              //   token:token,
                                              // ),
                                              SizedBox(height: 10,),
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
                                              searchtext!=""? ListView.separated(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  // padding: EdgeInsets.all(10),
                                                  itemCount:filteredList.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:(context, index) {
                                                    return //userlist[index].latestMessage!=null?
                                                      ChatCard(
                                                          onlineUsers: onlineUsers,
                                                          loginUserId: loginuserId,
                                                          token: token,
                                                          socket: socketCon,
                                                          communicationUserModel:
                                                          filteredList[index],
                                                          isGroup:
                                                          filteredList[index].isgrp ?? true
                                                      );
                                                  }
                                                  ,
                                                  separatorBuilder: ( context,index)=>
                                                  //userlist[index].latestMessage!=null?
                                                  SizedBox(height:15,)//:SizedBox()
                                              ):   ListView.separated(
                                                physics: NeverScrollableScrollPhysics(),
                                                // padding: EdgeInsets.all(10),
                                                itemCount:userlist.length,
                                                shrinkWrap: true,
                                                itemBuilder:(context, index) {
                                                  return //userlist[index].latestMessage!=null?
                                                  ChatCard(
                                                    onlineUsers: onlineUsers,
                                                    loginUserId: loginuserId,
                                                    token: token,
                                                    socket: socketCon,
                                                    communicationUserModel:
                                                        userlist[index],
                                                    isGroup:
                                                      userlist[index].isgrp ?? true
                                                  );
                                                    }
                                                    ,
                                                    separatorBuilder: ( context,index)=>
                                                    //userlist[index].latestMessage!=null?
                                                    SizedBox(height:15,)//:SizedBox()
                                                    ),
                                            ],
                                          ),
                                        ):SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Center(
                                  child: SizedBox(
                                    // width: 197,
                                    // height: 23,
                                    child: Text(
                                      "You have’nt chat yet",
                                      style: TextStyle(
                                        color: Color(0xff151522),
                                        fontSize: 19,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500,
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
                                      screen: CreateAGroup(
                                        token: token,
                                        loginUserId: loginuserId,
                                        socket: socketCon,
                                      ),
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
                                        style:GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
                                      )),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFF2871AF),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                                      ),
                                    )
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
