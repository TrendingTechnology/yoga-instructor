import 'package:flutter/material.dart';

class LoginSignningInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFed576a)),
    );
  }
}
