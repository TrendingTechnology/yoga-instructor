import 'package:flutter/material.dart';

import 'package:sofia/utils/sign_in.dart';

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final textController = name != null
      ? TextEditingController(text: name.split(' ')[0])
      : TextEditingController();
  FocusNode textFocusNode;

  String _userName;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
  }

  String _validateString(String value) {
    if (value.isEmpty) {
      return 'Name Can\'t Be Empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
