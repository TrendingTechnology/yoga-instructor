import 'package:flutter/material.dart';
import 'package:sofia/model/track.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/each_track_page.dart';

class TracksListWidget extends StatelessWidget {
  final List<Track> tracks;

  const TracksListWidget({
    Key key,
    @required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: tracks.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 32.0,
      ),
      itemBuilder: (_, index) {
        Track track = tracks[index];
        String trackName = track.name;
        String trackDescription = track.desc;
        int numberOfPoses = track.count;

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EachTrackPage(
                  trackName: trackName,
                  trackDescription: trackDescription,
                  numberOfPoses: numberOfPoses,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          trackName[0].toUpperCase() +
                              trackName.substring(1) +
                              ' track',
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Palette.black,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('Play button tapped !');
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
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 24.0,
                    ),
                    child: Text(
                      trackDescription,
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
