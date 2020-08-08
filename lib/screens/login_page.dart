import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:websafe_svg/websafe_svg.dart';

/// Widget for generating the Login Screen
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool webLogged;
  dynamic currentWebAuth;

  @override
  void initState() {
    super.initState();
    webLogged = false;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xFFffead7),
        // Color(0xFFffe6e1), --> color for the other cover
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            // TODO:Change fonts
            Text(
              "Sofia",
              style: GoogleFonts.titilliumWeb(
                textStyle: TextStyle(
                    fontSize: screenSize.width / 8, color: Colors.black),
              ),
            ),
            WebsafeSvg.asset(
              'assets/images/cover1.svg',
              width: MediaQuery.of(context).size.width,
              semanticsLabel: 'Cover Image',
            ),
          ],
        ),
      ),
    );
  }
}
