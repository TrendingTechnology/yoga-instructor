import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/model/track.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/preview_screen.dart';
import 'package:sofia/screens/timer_overlay.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/widgets/dashboard_widgets/poses_list/poses_list_error_widget.dart';
import 'package:sofia/widgets/dashboard_widgets/poses_list/poses_list_initial_widget.dart';
import 'package:sofia/widgets/dashboard_widgets/poses_list/poses_list_loading_widget.dart';
import 'package:sofia/widgets/dashboard_widgets/poses_list/poses_list_widget.dart';

class EachTrackPage extends StatefulWidget {
  final Track track;

  const EachTrackPage({
    @required this.track,
  });

  @override
  _EachTrackPageState createState() => _EachTrackPageState();
}

class _EachTrackPageState extends State<EachTrackPage> {
  final Database _database = Database();

  String trackName;
  String trackDescription;
  int totalNumberOfPoses;

  @override
  void initState() {
    super.initState();
    trackName = widget.track.name;
    trackDescription = widget.track.desc;
    totalNumberOfPoses = widget.track.count;
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 4,
              centerTitle: false,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: IconButton(
                  splashColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Palette.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              title: Text(
                trackName[0].toUpperCase() + trackName.substring(1),
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.black,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Image.asset(
                    'assets/images/${trackName[0].toUpperCase() + trackName.substring(1)}.jpg',
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
                              '15 minutes',
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
                          print('Play all button tapped !');
                          // Navigator.of(context).push(
                          //   PageRouteBuilder(
                          //     opaque: false,
                          //     pageBuilder: (context, _, __) => TimerOverlay(),
                          //   ),
                          // );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PreviewScreen(),
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
                                  'Play all',
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
                      trackDescription,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth / 2.2,
                          child: Center(
                            child: Text(
                              '$totalNumberOfPoses asanas',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                color: Palette.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Palette.black.withOpacity(0.4),
                          height: 40,
                          width: 2,
                        ),
                        Container(
                          width: screenWidth / 2.2,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_border,
                                  color: Palette.black.withOpacity(0.8),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  '160',
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 30.0,
                    ),
                    child: Consumer(
                      builder: (context, watch, child) {
                        final state = watch(
                          retrievePosesNotifierProvider(trackName).state,
                        );

                        return state.when(
                          () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context
                                  .read(
                                      retrievePosesNotifierProvider(trackName))
                                  .retrievePoses();
                            });
                            return PosesListInitialWidget();
                          },
                          retrieving: () => PosesListLoadingWidget(),
                          retrieved: (poses) => PosesListWidget(
                            poses: poses,
                          ),
                          error: (message) => PosesListErrorWidget(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
