import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class VideoPlayerWidget extends StatefulWidget {
  final List<String> videoUrls;
  final int initialIndex;

  VideoPlayerWidget({Key? key, required this.videoUrls, this.initialIndex = 0})
      : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  final CustomVideoPlayerSettings _customVideoPlayerSettings =
  const CustomVideoPlayerSettings(
    showSeekButtons: true,
    customAspectRatio: 16 / 9,
  );

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _videoPlayerController = VideoPlayerController.network(
      widget.videoUrls[currentIndex],
    )
      ..initialize().then((value) {
        setState(() {});
        _videoPlayerController.play();
      })
      ..addListener(() {
        if (_videoPlayerController.value.isBuffering) {
          // Handle buffering state, e.g., show a loading indicator
        }
      });

    _customVideoPlayerController = CustomVideoPlayerController(
      // prevTap: _playPrevious,nextTap: _playNext,
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _playNext() {
    if (currentIndex < widget.videoUrls.length - 1) {
      currentIndex++;
      _videoPlayerController.pause();
      _videoPlayerController.dispose();
      _initializePlayer();
    }
  }

  void _playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      _videoPlayerController.pause();
      _videoPlayerController.dispose();
      _initializePlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Sidra Learning",
          isAction: false,
          onTap: () {},
          // action: Row(
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.skip_previous),
          //       onPressed: _playPrevious,
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.skip_next),
          //       onPressed: _playNext,
          //     ),
          //   ],
          // ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _videoPlayerController.value.isBuffering
                  ? CircularProgressIndicator(color: Colors.deepOrange,)
                  : Container(),
              CustomVideoPlayer(
                // nextTap: _playNext,
                // prevTap: _playPrevious,
                customVideoPlayerController: _customVideoPlayerController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
