import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class RecognizerScreen extends StatefulWidget {
  final CameraController cameraController;
  final VideoPlayerController videoController;

  const RecognizerScreen({
    Key key,
    @required this.cameraController,
    @required this.videoController,
  }) : super(key: key);

  @override
  _RecognizerScreenState createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<RecognizerScreen> {
  VideoPlayerController _videoController;
  CameraController _cameraController;

  // Future<void> initializeVideoController() async {
  //   _videoController = VideoPlayerController.network(
  //       'https://stream.mux.com/kiBM5MAziq4wGLnc2GCVixAL8EXYg7wcUDA00VcSkzNM.m3u8.m3u8')
  //     ..initialize().then((_) {
  //       setState(() {});
  //     })
  //     ..play();

  //   setState(() {});
  // }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);

    _cameraController = widget.cameraController;
    _videoController = widget.videoController;
    _videoController.play();
    // initializeVideoController();

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    _videoController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _videoController.value.initialized
                ? OverflowBox(
                    maxWidth: screenSize.width,
                    maxHeight:
                        screenSize.width * _videoController.value.aspectRatio,
                    child: AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController),
                    ),
                  )
                : Container(),
            Hero(
              tag: 'camera_view',
              child: Align(
                alignment: Alignment.topRight,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: SizedBox(
                    width: screenSize.width * 0.16,
                    child: AspectRatio(
                      aspectRatio: _cameraController.value.aspectRatio,
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // child: Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Text(
        //         'pose',
        //         style: TextStyle(
        //           fontSize: 24.0,
        //         ),
        //       ),
        //     ),
        //     _videoController.value.initialized
        //         ? Flexible(
        //             child: AspectRatio(
        //               aspectRatio: _videoController.value.aspectRatio,
        //               child: VideoPlayer(_videoController),
        //             ),
        //           )
        //         : Container(),
        //   ],
        // ),
      ),
    );
  }
}
