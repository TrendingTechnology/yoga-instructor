import 'package:flutter/material.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/screens/each_pose_page.dart';

class CustomNavigators {
  static Route routeToNextScreen({
    @required List<Pose> poses,
    @required int nextIndex,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EachPosePage(
        poses: poses,
        currentIndex: nextIndex,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route routeToPreviousScreen({
    @required List<Pose> poses,
    @required int prevIndex,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EachPosePage(
        poses: poses,
        currentIndex: prevIndex,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
