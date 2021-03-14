import 'package:flutter/material.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/each_pose_page.dart';
import 'package:sofia/screens/preview_screen.dart';
import 'package:sofia/screens/timer_overlay.dart';

class PosesListWidget extends StatelessWidget {
  final List<Pose> poses;

  const PosesListWidget({
    Key key,
    @required this.poses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: poses.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 32.0,
      ),
      itemBuilder: (_, index) {
        Pose pose = poses[index];
        String poseTitle = pose.title;
        String poseSubtitle = pose.sub;

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EachPosePage(
                  poses: poses,
                  currentIndex: index,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Palette.mediumShade,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 24.0),
                          child: Text(
                            poseTitle[0].toUpperCase() + poseTitle.substring(1),
                            // maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Palette.black,
                            ),
                          ),
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
                                pose: pose,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.lightDarkShade,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 36.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                    child: Text(
                      poseSubtitle[0].toUpperCase() + poseSubtitle.substring(1),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Palette.black,
                      ),
                    ),
                  ),
                  // SizedBox(height: 24.0),
                  // TODO: Add the description when the descriptions
                  // are updated to firebase.
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 24.0,
                    ),
                    child: Text(
                      'There should be a description of each pose here in this place. Replace this text.',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                        color: Palette.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
