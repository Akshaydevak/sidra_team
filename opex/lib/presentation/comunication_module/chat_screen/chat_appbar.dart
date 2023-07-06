import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:socket_io_client/socket_io_client.dart';

import '../chat_profile_screen.dart';

class ChatAppBar extends StatelessWidget {
  final CommunicationUserModel? communicationUserModel;
  final bool? typing;
  final FromUser? groupTypingUser;
  final String? token;
  final Socket? socket;
  final String? roomId;
  final bool? isGroup;
  ChatAppBar(
      {Key? key,
      this.communicationUserModel,
      this.typing,
      this.socket,
      this.isGroup,
      this.token,
      this.roomId,
      this.groupTypingUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16,right: 16,top: 3,bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    BlocProvider.of<CommunicationBloc>(context)
                        .add(GetChatListEvent(token: token ?? ""));
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back)),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // PersistentNavBarNavigator.pushNewScreen(
                  //   context,
                  //   screen: ChatProfileScreen(),
                  //   withNavBar: true, // OPTIONAL VALUE. True by default.
                  //   pageTransitionAnimation: PageTransitionAnimation.fade,
                  // );
                },
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        NetworkImage(
                          isGroup??false?

                          communicationUserModel?.photoUrl ?? "":
                           "https://api-uat-user.sidrabazar.com/media/${communicationUserModel?.users?[0].photo}"
                          )),
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ChatProfileScreen(
                      token: token,roomId: roomId,
                      socket: socket,
                      isGroup: communicationUserModel?.isGroupChat ?? false,
                      communicationUserModel: communicationUserModel,
                    ),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    communicationUserModel?.isGroupChat == false
                        ? Container(
                            // color: Colors.green,
                            width: w / 1.9,
                            child: Text(
                              communicationUserModel?.users?[0].name ?? "",
                              // maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: const Color(0xff151522),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Text(
                            communicationUserModel?.name ?? "",
                            style: GoogleFonts.roboto(
                              color: const Color(0xff151522),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    // groupTypingUser != null
                    //     ? Row(
                    //         children: [
                    //           CircleAvatar(
                    //               backgroundColor: Colors.white,
                    //               radius: 14,
                    //               child: CircleAvatar(
                    //                 backgroundImage: NetworkImage(
                    //                     groupTypingUser?.photo ?? ""),
                    //                 radius: 12,
                    //               )),
                    //           Text(
                    //             "${groupTypingUser?.name} typing",
                    //             style: const TextStyle(
                    //               color: Color(0xff151522),
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     : Text(
                    //         typing == true ? "typing" : "",
                    //         style: const TextStyle(
                    //           color: Color(0xff151522),
                    //           fontSize: 16,
                    //         ),
                    //       )
                  ],
                ),
              )
            ],
          ),
          PopupMenuButton(
            icon: SvgPicture.string(TaskSvg().moreIcon),
            //don't specify icon if you want 3 dot menu
            color: Colors.white,
            elevation: 2,
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            itemBuilder: (context) => [
              // PopupMenuItem(
              //     padding: const EdgeInsets.all(0),
              //     value: 'a',
              //     enabled: true,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Container(
              //           padding: const EdgeInsets.only(left: 10),
              //           child: Row(
              //             children: [
              //               SvgPicture.string(TaskSvg().editorIcon),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 'Edit this Job',
              //                 style: GoogleFonts.poppins(
              //                     color: Colors.black54,
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w500),
              //               ),
              //             ],
              //           ),
              //         ),
              //         const Divider(
              //           indent: 30,
              //         ),
              //         Container(
              //           padding: const EdgeInsets.only(left: 10),
              //           child: Row(
              //             children: [
              //               SvgPicture.string(TaskSvg().shareJobIcon),
              //               // SvgPicture.string(TaskSvg().msgSendIcon),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 'share Profile',
              //                 style: GoogleFonts.poppins(
              //                     color: Colors.black54,
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w500),
              //               ),
              //             ],
              //           ),
              //         ),
              //         const Divider(
              //           indent: 30,
              //         ),
              //         Container(
              //           padding: const EdgeInsets.only(left: 10),
              //           child: Row(
              //             children: [
              //               SvgPicture.string(TaskSvg().shareJobIcon),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 'Pin',
              //                 style: GoogleFonts.poppins(
              //                     color: Colors.black54,
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w500),
              //               ),
              //             ],
              //           ),
              //         ),
              //         const Divider(
              //           indent: 30,
              //         ),
              //         Container(
              //           padding: const EdgeInsets.only(left: 10),
              //           child: Row(
              //             children: [
              //               SvgPicture.string(TaskSvg().activityIcon),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 'Map to a Job ',
              //                 style: GoogleFonts.poppins(
              //                     color: Colors.black54,
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w500),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ))
            ],
            onSelected: (value) {},
          ),
        ],
      ),
    );
  }
}
