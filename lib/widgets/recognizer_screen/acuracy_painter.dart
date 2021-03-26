import 'package:flutter/material.dart';
import 'package:sofia/res/palette.dart';
import 'dart:math' as math;

class AccuracyPainter extends CustomPainter {
  final double width;
  final double height;
  final double accuracy;

  AccuracyPainter({
    @required this.width,
    @required this.height,
    @required this.accuracy,
  });

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
        center: Offset(height / 4, height / 4),
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
        center: Offset(height / 4, height / 4),
        height: 150,
        width: 150,
      ),
      (2 * math.pi) / 3,
      ((5 * math.pi) / 3) * accuracy,
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(AccuracyPainter oldDelegate) {
    return accuracy != oldDelegate.accuracy;
  }
}
