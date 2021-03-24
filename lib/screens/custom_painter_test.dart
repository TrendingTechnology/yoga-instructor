import 'package:flutter/material.dart';
import 'package:sofia/res/palette.dart';
import 'dart:math' as math;

class CustomPainterTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofia: yoga trainer',
      // Redirect to the respective page as per the authentication info
      // Currently using DashboardPage instead of HomePage, to test
      // the new UI
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Colors.white,
        accentColor: Colors.white,
      ),
      home: CanvasArea(),
    );
  }
}

class CanvasArea extends StatelessWidget {
  const CanvasArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomPaint(
        painter: ShapePainter(width: width, height: height),
        child: Stack(
          children: [
            Container(
              child: Center(
                child: Text('90'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double width;
  final double height;

  ShapePainter({@required this.width, @required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Palette.lightShade
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var paint2 = Paint()
      ..color = Palette.lightDarkShade
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(width / 2, height / 2),
        height: 150,
        width: 150,
      ),
      (2 * math.pi) / 3,
      (5 * math.pi) / 3,
      false,
      paint1,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(width / 2, height / 2),
        height: 150,
        width: 150,
      ),
      (2 * math.pi) / 3,
      ((5 * math.pi) / 3) * 1,
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
