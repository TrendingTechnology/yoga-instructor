import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:sofia/res/palette.dart';

class TimerOverlay extends StatefulWidget {
  @override
  _TimerOverlayState createState() => _TimerOverlayState();
}

class _TimerOverlayState extends State<TimerOverlay> {
  Timer _timer;
  int _start = 5;

  @override
  void initState() {
    super.initState();
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
    if (_start == 1) Navigator.of(context).pop();
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
