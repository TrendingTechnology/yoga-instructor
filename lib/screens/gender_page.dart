import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/age_page.dart';
import 'package:sofia/utils/sign_in.dart';

String userName;

/// Displays the `GenderPage`.
///
/// Allows to select one of the gender.
///
/// **Connected pages:**
///
/// - `AgePage` (forward)
/// - `NamePage` (previous)
///
/// **Params:**
///
/// - [userName]
///
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
    FlutterStatusbarcolor.setStatusBarColor(Palette.genderBackground);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.genderBackground,
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          Container(
            // Color(0xFFffe6e1), --> color for the other cover
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: screenSize.height / 15),
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
                        bottom: screenSize.height / 60,
                      ),
                      child: Text(
                        'Yoga is a mirror to look at ourselves from within.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontSize: screenSize.width / 25,
                          color: Color(0xFF284e41),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SvgPicture.asset(
                        'assets/images/intro_2.svg',
                        width: MediaQuery.of(context).size.width,
                        semanticsLabel: 'Cover Image',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenSize.height / 50,
                      ),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: ToggleButtons(
                          splashColor: Colors.transparent,
                          // borderWidth: screenSize.width / 60,
                          borderColor: Colors.transparent,
                          fillColor: Colors.black12,
                          disabledBorderColor: Colors.black,
                          disabledColor: Colors.transparent,
                          color: Color(0xFF284e41),
                          selectedColor: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          children: <Widget>[
                            RotatedBox(
                              quarterTurns: 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: screenSize.width / 20,
                                  left: screenSize.width / 20,
                                  top: screenSize.height / 50,
                                  bottom: screenSize.height / 50,
                                ),
                                child: Text(
                                  'MALE',
                                  style: TextStyle(
                                    fontSize: screenSize.width / 18,
                                  ),
                                ),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: screenSize.width / 20,
                                  left: screenSize.width / 20,
                                  top: screenSize.height / 50,
                                  bottom: screenSize.height / 50,
                                ),
                                child: Text(
                                  'FEMALE',
                                  style: TextStyle(
                                    fontSize: screenSize.width / 18,
                                  ),
                                ),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: screenSize.width / 10,
                                  left: screenSize.width / 10,
                                  top: screenSize.height / 50,
                                  bottom: screenSize.height / 50,
                                ),
                                child: Text(
                                  'NON BINARY',
                                  style: TextStyle(
                                    fontSize: screenSize.width / 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          isSelected: isSelected,
                          onPressed: (int index) {
                            setState(() {
                              for (int indexBtn = 0; indexBtn < isSelected.length; indexBtn++) {
                                if (indexBtn == index) {
                                  isSelected[indexBtn] = !isSelected[indexBtn];
                                  selectedGender = genderList[index];
                                  print('GENDER: $selectedGender');
                                } else {
                                  isSelected[indexBtn] = false;
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check_circle,
                        size: screenSize.width / 10,
                        color: selectedGender != null ? Color(0xFF284e41) : Colors.black12,
                      ),
                      onPressed: selectedGender != null
                          ? () {
                              textFocusNode.unfocus();
                              userName = textController.text;
                              print('DONE Selecting');

                              // Allows user to navigate to the AgePage
                              // if any one gender is selected. Passes on the
                              // name and gender to the next page.
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AgePage(
                                      userName: widget.userName,
                                      gender: selectedGender,
                                    );
                                  },
                                ),
                              ).then((_) {
                                // Sets the status bar color of the one set to this page
                                // if an user comes back to this page.
                                FlutterStatusbarcolor.setStatusBarColor(Palette.genderBackground);
                                FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // For Showing a progress indicator
          // SafeArea(
          //   child: Container(
          //     child: LinearProgressIndicator(
          //       backgroundColor: Color(0xFFffe6e1),
          //       valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
          //       value: 1/3,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
