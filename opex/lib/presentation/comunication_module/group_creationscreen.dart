// import 'dart:io';
// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/core/common_snackBar.dart';
// import 'package:cluster/presentation/comunication_module/bloc/attachment_bloc.dart';
// import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
// import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
// import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
// import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../core/color_palatte.dart';
// import 'com_svg.dart';

// class NewGroupProfile extends StatefulWidget {
//   final String? token;
//   final List<GetEmployeeList> userIdList;
//   const NewGroupProfile({Key? key, this.token, required this.userIdList})
//       : super(key: key);

//   @override
//   State<NewGroupProfile> createState() => _NewGroupProfileState();
// }

// class _NewGroupProfileState extends State<NewGroupProfile> {
//   final picker = ImagePicker();
//   File? cropImage;
//   bool _cropped = false;
//   String? newGroupPic;

//   TextEditingController groupNameController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<GroupBloc, GroupState>(
//           listener: (context, state) {
//             if (state is CreateGroupLoading) {
//               showSnackBar(context,
//                   message: "GroupCreation Loading", color: ColorPalette.green);
//             } else if (state is CreateGroupSuccess) {
//               showSnackBar(context,
//                   message: "Successs", color: ColorPalette.green);
//               PersistentNavBarNavigator.pushNewScreen(
//                 context,
//                 screen: CommunicationModule(
//                   // token: widget.token??"",
//                 ),
//                 withNavBar: true, // OPTIONAL VALUE. True by default.
//                 pageTransitionAnimation: PageTransitionAnimation.fade,
//               );
//             } else if (state is CreateGroupFailed) {
//               showSnackBar(context,
//                   message: state.error, color: ColorPalette.black);
//             }
//           },
//         ),
//         BlocListener<AttachmentBloc, AttachmentState>(
//           listener: (context, state) {
//             if (state is UploadGroupProfilePicLoading) {
//               showSnackBar(context,
//                   message: "Group profile pic loading", color: Colors.green);
//             } else if (state is UploadGroupProfilePicSuccess) {
//               showSnackBar(context,
//                   message: state.message ?? '', color: Colors.green);
//               _cropped = true;
//             } else if (state is UploadGroupProfilePicFailed) {
//               showSnackBar(context,
//                   message: state.error ?? "", color: Colors.green);
//             }
//           },
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Color(0xff3A3A3A),
//           title: Text(
//             "New group",
//             style: GoogleFonts.roboto(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         body: ScrollConfiguration(
//           behavior: NoGlow(),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Profile",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Stack(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   getImage(ImageSource.gallery);
//                                 },
//                                 child: BlocBuilder<AttachmentBloc,
//                                     AttachmentState>(
//                                   builder: (context, state) {
//                                     if (state is UploadGroupProfilePicSuccess) {
//                                       newGroupPic = state.uploadLink;

//                                       return CircleAvatar(
//                                         radius: 35,
//                                         backgroundImage: NetworkImage(
//                                             state.uploadLink ?? ""),
//                                         backgroundColor:
//                                             ColorPalette.inactiveGrey,
//                                       );
//                                     }
//                                     return CircleAvatar(
//                                       radius: 35,
//                                       backgroundColor:
//                                           ColorPalette.inactiveGrey,
//                                     );
//                                   },
//                                 ),
//                               ),
//                               Positioned(
//                                   bottom: 10,
//                                   right: 0,
//                                   child: Container(
//                                     padding: EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         shape: BoxShape.circle),
//                                     child: SvgPicture.string(
//                                         CommunicationSvg().cameraIcon),
//                                   ))
//                             ],
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             width: w / 1.6,
//                             child: TextFormField(
//                               controller: groupNameController,
//                               onChanged: (val) {
//                                 setState(() {});
//                               },
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.black))),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 Divider(),
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Participants",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             "${widget.userIdList.length} people selected",
//                             style: const TextStyle(
//                               color: Color(0xff6d6d6d),
//                               fontSize: 14,
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       SizedBox(
//                           height: 60,
//                           child: ListView.separated(
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) =>  Stack(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 30,
//                                         backgroundColor:
//                                             ColorPalette.inactiveGrey,
//                                       ),
//                                       // InkWell(
//                                       //   onTap: (){
//                                       //     widget.userIdList.remove(widget.userIdList[index]);
//                                       //     setState(() {

//                                       //     });

//                                       //   },
//                                       //   child: Positioned(
//                                       //       bottom: 0,
//                                       //       right: 0,
//                                       //       child: Container(
//                                       //         decoration: BoxDecoration(
//                                       //           shape: BoxShape.circle,
//                                       //           color: ColorPalette.primary,
//                                       //         ),
//                                       //         child: Icon(
//                                       //           Icons.close,
//                                       //           color: Colors.white,
//                                       //           size: 15,
//                                       //         ),
//                                       //       )),
//                                       // )
//                                     ],
//                                   ),
//                               separatorBuilder: (context, index) => SizedBox(
//                                     width: 10,
//                                   ),
//                               itemCount: widget.userIdList.length))
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             BlocProvider.of<GroupBloc>(context).add(CreateGroupEvent(
//                 groupName: groupNameController.text,
//                 token: widget.token ?? "",
//                 groupPhotoUrl: newGroupPic??"",
//                 userIdList: widget.userIdList));
//           },
//           child: Icon(Icons.arrow_forward),
//           elevation: 0,
//           backgroundColor: groupNameController.text.isNotEmpty
//               ? ColorPalette.primary
//               : ColorPalette.inactiveGrey,
//         ),
//       ),
//     );
//   }

//   Future<void> getImage(source) async {
//     try {
//       final pickedFile =
//           await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

//       cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

//       if (cropImage != null) {
//         BlocProvider.of<AttachmentBloc>(context)
//             .add(UploadGroupProfilePicEvent(image: cropImage!));
//       }
//       setState(() {
//         _cropped = true;
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
