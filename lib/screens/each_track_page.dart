import 'package:flutter/material.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/timer_overlay.dart';
import 'package:sofia/utils/database.dart';

class EachTrackPage extends StatefulWidget {
  final String trackName;
  final String trackDescription;
  final int numberOfPoses;

  const EachTrackPage({
    @required this.trackName,
    @required this.trackDescription,
    @required this.numberOfPoses,
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
    trackName = widget.trackName;
    trackDescription = widget.trackDescription;
    totalNumberOfPoses = widget.numberOfPoses;
  }

  @override
  Widget build(BuildContext context) {
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
              delegate: SliverChildListDelegate([
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
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (context, _, __) => TimerOverlay(),
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
                  child: FutureBuilder(
                    future: _database.retrievePoses(trackName: trackName),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 32.0,
                          ),
                          itemBuilder: (_, index) {
                            String poseTitle = snapshot.data[index]['title'];
                            String poseSubtitle = snapshot.data[index]['sub'];

                            return InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => EachTrackPage(
                                //       trackName: trackName,
                                //       trackDescription: trackDescription,
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Palette.mediumShade,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0, top: 24.0),
                                              child: Text(
                                                poseTitle[0].toUpperCase() +
                                                    poseTitle.substring(1),
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
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  opaque: false,
                                                  pageBuilder:
                                                      (context, _, __) =>
                                                          TimerOverlay(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Palette.lightDarkShade,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8.0),
                                                    bottomLeft:
                                                        Radius.circular(8.0)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                        padding: const EdgeInsets.only(
                                            left: 16.0, top: 4.0),
                                        child: Text(
                                          poseSubtitle[0].toUpperCase() +
                                              poseSubtitle.substring(1),
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
                      return Container();
                    },
                  ),
                ),
              ]),
            )
          ],
        ),
        // child: SingleChildScrollView(
        //   physics: BouncingScrollPhysics(),
        //   child: Padding(
        //     padding: const EdgeInsets.only(bottom: 30.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(
        //               top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
        //           child: Row(
        //             children: [
        //               InkWell(
        //                 onTap: () {
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(right: 8.0),
        //                   child: Icon(
        //                     Icons.arrow_back_ios,
        //                     color: Palette.black,
        //                   ),
        //                 ),
        //               ),
        //               Text(
        //                 trackName[0].toUpperCase() + trackName.substring(1),
        //                 style: TextStyle(
        //                   fontSize: 28.0,
        //                   fontWeight: FontWeight.bold,
        //                   color: Palette.black,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         // ShaderMask(
        //         //   shaderCallback: (rect) {
        //         //     return LinearGradient(
        //         //       begin: Alignment.center,
        //         //       end: Alignment.bottomCenter,
        //         //       colors: [Colors.black, Colors.black, Colors.transparent],
        //         //     ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        //         //   },
        //         //   blendMode: BlendMode.dstIn,
        //         //   child: Image.asset(
        //         //     'assets/images/${trackName[0].toUpperCase() + trackName.substring(1)}.jpg',
        //         //   ),
        //         // ),
        //         Image.asset(
        //           'assets/images/${trackName[0].toUpperCase() + trackName.substring(1)}.jpg',
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.only(left: 16.0),
        //               child: Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   Icon(
        //                     Icons.access_time,
        //                     color: Palette.black.withOpacity(0.8),
        //                   ),
        //                   SizedBox(width: 8.0),
        //                   Text(
        //                     '15 minutes',
        //                     style: TextStyle(
        //                       fontSize: 18.0,
        //                       fontWeight: FontWeight.w400,
        //                       letterSpacing: 1,
        //                       color: Palette.black,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             InkWell(
        //               onTap: () {
        //                 print('Play all button tapped !');
        //                 Navigator.of(context).push(
        //                   PageRouteBuilder(
        //                     opaque: false,
        //                     pageBuilder: (context, _, __) => TimerOverlay(),
        //                   ),
        //                 );
        //               },
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   color: Palette.lightDarkShade,
        //                   borderRadius: BorderRadius.only(
        //                     bottomLeft: Radius.circular(8.0),
        //                   ),
        //                 ),
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(
        //                     left: 8.0,
        //                     right: 16.0,
        //                     top: 8.0,
        //                     bottom: 8.0,
        //                   ),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       Icon(
        //                         Icons.play_arrow,
        //                         color: Colors.white,
        //                         size: 36.0,
        //                       ),
        //                       Text(
        //                         'Play all',
        //                         // maxLines: 1,
        //                         softWrap: true,
        //                         overflow: TextOverflow.fade,
        //                         style: TextStyle(
        //                           fontSize: 22.0,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(
        //             top: 16.0,
        //             left: 16.0,
        //             right: 16.0,
        //           ),
        //           child: Text(
        //             trackDescription,
        //             style: TextStyle(
        //               fontSize: 16.0,
        //               fontWeight: FontWeight.w600,
        //               letterSpacing: 0.6,
        //               color: Palette.black,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(
        //             top: 16.0,
        //             left: 16.0,
        //             right: 16.0,
        //           ),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Container(
        //                 width: screenWidth / 2.2,
        //                 child: Center(
        //                   child: Text(
        //                     '$totalNumberOfPoses asanas',
        //                     style: TextStyle(
        //                       fontSize: 18.0,
        //                       fontWeight: FontWeight.w400,
        //                       letterSpacing: 1,
        //                       color: Palette.black,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 color: Palette.black.withOpacity(0.4),
        //                 height: 40,
        //                 width: 2,
        //               ),
        //               Container(
        //                 width: screenWidth / 2.2,
        //                 child: Center(
        //                   child: Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       Icon(
        //                         Icons.star_border,
        //                         color: Palette.black.withOpacity(0.8),
        //                       ),
        //                       SizedBox(width: 8.0),
        //                       Text(
        //                         '160',
        //                         style: TextStyle(
        //                           fontSize: 18.0,
        //                           fontWeight: FontWeight.w400,
        //                           letterSpacing: 1,
        //                           color: Palette.black,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(height: 24.0),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        //           child: FutureBuilder(
        //             future: _database.retrievePoses(trackName: trackName),
        //             builder: (context, snapshot) {
        //               if (snapshot.hasData) {
        //                 return ListView.separated(
        //                   shrinkWrap: true,
        //                   physics: BouncingScrollPhysics(),
        //                   itemCount: snapshot.data.length,
        //                   separatorBuilder: (context, index) => SizedBox(
        //                     height: 32.0,
        //                   ),
        //                   itemBuilder: (_, index) {
        //                     String poseTitle = snapshot.data[index]['title'];
        //                     String poseSubtitle = snapshot.data[index]['sub'];

        //                     return InkWell(
        //                       onTap: () {
        //                         // Navigator.of(context).push(
        //                         //   MaterialPageRoute(
        //                         //     builder: (context) => EachTrackPage(
        //                         //       trackName: trackName,
        //                         //       trackDescription: trackDescription,
        //                         //     ),
        //                         //   ),
        //                         // );
        //                       },
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                           color: Palette.mediumShade,
        //                           borderRadius:
        //                               BorderRadius.all(Radius.circular(8.0)),
        //                         ),
        //                         child: Padding(
        //                           padding: const EdgeInsets.all(0.0),
        //                           child: Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             mainAxisSize: MainAxisSize.max,
        //                             children: [
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.spaceBetween,
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   Expanded(
        //                                     child: Padding(
        //                                       padding: const EdgeInsets.only(
        //                                           left: 16.0, top: 24.0),
        //                                       child: Text(
        //                                         poseTitle[0].toUpperCase() +
        //                                             poseTitle.substring(1),
        //                                         // maxLines: 1,
        //                                         softWrap: true,
        //                                         overflow: TextOverflow.fade,
        //                                         style: TextStyle(
        //                                           fontSize: 22.0,
        //                                           fontWeight: FontWeight.bold,
        //                                           color: Palette.black,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   InkWell(
        //                                     onTap: () {
        //                                       print('Play button tapped !');
        //                                       Navigator.of(context).push(
        //                                         PageRouteBuilder(
        //                                           opaque: false,
        //                                           pageBuilder:
        //                                               (context, _, __) =>
        //                                                   TimerOverlay(),
        //                                         ),
        //                                       );
        //                                     },
        //                                     child: Container(
        //                                       decoration: BoxDecoration(
        //                                         color: Palette.lightDarkShade,
        //                                         borderRadius: BorderRadius.only(
        //                                             topRight:
        //                                                 Radius.circular(8.0),
        //                                             bottomLeft:
        //                                                 Radius.circular(8.0)),
        //                                       ),
        //                                       child: Padding(
        //                                         padding:
        //                                             const EdgeInsets.all(8.0),
        //                                         child: Icon(
        //                                           Icons.play_arrow,
        //                                           color: Colors.white,
        //                                           size: 36.0,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(
        //                                     left: 16.0, top: 4.0),
        //                                 child: Text(
        //                                   poseSubtitle[0].toUpperCase() +
        //                                       poseSubtitle.substring(1),
        //                                   maxLines: 1,
        //                                   softWrap: false,
        //                                   overflow: TextOverflow.fade,
        //                                   style: TextStyle(
        //                                     fontSize: 16.0,
        //                                     fontWeight: FontWeight.w400,
        //                                     color: Palette.black,
        //                                   ),
        //                                 ),
        //                               ),
        //                               // SizedBox(height: 24.0),
        //                               // TODO: Add the description when the descriptions
        //                               // are updated to firebase.
        //                               SizedBox(height: 8.0),
        //                               Padding(
        //                                 padding: const EdgeInsets.only(
        //                                   left: 16.0,
        //                                   right: 16.0,
        //                                   bottom: 24.0,
        //                                 ),
        //                                 child: Text(
        //                                   trackDescription,
        //                                   style: TextStyle(
        //                                     fontSize: 14.0,
        //                                     fontWeight: FontWeight.w400,
        //                                     letterSpacing: 1,
        //                                     color: Palette.black,
        //                                   ),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                 );
        //               }
        //               return Container();
        //             },
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
