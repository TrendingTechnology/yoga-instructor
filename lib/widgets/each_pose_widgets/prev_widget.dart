import 'package:flutter/material.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/each_pose_page.dart';

class PrevWidget extends StatelessWidget {
  const PrevWidget({
    Key key,
    @required this.poses,
    @required this.currentIndex,
  }) : super(key: key);

  final List<Pose> poses;
  final int currentIndex;

  Route _routeToPreviousScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EachPosePage(
        poses: poses,
        currentIndex: currentIndex - 1,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(_routeToPreviousScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Palette.lightDarkShade,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            left: 4.0,
            right: 10.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
                size: 16.0,
              ),
              SizedBox(width: 4.0),
              Text(
                'PREV',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
