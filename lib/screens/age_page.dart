import 'package:flutter/material.dart';

class AgePage extends StatefulWidget {
  final String userName;
  final String gender;

  AgePage({@required this.userName, @required this.gender});

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
