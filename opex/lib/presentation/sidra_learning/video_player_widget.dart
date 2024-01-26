import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../dashboard_screen/home_screen/homescreen_widget/application_model.dart';

class VideoPlayerWidget extends StatefulWidget {
  final List<String> videoUrls;
  late int initialIndex;
  final ApplicationModel? model;

  VideoPlayerWidget({Key? key, required this.videoUrls, this.initialIndex=0, this.model})
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

  // int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _videoPlayerController = VideoPlayerController.network(
      widget.videoUrls[widget.initialIndex],
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
      prevTap: _playPrevious,
      nextTap: _playNext,
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
    if (widget.initialIndex < widget.videoUrls.length - 1) {
      widget.initialIndex++;
      _videoPlayerController.pause();
      _videoPlayerController.dispose();
      _initializePlayer();
    }
  }

  void _playPrevious() {
    if (widget.initialIndex > 0) {
      widget.initialIndex--;
      _videoPlayerController.pause();
      _videoPlayerController.dispose();
      _initializePlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(
          label: "Back",
          isAction: false,
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_videoPlayerController.value.isInitialized) ...[
                AspectRatio(
                  aspectRatio: _customVideoPlayerSettings.customAspectRatio!,
                  child: Center(
                    child: CircularProgressIndicator(color: ColorPalette.primary,strokeWidth: 2),
                  ),
                ),
                // Video player widget
              ] else
                Container(
                  // Your CustomVideoPlayer widget
                  child: CustomVideoPlayer(
                    nextTap: _playNext,
                    prevTap: _playPrevious,
                    customVideoPlayerController: _customVideoPlayerController,
                  ),
                ),
              Container(
                width: w1,
                color: ColorPalette.cardBackground,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model?.title??"",
                      style: GoogleFonts.roboto(
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Description
                    Text(
                      widget.model?.subTitle??"",
                      style: GoogleFonts.roboto(
                        fontSize: w/28,
                        color: ColorPalette.subtextGrey
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
