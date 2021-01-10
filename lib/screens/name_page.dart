import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/gender_page.dart';
import 'package:sofia/utils/sign_in.dart';

/// Displays the `NamePage`.
///
/// Accepts the full user name. It pre-populates with the
/// name retrieved from the user's Goolge Account (if any present)
///
/// **Connected pages:**
///
/// - `GenderPage` (forward)
///
class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final textController =
      name != null ? TextEditingController(text: name.split(' ')[0]) : TextEditingController();
  FocusNode textFocusNode;

  String _userName;
  bool _isEditing = false;

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
    FlutterStatusbarcolor.setStatusBarColor(Palette.nameBackground);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        textFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.nameBackground,
        body: Container(
          // Color(0xFFffe6e1), --> color for the other cover
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenSize.height / 80,
                    ),
                    child: Text(
                      'QUOTE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'LexendTera',
                        fontSize: screenSize.width / 30,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenSize.width / 15,
                      right: screenSize.width / 15,
                      bottom: screenSize.height / 50,
                    ),
                    child: Text(
                      'Yoga teaches us to cure what need not be endured and endure what cannot be cured.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: screenSize.width / 25,
                        color: Color(0xFFf87473),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/images/cover.svg',
                      width: MediaQuery.of(context).size.width,
                      semanticsLabel: 'Cover Image',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenSize.width / 10,
                      left: screenSize.width / 10,
                      bottom: screenSize.height / 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - (screenSize.width / 3),
                          child: TextField(
                            focusNode: textFocusNode,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                              color: Colors.deepOrangeAccent[700],
                              fontSize: 25,
                            ),
                            controller: textController,
                            cursorColor: Colors.deepOrange,
                            onSubmitted: (value) {
                              textFocusNode.unfocus();
                              setState(() {
                                _isEditing = true;
                              });
                              _userName = textController.text;
                              print('DONE EDITING');
                            },
                            decoration: InputDecoration(
                              suffix: Container(
                                width: 1,
                                height: 32,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrangeAccent[700]),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              labelText: 'Enter your name',
                              labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 18),
                              hintText: 'AI assistant will calling you by this name',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                              errorText: _isEditing ? _validateString(textController.text) : null,
                              errorStyle: TextStyle(fontSize: 15, color: Colors.redAccent),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            size: 40,
                            color: Colors.deepOrangeAccent[700],
                          ),
                          onPressed: () {
                            textFocusNode.unfocus();
                            _userName = textController.text;
                            // Naviagtes to the GenderPage, and passes
                            // on the name.
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return GenderPage(
                                    userName: _userName,
                                  );
                                },
                              ),
                            ).then((_) {
                              // Sets the status bar color of the one set to this page
                              // if an user comes back to this page.
                              FlutterStatusbarcolor.setStatusBarColor(Palette.nameBackground);
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
