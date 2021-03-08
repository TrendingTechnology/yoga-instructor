import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/screens/predictor_page.dart';
import 'package:sofia/speech/output_speech.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceAssistantButton extends StatefulWidget {
  @override
  _VoiceAssistantButtonState createState() => _VoiceAssistantButtonState();
}

class _VoiceAssistantButtonState extends State<VoiceAssistantButton> {
  PersistentBottomSheetController _controller;

  final SpeechToText speech = SpeechToText();

  // For text to speech
  FlutterTts flutterTts;

  String _assistantText = '';
  String _userText = '';

  dynamic languages;
  String language;
  double volume = 0.8;
  double pitch = 1;
  double rate = Platform.isAndroid ? 0.8 : 0.6;

  bool _isOpen = true;
  IconData fabIcon = Icons.mic;

  // For speech to text
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];

  bool _isListening = false;

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

  Future _pause() async {
    await flutterTts.pause();
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();
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
      if (_userText == 'Yes') {
        stopListening();
        _controller.setState(() {
          _assistantText = startWithTrack;
        });
        _speak(startWithTrack);
        flutterTts.setCompletionHandler(() async {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PredictorPage('trikonasana.mp4'),
            ),
          );
        });
      } else if (_userText == 'No') {
        stopListening();
        _controller.setState(() {
          _assistantText = exploreTracks;
        });
        _speak(exploreTracks);
        flutterTts.setCompletionHandler(() async {
          Navigator.of(context).pop();
          setState(() {
            fabIcon = Icons.mic;
          });
        });
      } else {
        _controller.setState(() {
          _assistantText = notRecognized;
        });
        _speak(notRecognized);
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
  }

  @override
  initState() {
    super.initState();
    initTts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FloatingActionButton(
      heroTag: 'voice_assistant',
      onPressed: () async {
        setState(() {
          _isOpen = _isOpen == false ? true : false;
          _assistantText = '';
        });

        if (_isOpen) {
          fabIcon = Icons.mic;
          _stop();
        } else {
          fabIcon = Icons.stop;
        }

        if (_isOpen) {
          Navigator.of(context).pop();
        } else {
          _controller = showBottomSheet(
            elevation: 5,
            context: context,
            builder: (context) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
              height: screenSize.height * 0.30,
            ),
          );

          await _speak('');
          flutterTts.setCompletionHandler(() async {
            _controller.setState(() {
              _assistantText = greetings1;
            });
            await Future.delayed(Duration(milliseconds: 600));
            await _speak(greetings1);
            flutterTts.setCompletionHandler(() async {
              _controller.setState(() {
                _assistantText = greetings2;
              });
              await Future.delayed(Duration(milliseconds: 600));
              await _speak(greetings2);
              flutterTts.setCompletionHandler(() async {
                _controller.setState(() {
                  _assistantText = askToStartWithBeginners;
                });
                await Future.delayed(Duration(milliseconds: 600));
                await _speak(askToStartWithBeginners);
                flutterTts.setCompletionHandler(() async {
                  await flutterTts.stop();
                  _hasSpeech ? null : await initSpeechState();
                  !_hasSpeech || speech.isListening
                      ? null
                      : await startListening().whenComplete(() {
                          // _controller.setState(() {
                          //   _userText = lastWords;
                          //   print(lastWords);
                          // });
                        });
                });
              });
            });
          });

          // flutterTts.getVoices;

          // await _speak(greetings2);
          // flutterTts.setCompletionHandler(() async {
          //   _controller.setState(() {
          //     _assistantText = greetings2;
          //   });
          // });

          // await _speak(askToStartWithBeginners);
          // flutterTts.setCompletionHandler(() async {
          //   _controller.setState(() {
          //     _assistantText = askToStartWithBeginners;
          //   });
          // });
        }
      },
      backgroundColor: Colors.pinkAccent[700],
      child: Icon(fabIcon, color: Colors.white),
    );
  }
}
