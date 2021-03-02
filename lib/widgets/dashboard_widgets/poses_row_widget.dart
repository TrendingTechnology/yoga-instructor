import 'package:flutter/material.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';

class PosesRowWidget extends StatelessWidget {
  const PosesRowWidget({
    Key key,
    @required this.screeWidth,
    @required this.poses,
  }) : super(key: key);

  final double screeWidth;
  final List<Pose> poses;

  final double POSE_WIDTH_MULT = 0.6;
  final double POSE_HEIGHT_MULT = 0.53;

  final double FAV_WIDTH_MULT = 5.5;
  final double FAV_HEIGHT_MULT = 4.8;

  final double IMAGE_MULT = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screeWidth * POSE_HEIGHT_MULT,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: poses.length,
        separatorBuilder: (context, index) => SizedBox(
          width: 24.0,
        ),
        itemBuilder: (_, index) {
          String poseTitle = poses[index].title;
          String poseSubtitle = poses[index].sub;

          return Row(
            children: [
              if (index == 0) SizedBox(width: 16.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  width: screeWidth * POSE_WIDTH_MULT,
                  decoration: BoxDecoration(
                    color: Palette.mediumShade,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: SizedBox(
                          width: screeWidth * IMAGE_MULT,
                          child: Image.asset(
                            'assets/images/triangle.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    poseTitle[0].toUpperCase() +
                                        poseTitle.substring(1) +
                                        ' pose',
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.black,
                                    ),
                                  ),
                                  Text(
                                    poseSubtitle[0].toUpperCase() +
                                        poseSubtitle.substring(1),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                      color: Palette.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Icon(
                            //   Icons.favorite_border,
                            //   size: 26,
                            //   color: Palette.lightDarkShade,
                            // ),
                            ClipOval(
                              child: Material(
                                color: Palette.lightDarkShade,
                                child: InkWell(
                                  splashColor: Palette.lightDarkShade,
                                  child: SizedBox(
                                    width: 38,
                                    height: 38,
                                    child: Center(
                                      child: Icon(
                                        Icons.favorite,
                                        size: 20,
                                        color: Palette
                                            .lightShade, // TODO: Change color to white as clicked
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (index == poses.length - 1) SizedBox(width: 16.0),
            ],
          );
        },
      ),
    );
  }
}
