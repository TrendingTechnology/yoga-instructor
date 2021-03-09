import 'package:flutter/material.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/each_pose_page.dart';
import 'package:sofia/widgets/each_pose_widgets/custom_navigator.dart';

class PrevNextWidget extends StatelessWidget {
  const PrevNextWidget({
    Key key,
    @required this.poses,
    @required this.currentIndex,
  }) : super(key: key);

  final List<Pose> poses;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
              CustomNavigators.routeToPreviousScreen(
                poses: poses,
                prevIndex: currentIndex - 1,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Palette.lightDarkShade,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 4.0,
                right: 8.0,
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
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
              CustomNavigators.routeToNextScreen(
                poses: poses,
                nextIndex: currentIndex + 1,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Palette.lightDarkShade,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 8.0,
                right: 4.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
