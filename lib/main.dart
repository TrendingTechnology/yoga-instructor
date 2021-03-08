import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/screens/onboarding_screen.dart';

/// The list of camera types (mainly including: front and back)
List<CameraDescription> cameras = [];
void main() async {
  try {
    // To load the cameras before the app is initialized
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: ${e.code}\nError Message: ${e.description}');
  }

  // Starting point of the app
  runApp(
    ProviderScope(
      child: OnboardingScreen(),
    ),
    // For re-uploading the data to Firebase:
    // DebugScreen()
  );
}

/// First stateless widget to get loaded as soon as
/// the Dart engine runs
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();

//     getUserInfo();
//   }

//   /// Checks if the user is already logged in,
//   /// and retrieves user info
//   Future getUserInfo() async {
//     await getUser();
//     // await getUid();
//     setState(() {});
//     print(uid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Sofia: yoga trainer',
//       // Redirect to the respective page as per the authentication info
//       // Currently using DashboardPage instead of HomePage, to test
//       // the new UI
//       theme: ThemeData(fontFamily: 'GoogleSans'),
//       home: (uid != null && authSignedIn != false)
//           ? detailsUploaded
//               ? DashboardPage() // new page test
//               : NamePage()
//           : LoginPage(),
//     );
//   }
// }
