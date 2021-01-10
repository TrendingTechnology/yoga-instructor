import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sofia/screens/dashboard_page.dart';
import 'screens/login_page.dart';
import 'screens/name_page.dart';
import 'utils/sign_in.dart';

/// The list of camera types (mainly including: front and back)
List<CameraDescription> cameras = [];
void main() async {
  try {
    // To load the cameras before the app is initialized
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }

  // Starting point of the app
  runApp(MyApp());
}

/// Prints the camera error, if any occurs
///
/// **Inputs:**
///
/// [code] - error code
///
/// [message] - error message
///
/// **Use like:**
///
/// ```dart
/// logError(e.code, e.description);
/// ```
///
void logError(String code, String message) => print('Error: $code\nError Message: $message');

/// First stateless widget to get loaded as soon as
/// the Dart engine runs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  /// Checks if the user is already logged in,
  /// and retrieves user info
  Future getUserInfo() async {
    await getUser();
    // await getUid();
    setState(() {});
    print(uid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofia: yoga trainer',
      // Redirect to the respective page as per the
      // authentication info
      theme: ThemeData(fontFamily: 'GoogleSans'),
      home: (uid != null && authSignedIn != false)
          ? detailsUploaded
              ? DashboardPage() // new page test
              : NamePage()
          : LoginPage(),
    );
  }
}
