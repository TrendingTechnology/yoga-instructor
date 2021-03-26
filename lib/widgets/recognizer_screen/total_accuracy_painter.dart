import 'package:flutter/material.dart';
import 'package:sofia/res/palette.dart';
import 'dart:math' as math;

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
