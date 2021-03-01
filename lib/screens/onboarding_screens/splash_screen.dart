import 'package:flutter/material.dart';
import 'package:sofia/res/palette.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                fontSize: 50,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
