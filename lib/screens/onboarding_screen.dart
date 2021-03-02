import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/screens/dashboard_screen.dart';
import 'onboarding_screens/login_screen.dart';
import 'onboarding_screens/name_screen.dart';
import 'onboarding_screens/splash_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sofia: yoga trainer',
      // Redirect to the respective page as per the authentication info
      // Currently using DashboardPage instead of HomePage, to test
      // the new UI
      theme: ThemeData(
        fontFamily: 'GoogleSans',
      ),
      home: Consumer(
        builder: (context, watch, child) {
          final state = watch(
            authCurrentUserNotifierProvider.state,
          );

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: state.when(
              () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context
                      .read(authCurrentUserNotifierProvider)
                      .getCurrentUser();
                });
                return SplashScreen();
              },
              finding: () => SplashScreen(),
              notSignedIn: () => LoginScreen(),
              alreadySignedIn: (userData) => DashboardScreen(user: userData),
              detailsNotUploaded: (user) => NameScreen(user: user),
              error: (message) => LoginScreen(),
            ),
          );
        },
      ),
    );
  }
}
