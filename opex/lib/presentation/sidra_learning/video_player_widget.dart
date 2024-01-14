import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      materialProgressColors: ChewieProgressColors(
        playedColor: ColorPalette.primary,
        handleColor: ColorPalette.primary,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey[300]!,
      ),
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('My option works!'),
            iconData: Icons.chat,
            title: 'My localized title',
          ),
          OptionItem(
            onTap: () =>
                debugPrint('Another option that works!'),
            iconData: Icons.chat,
            title: 'Another localized title',
          ),
        ];
      },
      autoPlay: true,
      looping: false,
      allowMuting: false, // Hide volume button
      allowFullScreen: true,
      aspectRatio: 16 / 9, // Set the aspect ratio to 16:9
      showControls: true, // Hide play and stop buttons
      autoInitialize: true, // Automatically initializes the video player
      placeholder: Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      // Other customization options...
    );

    _controller.addListener(() {
      setState(() {
        _currentPosition = _controller.value.position;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) =>
      '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ],
    );
  }

  void _handleDoubleTap() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.duration;

    // Define the seeking duration
    final seekDuration = Duration(seconds: 10);

    // Determine if the double-tap is on the left or right side of the video
    final doubleTapPosition = MediaQuery.of(context).size.width / 2;

    if (currentPosition + seekDuration < duration && _controller.value.isPlaying) {
      // Seek forward if double-tap is on the right side
      if (currentPosition.inMilliseconds / duration.inMilliseconds < doubleTapPosition) {
        _controller.seekTo(currentPosition + seekDuration);
      } else {
        // Seek backward if double-tap is on the left side
        _controller.seekTo(currentPosition - seekDuration);
      }
    }
  }
}
