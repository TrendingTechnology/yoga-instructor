import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:sofia/res/palette.dart';

class ScroreViewerWidget extends StatefulWidget {
  const ScroreViewerWidget({
    Key key,
    @required this.accuracy,
  }) : super(key: key);

  final double accuracy;

  @override
  _ScroreViewerWidgetState createState() => _ScroreViewerWidgetState();
}

class _ScroreViewerWidgetState extends State<ScroreViewerWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomPaint(
          painter: ShapePainter(
              width: width, height: height, accuracy: widget.accuracy),
          child: SizedBox(
            height: height / 2,
            width: height / 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${(widget.accuracy * 100).toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.darkShade,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShapePainter extends CustomPainter {
  final double width;
  final double height;
  final double accuracy;

  ShapePainter({
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
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
