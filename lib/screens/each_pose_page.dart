import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/preview_screen.dart';
import 'package:sofia/screens/timer_overlay.dart';
import 'package:sofia/widgets/each_pose_widgets/next_widget.dart';
import 'package:sofia/widgets/each_pose_widgets/prev_next_widget.dart';
import 'package:sofia/widgets/each_pose_widgets/prev_widget.dart';

class EachPosePage extends StatefulWidget {
  final List<Pose> poses;
  final int currentIndex;

  const EachPosePage({
    Key key,
    @required this.poses,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  _EachPosePageState createState() => _EachPosePageState();
}

class _EachPosePageState extends State<EachPosePage> {
  int currentIndex;
  Pose currentPose;
  String poseName;
  String poseSubtitle;
  String poseNameDisplay;
  List<String> benefitList;

  List<Pose> poses;

  @override
  void initState() {
    super.initState();
    poses = widget.poses;
    currentIndex = widget.currentIndex;
    currentPose = widget.poses[currentIndex];
    poseName = currentPose.title;
    poseNameDisplay = poseName[0].toUpperCase() + poseName.substring(1);

    poseSubtitle =
        currentPose.sub[0].toUpperCase() + currentPose.sub.substring(1);

    benefitList = currentPose.benefits.split('. ');
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: currentIndex == 0
          ? NextWidget(
              poses: poses,
              currentIndex: currentIndex,
            )
          : currentIndex == poses.length - 1
              ? PrevWidget(
                  poses: poses,
                  currentIndex: currentIndex,
                )
              : PrevNextWidget(
                  poses: poses,
                  currentIndex: currentIndex,
                ),
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenWidth * 0.8,
              child: Image.asset(
                'assets/images/triangle.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Palette.black.withOpacity(0.8),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '3 minutes',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          color: Palette.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('Play button tapped !');
                    // Navigator.of(context).push(
                    //   PageRouteBuilder(
                    //     opaque: false,
                    //     pageBuilder: (context, _, __) => TimerOverlay(),
                    //   ),
                    // );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PreviewScreen(
                          pose: currentPose,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.lightDarkShade,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 16.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 36.0,
                          ),
                          Text(
                            'Play',
                            // maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                poseNameDisplay,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                poseSubtitle,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Palette.black.withOpacity(0.6),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                'Some of the benefits of the $poseNameDisplay pose are as follows:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: Palette.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: benefitList.length,
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      // top: 8.0,
                      bottom: 16.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '•  ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: Palette.black,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${benefitList[index]}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6,
                              color: Palette.lightDarkShade,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
