// import 'package:cluster/common_widgets/loading.dart';
// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/core/color_palatte.dart';
// import 'package:cluster/presentation/comunication_module/com_svg.dart';
// import 'package:cluster/presentation/comunication_module/com_svg.dart';
// import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
// import 'package:cluster/presentation/comunication_module/group_creationscreen.dart';
// import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
// import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// class NewGroup extends StatefulWidget {
//   final String? token;
//   NewGroup({Key? key, this.token}) : super(key: key);

//   @override
//   State<NewGroup> createState() => _NewGroupState();
// }

// class _NewGroupState extends State<NewGroup> {
//   bool isSelect = false;
//   List<GetEmployeeList> userIdList = [];
//   List<GetEmployeeList> selectedUserIdList = [];

//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     return BlocProvider(
//       create: (context) =>
//           GroupBloc()..add(GetAllRegisteredUsersEvent(widget.token ?? "")),
//       child: Scaffold(
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: selectedUserIdList.isNotEmpty
//               ? ColorPalette.primary
//               : ColorPalette.inactiveGrey,
//           tooltip: "Create group",
//           onPressed: () {
//             selectedUserIdList.isNotEmpty
//                 ? PersistentNavBarNavigator.pushNewScreen(
//                     context,
//                     screen: NewGroupProfile(
//                         token: widget.token, userIdList: userIdList),
//                     withNavBar: true, // OPTIONAL VALUE. True by default.
//                     pageTransitionAnimation: PageTransitionAnimation.fade,
//                   )
//                 : null;
//           },
//           child: const Icon(Icons.arrow_forward,color: Colors.white,),
//         ),
//         appBar: AppBar(
//            iconTheme: IconThemeData(
//                 color: Colors.black, //change your color here
//               ),
//           elevation: 0,
//               backgroundColor: Colors.white,

//           title: Text(
//             "New group",
//             style: GoogleFonts.roboto(
//               color: Colors.black,
//               fontSize: 24,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         body: ScrollConfiguration(
//           behavior: NoGlow(),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                     padding: const EdgeInsets.all(16),
//                     child: selectedUserIdList.isEmpty
//                         ? GestureDetector(
//                             onTap: () {
//                               setState(() {});
//                             },
//                             child: Text(
//                               "Tap and select contacts to create a group",
//                               style: GoogleFonts.roboto(
//                                 color: Colors.black,
//                                 fontSize: w / 23,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           )
//                         : Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "${selectedUserIdList.length} selected",
//                                 style: GoogleFonts.roboto(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               SizedBox(
//                                   height:MediaQuery.of(context).size.height/8,
//                                   child: ListView.separated(
//                                       scrollDirection: Axis.horizontal,
//                                       itemBuilder: (context, index) =>
//                                            Column(
//                                              children: [
//                                                Container(
//                                                 width: w/4,
//                                                  child: Column(
//                                                   children: [
//                                                     CircleAvatar(
//                                                       radius: 30,
//                                                       backgroundColor:
//                                                           ColorPalette.inactiveGrey,
//                                                     ),
//                                                     Center(
//                                                       child: Text("${selectedUserIdList[index].fname} ${selectedUserIdList[index].lname}",
//                                                       softWrap: true,textAlign: TextAlign.center,),
//                                                     )
                                                 
//                                                     // Positioned(
//                                                     //     bottom: 0,
//                                                     //     right: 0,
//                                                     //     child: Container(
//                                                     //       decoration:
//                                                     //           const BoxDecoration(
//                                                     //         shape: BoxShape.circle,
//                                                     //         color:
//                                                     //             ColorPalette.primary,
//                                                     //       ),
//                                                     //       child: const Icon(
//                                                     //         Icons.close,
//                                                     //         color: Colors.white,
//                                                     //         size: 15,
//                                                     //       ),
//                                                     //     ))
//                                                   ],
//                                                                                            ),
//                                                ),
//                                              ],
//                                            ),
//                                       separatorBuilder: (context, index) =>
//                                           const SizedBox(
//                                             width:1,
//                                           ),
//                                       itemCount: selectedUserIdList.length)),
//                                       Divider()
//                             ],
//                           )),
//                 // SizedBox(height: 20,),
                
//                 BlocBuilder<GroupBloc, GroupState>(
//                   builder: (context, state) {
//                     if (state is GetAllRegisteredUsersLoading) {
//                       return customCupertinoLoading();
//                     } else if (state is GetAllRegisteredUsersSuccess) {
//                       return SizedBox(
//                         height: MediaQuery.of(context).size.height / 1.2,
//                         child: ListView.separated(
//                           // padding: EdgeInsets.all(10),
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) => NewGroupCard(
//                               userIdList: userIdList,
//                               onPress: (val) {
//                                 selectedUserIdList = val;
//                                 print("got it ${selectedUserIdList}");
//                                 setState(() {});
//                               },photo: state.registeresUsers[index].profile,
//                               // userId: state.registeresUsers[index].id,
//                               name: state.registeresUsers[index].fname,
//                               lastName: state.registeresUsers[index].lname,
//                               email: state.registeresUsers[index].email),
//                           itemCount: state.registeresUsers.length,
//                           separatorBuilder: (context, index) => const Divider(
//                             indent: 50,
//                           ),
//                         ),
//                       );
//                     } else if (state is GetAllRegisteredUsersFailed) {}
//                     return Container();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NewGroupCard extends StatefulWidget {
//   final String? name;
//   final String? lastName;
//   final String? email;
//   final String? photo;
//   final String? userId;
//   List<GetEmployeeList> userIdList = [];
//   final Function(List<GetEmployeeList>) onPress;
//   NewGroupCard(
//       {Key? key,
//       this.email,
//       this.name,
//       this.userId,
//       this.lastName,
//       this.photo,
//       required this.onPress,
//       required this.userIdList})
//       : super(key: key);

//   @override
//   State<NewGroupCard> createState() => _GroupCardState();
// }

// class _GroupCardState extends State<NewGroupCard> {
//   bool isSelect = false;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           isSelect = !isSelect;
//         });
//         // print(widget.userId);
//         if (isSelect == true) {
//           widget.userIdList.add(GetEmployeeList(
//               fname: widget.name,
//               lname: widget.lastName,
//               email: widget.email,
//               profile: widget.photo));
//         } else {
//           widget.userIdList.remove(GetEmployeeList(
//               fname: widget.name,
//               lname: widget.lastName,
//               email: widget.email,
//               profile: widget.photo));
//         }
//         widget.onPress(widget.userIdList);
//       },
//       child: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: isSelect
//               ? const BoxDecoration(
//                   color: Color.fromARGB(255, 240, 242, 245),
//                 )
//               : const BoxDecoration(),
//           // padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const CircleAvatar(),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.name ?? "",
//                         style: GoogleFonts.roboto(
//                           color: const Color(0xff151522),
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         widget.email ?? "",
//                         style: const TextStyle(
//                           color: Color(0xff6d6d6d),
//                           fontSize: 14,
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               isSelect
//                   ? SvgPicture.string(CommunicationSvg().tickIcon,color: ColorPalette.primary,)
//                   : Container()
//             ],
//           )),
//     );
//   }
// }
