import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/screens/home_page.dart';
import 'package:sofia/speech/output_speech.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';

bool isPredicted;

int predictionStatus = 0;

/// Widget for creating the Prediction screen,
/// where the recognition of the poses occur
/// and the user is given proper feedback according to it
class PredictorPage extends StatefulWidget {
  final String videoName;

  PredictorPage(this.videoName);

  @override
  _PredictorPageState createState() => _PredictorPageState();
}

class _PredictorPageState extends State<PredictorPage> {
  VideoPlayerController videoPlayerController;
  CameraController _cameraController;
  FlutterTts flutterTts = FlutterTts();

  GlobalKey<ScaffoldState> _key = GlobalKey();
  PersistentBottomSheetController _controller;
  // var timer;

  Size screenSize;

  int _currentPosition = 0;

  String _assistantText = '';
  String _userText = '';

  bool _isListening = false;

  static int delay = 10;

  // For surya namaskar
  // List<int> durationList = [
  //   13,
  //   25 + delay,
  //   41 + delay * 2,
  //   56 + delay * 3,
  //   71 + delay * 4,
  //   82 + delay * 5,
  //   92 + delay * 6,
  //   117 + delay * 7,
  //   131 + delay * 8,
  //   142 + delay * 9,
  //   154 + delay * 10,
  //   165 + delay * 11,
  //   175 + delay * 12,
  // ];

  // For trikonasana
  List<int> durationList = [
    14,
    35 + delay,
    49 + delay * 2,
    82 + delay * 3,
    115 + delay * 4,
    123 + delay * 5,
    137 + delay * 6,
  ];

  // For text to speech
  double volume = 0.8;
  double pitch = 1;
  double rate = Platform.isAndroid ? 0.8 : 0.6;

  // For speech to text
  final SpeechToText speech = SpeechToText();

  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];

  Future<void> _initVideoPlayer() async {
    videoPlayerController =
        VideoPlayerController.asset('assets/videos/${widget.videoName}')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          })
          ..setVolume(1)
          ..play()
          ..addListener(() {
            final bool isPlaying = videoPlayerController.value.isPlaying;

            if (isPlaying) {
              _currentPosition = videoPlayerController.value.position.inSeconds;
              print("CURRENT POS: $_currentPosition");
            }
          });
  }

  Future _speak(String speechText) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    await flutterTts.speak(speechText);
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );

    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  Future<void> startListening() async {
    _isListening = true;
    lastWords = "";
    lastError = "";
    await speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 10),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      partialResults: true,
    );
    setState(() {});
  }

  Future<void> stopListening() async {
    await speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
    });
    _controller.setState(() {
      String input = lastWords.split(' - ')[0];
      _userText = input[0].toUpperCase() + input.substring(1);
    });
    print(lastWords);
    print('USER INPUT: $_userText');

    // To check if the speech was recognized
    // with good probability
    if (result.finalResult && !_isListening) {
      stopListening();
      // Checking the recognized words
      // if (_userText == 'Yes') {
      //   stopListening();
      //   _controller.setState(() {
      //     _assistantText = startWithTrack;
      //   });
      //   _speak(startWithTrack);
      // } else if (_userText == 'No') {
      //   stopListening();
      //   setState(() {
      //     _isListening = false;
      //   });
      //   _controller.setState(() {
      //     _isListening = false;
      //   });

      //   // Navigator.of(context).push(
      //   //   MaterialPageRoute(
      //   //     builder: (context) => HomePage(afterCompletion: true),
      //   //   ),
      //   // );
      // } else {
      //   _controller.setState(() {
      //     _assistantText = notRecognized;
      //   });
      //   _speak(notRecognized);
      //   stopListening();
      //   flutterTts.setCompletionHandler(() async {
      //     _hasSpeech ? null : await initSpeechState();
      //     !_hasSpeech || speech.isListening ? null : await startListening();
      //   });
      // }
    } else {
      // If speech not recognized
      // stopListening();
      // _controller.setState(() {
      //   _assistantText = notRecognized;
      //   _speak(notRecognized);
      // });
    }
  }

  void errorListener(SpeechRecognitionError error) {
    print("Received error status: $error, listening: ${speech.isListening}");
    // setState(() {
    //   lastError = "${error.errorMsg} - ${error.permanent}";
    // });
  }

  void statusListener(String status) {
    print(
      "Received listener status: $status, listening: ${speech.isListening}",
    );
    setState(() {
      lastStatus = "$status";
      // speech.isListening ? _isListening = true : _isListening = false;
    });

    _controller.setState(() {
      speech.isListening ? _isListening = true : _isListening = false;
    });
    if (!_isListening) {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(afterCompletion: true),
      //   ),
      // );
    }
  }

  @override
  void initState() {
    isPredicted = false;
    super.initState();

    _initVideoPlayer();

    _cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    //  0 pause
    // +1 speak
    // +9 move on -> 4
    // +14 status 0 -> 9
    // +14 play -> 9

    for (int i = 0; i < durationList.length; i++) {
      Timer(Duration(seconds: durationList[i]), () {
        setState(() {
          videoPlayerController.pause();
        });
      });
      Timer(Duration(seconds: durationList[i] + 0), () {
        setState(() {
          predictionStatus = 1;
          flutterTts.speak('Recognizing the pose');
        });
      });

      if (i == 6) {
        Timer(Duration(seconds: durationList[i] + 4), () {
          setState(() {
            predictionStatus = 2;
            flutterTts.speak('Triangle pose successfully complete');
          });
        });
      } else if (i == 3) {
        Timer(Duration(seconds: durationList[i] + 4), () {
          setState(() {
            predictionStatus = 4;
            flutterTts
                .speak('Couldn\'t recognize. Can you please repeat the pose?');
          });
        });
        Timer(Duration(seconds: durationList[i] + 9), () {
          setState(() {
            predictionStatus = 0;
          });
        });
        Timer(Duration(seconds: durationList[i] + 9), () {
          setState(() {
            videoPlayerController.seekTo(Duration(seconds: 49));
            videoPlayerController.play();
          });
        });
      } else {
        Timer(Duration(seconds: durationList[i] + 4), () {
          setState(() {
            predictionStatus = 2;
            flutterTts.speak('Moving on to the next step');
          });
        });
        Timer(Duration(seconds: durationList[i] + 9), () {
          setState(() {
            predictionStatus = 0;
          });
        });
        Timer(Duration(seconds: durationList[i] + 9), () {
          setState(() {
            videoPlayerController.play();
          });
        });
      }
    }

    // // First Step
    // Timer(Duration(seconds: 21), () {
    //   setState(() {
    //     videoPlayerController.pause();
    //   });
    // });
    // Timer(Duration(seconds: 22), () {
    //   setState(() {
    //     predictionStatus = 1;
    //     flutterTts.speak('Recognizing the pose');
    //   });
    // });
    // Timer(Duration(seconds: 30), () {
    //   setState(() {
    //     predictionStatus = 2;
    //     flutterTts.speak('Let\'s move on to the next step');
    //   });
    // });

    // // Second Step
    // Timer(Duration(seconds: 36), () {
    //   setState(() {
    //     predictionStatus = 0;
    //   });
    // });
    // Timer(Duration(seconds: 36), () {
    //   setState(() {
    //     videoPlayerController.play();
    //   });
    // });
    // Timer(Duration(seconds: 57), () {
    //   setState(() {
    //     videoPlayerController.pause();
    //   });
    // });
    // Timer(Duration(seconds: 58), () {
    //   setState(() {
    //     predictionStatus = 1;
    //     flutterTts.speak('Recognizing the pose');
    //   });
    // });
    // Timer(Duration(seconds: 67), () {
    //   setState(() {
    //     predictionStatus = 2;
    //     flutterTts.speak('Great! Moving on to the last step');
    //   });
    // });

    // // Third step
    // Timer(Duration(seconds: 72), () {
    //   setState(() {
    //     predictionStatus = 0;
    //   });
    // });
    // Timer(Duration(seconds: 72), () {
    //   setState(() {
    //     videoPlayerController.play();
    //   });
    // });
    // Timer(Duration(seconds: 112), () {
    //   setState(() {
    //     videoPlayerController.pause();
    //   });
    // });
    // Timer(Duration(seconds: 113), () {
    //   setState(() {
    //     predictionStatus = 1;
    //     flutterTts.speak('Recognizing the pose');
    //   });
    // });
    // Timer(Duration(seconds: 127), () {
    //   setState(() {
    //     predictionStatus = 2;
    //     flutterTts.speak('You have successfully completed the pose!');
    //     print('COMPLETE');
    //   });
    // });

    // Timer(Duration(seconds: 132), () {
    //   setState(() {
    //     videoPlayerController.play();
    //   });
    // });

    Timer(Duration(seconds: durationList[6] + 9), () async {
      _controller = _key.currentState.showBottomSheet(
        (_) => Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(10),
            //   topRight: Radius.circular(10),
            // ),
          ),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                // bottom: screenSize.height / 20,
                left: screenSize.width / 30,
                right: screenSize.width / 30,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height / 40),
                    child: Text(
                      'SOFIA',
                      style: GoogleFonts.montserrat(
                          color: Colors.white38,
                          fontSize: 22,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenSize.width / 5,
                            ),
                            child: Text(
                              _assistantText,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: screenSize.width / 5),
                            child: Text(
                              _userText,
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    visible: _isListening,
                    child: Padding(
                      padding: EdgeInsets.only(top: screenSize.height / 40),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.black12,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          height: screenSize.height * 0.35,
        ),
      );

      await _speak('');
      flutterTts.setCompletionHandler(() async {
        _controller.setState(() {
          _assistantText = poseCompletion;
        });
        await Future.delayed(Duration(milliseconds: 600));
        await _speak(poseCompletion);
        flutterTts.setCompletionHandler(() async {
          await flutterTts.stop();
          _hasSpeech ? null : await initSpeechState();
          !_hasSpeech || speech.isListening ? null : await startListening();
        });
      });
    });

    Timer(Duration(seconds: durationList[6] + 16), () async {
      // _speak('');
      stopListening();
      setState(() {});
      _controller.setState(() {
        _assistantText = oneCompletionString;
      });
      await Future.delayed(Duration(milliseconds: 600));
      await _speak(oneCompletion);
      flutterTts.setCompletionHandler(() async {
        await flutterTts.stop();
        _controller.setState(() {
          _assistantText = exploreTracksCompletion;
        });
        await Future.delayed(Duration(milliseconds: 600));
        await _speak(exploreTracksCompletion);
        flutterTts.setCompletionHandler(() async {
          await flutterTts.stop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(afterCompletion: true),
            ),
          );
        });
      });
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
    });
    // isPredicted = true;
    return Scaffold(
      key: _key,
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 30,
                ),
                child: Center(
                  child: Text(
                    "TRIANGLE POSE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              videoPlayerController.value.initialized
                  ? AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    )
                  : Container(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _cameraController.value.isInitialized
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            // height: screenSize.height * 0.45,
                            // width: screenSize.width / 1.5,
                            child: AspectRatio(
                              aspectRatio: _cameraController.value.aspectRatio,
                              child: CameraPreview(_cameraController),
                            ),
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: _predictionStatus(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       videoPlayerController.value.isPlaying
      //           ? videoPlayerController.pause()
      //           : videoPlayerController.play();
      //     });
      //   },
      //   child: Icon(
      //     videoPlayerController.value.isPlaying
      //         ? Icons.pause
      //         : Icons.play_arrow,
      //   ),
      //   backgroundColor: Colors.grey,
      // ),
    );
  }

  Widget _predictionStatus() {
    if (isPredicted) {
      // firstTime = false;
      videoPlayerController.setVolume(0);
      flutterTts.setSpeechRate(0.5);
      flutterTts.speak("Mountain pose successfully complete!");
      videoPlayerController.pause();
      // _videoController?.dispose();
      // Timer(Duration(seconds: 5), () {
      //   Navigator.of(context).pop();
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return DashboardScreen();
      //       },
      //     ),
      //   );
      // });
    }

    switch (predictionStatus) {
      // case 0:
      //   return Center(
      //     child: Text(
      //       'Follow the video',
      //       style: TextStyle(color: Colors.grey[800], fontSize: 20),
      //     ),
      //   );
      case 1:
        return Column(
          children: <Widget>[
            Text(
              'Processing',
              style: TextStyle(color: Colors.amber, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.amber,
                ),
              ),
            )
          ],
        );
        break;
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Successful',
              style: TextStyle(color: Colors.greenAccent, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
                size: 30,
              ),
            )
          ],
        );
        break;
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Failed',
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.close,
                color: Colors.redAccent,
                size: 30,
              ),
            )
          ],
        );
        break;
      default:
        return Center(
          child: Text(
            'Follow the video',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
        break;
    }
    // return isPredicted
    //     ? Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           Text(
    //             'Successful',
    //             style: TextStyle(color: Colors.greenAccent, fontSize: 20),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           SizedBox(
    //             height: 30,
    //             width: 30,
    //             child: Icon(
    //               Icons.check_circle,
    //               color: Colors.greenAccent,
    //               size: 30,
    //             ),
    //           )
    //         ],
    //       )
    //     : Column(
    //         children: <Widget>[
    //           Text(
    //             'Processing',
    //             style: TextStyle(color: Colors.amber, fontSize: 20),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           SizedBox(
    //             height: 30,
    //             width: 30,
    //             child: CircularProgressIndicator(
    //               valueColor: AlwaysStoppedAnimation<Color>(
    //                 Colors.amber,
    //               ),
    //             ),
    //           )
    //         ],
    //       );
  }
}
