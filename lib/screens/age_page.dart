import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/screens/gender_page.dart';
import 'package:sofia/screens/home_page.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/utils/sign_in.dart';

/// Widget for generating the Age Screen,
/// and storing it in the database
class AgePage extends StatefulWidget {
  final String userName;
  final String gender;

  AgePage({@required this.userName, @required this.gender});

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  TextEditingController textController;
  FocusNode textFocusNode;
  Database _database = Database();

  int _age;

  String errorString;
  bool _isEditing = false;
  bool _isStoring = false;

  AppBar appBar = AppBar(
    centerTitle: true,
    title: Text(
      '',
      style: TextStyle(color: Colors.deepOrangeAccent[700], fontSize: 30),
    ),
    backgroundColor: Color(0xFFfeafb6),
    elevation: 0,
  );

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textController.text = null;
    textFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
