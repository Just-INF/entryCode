import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final double width;
  final double height;
  final String videoUrl;
  final bool shouldPlay;

  const CustomVideoPlayer({
    required this.width,
    required this.height,
    required this.videoUrl,
    required this.shouldPlay,
    Key? key,
  }) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoUrl != oldWidget.videoUrl || widget.shouldPlay != oldWidget.shouldPlay) {
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        if (widget.shouldPlay) {
          _controller.play();
        } else {
          _controller.pause();
        }
        setState(() {});
      }).catchError((error) {
        print('Error loading video: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
