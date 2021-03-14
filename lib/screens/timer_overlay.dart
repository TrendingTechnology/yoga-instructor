import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:sofia/screens/preview_screen.dart';
import 'package:video_player/video_player.dart';

class TimerOverlay extends StatefulWidget {
  @override
  _TimerOverlayState createState() => _TimerOverlayState();
}

class _TimerOverlayState extends State<TimerOverlay> {
  Timer _timer;
  int _start = 5;
  VideoPlayerController _controller;

  bool _isInitialized = false;

  Future<void> initializeVideoController() async {
    _controller = VideoPlayerController.network(
        'https://stream.mux.com/kiBM5MAziq4wGLnc2GCVixAL8EXYg7wcUDA00VcSkzNM.m3u8.m3u8');
    await _controller.initialize();

    _isInitialized = true;

    print(_isInitialized);
  }

  @override
  void initState() {
    super.initState();
    initializeVideoController();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_start == 1 && _isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                PreviewScreen(videoPlayerController: _controller),
          ),
        );
      });
    }
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      body: SafeArea(
        child: Stack(
          children: [
            FlareActor(
              "assets/rive/loading_1.flr",
              // alignment: Alignment.center,
              // fit: BoxFit.fitWidth,
              animation: "run",
            ),
            Center(
              child: Text(
                '$_start',
                style: TextStyle(
                  fontSize: 100.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
