import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/comunication_module/bloc/attachment_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/media_list.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../dashboard_screen/home_screen/home_svg.dart';

class ChatProfileScreen extends StatefulWidget {
  bool isGroup;
  final CommunicationUserModel? communicationUserModel;
  final String? token;
  final Socket? socket;
  final String? roomId;
  ChatProfileScreen(
      {Key? key,
      this.isGroup = false,
      this.communicationUserModel,
      this.socket,
      this.roomId,
      required this.token})
      : super(key: key);

  @override
  State<ChatProfileScreen> createState() => _ChatProfileScreenState();
}

class _ChatProfileScreenState extends State<ChatProfileScreen> {
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    print("chat id ${widget.communicationUserModel?.id}");
    var w = MediaQuery.of(context).size.width;
    return BlocListener<GroupBloc, GroupState>(
      listener: (context, state) {
        if (state is GroupLeaveLoading) {
          print("group leave loading");
        } else if (state is GroupLeaveSuccess) {
          showSnackBar(context,
              message: state.successMessage, color: Colors.green);
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CommunicationModule(
              token: widget.token ?? "",
            ),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        } else if (state is GroupLeaveFailed) {
          showSnackBar(context, message: state.error, color: Colors.green);
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GroupBloc()
              ..add(GroupProfileGet(
                  chatid: widget.communicationUserModel?.id ?? "",
                  token: widget.token ?? "")),
          ),
          BlocProvider(
            create: (context) => AttachmentBloc()
              ..add(GroupProfileAttachmentsGet(
                  chatId: widget.communicationUserModel?.id ?? "",
                  token: widget.token ?? "")),
          )
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // Navigation bar
              statusBarColor: Colors.white, // Status bar
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    // width: w,
                    child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          widget.isGroup?
                          widget.communicationUserModel?.photoUrl ?? "":
                           "https://api-uat-user.sidrabazar.com/media/${widget.communicationUserModel?.users?[0].photo}"
                          ,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.communicationUserModel?.isGroupChat == false
                      ? Text(
                          widget.communicationUserModel?.users?[0].name ?? "",
                          style: GoogleFonts.roboto(
                            color: const Color(0xff151522),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Text(
                          widget.communicationUserModel?.name ?? "",
                          style: GoogleFonts.roboto(
                            color: const Color(0xff151522),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.isGroup
                        ? "Created by ${widget.communicationUserModel?.createdBy}"
                        : "${widget.communicationUserModel?.users?[0].email ?? ""}",
                    style: const TextStyle(
                      color: Color(0xff7b6f72),
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    width: w,
                    height: 6,
                    color: const Color(0xfff8f7f5),
                  ),
                  SizedBox(
                      width: w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.isGroup
                              ? BlocBuilder<AttachmentBloc, AttachmentState>(
                                  builder: (context, state) {
                                    if (state
                                        is GetGroupAttachmentsInProfileLoading) {
                                      customCupertinoLoading();
                                    } else if (state
                                        is GetGroupAttachmentsInProfileSuccess) {
                                      return Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 16, top: 25),
                                              child: Text(
                                                "Attachments",
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff151522),
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MediaList(
                                              messages: state.groupProfileGet
                                                  .media?.messages),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                top: 30,
                                                bottom: 10,
                                                right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${widget.communicationUserModel?.users?.length} Members",
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        const Color(0xff151522),
                                                    fontSize: w / 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "Add Member",
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        const Color(0xfffe5762),
                                                    fontSize: w / 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: const Color(0xffA9A8A8)
                                                .withOpacity(0.3),
                                            thickness: 1.1,
                                          ),
                                          ListView.separated(
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: const EdgeInsets.all(16),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
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
                                                              widget
                                                                      .communicationUserModel
                                                                      ?.users?[
                                                                          index]
                                                                      .name ??
                                                                  "",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff151522),
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            index == 0
                                                                ? const Text(
                                                                    "Moderator",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xffe70c0c),
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  )
                                                                : Container()
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    PopupMenuButton(
                                                      icon: SvgPicture.string(
                                                          TaskSvg().moreIcon),
                                                      //don't specify icon if you want 3 dot menu
                                                      color: Colors.white,
                                                      elevation: 2,
                                                      padding: EdgeInsets.zero,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      itemBuilder: (context) =>
                                                          [
                                                        PopupMenuItem(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            value: 'a',
                                                            enabled: true,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child: Text(
                                                                    'Edit this Job',
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  indent: 30,
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                      onSelected: (value) {},
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(
                                                        indent: 50,
                                                        thickness: 1.1,
                                                      ),
                                              itemCount: widget
                                                      .communicationUserModel
                                                      ?.users
                                                      ?.length ??
                                                  0),
                                        ],
                                      );
                                    }
                                    return Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 25),
                                            child: Text(
                                              "Attachments",
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff151522),
                                                fontSize: w / 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const MediaList(),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              top: 30,
                                              bottom: 10,
                                              right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${widget.communicationUserModel?.users?.length} Members",
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xff151522),
                                                  fontSize: w / 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "Add Member",
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xfffe5762),
                                                  fontSize: w / 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: const Color(0xffA9A8A8)
                                              .withOpacity(0.3),
                                          thickness: 1.1,
                                        ),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            primary: false,
                                            padding: const EdgeInsets.all(16),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Colors.grey,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
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
                                                            widget
                                                                    .communicationUserModel
                                                                    ?.users?[
                                                                        index]
                                                                    .name ??
                                                                "",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff151522),
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          index == 0
                                                              ? const Text(
                                                                  "Moderator",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xffe70c0c),
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                )
                                                              : Container()
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  PopupMenuButton(
                                                    icon: SvgPicture.string(
                                                        TaskSvg().moreIcon),
                                                    //don't specify icon if you want 3 dot menu
                                                    color: Colors.white,
                                                    elevation: 2,
                                                    padding: EdgeInsets.zero,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          value: 'a',
                                                          enabled: true,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  'Edit this Job',
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              const Divider(
                                                                indent: 30,
                                                              )
                                                            ],
                                                          ))
                                                    ],
                                                    onSelected: (value) {},
                                                  ),
                                                ],
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                                      indent: 50,
                                                      thickness: 1.1,
                                                    ),
                                            itemCount: widget
                                                    .communicationUserModel
                                                    ?.users
                                                    ?.length ??
                                                0),
                                      ],
                                    );
                                  },
                                )
                              : BlocBuilder<GroupBloc, GroupState>(
                                  builder: (context, state) {
                                    print("check the state $state");
                                    if (state
                                        is GetGroupProfileDetailsLoading) {
                                      customCupertinoLoading();
                                    } else if (state
                                        is GetGroupProfileDetailsSuccess) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 25),
                                            child: Text(
                                              "Attachments",
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff151522),
                                                fontSize: w / 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          MediaList(
                                              messages: state.profileGetModel
                                                  .media?.messages),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, top: 20),
                                            child: Text(
                                              "Groups",
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xff151522),
                                                fontSize: w / 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: const Color(0xffA9A8A8)
                                                .withOpacity(0.3),
                                            thickness: 1.1,
                                          ),
                                          ListView.separated(
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: const EdgeInsets.all(16),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor:
                                                          const Color(
                                                              0xff1ECAC0),
                                                      child: Text(
                                                        "R",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          color: Colors.white,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
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
                                                                  .profileGetModel
                                                                  .groups?[
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xff151522),
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        const Text(
                                                          "Moderator",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffe70c0c),
                                                            fontSize: 15,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(
                                                        indent: 50,
                                                        thickness: 1.1,
                                                      ),
                                              itemCount: state.profileGetModel
                                                      .groups?.length ??
                                                  0),
                                        ],
                                      );
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 25),
                                          child: Text(
                                            "Attachments",
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff151522),
                                              fontSize: w / 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const MediaList(),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, top: 20),
                                          child: Text(
                                            "Groups",
                                            style: GoogleFonts.roboto(
                                              color: const Color(0xff151522),
                                              fontSize: w / 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: const Color(0xffA9A8A8)
                                              .withOpacity(0.3),
                                          thickness: 1.1,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          Container(
                            width: w,
                            height: 6,
                            color: const Color(0xfff8f7f5),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: const EdgeInsets.all(16),
                              width: w,
                              // padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xffe6ecf0),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16, top: 16),
                                  child: SingleRow(
                                    label: widget.isGroup
                                        ? "Notify me on due date"
                                        : "Mute Notifications",
                                    color: const Color(0xffFFC800),
                                    svg: TaskSvg().notificationIcon,
                                    endIcon: isMute
                                        ? SvgPicture.string(
                                            HomeSvg().toggleActive)
                                        : SvgPicture.string(
                                            HomeSvg().toggleInActive),
                                    onTap: () {
                                      setState(() {
                                        isMute = !isMute;
                                      });
                                    },
                                  ),
                                ),
                              ])),
                          widget.isGroup
                              ? InkWell(
                                  onTap: () {
                                    BlocProvider.of<GroupBloc>(context).add(
                                        GroupLeaveEvent(
                                            roomId: widget.roomId ?? "",
                                            token: widget.token ?? ""));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(16),
                                    width: 382,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0xffe6ecf0),
                                        width: 1,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x05000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Leave Chat",
                                      style: GoogleFonts.roboto(
                                        color: const Color(0xfffe5762),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  // margin: const EdgeInsets.all(16),
                                  // width: 382,
                                  // height: 60,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   border: Border.all(
                                  //     color: const Color(0xffe6ecf0),
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
                                  // alignment: Alignment.center,
                                  // child: Text(
                                  //   "Block @name",
                                  //   style: GoogleFonts.roboto(
                                  //     color: const Color(0xfffe5762),
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                  )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
