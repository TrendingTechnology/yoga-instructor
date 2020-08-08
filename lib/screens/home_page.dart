import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();

    // For uploading tracks to the database
    // database.uploadTracks();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
