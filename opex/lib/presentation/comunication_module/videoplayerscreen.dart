import 'dart:async';

import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final bool? looping;
  final bool? autoplay;
  final VideoPlayerController? videoPlayerController;
  final AlignmentGeometry? alignmentGeometry;

  VideoPlayerScreen(
      {Key? key,
      required this.looping,
      required this.autoplay,
      required this.videoPlayerController,
      required this.alignmentGeometry})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  ChewieController? _chewieController;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(10),
          ),
          color: ColorPalette.primary,
        ),
        alignment: widget.alignmentGeometry,
        child: Chewie(
          controller: ChewieController(
            allowFullScreen: false,
            videoPlayerController: widget.videoPlayerController!,
            aspectRatio: 5 / 8,
            autoInitialize: true,
            autoPlay: widget.autoplay!,
            looping: widget.looping!,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ));
  }
}
