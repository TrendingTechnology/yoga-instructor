import 'package:flutter/material.dart';
import 'package:sofia/res/palette.dart';

class UserInfoStoringWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Palette.accentDarkPink,
      ),
    );
  }
}
