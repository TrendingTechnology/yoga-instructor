import 'package:flutter/material.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/res/palette.dart';

class PosesInitialWidget extends StatelessWidget {
  const PosesInitialWidget({
    Key key,
    @required this.screeWidth,
  }) : super(key: key);

  final double screeWidth;

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
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(
          width: 24.0,
        ),
        itemBuilder: (_, index) {
          return Row(
            children: [
              if (index == 0) SizedBox(width: 16.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  width: screeWidth * POSE_WIDTH_MULT,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              if (index == 9) SizedBox(width: 16.0),
            ],
          );
        },
      ),
    );
  }
}
