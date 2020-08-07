import 'package:flutter/material.dart';
import 'package:sofia/screens/home_page.dart';

import 'screens/login_page.dart';
import 'screens/name_page.dart';
import 'utils/sign_in.dart';

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

  Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofia: yoga trainer',
      home: (uid != null && authSignedIn != false)
          ? detailsUploaded ? HomePage() : NamePage()
          : LoginPage(),
    );
  }
}
