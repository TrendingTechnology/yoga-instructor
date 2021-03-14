import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PreviewScreen extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const PreviewScreen({
    Key key,
    @required this.videoPlayerController,
  }) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController currentVideoController;

  @override
  void initState() {
    currentVideoController = widget.videoPlayerController..play();
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            currentVideoController.value.initialized
                ? Flexible(
                    child: AspectRatio(
                      aspectRatio: currentVideoController.value.aspectRatio,
                      child: VideoPlayer(currentVideoController),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
