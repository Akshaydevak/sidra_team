import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/create_chatgroup.dart';
import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/comunication_module/newgroup.dart';
import 'package:cluster/presentation/mpos/search_card.dart';
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

class CreateAGroup extends StatefulWidget {
  final String? token;
  final String? loginUserId;
  final Socket? socket;
  const CreateAGroup({Key? key, this.token, this.loginUserId, this.socket})
      : super(key: key);

  @override
  State<CreateAGroup> createState() => _CreateAGroupState();
}

class _CreateAGroupState extends State<CreateAGroup> {
  bool changeUi = false;
  List<CommunicationUserModel> chatlist=[];
  String email1='';
  bool val=true;
  // var _listGenderText = ["Users", "Groups"];
  // var _tabTextIconIndexSelected = 0;
  @override
  void initState() {
    context.read<GroupBloc>().add(GetAllRegisteredUsersEvent(""));
  
BlocProvider.of<CommunicationBloc>(context).add(
          GetFilterdChatListEvent(
            token: widget.token ?? "",
            chatFilter:"chats"
          ));
      
                 
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return MultiBlocListener(
     listeners: [
      BlocListener<CommunicationBloc,CommunicationState>( 
      listener: (context, state) {
        print("state found ${state}");
         if (state is AddAFriendUserSuccess) {
          print("add friend success");
          val=false;
        PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: ChatScreen(
          token: widget.token,
          loginUserId:widget.loginUserId,
          socket:widget.socket,
          isGroup:false,
          chat: true,
          communicationuser:state.chatListData1,
        ),
        );
          // Navigator.pop(context); 
          // BlocProvider.of<CommunicationBloc>(context).add(
          //         GetFilterdChatListEvent(
          //           token: widget.token ?? "",
          //           chatFilter: "chats"
          //         ));                 
         
          //           getlist(email1);
        } else if(state is AddAFriendUserFailed) {
          showSnackBar(context, message: state.error, color: Colors.red);
        }
      },
      // listenWhen: ,
     ),
       BlocListener<CommunicationBloc, CommunicationState>(
          listener: (context, state) {
            if (state is GetChatListLoading) {
             customCupertinoLoading();
            } 
            else if (state is GetChatListSuccess) {
              print("sucesss ${state.chatList[0].email}");
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
      
     ],
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
           leading: BackButton(
            onPressed: () {
              
              Navigator.pop(context);
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
            title: Text("New Message",style:  TextStyle(color: Colors.black,fontSize: w/22))
            ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen:CreateChatGroup(token: widget.token,socket: widget.socket,loginUserId: widget.loginUserId),//NewGroup(token: widget.token),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    width: w,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 240, 242, 245),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 37.14,
                          height: 37.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ColorPalette.primary,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.string(
                            CommunicationSvg().groupIcon,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Create new group",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchCard(hint: "Search User ...",
                    onchange: (val){
                    context.read<GroupBloc>().add(GetAllRegisteredUsersEvent(val.toString()));
                    setState(() {
                      
                    });
                  }),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(15),
                //   child: TextFormField(
                //   onChanged: (val) {
                //     print("sruthy $ValueKey");
                //     context.read<GroupBloc>().add(GetAllRegisteredUsersEvent(val.toString()));
                                 
                //             setState(() {
                              
                //             });
                //     // if (val.isNotEmpty) {
                //     //   changeUi = true;
                //     //   setState(() {});
                //     //   BlocProvider.of<CommunicationBloc>(context).add(
                //     //       GetSearchedUserEvent(
                //     //           searchQuery: val, token: widget.token ?? ""));
                //     // }else{
                //     //   changeUi=false;
                //     // }
                //   },
                //   textAlign: TextAlign.justify,
                //   decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0xffe6ecf0),
                //         ),
                //       ),
                //       filled: true,
                //       fillColor: const Color(0xfff8f7f5),
                //       hintText: "Search ...",
                //       hintStyle: TextStyle(color: Colors.grey),
                //       border: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.transparent,
                //           ),
                //           borderRadius: BorderRadius.circular(10))),
                //                 ),
                // ),
                 BlocBuilder<GroupBloc, GroupState>(
                        builder: (context, state) {
                          
                          if (state is GetAllRegisteredUsersLoading) {
                            return customCupertinoLoading();
                          } else if (state is GetAllRegisteredUsersSuccess) {
                            print("got the responsee ${state.registeresUsers.length}");
                            print("sjsd ${authentication.authenticatedUser.code}");
                            for(int i=0;i<state.registeresUsers.length;){
                              // print();
                              if(authentication.authenticatedUser.code==state.registeresUsers[i].userCode){
                                      state.registeresUsers.removeAt(i);
                                      }
                                i++;
                            }
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
                                     itemCount: state.registeresUsers.length,
                                    itemBuilder: (context, index) {
                                      
                                     return InkWell(
                                          onTap: () {
                                             
                                            email1=state.registeresUsers[index].email!;
                                             
                                            setState(()async{
                                              bool val1=false;
                                              int id=1;
                                              int i1=0;
                                              print("1-------------$val");
                                            print("llllll${chatlist.length}}");
                                            if(chatlist.isNotEmpty){
                                            for(int i=0; i<=chatlist.length;i++){
                                              print(chatlist[i].users!.length);
                                              for(int j=0; j<=chatlist[i].users!.length;j++){ 
                                                print(" $i");
                                              print(val);
                                                if(chatlist[i].users?[j].email==email1){ 
                                                  val1=true;
                                                  i1=i;
                                                  BlocProvider.of<ChatBloc>(context).add(ChatScreenGetEvent(
                                                  token: widget.token ?? "",
                                                  // userId: chatlist[i].id ?? "",
                                                  pageNo: 1, chatId: chatlist[i].id??""));
                                                  print(",.,.,.,$i...$val1");
                                                break;
                                                }
                                                else{
                                                  val1=false;
      
                                                j++;
                                                    id++;
                                                }
                                                  
                                                  } 
                                                  if(val1==true){
                                                  break; 
                                                  }
                                                  else if(id>chatlist.length){
                                                    break;
                                                  }
                                                } 
                                            }
                                            else{
                                              val1=false;
                                            } 
                                                print("...$val1");
                                            print("2-------------$val1");
                                            
                                               val1==false? 
                                                
                                            BlocProvider.of<
                                                        CommunicationBloc>(
                                                    context)
                                                .add(AddAFriendUserEvent(
                                              token: widget.token ?? "",
                                              email: state
                                                      .registeresUsers[index]
                                                      .email ??
                                                  "",
                                              fname: state
                                                      .registeresUsers[index]
                                                      .fname ??
                                                  "",
                                              photo: state
                                                      .registeresUsers[index].userMete
                                                      ?.profile ??
                                                  "",
                                              lname: state
                                                      .registeresUsers[index]
                                                      .lname ??
                                                  "",
                                                 usercode: state.registeresUsers[index].userCode??"" 
                                            ))
                                            :val1==true?
                                             
                                                PersistentNavBarNavigator.pushNewScreen(
                                                context,
                                                screen: ChatScreen(
                                                  token: widget.token,
                                                  loginUserId:widget.loginUserId,
                                                  socket:widget.socket,
                                                  isGroup:false,
                                                  chat: true,
                                                  communicationuser:chatlist[i1],
                                                ),
                                                withNavBar:
                                                    false, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation.fade,
                                              ):null;
                                            }); 
                                          },
                                          child: EmployeeCard(employeeList: state.registeresUsers[index],isCommunicate:true,)
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
                                        );
                          },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height:5,
                                        ),
                                   ),
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
    );
  }

  

}
