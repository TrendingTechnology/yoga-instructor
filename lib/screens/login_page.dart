import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/utils/sign_in.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'name_page.dart';

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
            _signInButton(),
          ],
        ),
      ),
    );
  }

  /// Show Info after the Auth0 authentication is complete
  void showInfo(String text, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return NamePage();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  /// Creating the Google Sign In button
  Widget _signInButton() {
    return DecoratedBox(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white),
      child: OutlineButton(
        highlightColor: Color(0xFFffdbb7),
        splashColor: Color(0xFFffdbb7),
        onPressed: () {
          signInWithGoogle().whenComplete(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NamePage();
                },
              ),
            ).catchError(
              (e) => print('SIGN IN ERROR: $e'),
            );
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
