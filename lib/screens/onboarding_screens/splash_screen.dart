import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/res/palette.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Palette.loginBackground);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return Scaffold(
      body: Container(
        color: Palette.loginBackground,
        child: Center(
          child: Hero(
            tag: 'sofia_text',
            child: Text(
              "Sofia",
              style: TextStyle(
                fontFamily: 'TitilliumWeb',
                fontSize: 60,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
