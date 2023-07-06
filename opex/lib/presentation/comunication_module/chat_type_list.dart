import 'package:cluster/presentation/comunication_module/bloc/communication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_type_model.dart';

class ChatTypeList extends StatefulWidget {
  final String? token;
  const ChatTypeList({Key? key, this.token}) : super(key: key);

  @override
  State<ChatTypeList> createState() => _ChatTypeListState();
}

class _ChatTypeListState extends State<ChatTypeList> {
  int select = 0;
  String? filterName;
  void onSelect(int val) {
    select = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w - 55,
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 0, left: 10),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: chatTypeList.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: () {
                onSelect(i);
                filterName = chatTypeList[i].code;
                BlocProvider.of<CommunicationBloc>(context).add(
                    GetFilterdChatListEvent(
                        token: widget.token ?? "",
                        chatFilter: filterName ?? ""));
              },
              child: Container(
                width: 85,
                height: 36,
                decoration: select == i
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xfffe5762),
                          width: 1,
                        ),
                        color: const Color(0x0cfe5762),
                      )
                    : BoxDecoration(
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
                child: Text(chatTypeList[i].name),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 5,
          );
        },
      ),
    );
  }
}
