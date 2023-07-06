import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:cluster/presentation/comunication_module/chat_screen.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/comunication_module/newgroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BlocListener<CommunicationBloc, CommunicationState>(
      listener: (context, state) {
        print("state found ${state}");
        if (state is AddAFriendUserSuccess) {
          Navigator.pop(context);
          BlocProvider.of<CommunicationBloc>(context)
              .add(GetChatListEvent(token: widget.token ?? ""));
          showSnackBar(context,
              message: state.successMessage, color: Colors.green);
        } else if (state is AddAFriendUserFailed) {
          showSnackBar(context, message: state.error, color: Colors.red);
        }
      },
      child: BlocProvider(
        create: (context) =>
            GroupBloc()..add(GetAllRegisteredUsersEvent(widget.token ?? "")),
        child: Scaffold(
          appBar: AppBar(
             leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<CommunicationBloc>(context)
                    .add(GetChatListEvent(token: widget.token ?? ""));
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
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: NewGroup(token: widget.token),
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
                        color: const Color(0xfffdf2f2),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 37.14,
                            height: 37.14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xfffe5762),
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
                                                                .mail ??
                                                            "",
                                                        fname: state
                                                                .searchedUsers[
                                                                    index]
                                                                .name ??
                                                            "",
                                                        lname: state
                                                                .searchedUsers[
                                                                    index]
                                                                .lastName ??
                                                            "",
                                                        photo: state
                                                                .searchedUsers[
                                                                    index]
                                                                .photo ??
                                                            ""));
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
                                                                  .name ??
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
                                                                  .mail ??
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
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => InkWell(
                                            onTap: () {
                                              BlocProvider.of<
                                                          CommunicationBloc>(
                                                      context)
                                                  .add(AddAFriendUserEvent(
                                                token: widget.token ?? "",
                                                email: state
                                                        .registeresUsers[index]
                                                        .mail ??
                                                    "",
                                                fname: state
                                                        .registeresUsers[index]
                                                        .name ??
                                                    "",
                                                photo: state
                                                        .registeresUsers[index]
                                                        .photo ??
                                                    "",
                                                lname: state
                                                        .registeresUsers[index]
                                                        .lastName ??
                                                    "",
                                              ));
                                              // PersistentNavBarNavigator.pushNewScreen(
                                              //   context,
                                              //   screen: ChatScreen(
                                              //     token: token,
                                              //     loginUserId: loginUserId,
                                              //     socket: socket,
                                              //     isGroup:false,
                                              //     communicationUserModel:
                                              //         CommunicationUserModel(name: state.registeresUsers[index].name,
                                              //         id: state.registeresUsers[index].id,),
                                              //   ),
                                              //   withNavBar:
                                              //       true, // OPTIONAL VALUE. True by default.
                                              //   pageTransitionAnimation:
                                              //       PageTransitionAnimation.fade,
                                              // );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                                    .registeresUsers[
                                                                        index]
                                                                    .name ??
                                                                "",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              color: const Color(
                                                                  0xff151522),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            state
                                                                    .registeresUsers[
                                                                        index]
                                                                    .mail ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xff6d6d6d),
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  index < 0
                                                      ? Container(
                                                          width: 28,
                                                          height: 28,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: const Color(
                                                                0xfffe5762),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "15",
                                                              style: GoogleFonts
                                                                  .outfit(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                            indent: 50,
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
