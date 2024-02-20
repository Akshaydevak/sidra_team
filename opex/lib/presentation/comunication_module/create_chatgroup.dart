import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/create_chatgrplist.dart';
import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
import 'package:cluster/presentation/dashboard_screen/cart_screen/cart_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/task_operation/employee_group_screen.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../common_widgets/gradient_button.dart';
import '../../../../common_widgets/loading.dart';

import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'dummy_design_forTesting/dummy_user_list_model.dart';

class CreateChatGroup extends StatefulWidget {
  final bool edit;
  final String? token;
  final Socket? socket;
  final String? loginUserId;
  const CreateChatGroup({Key? key,  this.edit=false,this.token,this.socket,this.loginUserId}) : super(key: key);

  @override
  State<CreateChatGroup> createState() => _CreateChatGroupState();
}

class _CreateChatGroupState extends State<CreateChatGroup> {
  int isSelected = 0;
  bool select = false;
  void onSelect(int val) {
    isSelected = val;
    select = true;
    setState(() {});
  }
  List<String> userCodeList=[]  ;
  List<GetEmployeeList> userList=[];
  GetTaskGroupList? readGroup;
  List<String> newTable=[];
  List<GetEmployeeList> userIdList = [];
  List<UserDummyList> userlist = [];
  void chaneTable(List<String> val,List<GetEmployeeList> update,bool changeVal){
    // userList?.clear();
    newTable=val;
    userList=update;
    isChange=changeVal;
    validationCheck();
    setState((){});

  }
  @override
  void initState() {

    context.read<GroupBloc>().add(
      GetAllRegisteredUsersEvent(
       "") 
    );
    super.initState();
  }
  bool isChange=false;
  FocusNode focusNode=FocusNode();
  FocusNode descriptionfocusNode=FocusNode();
  bool? isValid=false;
  validationCheck(){
    if(groupName.text!=""&&discription.text!=""&&isChange==true){
      isValid=true;
    }
    else{
      isValid=false;
    }
  }

  GetTaskGroupList? taskgroup;
  final TextEditingController groupName = TextEditingController();
  final TextEditingController discription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("uuu$newTable");
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // Navigation bar
              statusBarColor: Colors.white, // Status bar
            ),
            surfaceTintColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,

          title: Text(
            "Create",
            style:  TextStyle(color: Colors.black,fontSize: w/22),
          ),
          titleSpacing: 0,
          leading: GestureDetector(
              onTap:() {
                widget.socket!.emit("update.list",{
      
                        print("update")
                      });
                      widget.socket!.on("friends.update", (data) {
        print("858768$data");
        setState(() {
          
        });
      } );
                      Navigator.pop(context) ;
                      BlocProvider.of<CommunicationBloc>(context)
              .add(GetFilterdChatListEvent(
                    token: widget.token ?? "",
                    chatFilter: "chats"
                  ));
                    },

              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          )
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: MultiBlocListener(
  listeners: [
    BlocListener<GroupBloc, GroupState>(
            listener: (context, state) {
              if (state is CreateGroupLoading) {
                print("'ghj");
                // showSnackBar(context,
                    // message: "Loading...",
                    // color: Colors.white,
                    // // icon: HomeSvg().SnackbarIcon,
                    // autoDismiss: true);
              }

              if (state is CreateGroupFailed) {
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
              }
              if (state is CreateGroupSuccess) {
                // taskgroup = state.group;
                Navigator.pop(context);
                Navigator.pop(context);
              
      
        widget.socket!.emit("group.message",{
        "type": "notify", "chatid": state.list.chatid, "content": "Group Created By ${state.list.createdBy.toString().toTitleCase()}\n ${state.list.addedUsers?.join(',').toString().toTitleCase()} are added to the group"
      });
      BlocProvider.of<ChatBloc>(context).add(ChatScreenGetEvent(
            token: widget.token ?? "",
            grpchatId: "",
            chatId:state.list.chatid??"",
            pageNo: 1,
            userId: widget.loginUserId??""));
      PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: ChatScreen(
              token: widget.token,
              loginUserId: widget.loginUserId,
              socket: widget.socket,
              isGroup: true,
              isg: true,
              grpuser: state.list,
            ),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.fade,
      );
              //   Fluttertoast.showToast(
              //       msg: 'Successfully Created Group',
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.BOTTOM,
              //       backgroundColor: Colors.black,
              //       textColor: Colors.white);
                    
              }
            },
),
  ],
  child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w1,
              // height: 185,
              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Color(0xffe6ecf0),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style:GoogleFonts.roboto(
                        fontWeight: FontWeight.w600
                    ) ,
                    onChanged: (n){
                      validationCheck();
                      setState(() {

                      });
                    },
                    focusNode: focusNode,
                    decoration:  InputDecoration(
                      contentPadding: EdgeInsets.only(left:16,right: 16 ),
                      hintText: "Group Name",
                      hintStyle: TextStyle(
                        color: Color(0x66151522),
                        fontSize: w/26,
                      ),
                      border: InputBorder.none,

                    ),
                    controller: groupName,

                    maxLines: 1,
                  ),

                  Container(
                    margin: EdgeInsets.only(left:16),
                    width: w1,
                    height: 1.50,
                    color: ColorPalette.divider,
                  ),

                  TextFormField(
                    style:GoogleFonts.roboto(
                        fontWeight: FontWeight.w600
                    ) ,
                    controller: discription,
                    // maxLength: 150,
                    // maxLines: 2,
                    // minLines: 1,
                    onChanged: (n){
                      validationCheck();
                      setState(() {

                      });
                    },
                    focusNode: descriptionfocusNode,
                    decoration:  InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16,top: 10,right: 16),
                      hintText: "Group Description",
                      hintStyle: TextStyle(
                        color: Color(0x66151522),
                        fontSize: w/26,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Group name & description are mandatory",
              style: GoogleFonts.roboto(fontSize: w/30),),
            ),
            SizedBox(height: 10,),
          SizedBox(
            height: h / 1.65,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    BlocBuilder<GroupBloc, GroupState>(
                      builder: (context, state) {
                        if (state is GetAllRegisteredUsersLoading) {
                          return  LottieLoader();
                        }
                        if (state is GetAllRegisteredUsersSuccess) {

                          print("Success shifu");
                              print("sjsd ${authentication.authenticatedUser.code}");
                              for(int i=0;i<state.registeresUsers.length;){
                                // print();
                                if(authentication.authenticatedUser.code==state.registeresUsers[i].userCode){
                                        state.registeresUsers.removeAt(i);
                                        }
                                  i++;
                              }
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  "Select from List (${userCodeList.length})",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff151522),
                                    fontSize: w/24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: w1,
                                  // height: h / 2.5,
                                  // decoration: BoxDecoration(
                                  //   borderRadius:
                                  //   BorderRadius.circular(10),
                                  //   border: Border.all(
                                  //     color: Color(0xffe6ecf0),
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
                                  child: ListView.separated(
                                      primary: true,
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GroupChatList(
                                            userUpdateList: userList,
                                            userList: userCodeList,
                                            readUser:userCodeList.isNotEmpty? userCodeList.contains(state.registeresUsers[index].userCode):false,

                                              listuser: chaneTable,
                                              employeeList: state
                                                  .registeresUsers[index]),
                                      separatorBuilder:
                                          (context, index) => Container(),
                                      itemCount:
                                      state.registeresUsers.length),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),

                    // SizedBox(height: h/10,)
                  ],
                ),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: isValid==true&&userList.isNotEmpty?
              GradientButton(
                  onPressed: () {
   
                    BlocProvider.of<GroupBloc>(context).add(
                        CreateGroupEvent(
                            groupName: groupName.text,
                            description: discription.text,
                            userIdList: userList,
                            token: widget.token ??"",
                            groupPhotoUrl: ""
                            
                            ));
                  },
                  gradient: const LinearGradient(
                    colors: [
                      ColorPalette.primary,
                      ColorPalette.primary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color:  ColorPalette.primary,
                  child: Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                  )
                  :
              GradientButton(
                  onPressed: () {
                  },
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffD3D3D3),
                      Color(0xffD3D3D3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: const Color(0xffD3D3D3),
                  child: Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
            SizedBox(height: 5,)
        ])

),
        ));
  }
}
