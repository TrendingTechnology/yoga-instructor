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

  String _validateString(String value) {
    value = value.trim();

    if (textController.text != null) {
      if (value.isEmpty) {
        return 'Age Can\'t Be Empty';
      } else if (!isNumeric(value)) {
        return 'Age should be numeric';
      }
    }

    return null;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<void> _uploadData() async {
    textFocusNode.unfocus();
    setState(() {
      _isStoring = true;
    });

    var ageString = textController.text.trim();
    ageString.contains('.')
        ? ageString = ageString.split('.')[0]
        : ageString = ageString;

    _age = int.parse(ageString);
    print('DONE EDITING');
    print('AGE: $_age');
    await _database.storeUserData(
      userName: widget.userName,
      gender: widget.gender,
      age: _age,
    );
    _isStoring = false;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
