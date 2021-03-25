import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';
import 'dart:math' as math;

import 'package:supercharged/supercharged.dart';

enum AnimProps {
  accuracy,
  title,
  subtitle,
  stars,
  time,
  opacity,
}

class ScoreOverlay extends StatefulWidget {
  final Pose pose;
  final double totalAccuracy;

  const ScoreOverlay({
    Key key,
    @required this.pose,
    @required this.totalAccuracy,
  }) : super(key: key);

  @override
  _ScoreOverlayState createState() => _ScoreOverlayState();
}

class _ScoreOverlayState extends State<ScoreOverlay>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<TimelineValue<AnimProps>> _animation;

  Timer _timer;
  int _start = 5;
  // Pose _currentPose;

  @override
  void initState() {
    super.initState();
    // _currentPose = widget.pose;
    // startTimer();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = TimelineTween<AnimProps>()
        .addScene(
          begin: 0.milliseconds,
          end: 1000.milliseconds,
          curve: Curves.easeOut,
        )
        .animate(
          AnimProps.accuracy,
          tween: Tween(begin: 0.0, end: widget.totalAccuracy),
        )
        .addSubsequentScene(
          delay: 200.milliseconds,
          duration: 600.milliseconds,
          curve: Curves.bounceOut,
        )
        .animate(AnimProps.title, tween: Tween(begin: 0.0, end: 1.0))
        .addSubsequentScene(
          delay: 200.milliseconds,
          duration: 600.milliseconds,
          curve: Curves.easeIn,
        )
        .animate(AnimProps.subtitle, tween: Tween(begin: 0.0, end: 1.0))
        .addSubsequentScene(
          delay: 200.milliseconds,
          duration: 600.milliseconds,
          curve: Curves.easeIn,
        )
        .animate(AnimProps.stars, tween: Tween(begin: 0.0, end: 1.0))
        .addSubsequentScene(
          delay: 200.milliseconds,
          duration: 1000.milliseconds,
          curve: Curves.easeIn,
        )
        .animate(AnimProps.time, tween: Tween(begin: 0.0, end: 1.0))
        .addSubsequentScene(
          delay: 200.milliseconds,
          duration: 600.milliseconds,
          curve: Curves.easeInOut,
        )
        .animate(AnimProps.opacity, tween: Tween(begin: 0.0, end: 1.0))
        .parent
        .animatedBy(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // if (_start == 1) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     // Navigator.of(context).pushReplacement(
    //     //   MaterialPageRoute(
    //     //     builder: (context) => PreviewScreen(),
    //     //   ),
    //     // );
    //     Navigator.of(context).pop();
    //   });
    // }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => _buildAnimation(
            context: context,
            child: child,
            height: height,
            width: width,
          ),
        )),
      ),
    );
  }

  Widget _buildAnimation({
    @required BuildContext context,
    @required Widget child,
    @required height,
    @required width,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Opacity(
          opacity: _animation.value.get(AnimProps.opacity),
          child: Container(
            width: double.maxFinite,
            color: Palette.accentDarkPink,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'You will be redirected to the dashboard in ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'GoogleSans',
                    letterSpacing: 1,
                  ),
                  children: [
                    TextSpan(
                      text: '5 seconds',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: height - 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Accuracy',
                      style: TextStyle(
                        color: Palette.black,
                        fontSize: 24.0,
                        fontFamily: 'GoogleSans',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        height: height / 2,
                        width: height / 2,
                        child: CustomPaint(
                          painter: TotalAccuracyPainter(
                            width: width,
                            height: height,
                            accuracy: _animation.value.get(AnimProps.accuracy),
                          ),
                          child: SizedBox(
                            height: height / 2,
                            width: height / 2,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${_animation.value.get(AnimProps.accuracy) == 1.0 ? 100 : (_animation.value.get(AnimProps.accuracy) * 100).toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 46.0,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.darkShade,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: _animation.value.get(AnimProps.title),
                      child: Text(
                        'Congratulations 🎉',
                        style: TextStyle(
                          color: Colors.greenAccent.shade400,
                          fontSize:
                              36.0 * _animation.value.get(AnimProps.title),
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Opacity(
                      opacity: _animation.value.get(AnimProps.subtitle),
                      child: Text(
                        'you have successfully completed the triangle pose',
                        style: TextStyle(
                          color: Palette.black,
                          fontSize: 24.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Opacity(
                      opacity: _animation.value.get(AnimProps.stars),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Palette.accentDarkPink,
                            size: 36.0,
                          ),
                          SizedBox(width: 16.0),
                          RichText(
                            text: TextSpan(
                              text: '19 ',
                              style: TextStyle(
                                color: Palette.accentDarkPink,
                                fontSize: 26.0,
                                fontFamily: 'GoogleSans',
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '/ 20',
                                  style: TextStyle(
                                    color:
                                        Palette.accentDarkPink.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Opacity(
                      opacity: _animation.value.get(AnimProps.time),
                      child: Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Palette.accentDarkPink,
                            size: 36.0,
                          ),
                          SizedBox(width: 16.0),
                          Text(
                            '3min 15sec',
                            style: TextStyle(
                              color: Palette.accentDarkPink,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TotalAccuracyPainter extends CustomPainter {
  final double width;
  final double height;
  final double accuracy;

  TotalAccuracyPainter({
    @required this.width,
    @required this.height,
    @required this.accuracy,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Palette.lightShade
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var paint2 = Paint()
      ..color = Palette.lightDarkShade
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(height / 4, height / 4),
        height: 180,
        width: 180,
      ),
      (2 * math.pi) / 3,
      (5 * math.pi) / 3,
      false,
      paint1,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(height / 4, height / 4),
        height: 180,
        width: 180,
      ),
      (2 * math.pi) / 3,
      ((5 * math.pi) / 3) * accuracy,
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(TotalAccuracyPainter oldDelegate) {
    return accuracy != oldDelegate.accuracy;
  }
}
