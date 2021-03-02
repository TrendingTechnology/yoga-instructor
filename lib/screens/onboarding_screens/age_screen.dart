import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/application/states/store_user_data_state.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/dashboard_screen.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/widgets/age_widgets/user_info_error_widget.dart';
import 'package:sofia/widgets/age_widgets/user_info_initial_widget.dart';
import 'package:sofia/widgets/age_widgets/user_info_stored_widget.dart';
import 'package:sofia/widgets/age_widgets/user_info_storing_widget.dart';

/// Displays the `AgePage`.
///
/// Allows user to choose any one of the age ranges. Also, uploads
/// to the database when the user proceeds from this page.
///
/// **Connected pages:**
///
/// - `DashboardPage` (forward)
/// - `GenderPage` (previous)
///
/// **Params:**
///
/// - [userName]
/// - [gender]
///
class AgeScreen extends StatefulWidget {
  final FirebaseUser user;
  final String userName;
  final String gender;

  AgeScreen({
    @required this.user,
    @required this.userName,
    @required this.gender,
  });

  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  Database _database = Database();

  String errorString;
  // bool _isStoring = false;
  // int _selectedAgeGroup;

  // List<String> _ageGroupList = ['< 20', '20 - 34', '35+'];
  // List<bool> _selectedList = [false, false, false];

  AppBar appBar = AppBar(
    centerTitle: true,
    leading: BackButton(
      color: Colors.black54,
    ),
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
    print(widget.userName);
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  // Future<void> _uploadData() async {
  //   setState(() {
  //     _isStoring = true;
  //   });

  //   await _database.storeUserData(
  //     uid: widget.user.uid,
  //     imageUrl: widget.user.photoUrl,
  //     userName: widget.userName,
  //     gender: widget.gender,
  //     age: _ageGroupList[_selectedAgeGroup],
  //   );
  //   _isStoring = false;
  //   Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return DashboardScreen(); // new dashboard test
  //         // return HomePage();
  //       },
  //     ),
  //     (route) => false,
  //   ).then((_) {
  //     FlutterStatusbarcolor.setStatusBarColor(Palette.ageBackground);
  //     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Palette.ageBackground);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var screenSize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Palette.ageBackground,
        appBar: appBar,
        body: Container(
          // Color(0xFFffe6e1), --> color for the other cover
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
                  bottom: screenSize.height / 50,
                ),
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
              SizedBox(height: screenSize.height / 50),

              ProviderListener(
                provider: storeUserDataNotifierProvider.state,
                onChange: (context, state) async {
                  if (state is StoredUserData) {
                    await Future.delayed(Duration(seconds: 1));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) {
                          return DashboardScreen(user: state.userData);
                        },
                      ),
                      (route) => false,
                    ).then((_) {
                      FlutterStatusbarcolor.setStatusBarColor(
                          Palette.ageBackground);
                      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
                    });
                  }
                },
                child: Consumer(
                  builder: (context, watch, child) {
                    final state = watch(
                      storeUserDataNotifierProvider.state,
                    );

                    return state.when(
                      () => UserInfoInitialWidget(
                        screenSize: screenSize,
                        uid: widget.user.uid,
                        imageUrl: widget.user.photoUrl,
                        userName: widget.userName,
                        gender: widget.gender,
                      ),
                      storing: () => UserInfoStoringWidget(),
                      stored: (_) => UserInfoStoredWidget(),
                      error: (message) => UserInfoErrorWidget(
                        errorMessage: message,
                        screenSize: screenSize,
                        uid: widget.user.uid,
                        imageUrl: widget.user.photoUrl,
                        userName: widget.userName,
                        gender: widget.gender,
                      ),
                    );
                  },
                ),
              ),
              // _isStoring
              //     ? CircularProgressIndicator(
              //         valueColor:
              //             new AlwaysStoppedAnimation<Color>(Color(0xFFed576a)),
              //       )
              //     : IconButton(
              //         icon: Icon(
              //           Icons.check_circle,
              //           size: screenSize.width / 10,
              //           color: _selectedAgeGroup != null
              //               ? Color(0xFFed576a)
              //               : Colors.black12,
              //         ),
              //         onPressed: _selectedAgeGroup != null
              //             ? () async {
              //                 await _uploadData().catchError(
              //                   (e) => print('UPLOAD ERROR: $e'),
              //                 );
              //               }
              //             : null,
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
