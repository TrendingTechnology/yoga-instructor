import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/main.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/screens/timer_overlay.dart';
import 'package:tflite/tflite.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

class PreviewScreen extends StatefulWidget {
  final Pose pose;

  const PreviewScreen({
    Key key,
    @required this.pose,
  }) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController _videoController;

  CameraController _cameraController;

  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  bool _isBodyVisible = false;
  bool isDetecting = false;
  bool isInLandscape = false;

  int totalPartsInFrame = 0;
  int totalNumOfTimesPositive = 0;

  Future<void> initializeVideoController() async {
    _videoController = VideoPlayerController.network(
        'https://stream.mux.com/kiBM5MAziq4wGLnc2GCVixAL8EXYg7wcUDA00VcSkzNM.m3u8.m3u8');
    await _videoController.initialize();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    totalPartsInFrame = 0;
    _isBodyVisible = false;
    if (mounted) {
      setState(() {
        _recognitions = recognitions;
        _imageHeight = imageHeight;
        _imageWidth = imageWidth;
      });
      // _recognitions.isNotEmpty
      //     ? print('RECOG: ${_recognitions[0]['keypoints']}')
      //     : null;

      if (_recognitions.isNotEmpty) {
        Map<dynamic, dynamic> partsMap = _recognitions[0]['keypoints'];
        partsMap.forEach((key, value) {
          double score = value['score'];

          if (score > 0.5) {
            totalPartsInFrame++;
          }
        });

        print('TOTAL PARTS: $totalPartsInFrame');

        if (totalPartsInFrame > 11) {
          setState(() {
            _isBodyVisible = true;
            totalNumOfTimesPositive++;
            // Tflite?.close();
            // _cameraController?.stopImageStream();
          });
        }

        if (totalNumOfTimesPositive > 5) {
          Tflite?.close();
          _cameraController?.stopImageStream();
          print('READY');
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, _, __) => TimerOverlay(
                pose: widget.pose,
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> initializeCameraController() async {
    await Tflite.loadModel(
      model: "assets/model/posenet.tflite",
      numThreads: 4,
    );

    _cameraController = CameraController(cameras[1], ResolutionPreset.low);
    _cameraController.initialize().then((_) async {
      if (!mounted) {
        return;
      }

      _cameraController.startImageStream((CameraImage image) {
        // print('IMAGE: ${image.height} x ${image.width}');

        if (!isDetecting && isInLandscape) {
          isDetecting = true;

          Tflite.runPoseNetOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            asynch: true,
            rotation: 180,
            numResults: 1,
            threshold: 0.2,
          ).then(
            (recognitions) {
              // print(recognitions);
              setRecognitions(
                recognitions,
                image.height,
                image.width,
              );
              isDetecting = false;
            },
          );
        }
      });
    });
  }

  fixInLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isInLandscape = true;
      });
    });
  }

  @override
  void initState() {
    // _videoController = _videoController..play();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    initializeCameraController();
    initializeVideoController();
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _cameraController?.dispose();

    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (_cameraController == null || !_cameraController.value.isInitialized) {
    //   return Container();
    // }

    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    // print(
    //     'Sensor rotation: ${_cameraController.description.sensorOrientation}');
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // var tmp = MediaQuery.of(context).size;
    // var screenH = math.max(tmp.height, tmp.width);
    // var screenW = math.min(tmp.height, tmp.width);
    // tmp = _cameraController.value.previewSize;
    // var previewH = math.max(tmp.height, tmp.width);
    // var previewW = math.min(tmp.height, tmp.width);
    // var screenRatio = screenH / screenW;
    // var previewRatio = previewH / previewW;

    // return OverflowBox(
    //   maxHeight:
    //       screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
    //   maxWidth:
    //       screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
    //   child: CameraPreview(_cameraController),
    // );

    // return Scaffold(
    //   resizeToAvoidBottomPadding: false,
    //   body: Row(
    //     children: [
    //       Expanded(
    //         child: Container(
    //           color: Colors.green,
    //         ),
    //       ),
    //       RotatedBox(
    //         quarterTurns: 3,
    //         child: Container(
    //           // height: screenSize.height * 0.45,
    //           // width: screenSize.width / 1.5,
    //           child: AspectRatio(
    //             aspectRatio: _cameraController.value.aspectRatio,
    //             child: CameraPreview(_cameraController),
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: Container(
    //           color: Colors.green,
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/landspace_orientation.jpg'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Please rotate your device to the ',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: 'landscape mode.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text:
                                      '\n\nIf you want to auto-set the device orientation to landscape as you enter the preview mode, enable ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                  children: [
                                    TextSpan(
                                      text: '"Auto set orientation" ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                          text: 'in the settings.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Rotate to the right',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: '',
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Icon(Icons.arrow_forward_rounded),
                          ],
                        ),
                      )
                    ],
                  ),
                  // child: Text(
                  //   'Please rotate your device to the landscape mode. If you want to auto-set the device orientation to landscape as you enter the preview mode, enable "Auto set orientation" in the settings.',
                  // ),
                ),
              ],
            );
          } else {
            fixInLandscape();

            if (_cameraController.value.isInitialized) {
              return CameraPreviewWidget(
                isBodyVisible: _isBodyVisible,
                cameraController: _cameraController,
              );
            } else {
              return Container(
                color: Colors.white,
              );
            }
          }
        },
      ),
    );

    // return Scaffold(
    //   body: SafeArea(
    //     child: Stack(
    //       children: [
    //         Container(
    //           child: Center(
    //             child: Text(
    //               'Please make sure that your entire body is visible within the area.',
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         _videoController.value.initialized
    //             ? Flexible(
    //                 child: AspectRatio(
    //                   aspectRatio: _videoController.value.aspectRatio,
    //                   child: VideoPlayer(_videoController),
    //                 ),
    //               )
    //             : Container(),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({
    Key key,
    @required bool isBodyVisible,
    @required CameraController cameraController,
  })  : _isBodyVisible = isBodyVisible,
        _cameraController = cameraController,
        super(key: key);

  final bool _isBodyVisible;
  final CameraController _cameraController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isBodyVisible
          ? Colors.green.withOpacity(0.8)
          : Colors.red.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: Container(
              child: AspectRatio(
                aspectRatio: _cameraController.value.aspectRatio,
                child: CameraPreview(_cameraController),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
