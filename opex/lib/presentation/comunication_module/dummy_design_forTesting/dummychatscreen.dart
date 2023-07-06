import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_model.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummychat_live_screen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dymmy_login_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DummyChatScreen extends StatefulWidget {
  final String dummyToken;
  const DummyChatScreen({super.key, required this.dummyToken});

  @override
  State<DummyChatScreen> createState() => _DummyChatScreenState();
}

class _DummyChatScreenState extends State<DummyChatScreen> {
  TextEditingController searchController = TextEditingController();
  Socket? socket;
  List<DummyFriendList> sampleFriendsList = [];
  List<MessageFormat> sampleMessages = [];
  List<Map<String, dynamic>> friendList = [];

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    try {
      // Configure socket transports must be sepecified
      socket = io(
          'https://api-communication-application.hilalcart.com/',
          <String, dynamic>{
            'transports': ['websocket'],
            'auth': {'token': widget.dummyToken},
            'autoConnect': false,
          });
      // Connect to websocket
      socket!.connect();
      // Handle socket events
      socket!.on('connect', (_) => print('connect: ${socket?.id}'));
      socket!.on('myid', (data) {
        print("conn my id $data");
      });
      socket!.on('connected', (
        data,
      ) {
        print("connected anutto");
        print(
            "conn connection status ${data}"); //its a response which will be come from socket.
      });
      socket!.on('friends.list', (data) {
        print(
            "conn list ${data}"); //its a response which will be come from socket.
        for (var elements in data) {
          sampleFriendsList.add(DummyFriendList.fromJson(elements));
        }
        setState(() {});
      });
      socket!.on("send.message", (data) {
        print("data is this bruh $data");
      });
      socket!.on('messages', (data) {
        print("conn messages outside ${data}");
        for (var elements in data) {
          sampleMessages.add(MessageFormat.fromJson(elements));
        }
      });
      // socket!.on('location', handleLocationListen);
      // socket!.on('typing', handleTyping);
      // socket!.on('message', handleMessage);
      socket!.on('disconnect', (_) => print('disconnect'));
      socket!.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chat Page"),
        actions: [
          const Center(child: Text("Logout")),
          InkWell(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const LoginDemo(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.logout_outlined),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a friend",
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Search for your friend'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: searchController,
                          //obscureText: true,
                          decoration: newInputDecoration("search"),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return ('required');
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          socket!.emit('add.friend', searchController.text);
                          socket!.on('on.error', (data) {
                            print("listened++ $data");
                          });
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        // height: ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,

                          screen: DummyChatLiveScreen(
                            userName: sampleFriendsList[index].userName ?? "",
                            connected: sampleFriendsList[index].connected,
                            userCode: sampleFriendsList[index].userId,
                            sampleMessagesOfUser: sampleMessages,
                            socket: socket!,
                          ),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('dp'.toString()),
                      ),
                      title: Text(sampleFriendsList[index].userName ?? ""),
                      // subtitle: Text(friendList[index].userId ?? ""),
                      trailing: sampleFriendsList[index].connected == true
                          ? const Icon(
                              Icons.offline_bolt_outlined,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.offline_bolt_outlined,
                              color: Colors.red,
                            ));
                },
                itemCount: sampleFriendsList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration newInputDecoration(
  String label, {
  String? hintText,
  Widget? leading,
  Widget? suffix,
  String? prefixText,
}) =>
    InputDecoration(
      suffixIcon: suffix,
      prefixText: prefixText,
      prefixStyle: const TextStyle(color: Colors.black, fontSize: 15),
      //prefixIcon: leading,
      //contentPadding: EdgeInsets.zero,
      // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      errorMaxLines: 2,
      counterText: "",
      hintText: "  $label",

      alignLabelWithHint: true,
      fillColor: Colors.white,
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffD9D9D9)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffD9D9D9)),
      ),

      isDense: true,
      helperStyle: const TextStyle(fontSize: 8),

      helperMaxLines: 15,
    );
