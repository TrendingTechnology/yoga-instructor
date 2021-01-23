import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/login_page.dart';
import 'package:sofia/screens/track_page.dart';
import 'package:sofia/speech/output_speech.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/utils/sign_in.dart';
import 'package:sofia/widget/voice_assistant_button.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  final bool afterCompletion;
  HomePage({this.afterCompletion = false});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database database = Database();

  List<Widget> result = [];
  FlutterTts flutterTts = FlutterTts();

  GlobalKey<ScaffoldState> _key = GlobalKey();
  PersistentBottomSheetController _controller;
  // var timer;

  var screenSize;

  int _currentPosition = 0;

  String _assistantText = '';
  String _userText = '';

  bool _isListening = false;

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

  /// For invoking a TTS voice output
  Future _speak(String speechText) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    // _controller.setState(() {
    //   _assistantText = speechText;
    // });

    await flutterTts.speak(speechText);

    // if (speechText != null) {
    //   if (speechText.isNotEmpty) {
    //     await flutterTts.speak(speechText);
    //   }
    // }
    // await Future.delayed(Duration(seconds: 4));
  }

  /// Initializing the Speech to Text API
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

  /// To start listening for voice input
  /// given by the user
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

  /// Stop the voice input recognition
  Future<void> stopListening() async {
    await speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  /// For cancelling a voice input recognition
  /// even if the processing is not complete (force stop)
  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// For specifying how load or low voice it should
  /// pich up for recognition
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  /// After voice is recognized, use the result
  /// for making decision accordingly
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
      if (_userText == 'Yes') {
        stopListening();
        _controller.setState(() {
          _assistantText = startWithTrack;
        });
        _speak(startWithTrack);
      } else if (_userText == 'No') {
        stopListening();
        setState(() {
          _isListening = false;
        });
        _controller.setState(() {
          _isListening = false;
        });

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(afterCompletion: true),
        //   ),
        // );
      } else {
        _controller.setState(() {
          _assistantText = notRecognized;
        });
        _speak(notRecognized);
        stopListening();
        flutterTts.setCompletionHandler(() async {
          _hasSpeech ? null : await initSpeechState();
          !_hasSpeech || speech.isListening ? null : await startListening();
        });
      }
    } else {
      // If speech not recognized
      // stopListening();
      // _controller.setState(() {
      //   _assistantText = notRecognized;
      //   _speak(notRecognized);
      // });
    }
  }

  /// Handling error case
  void errorListener(SpeechRecognitionError error) {
    print("Received error status: $error, listening: ${speech.isListening}");
    // setState(() {
    //   lastError = "${error.errorMsg} - ${error.permanent}";
    // });
  }

  /// To understand when the speech recognition is listening
  /// to the user input and when it is complete
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
    super.initState();

    // For uploading tracks to the database
    // database.uploadTracks();
  }

  /// For generating the widgets to be displayed on the home screen
  generateChildren(var screenSize, String trackName, String desc) {
    result.add(
      Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenSize.width / 20,
            right: screenSize.width / 20,
            bottom: screenSize.height / 30,
          ),
          child: Material(
            color: Colors.transparent,
            child: Card(
              elevation: 3,
              shadowColor: Color(0xFFffc7b8),
              color: Color(0xFFffe5de),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenSize.width / 10),
              ),
              // height: screenSize.height / 10,
              // width: double.maxFinite,
              // decoration: BoxDecoration(
              //   color: Color(0xFFffe5de),
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(20),
              //   ),
              // ),
              child: InkWell(
                borderRadius: BorderRadius.circular(screenSize.width / 10),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TrackPage(
                        trackName: trackName,
                        desc: desc,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height / 80,
                    bottom: screenSize.height / 60,
                    left: screenSize.width / 15,
                    right: screenSize.width / 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            trackName.toUpperCase(),
                            style: GoogleFonts.openSans(
                              fontSize: screenSize.width / 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height / 8,
                        width: screenSize.height / 5,
                        child: Image.asset('assets/images/$trackName.png'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFFFFF3F0));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Color(0xFFffe5de),
      //   centerTitle: true,
      //   title: Text(
      //     '',
      //     style: TextStyle(color: Color(0xFFf3766e)),
      //   ),
      // ),
      floatingActionButton: VoiceAssistantButton(),
      body: FutureBuilder(
        future: database.retrieveTracks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String beginnersTrackName = snapshot.data[0].data['name'];
            String beginnersTrackDesc = snapshot.data[0].data['desc'];

            /// Generating the Name View tile
            Widget _nameView() {
              return FutureBuilder(
                future: database.retrieveUserInfo(),
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    String storedName = snapshot2.data['name'];
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3F0),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: screenSize.height / 60,
                          top: screenSize.height / 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hi, ${storedName != null ? storedName.split(' ')[0] : 'there'}!',
                              style: GoogleFonts.lato(
                                fontSize: screenSize.width / 15.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FlatButton(
                              onPressed: () async {
                                await signOutGoogle().whenComplete(
                                  () => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  ),
                                );
                              },
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Sign out',
                                style: GoogleFonts.poppins(
                                  letterSpacing: 0,
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              );
            }

            /// Generating the Beginners Track tile
            Widget _beginnersTrack() {
              return Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width / 20,
                  right: screenSize.width / 20,
                  bottom: screenSize.height / 30,
                ),
                child: Card(
                  elevation: 3,
                  shadowColor: Color(0xFFffc7b8),
                  color: Color(0xFFffe5de),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenSize.width / 10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height / 60,
                      bottom: screenSize.height / 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenSize.height / 80,
                            bottom: screenSize.height / 60,
                            left: screenSize.width / 80,
                            right: screenSize.width / 20,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: screenSize.width * 0.50,
                                child: Center(
                                  child: Text(
                                    beginnersTrackName.toUpperCase(),
                                    style: GoogleFonts.openSans(
                                      fontSize: screenSize.width / 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Image.asset('assets/images/$beginnersTrackName.png'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.80,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TrackPage(
                                    trackName: beginnersTrackName,
                                    desc: beginnersTrackDesc,
                                  ),
                                ),
                              );
                            },
                            color: Color(0xFFffc7b8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                screenSize.height / 30,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: screenSize.height / 60,
                                bottom: screenSize.height / 60,
                              ),
                              child: Text(
                                'START NOW',
                                style: GoogleFonts.poppins(
                                  letterSpacing: 2,
                                  color: Colors.black54,
                                  fontSize: screenSize.height / 38,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            result.clear();

            // Adding the widgets to the list
            result.add(_nameView());
            result.add(SizedBox(height: screenSize.height / 30));
            result.add(_beginnersTrack());
            result.add(Padding(
              padding: EdgeInsets.only(
                bottom: screenSize.height / 40,
              ),
              child: Center(
                child: Text(
                  'EXPLORE',
                  style: TextStyle(
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width / 25,
                      color: Colors.black54),
                ),
              ),
            ));

            for (int i = 1; i < snapshot.data.length; i++) {
              String trackName = snapshot.data[i].data['name'];
              String description = snapshot.data[i].data['desc'];
              generateChildren(screenSize, trackName, description);
            }

            // Displaying the list widgets
            return Container(
              color: Color(0xFFFFF3F0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: result,
              ),
            );
          }

          // While the result is being retreived from the API,
          // show this widget
          return Container(
            color: Color(0xFFFFF3F0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Color(0xFFffc7b8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
