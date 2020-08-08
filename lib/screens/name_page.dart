import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/screens/gender_page.dart';
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
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Sofia',
      //     style: TextStyle(
      //       color: Colors.deepOrangeAccent[700],
      //       fontSize: 30
      //     ),
      //   ),
      //   backgroundColor: Color(0xFFffe6e1),
      //   elevation: 0,
      // ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFFffe6e1),
            // Color(0xFFffe6e1), --> color for the other cover
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                        'Yoga teaches us to cure what need not be endured and endure what cannot be cured.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: screenSize.width / 25,
                          color: Color(0xFFf87473),
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
                      child: TextField(
                        focusNode: textFocusNode,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          color: Colors.deepOrangeAccent[700],
                          fontSize: 25,
                        ),
                        controller: textController,
                        cursorColor: Colors.deepOrange,
                        onSubmitted: (value) {
                          textFocusNode.unfocus();
                          _userName = textController.text;
                          print('DONE EDITING');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return GenderPage(
                                  userName: _userName,
                                );
                              },
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          suffix: IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              size: 30,
                              color: Colors.deepOrangeAccent[700],
                            ),
                            onPressed: () {
                              textFocusNode.unfocus();
                              _userName = textController.text;
                              print('DONE EDITING');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return GenderPage(
                                      userName: _userName,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent[700]),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                          labelText: 'Enter your name',
                          labelStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 18),
                          hintText:
                              'AI assistant will calling you by this name',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                          errorText: _validateString(textController.text),
                          errorStyle:
                              TextStyle(fontSize: 15, color: Colors.redAccent),
                        ),
                      ),
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
