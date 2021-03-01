import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/application/states/auth_sign_in_state.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/widgets/login_widgets/login_error.dart';
import 'package:sofia/widgets/login_widgets/login_initial_widget.dart';
import 'package:sofia/widgets/login_widgets/login_signed_in_widget.dart';
import 'package:sofia/widgets/login_widgets/login_signing_in_widget.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'name_screen.dart';

/// Displays the `LoginPage`.
///
/// Uses Google Sign In for user authentication.
///
/// **Connected pages:**
///
/// - `NamePage` (forward)
///
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Palette.loginBackground);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    var screenSize = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Palette.loginBackground,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Hero(
                tag: 'sofia_text',
                child: Text(
                  "Sofia",
                  style: TextStyle(
                    fontFamily: 'TitilliumWeb',
                    fontSize: screenSize.width / 8,
                    color: Colors.black,
                  ),
                ),
              ),
              WebsafeSvg.asset(
                'assets/images/cover1.svg',
                width: MediaQuery.of(context).size.width,
                semanticsLabel: 'Cover Image',
              ),
              ProviderListener(
                provider: authSignInNotifierProvider.state,
                onChange: (context, state) async {
                  if (state is SignedIn) {
                    FirebaseUser signedInUser = state.user;

                    await Future.delayed(Duration(seconds: 1));

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return NameScreen(user: signedInUser);
                        },
                      ),
                    ).then((_) {
                      // Sets the status bar color of the one set to this page
                      // if an user comes back to this page.
                      FlutterStatusbarcolor.setStatusBarColor(
                          Palette.loginBackground);
                      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
                    });
                  }
                },
                child: Consumer(
                  builder: (context, watch, child) {
                    final state = watch(
                      authSignInNotifierProvider.state,
                    );

                    return state.when(
                      () => LoginInitialWidget(),
                      signingIn: () => LoginSignningInWidget(),
                      signedIn: (_) => LoginSignedInWidget(),
                      error: (message) => LoginError(errorMessage: message),
                    );
                  },
                ),
              )
              // _googleSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Generates Google Sign In button widget
  // Widget googleSignInButton() {
  //   return DecoratedBox(
  //     decoration: ShapeDecoration(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(40),
  //         ),
  //         color: Colors.white),
  //     child: OutlineButton(
  //       highlightColor: Colors.grey[100],
  //       splashColor: Colors.grey[100],
  //       color: Colors.grey[100],
  //       onPressed: () {
  //         // Navigates to the NamePage if the authentication
  //         // is successful.
  //         signInWithGoogle().then((user) {
  //           if (user != null) {
  //             Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(
  //                 builder: (context) {
  //                   return NameScreen(
  //                     user: user,
  //                   );
  //                 },
  //               ),
  //             ).then((_) {
  //               // Sets the status bar color of the one set to this page
  //               // if an user comes back to this page.
  //               FlutterStatusbarcolor.setStatusBarColor(
  //                   Palette.loginBackground);
  //               FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  //             });
  //           }
  //         }).catchError(
  //           (e) => print('SIGN IN ERROR: $e'),
  //         );
  //       },
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //       highlightElevation: 0,
  //       borderSide: BorderSide(color: Colors.black),
  //       child: Padding(
  //         padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Image(
  //                 image: AssetImage("assets/images/google_logo.png"),
  //                 height: 35.0),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 10),
  //               child: Text(
  //                 'Sign in with Google',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   color: Colors.black45,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
