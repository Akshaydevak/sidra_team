import 'dart:async';

import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final bool? looping;
  final bool? autoplay;
  final bool? me;
  final String? videoUrl;
  final AlignmentGeometry? alignmentGeometry;

  VideoPlayerScreen(
      {Key? key,
      required this.looping,
      required this.me,
      required this.autoplay,
      required this.videoUrl,
      required this.alignmentGeometry})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  ChewieController? _chewieController;
  Uri? uri ;
  VideoPlayerController? videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

@override
void initState(){
  uri = Uri.parse(widget.videoUrl!);
  videoPlayerController =VideoPlayerController.networkUrl(uri!);
  _initializeVideoPlayerFuture = videoPlayerController!.initialize().then((_) {
    //       Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
  // print("vediooooo${widget.videoPlayerController}");
super.initState();
}
@override
dispose(){
  videoPlayerController!.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return new Container(
    constraints:  BoxConstraints(
                                                  maxWidth: 275,
                                                 maxHeight:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height /
                                                                  2.5,
                                              ),
        //                                       decoration: BoxDecoration(
                                                
        //                                               // RoundedRectangleBorder(
        //                                             borderRadius: BorderRadius.only(
        //                                               topLeft: Radius.circular(10),
        //                                               topRight: Radius.circular(10),
        //                                               bottomLeft:
        //                                                   Radius.circular(10),
        //                                               bottomRight:
        //                                                   Radius.circular(0),
                                                          
        //                                             ),
        //                                             boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     offset: Offset(0, 1), // changes position of shadow
        //   ),
        // ],
                                                  // ),
                                                //  color: ColorPalette.primary,
                                                //   ),
                                              key:new PageStorageKey(widget.videoUrl) ,
                child: Padding(
                  padding: const EdgeInsets.only(top:8,bottom: 14,left:8,right: 8),
                  child: Chewie(
                    key: new PageStorageKey(widget.videoUrl),
                    controller: ChewieController(
                      videoPlayerController: videoPlayerController!,
                      aspectRatio: 4/ 5,
                      maxScale: 3.5,
                      allowedScreenSleep: false,
                      // Prepare the video to be played and display the first frame
                      autoInitialize: true,
                      looping: false,
                      autoPlay: false,
                      // Errors can occur for example when trying to play a video
                     // from a non-existent URL
                      errorBuilder: (context, errorMessage) {
                        return Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
            else {
              return Center(
                child: CircularProgressIndicator(color: Colors.white,),);
            }
          },
        );
  }
}
