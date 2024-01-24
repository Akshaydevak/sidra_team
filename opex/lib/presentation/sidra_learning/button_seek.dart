import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class SeekButtonsMy extends StatefulWidget {
  final CustomVideoPlayerController customVideoPlayerController;
  final VoidCallback nextTap;
  final VoidCallback prevTap;

  const SeekButtonsMy({Key? key, required this.customVideoPlayerController, required this.nextTap, required this.prevTap})
      : super(key: key);

  @override
  State<SeekButtonsMy> createState() => _SeekButtonsMyState();
}

class _SeekButtonsMyState extends State<SeekButtonsMy> {
  bool _areControlsVisible = true;

  @override
  void initState() {
    super.initState();
    _areControlsVisible =
        widget.customVideoPlayerController.areControlsVisible.value;
    widget.customVideoPlayerController.areControlsVisible.addListener(() {
      if (!mounted) return;
      setState(() {
        _areControlsVisible =
            widget.customVideoPlayerController.areControlsVisible.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      child: _areControlsVisible
          ? Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              color: Colors.black12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: GestureDetector(
                onTap: onSeekForward,
                onDoubleTap: widget.nextTap,
                child: const Icon(
                  Icons.rotate_left_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Material(
              color: Colors.black12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: GestureDetector(
                onTap: onSeekBack,
                onDoubleTap: widget.prevTap,
                child: const Icon(
                  Icons.rotate_right_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }

  void onSeekBack() async {
    Duration? currentPosition =
    await widget.customVideoPlayerController.videoPlayerController.position;
    Duration seekDuration = widget
        .customVideoPlayerController.customVideoPlayerSettings.seekDuration;
    if (currentPosition != null) {
      Duration seekResult = Duration(
          microseconds:
          currentPosition.inMicroseconds + seekDuration.inMicroseconds);
      widget.customVideoPlayerController.videoPlayerController
          .seekTo(seekResult);
    }
  }

  void onSeekForward() async {
    Duration? currentPosition =
    await widget.customVideoPlayerController.videoPlayerController.position;
    Duration seekDuration = widget
        .customVideoPlayerController.customVideoPlayerSettings.seekDuration;
    if (currentPosition != null) {
      Duration seekResult = Duration(
          microseconds:
          currentPosition.inMicroseconds - seekDuration.inMicroseconds);
      widget.customVideoPlayerController.videoPlayerController
          .seekTo(seekResult);
    }
  }
}


