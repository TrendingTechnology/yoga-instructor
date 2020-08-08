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
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Color(0xFFfeafb6),
        // Color(0xFFffe6e1), --> color for the other cover
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: screenSize.height - appBar.preferredSize.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: screenSize.height / 80,
                  ),
                  child: Text(
                    'QUOTE',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendTera(
                      fontSize: screenSize.width / 30,
                      color: Colors.black26,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.width / 15,
                      right: screenSize.width / 15,
                      bottom: screenSize.height / 50),
                  child: Text(
                    'The yoga pose you avoid the most you need the most.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: screenSize.width / 25,
                      color: Color(0xFF734435),
                    ),
                  ),
                ),
                Flexible(
                  child: SvgPicture.asset(
                    'assets/images/intro_3.svg',
                    width: screenSize.width,
                    semanticsLabel: 'Cover Image',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenSize.width / 10,
                    left: screenSize.width / 10,
                    bottom: screenSize.height / 10,
                  ),
                  child: TextField(
                    enabled: !_isStoring,
                    focusNode: textFocusNode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      color: Color(0xFFc31304),
                      fontSize: 25,
                    ),
                    controller: textController,
                    cursorColor: Colors.deepOrange,
                    autofocus: false,
                    onChanged: (value) {
                      // setState(() {
                      //   textController.text = value;
                      // });
                      setState(() {
                        _isEditing = true;
                      });

                      // _validateString(value);
                    },
                    onSubmitted: (value) async {
                      await _uploadData().catchError(
                        (e) => print('UPLOAD ERROR: $e'),
                      );
                    },
                    decoration: InputDecoration(
                      suffix: _isStoring
                          ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.redAccent[800],
                              ),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.check_circle,
                                size: 30,
                                color: Color(0xFFc31304),
                              ),
                              onPressed: _isStoring
                                  ? null
                                  : () async {
                                      await _uploadData().catchError(
                                        (e) => print('UPLOAD ERROR: $e'),
                                      );
                                    },
                            ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrangeAccent[700]),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF734435)),
                      ),
                      labelText: 'Enter your age',
                      labelStyle:
                          TextStyle(color: Color(0xFF734435), fontSize: 18),
                      hintText: 'Used for tracking your fitness',
                      hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                      errorText: _isEditing
                          ? _validateString(textController.text)
                          : null,
                      errorStyle:
                          TextStyle(fontSize: 15, color: Colors.redAccent[800]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
