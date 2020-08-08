import 'package:flutter/material.dart';

import 'package:sofia/utils/sign_in.dart';

String userName;

class GenderPage extends StatefulWidget {
  final String userName;

  GenderPage({@required this.userName});

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final textController = name != null
      ? TextEditingController(text: name.split(' ')[0])
      : TextEditingController(text: '');
  FocusNode textFocusNode;
  List<bool> isSelected = [false, false, false];
  List<String> genderList = ['Male', 'Female', 'Non Binary'];

  String selectedGender;

  AppBar appBar = AppBar(
    centerTitle: true,
    title: Text(
      '',
      style: TextStyle(color: Colors.deepOrangeAccent[700], fontSize: 30),
    ),
    backgroundColor: Color(0xFF5cb798),
    elevation: 0,
  );

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
