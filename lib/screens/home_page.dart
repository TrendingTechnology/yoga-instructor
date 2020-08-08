import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool afterCompletion;
  HomePage({this.afterCompletion = false});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // For uploading tracks to the database
    // database.uploadTracks();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
