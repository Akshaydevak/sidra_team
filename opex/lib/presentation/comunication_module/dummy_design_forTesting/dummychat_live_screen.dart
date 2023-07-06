import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:math' as math;

class DummyChatLiveScreen extends StatefulWidget {
  final String? userName;
  final String? userCode;
  final bool? connected;
  final Socket socket;
  final List<MessageFormat>? sampleMessagesOfUser;
  const DummyChatLiveScreen(
      {super.key,
      this.userName,
      this.userCode,
      this.connected,
      this.sampleMessagesOfUser,
      required this.socket});

  @override
  State<DummyChatLiveScreen> createState() => _DummyChatLiveScreenState();
}

class _DummyChatLiveScreenState extends State<DummyChatLiveScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("the socket${widget.socket}");
    // widget.socket.on('latest.message', (data) {
    //   print("this is success for got message $data");
    // });

    // widget.socket.on('messages', (data) {
    //   print("conn messages ${data}");
    // });

    // print("send messages are this outside");
    // widget.socket.on('messages', (data) {
    //   print("send messages are this ${data}");
    // });
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          Text(widget.userName ?? "Username"),
          Text(
            widget.connected == true ? "online" : "offline",
            style: const TextStyle(fontSize: 14.0, color: Colors.white70),
          )
        ]),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 4,
                  );
                },
                itemBuilder: (context, index) {
                  return Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          child: Text(
                            widget.sampleMessagesOfUser?[index].content ?? "",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: CustomPaint(
                          painter: CustomShape(Colors.grey[300]!),
                        ),
                      ),
                    ],
                  ));
                },
                itemCount: widget.sampleMessagesOfUser?.length ?? 0,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10.0),
                        hintText: "Type a message"),
                  )),
                  IconButton(
                      onPressed: () {
                       
                        // widget.socket.on("send.message", (data) {
                        //   print("data is this bruh $data");
                        // });
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomShape extends CustomPainter {
  final Color bgColor;

  CustomShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
