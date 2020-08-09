import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sofia/screens/home_page.dart';

import 'screens/login_page.dart';
import 'screens/name_page.dart';
import 'utils/sign_in.dart';

/// For storing the list of cameras
List<CameraDescription> cameras = [];
void main() async {
  // Getting the available device cameras
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(MyApp());
}

/// For printing the camera error, if any occurs
void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Checking if the user is already logged in
    // and retrieve user info
    getUserInfo();
  }

  Future getUserInfo() async {
    await getUser();
    await getUid();
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
      home: (uid != null && authSignedIn != false)
          ? detailsUploaded ? HomePage() : NamePage()
          : LoginPage(),
    );
  }
}
