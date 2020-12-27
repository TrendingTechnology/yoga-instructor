import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/utils/sign_in.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'name_page.dart';

/// Widget for generating the Login Screen.
/// Uses Google Sign In for user authentication
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  dynamic currentWebAuth;
  bool _isAuth0Processing = false;

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
            Text(
              "Sofia",
              style: GoogleFonts.titilliumWeb(
                textStyle: TextStyle(fontSize: screenSize.width / 8, color: Colors.black),
              ),
            ),
            WebsafeSvg.asset(
              'assets/images/cover1.svg',
              width: MediaQuery.of(context).size.width,
              semanticsLabel: 'Cover Image',
            ),
            _googleSignInButton(),
            // _auth0SignInButton(),
          ],
        ),
      ),
    );
  }

  /// Google Sign In button widget
  Widget _googleSignInButton() {
    return DecoratedBox(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white),
      child: OutlineButton(
        highlightColor: Colors.grey[100],
        splashColor: Colors.grey[100],
        color: Colors.grey[100],
        onPressed: () {
          signInWithGoogle().then((user) {
            if (user != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NamePage();
                  },
                ),
              );
            }
          }).catchError(
            (e) => print('SIGN IN ERROR: $e'),
          );
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
              Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
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
