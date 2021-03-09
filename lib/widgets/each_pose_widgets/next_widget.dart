import 'package:flutter/material.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/widgets/each_pose_widgets/custom_navigator.dart';

class NextWidget extends StatelessWidget {
  const NextWidget({
    Key key,
    @required this.poses,
    @required this.currentIndex,
  }) : super(key: key);

  final List<Pose> poses;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            left: 10.0,
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
    );
  }
}
