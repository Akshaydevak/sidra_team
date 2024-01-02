import 'package:chewie/chewie.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/image_details_screen.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class MediaList extends StatelessWidget {
  final List<ChatModel>? messages;
  const MediaList({Key? key, this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.only(right: 10, left: 16),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: messages?.length ?? 0,
        itemBuilder: (BuildContext context, int i) {
          return 
          messages?[i].type == "image"
              ? InkWell(
                onTap: (){
                   Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return DetailScreen(
                                                image: messages?[i]
                                                        .message ??
                                                    "",
                                              );
                                            }));
                },
                child: Container(
                    width: w / 3,
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(messages?[i].message ?? ""),
                          fit: BoxFit.contain),
                    )),
              )
              : 
              messages?[i].type == "video"?
              Container(
                child: SvgPicture.string(TaskSvg().videoFileSvg),
              ):
                Container(
                child: SvgPicture.string(TaskSvg().documentSvg));
              // Container(
              //     height: MediaQuery.of(context).size.height / 2,
              //     width: MediaQuery.of(context).size.width / 3,
              //     // padding: const EdgeInsets.all(10),
              //     decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(10),
              //         topRight: Radius.circular(10),
              //         bottomLeft: Radius.circular(0),
              //         bottomRight: Radius.circular(10),
              //       ),
              //       color: Color(0xfff8f7f5),
              //     ),
              //     child: Chewie(
              //       controller: ChewieController(
              //           allowFullScreen: true,
              //           autoPlay: false,
              //           showControls: true,
              //           videoPlayerController: VideoPlayerController.network(
              //             messages?[i].message ?? "",
              //           )),
              //     ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 5,
          );
        },
      ),
    );
  }
}
