import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CmtnSearch extends StatefulWidget {
  final String? token;
  const CmtnSearch({Key? key, this.token}) : super(key: key);

  @override
  State<CmtnSearch> createState() => _CmtnSearchState();
}

class _CmtnSearchState extends State<CmtnSearch> {
  @override
  void initState() {
    BlocProvider.of<CommunicationBloc>(context)
        .add(GetSearchedUserEvent(searchQuery: "v", token: widget.token ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BlocListener<CommunicationBloc, CommunicationState>(
      listener: (context, state) {
        if (state is AddAFriendUserSuccess) {
          Navigator.pop(context);
          BlocProvider.of<CommunicationBloc>(context)
              .add(GetChatListEvent(token: widget.token ?? ""));
          // showSnackBar(context,
          //     message: state.successMessage, color: Colors.green);
        } else if (state is AddAFriendUserFailed) {
          showSnackBar(context, message: state.error, color: Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // Navigation bar
              statusBarColor: Colors.white, // Status bar
            ),
            backgroundColor: Colors.white,
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<CommunicationBloc>(context)
                    .add(GetChatListEvent(token: widget.token ?? ""));
              },
              color: Colors.black,
            ),
            title: Container(
              height: 45,
              // padding: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                onTap: () {
                  BlocProvider.of<CommunicationBloc>(context).add(
                      GetSearchedUserEvent(
                          searchQuery: "v", token: widget.token ?? ""));
                },
                onChanged: (value) {
                  BlocProvider.of<CommunicationBloc>(context).add(
                      GetSearchedUserEvent(
                          searchQuery: value, token: widget.token ?? ""));
                },
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
                BlocBuilder<CommunicationBloc, CommunicationState>(
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
                                      BlocProvider.of<CommunicationBloc>(
                                              context)
                                          .add(AddAFriendUserEvent(
                                              token: widget.token ?? "",
                                              email: state.searchedUsers[index]
                                                      .email ??
                                                  "",
                                              fname: state.searchedUsers[index]
                                                      .fname ??
                                                  "",
                                              lname: state.searchedUsers[index]
                                                      .lname ??
                                                  "",
                                              photo: state.searchedUsers[index]
                                                      .profile ??
                                                  "",
                                                  usercode: state.searchedUsers[index]
                                                      .userCode ??
                                                  ""
                                                  ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.searchedUsers[index]
                                                            .fname ??
                                                        "",
                                                    style: GoogleFonts.roboto(
                                                      color: const Color(
                                                          0xff151522),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    state.searchedUsers[index]
                                                            .email ??
                                                        "",
                                                    style: TextStyle(
                                                      color: Color(0xff6d6d6d),
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
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
