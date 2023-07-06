import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/bloc/chat_bloc.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:cluster/common_widgets/string_extensions.dart';

import 'chat_profile_screen.dart';
import 'chat_screen.dart';

class ChatCard extends StatefulWidget {
  bool isGroup;
  List<String> onlineUsers;
  final String? token;
  final Socket? socket;
  final String? loginUserId;
  final CommunicationUserModel? communicationUserModel;
  ChatCard(
      {Key? key,
      this.isGroup = false,
      required this.onlineUsers,
      this.token,
      this.socket,
      this.loginUserId,
      this.communicationUserModel})
      : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    // print("inside the array is this ${widget.onlineUsers[0]}");
    // print("inside the communi ${widget.communicationUserModel?.id}");
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ChatBloc>(context).add(ChatScreenGetEvent(
            token: widget.token ?? "",
            userId: widget.communicationUserModel?.id ?? "",
            pageNo: 1));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ChatScreen(
            token: widget.token,
            loginUserId: widget.loginUserId,
            socket: widget.socket,
            isGroup: widget.isGroup,
            communicationUserModel: widget.communicationUserModel,
          ),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: ChatProfileScreen(
                        //       token: widget.token,
                        //       isGroup: widget.isGroup,
                        //       communicationUserModel:
                        //           widget.communicationUserModel),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: ColorPalette.inactiveGrey,
                        backgroundImage: NetworkImage(
                          widget.isGroup?
                            widget.communicationUserModel?.photoUrl ?? "":
                            "https://api-uat-user.sidrabazar.com/media/${widget.communicationUserModel?.users?[0].photo}" ),
                      ),
                    ),
                    widget.communicationUserModel?.users?[0].connected ==
                                true ||
                            widget.onlineUsers.contains(
                                widget.communicationUserModel?.users?[0].id)
                        ? const Positioned(
                            right: 3,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 6,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff079b15),
                                  radius: 5,
                                )))
                        : Container()
                  ],
                ),
                const SizedBox(
                  width: 14,
                ),
                Container(
                  width: w / 1.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.communicationUserModel?.isGroupChat == false
                          ? Text(
                              widget.communicationUserModel?.users?[0].name
                                      ?.toTitleCase() ??
                                  "",
                              style: GoogleFonts.roboto(
                                color: const Color(0xff151522),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Text(
                              widget.communicationUserModel?.name
                                      ?.toTitleCase() ??
                                  "",
                              style: GoogleFonts.roboto(
                                color: const Color(0xff151522),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      widget.communicationUserModel != null &&
                              widget.communicationUserModel?.messages != null
                          ? widget.communicationUserModel!.messages!.isNotEmpty
                              ? widget.communicationUserModel!.messages![0]
                                          .type !=
                                      "text"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.image,
                                              color: ColorPalette.inactiveGrey,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(widget.communicationUserModel!
                                                    .messages![0].type ??
                                                "")
                                          ],
                                        ),
                                        Text(
                                            widget.communicationUserModel
                                                    ?.messages?[0].createdAt ??
                                                "",
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff6d6d6d),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: w/3,
                                          child: Text(
                                            widget.communicationUserModel
                                                    ?.messages?[0].message ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xff151522),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                            widget.communicationUserModel
                                                    ?.messages?[0].createdAt ??
                                                "",
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff6d6d6d),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    )
                              : Text("")
                          : Text("")
                    ],
                  ),
                )
              ],
            ),
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       if (widget.communicationUserModel?.messages != null) ...{
            //         widget.communicationUserModel!.messages!.isNotEmpty
            //             ? Row(
            //                 children: [
            //                   SizedBox(
            //                     // width: w/7,
            //                     child: Text(
            //                         widget.communicationUserModel?.messages?[0]
            //                                 .createdAt ??
            //                             "",
            //                         overflow: TextOverflow.fade,
            //                         style: GoogleFonts.roboto(
            //                           color: const Color(0xff6d6d6d),
            //                           fontSize: 13,
            //                           fontWeight: FontWeight.w500,
            //                         )),
            //                   ),
            //                 ],
            //               )
            //             : Container()
            //       }
            //       // widget.isGroup
            //       //     ? Column(
            //       //         children: [
            //       //           const SizedBox(
            //       //             height: 5,
            //       //           ),
            //       //           CircleAvatar(
            //       //             radius: 15,
            //       //             backgroundColor: const Color(0xffFE5762),
            //       //             child: Text(
            //       //               "15",
            //       //               style: GoogleFonts.outfit(
            //       //                 color: Colors.white,
            //       //                 fontSize: 14,
            //       //                 fontWeight: FontWeight.w600,
            //       //               ),
            //       //             ),
            //       //           )
            //       //         ],
            //       //       )
            //       //     : Container(),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
