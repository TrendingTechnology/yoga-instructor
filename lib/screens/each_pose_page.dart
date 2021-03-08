import 'package:flutter/material.dart';

class EachPosePage extends StatefulWidget {
  @override
  _EachPosePageState createState() => _EachPosePageState();
}

class _EachPosePageState extends State<EachPosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            'assets/images/triangle.png',
          ),
        ],
      ),
    );
  }
}
