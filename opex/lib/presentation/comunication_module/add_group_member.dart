import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_profile_screen.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/comunication_module/create_chatgroup.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/comunication_module/newgroup.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';
import  'package:cluster/presentation/task_operation/employee_card.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';

class AddGroupMembers extends StatefulWidget {
  final String? token;
  final String? chatid;
  bool isGroup;
  final UserDummyList? communicationUserModel;
  final Socket? socket;
  AddGroupMembers({Key? key, 
  this.token,
  this.chatid,
  this.isGroup = false,
      this.communicationUserModel,
      this.socket,
  })
      : super(key: key);

  @override
  State<AddGroupMembers> createState() => _AddGroupMembersState();
}

class _AddGroupMembersState extends State<AddGroupMembers> {
  bool changeUi = false;
  List<CommunicationUserModel> chatlist=[];
  String email1='';
  String? uid='';
  bool val=true;
  // var _listGenderText = ["Users", "Groups"];
  // var _tabTextIconIndexSelected = 0;
  @override
  void initState() {
    //  BlocProvider.of<
    //   GroupBloc>(context).add(
    //     GetAllRegisteredUsersEvent(widget.token ?? "")
    //   );
       BlocProvider.of<CommunicationBloc>(context).add(
          GetFilterdChatListEvent(
            token: widget.token ?? "",
            chatFilter: "chats"
          ));  


          //  widget.socket!.on("userAddedToGroup", (data) {

          //     print("user $data");
          //       showSnackBar(context,
          //     message: "User Add To Group Successfully", color: ColorPalette.primary);
          //   } 
            
          // );         
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return 
      BlocProvider(
      create: (context) =>
            GroupBloc()..add(GetAllRegisteredUsersEvent(widget.token ?? "")), 
      child: MultiBlocListener(
       listeners: [
      //   BlocListener<CommunicationBloc,CommunicationState>( 
      //   listener: (context, state) {
      //     print("state found ${state}");
      //      if (state is AddAFriendUserSuccess) {
      //       print("add friend success");
      //       val=false;
         
      //       // Navigator.pop(context); 
      //       // BlocProvider.of<CommunicationBloc>(context).add(
      //       //         GetFilterdChatListEvent(
      //       //           token: widget.token ?? "",
      //       //           chatFilter: "chats"
      //       //         ));                 
      //       // showSnackBar(context,
      //       //     message: state.successMessage, color: Colors.green);
      //       //           getlist(email1);
      //     } else if(state is AddAFriendUserFailed) {
      //       showSnackBar(context, message: state.error, color: Colors.red);
      //     }
      //   },
        
      //  ),
         BlocListener<CommunicationBloc, CommunicationState>(
            listener: (context, state) {
              print("state found ${state}");
              if (state is GetChatListLoading) {
               customCupertinoLoading();
              } 
              else if (state is GetChatListSuccess) {
                print("sucesss ${state.chatList.length}");
                chatlist=state.chatList;
                setState(() {
                });
                }
                else if(state is GetChatListFailed){
                  print("faileddddddd");
                  setState(() {
                    
                  });
                }
            }
            ),
            BlocListener<GroupBloc,GroupState>(
              listener: (context, state){
                if(state is GroupMemberAddLoading){
                      print("loading");
                }
                  else if(state is GroupMemberAddSuccess){
                    BlocProvider.of<GroupBloc>(context)
              .add(GetAllRegisteredUsersEvent(widget.token ?? ""));
                    print("success");
                    widget.socket!.emit("updategroup.list",{widget.chatid,uid});
                    widget.socket!.on("group.update", (data) => print("update"));
                    showSnackBar(context,
                message: state.successmsg, color: Colors.green);
                  }
                  else if(state is GroupMemberAddFailed){
                    BlocProvider.of<GroupBloc>(context)
              .add(GetAllRegisteredUsersEvent(widget.token ?? ""));
                    showSnackBar(context,
                message: state.error, color: Colors.red);
    
                  }
              }
              
              )
        
       ],
               
          child: Scaffold(
            appBar: AppBar(
               leading: BackButton(
                onPressed: () {
                  print("hello");
                 
                  setState(() {
                    widget.socket!.emit("group.members",{widget.chatid,uid});
                     widget.socket!.on("groupmembers.result", (data) => print("update"));
                      widget.socket!.emit("update.list",{
                      widget.socket!.on("friends.update", (data) => print(data)),
                                        print("update")
                                      });
                  Navigator.pop(context);
                  });
                  // BlocProvider.of<CommunicationBloc>(context)
                  //     .add(GetChatListEvent(token: widget.token ?? ""));
                },
                color: Colors.black,
              ),
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                elevation: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  systemNavigationBarColor: Colors.white, // Navigation bar
                  statusBarColor: Colors.white, // Status bar
                ),
                backgroundColor: Colors.white,
                title: Container(
                  height: 44,
                  child: TextFormField(
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        changeUi = true;
                        setState(() {});
                        BlocProvider.of<CommunicationBloc>(context).add(
                            GetSearchedUserEvent(
                                searchQuery: val, token: widget.token ?? ""));
                      }else{
                        changeUi=false;
                      }
                    },
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffe6ecf0),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xfff8f7f5),
                        hintText: "Search ...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )),
            body: ScrollConfiguration(
              behavior: NoGlow(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     PersistentNavBarNavigator.pushNewScreen(
                    //       context,
                    //       screen:CreateChatGroup(token: widget.token,),//NewGroup(token: widget.token),
                    //       withNavBar: false, // OPTIONAL VALUE. True by default.
                    //       pageTransitionAnimation: PageTransitionAnimation.fade,
                    //     );
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.all(16),
                    //     padding: const EdgeInsets.all(16),
                    //     width: w,
                    //     height: 70,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Color.fromARGB(255, 240, 242, 245),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           width: 37.14,
                    //           height: 37.14,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(50),
                    //             color: ColorPalette.primary,
                    //           ),
                    //           alignment: Alignment.center,
                    //           child: SvgPicture.string(
                    //             CommunicationSvg().groupIcon,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Create new group",
                    //           style: GoogleFonts.roboto(
                    //             color: ColorPalette.black,
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    changeUi
                        ? BlocBuilder<CommunicationBloc, CommunicationState>(
                            builder: (context, state) {
                            if (state is GetSearchedUsersLoading) {
                            } else if (state is GetSearchedUsersSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 20, bottom: 16),
                                    child: Text(
                                      "${state.searchedUsers.length.toString()} Contacts",
                                      style: GoogleFonts.roboto(
                                        color: const Color(0xff151522),
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 8,
                                          );
                                        },
                                        shrinkWrap: true,
                                        itemCount: state.searchedUsers.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              BlocProvider.of<
                                                      CommunicationBloc>(context)
                                                  .add(
                                                      AddAFriendUserEvent(
                                                          token:
                                                              widget.token ?? "",
                                                          email: state
                                                                  .searchedUsers[
                                                                      index]
                                                                  .email ??
                                                              "",
                                                          fname: state
                                                                  .searchedUsers[
                                                                      index]
                                                                  .fname ??
                                                              "",
                                                          lname: state
                                                                  .searchedUsers[
                                                                      index]
                                                                  .lname ??
                                                              "",
                                                          photo: state
                                                                  .searchedUsers[
                                                                      index]
                                                                  .profile ??
                                                              "",
                                                              usercode: state.searchedUsers[index].userCode??""));
    
                                                            
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const CircleAvatar(),
                                                      const SizedBox(
                                                        width: 10,
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
                                                                    .searchedUsers[
                                                                        index]
                                                                    .fname ??
                                                                "",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color: const Color(
                                                                  0xff151522),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            state
                                                                    .searchedUsers[
                                                                        index]
                                                                    .email ??
                                                                "",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff6d6d6d),
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  // index < 3
                                                  //     ? Container(
                                                  //         width: 28,
                                                  //         height: 28,
                                                  //         decoration: BoxDecoration(
                                                  //           borderRadius:
                                                  //               BorderRadius.circular(
                                                  //                   30),
                                                  //           color:
                                                  //               const Color(0xfffe5762),
                                                  //         ),
                                                  //         child: Center(
                                                  //           child: Text(
                                                  //             "15",
                                                  //             style: GoogleFonts.outfit(
                                                  //               color: Colors.white,
                                                  //               fontSize: 14,
                                                  //               fontWeight:
                                                  //                   FontWeight.w600,
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       )
                                                  //     : Container()
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          })
                        : BlocBuilder<GroupBloc, GroupState>(
                            builder: (context, state) {
                              if (state is GetAllRegisteredUsersLoading) {
                                return customCupertinoLoading();
                              } else if (state is GetAllRegisteredUsersSuccess) {
                                return Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 10, bottom: 16),
                                        child: Text(
                                          "${state.registeresUsers.length} Contacts",
                                          style: GoogleFonts.roboto(
                                            color: const Color(0xff151522),
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ListView.separated(
                                        padding:EdgeInsets.only(left: 16,right: 16) ,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => InkWell(
                                              onTap: () {
                                                 
                                                email1=state.registeresUsers[index].email!;
                                                 String? cid='';
                                                 String uuid='';
                                                setState((){
                                               
                                                    widget.socket!.emit("userAddToGroup",{
                                                      "userCode": "${state.registeresUsers[index].userCode}",
                                                     "chatId": widget.chatid.toString() });
                                                   print("hjkl");
                                                     
                                                   widget.socket?.on("update.chat.list", (data) => print("fxgf  $data"));
                                                   widget.socket!.emit("group.message",{
                                                    "type": "notify", "chatid": widget.chatid, "content": "${state.registeresUsers[index].fname.toString().toTitleCase()} ${state.registeresUsers[index].lname} is added to group"
                                                  });

                                                widget.socket!.on("userAlreadyInGroup", (data) {
                                                  showSnackBar(context,
                                                  message: "Already in Group", color: ColorPalette.primary);
                                                
                                                });
                                                
                                                 widget.socket!.on("userAddedToGroup", (data) {     
                                                  print("user $data");
                                                   showSnackBar(context,
                                                  message: "User Add To Group Successfully", color: ColorPalette.primary);
                                                  
                                                } 
                                               
                                              );
                                              
                                                });
                                               
                                               
                                                
                                              },
                                              child: EmployeeCard(employeeList: state.registeresUsers[index],)
                                              // Container(
                                              //   padding:
                                              //       const EdgeInsets.symmetric(
                                              //           horizontal: 10),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       Row(
                                              //         children: [
                                              //           const CircleAvatar(),
                                              //           const SizedBox(
                                              //             width: 10,
                                              //           ),
                                              //           Column(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .start,
                                              //             crossAxisAlignment:
                                              //                 CrossAxisAlignment
                                              //                     .start,
                                              //             children: [
                                              //               Text(
                                              //                 state
                                              //                         .registeresUsers[
                                              //                             index]
                                              //                         .name ??
                                              //                     "",
                                              //                 style: GoogleFonts
                                              //                     .roboto(
                                              //                   color: const Color(
                                              //                       0xff151522),
                                              //                   fontSize: 18,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .w500,
                                              //                 ),
                                              //               ),
                                              //               Text(
                                              //                 state
                                              //                         .registeresUsers[
                                              //                             index]
                                              //                         .mail ??
                                              //                     "",
                                              //                 style:
                                              //                     const TextStyle(
                                              //                   color: Color(
                                              //                       0xff6d6d6d),
                                              //                   fontSize: 14,
                                              //                 ),
                                              //               )
                                              //             ],
                                              //           )
                                              //         ],
                                              //       ),
                                              //       index < 0
                                              //           ? Container(
                                              //               width: 28,
                                              //               height: 28,
                                              //               decoration:
                                              //                   BoxDecoration(
                                              //                 borderRadius:
                                              //                     BorderRadius
                                              //                         .circular(
                                              //                             30),
                                              //                 color: const Color(
                                              //                     0xfffe5762),
                                              //               ),
                                              //               child: Center(
                                              //                 child: Text(
                                              //                   "15",
                                              //                   style: GoogleFonts
                                              //                       .outfit(
                                              //                     color: Colors
                                              //                         .white,
                                              //                     fontSize: 14,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w600,
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             )
                                              //           : Container()
                                              //     ],
                                              //   ),
                                              // ),
                                            ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height:5,
                                            ),
                                        itemCount: state.registeresUsers.length),
                                    SizedBox(
                                      height: 50,
                                    )
                                  ],
                                );
                              } else if (state is GetAllRegisteredUsersFailed) {}
                              return Container();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  

}
