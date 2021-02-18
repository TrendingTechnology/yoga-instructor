import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/screens/each_track_page.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/utils/sign_in.dart';

// TODOD: Add caching of the data to prevent empty
// screen during the intial load of the data from firebase
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Database _database = Database();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    double screeWidth = MediaQuery.of(context).size.width;
    double screeHeight = MediaQuery.of(context).size.height;

    const double POSE_WIDTH_MULT = 0.6;
    const double POSE_HEIGHT_MULT = 0.53;

    const double FAV_WIDTH_MULT = 5.5;
    const double FAV_HEIGHT_MULT = 4.8;

    const double IMAGE_MULT = 1.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   title: Text(
        //     'Hello, Souvik',
        //     style: TextStyle(
        //       fontSize: 26.0,
        //       fontWeight: FontWeight.bold,
        //       color: Palette.black,
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 16.0, top: 8.0),
        //       child: Stack(
        //         children: [
        //           ClipRRect(
        //             borderRadius: BorderRadius.circular(60),
        //             child: Container(
        //               color: Palette.lightDarkShade,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(6.0),
        //                 child: Icon(
        //                   Icons.person,
        //                   color: Palette.lightShade,
        //                   size: 26,
        //                 ),
        //               ),
        //             ),
        //           ),
        //           imageUrl != null
        //               ? ClipRRect(
        //                   borderRadius: BorderRadius.circular(60),
        //                   child: SizedBox(width: 38.0, child: Image.network(imageUrl)),
        //                 )
        //               : Container(),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 4,
                centerTitle: false,
                pinned: true,
                title: Text(
                  'Hello, Souvik',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Palette.black,
                  ),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              color: Palette.lightDarkShade,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.person,
                                  color: Palette.lightShade,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                          imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: SizedBox(
                                    width: 38.0,
                                    child: Image.network(imageUrl),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      'Inhale the future, exhale the past.', // Update the quote from backend
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  // Your favourites
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      'For beginners',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  FutureBuilder(
                    future: _database.retrievePoses(trackName: 'beginners'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: screeWidth * POSE_HEIGHT_MULT,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 24.0,
                            ),
                            itemBuilder: (_, index) {
                              String poseTitle = snapshot.data[index]['title'];
                              String poseSubtitle = snapshot.data[index]['sub'];

                              return Row(
                                children: [
                                  if (index == 0) SizedBox(width: 16.0),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Container(
                                      width: screeWidth * POSE_WIDTH_MULT,
                                      decoration: BoxDecoration(
                                        color: Palette.mediumShade,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        poseTitle[0]
                                                                .toUpperCase() +
                                                            poseTitle
                                                                .substring(1) +
                                                            ' pose',
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Palette.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        poseSubtitle[0]
                                                                .toUpperCase() +
                                                            poseSubtitle
                                                                .substring(1),
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                                    color:
                                                        Palette.lightDarkShade,
                                                    child: InkWell(
                                                      splashColor: Palette
                                                          .lightDarkShade,
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
                                  if (index == snapshot.data.length - 1)
                                    SizedBox(width: 16.0),
                                ],
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 24.0),
                  // Your favourites
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      'Explore tracks',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: FutureBuilder(
                      future: _database.retrieveTracks(),
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
                              String trackName = snapshot.data[index]['name'];
                              String trackDescription =
                                  snapshot.data[index]['desc'];
                              int numberOfPoses = snapshot.data[index]['count'];

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
                                        // Expanded(
                                        //   child: Center(
                                        //     child: SizedBox(
                                        //       width: screeWidth * IMAGE_MULT,
                                        //       child:
                                        //           Image.asset('assets/images/child.png'),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Text(
                                        //       trackName[0].toUpperCase() +
                                        //           trackName.substring(1) +
                                        //           ' track',
                                        //       maxLines: 1,
                                        //       softWrap: false,
                                        //       overflow: TextOverflow.fade,
                                        //       style: TextStyle(
                                        //         fontSize: 22.0,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Palette.black,
                                        //       ),
                                        //     ),
                                        //     ClipOval(
                                        //       child: Material(
                                        //         color: Palette.lightDarkShade,
                                        //         child: InkWell(
                                        //           splashColor: Palette.lightDarkShade,
                                        //           child: SizedBox(
                                        //             width: 38,
                                        //             height: 38,
                                        //             child: Center(
                                        //               child: Icon(
                                        //                 Icons.play_arrow,
                                        //                 size: 20,
                                        //                 color: Colors.white,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           onTap: () {},
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8.0)),
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
                  // Container(
                  //   color: Colors.black,
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         height: 24,
                  //         width: double.maxFinite,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.only(
                  //             bottomLeft: Radius.circular(8.0),
                  //             bottomRight: Radius.circular(8.0),
                  //           ),
                  //         ),
                  //       ),
                  //       Text(
                  //         'Privacy policy', // Update the quote from backend
                  //         style: TextStyle(
                  //           fontSize: 16.0,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 2,
                          color: Palette.black.withOpacity(0.2),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Icon(
                              Icons.privacy_tip,
                              color: Palette.black.withOpacity(0.6),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Privacy policy', // Update the quote from backend
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Palette.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Palette.black.withOpacity(0.6),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Contact us', // Update the quote from backend
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Palette.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Palette.black.withOpacity(0.6),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'About', // Update the quote from backend
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Palette.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
          // child: SingleChildScrollView(
          //   physics: BouncingScrollPhysics(),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 16.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             // crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Hello, Souvik',
          //                 style: TextStyle(
          //                   fontSize: 26.0,
          //                   fontWeight: FontWeight.bold,
          //                   color: Palette.black,
          //                 ),
          //               ),
          //               Stack(
          //                 children: [
          //                   ClipRRect(
          //                     borderRadius: BorderRadius.circular(60),
          //                     child: Container(
          //                       color: Palette.lightDarkShade,
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(6.0),
          //                         child: Icon(
          //                           Icons.person,
          //                           color: Palette.lightShade,
          //                           size: 26,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   imageUrl != null
          //                       ? ClipRRect(
          //                           borderRadius: BorderRadius.circular(60),
          //                           child: SizedBox(
          //                               width: 38.0,
          //                               child: Image.network(imageUrl)),
          //                         )
          //                       : Container(),
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),
          //         SizedBox(height: 8.0),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //           child: Text(
          //             'Inhale the future, exhale the past.', // Update the quote from backend
          //             style: TextStyle(
          //               fontSize: 16.0,
          //               fontWeight: FontWeight.bold,
          //               color: Palette.black.withOpacity(0.5),
          //             ),
          //           ),
          //         ),
          //         SizedBox(height: 32.0),
          //         // Your favourites
          //         Padding(
          //           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //           child: Text(
          //             'For beginners',
          //             style: TextStyle(
          //               fontSize: 32.0,
          //               fontWeight: FontWeight.bold,
          //               color: Palette.black,
          //             ),
          //           ),
          //         ),
          //         SizedBox(height: 16.0),
          //         FutureBuilder(
          //           future: _database.retrievePoses(trackName: 'beginners'),
          //           builder: (context, snapshot) {
          //             if (snapshot.hasData) {
          //               return Container(
          //                 height: screeWidth * POSE_HEIGHT_MULT,
          //                 child: ListView.separated(
          //                   physics: BouncingScrollPhysics(),
          //                   scrollDirection: Axis.horizontal,
          //                   itemCount: snapshot.data.length,
          //                   separatorBuilder: (context, index) => SizedBox(
          //                     width: 24.0,
          //                   ),
          //                   itemBuilder: (_, index) {
          //                     String poseTitle = snapshot.data[index]['title'];
          //                     String poseSubtitle = snapshot.data[index]['sub'];

          //                     return Row(
          //                       children: [
          //                         if (index == 0) SizedBox(width: 16.0),
          //                         Padding(
          //                           padding:
          //                               const EdgeInsets.only(bottom: 16.0),
          //                           child: Container(
          //                             width: screeWidth * POSE_WIDTH_MULT,
          //                             decoration: BoxDecoration(
          //                               color: Palette.mediumShade,
          //                               borderRadius: BorderRadius.all(
          //                                   Radius.circular(8.0)),
          //                             ),
          //                             child: Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               mainAxisSize: MainAxisSize.max,
          //                               children: [
          //                                 ClipRRect(
          //                                   borderRadius: BorderRadius.only(
          //                                     topLeft: Radius.circular(8.0),
          //                                     topRight: Radius.circular(8.0),
          //                                   ),
          //                                   child: SizedBox(
          //                                     width: screeWidth * IMAGE_MULT,
          //                                     child: Image.asset(
          //                                       'assets/images/triangle.png',
          //                                       fit: BoxFit.cover,
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 Padding(
          //                                   padding: const EdgeInsets.only(
          //                                     left: 8.0,
          //                                     right: 8.0,
          //                                     top: 8.0,
          //                                   ),
          //                                   child: Row(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment
          //                                             .spaceBetween,
          //                                     children: [
          //                                       Flexible(
          //                                         child: Column(
          //                                           crossAxisAlignment:
          //                                               CrossAxisAlignment
          //                                                   .start,
          //                                           children: [
          //                                             Text(
          //                                               poseTitle[0]
          //                                                       .toUpperCase() +
          //                                                   poseTitle
          //                                                       .substring(1) +
          //                                                   ' pose',
          //                                               maxLines: 1,
          //                                               softWrap: false,
          //                                               overflow:
          //                                                   TextOverflow.fade,
          //                                               style: TextStyle(
          //                                                 fontSize: 16.0,
          //                                                 fontWeight:
          //                                                     FontWeight.bold,
          //                                                 color: Palette.black,
          //                                               ),
          //                                             ),
          //                                             Text(
          //                                               poseSubtitle[0]
          //                                                       .toUpperCase() +
          //                                                   poseSubtitle
          //                                                       .substring(1),
          //                                               maxLines: 1,
          //                                               softWrap: false,
          //                                               overflow:
          //                                                   TextOverflow.fade,
          //                                               style: TextStyle(
          //                                                 fontSize: 14.0,
          //                                                 fontWeight:
          //                                                     FontWeight.w400,
          //                                                 letterSpacing: 1,
          //                                                 color: Palette.black,
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                       // Icon(
          //                                       //   Icons.favorite_border,
          //                                       //   size: 26,
          //                                       //   color: Palette.lightDarkShade,
          //                                       // ),
          //                                       ClipOval(
          //                                         child: Material(
          //                                           color:
          //                                               Palette.lightDarkShade,
          //                                           child: InkWell(
          //                                             splashColor: Palette
          //                                                 .lightDarkShade,
          //                                             child: SizedBox(
          //                                               width: 38,
          //                                               height: 38,
          //                                               child: Center(
          //                                                 child: Icon(
          //                                                   Icons.favorite,
          //                                                   size: 20,
          //                                                   color: Palette
          //                                                       .lightShade, // TODO: Change color to white as clicked
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                             onTap: () {},
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                         if (index == snapshot.data.length - 1)
          //                           SizedBox(width: 16.0),
          //                       ],
          //                     );
          //                   },
          //                 ),
          //               );
          //             }
          //             return Container();
          //           },
          //         ),
          //         SizedBox(height: 24.0),
          //         // Your favourites
          //         Padding(
          //           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //           child: Text(
          //             'Explore tracks',
          //             style: TextStyle(
          //               fontSize: 32.0,
          //               fontWeight: FontWeight.bold,
          //               color: Palette.black,
          //             ),
          //           ),
          //         ),
          //         SizedBox(height: 16.0),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          //           child: FutureBuilder(
          //             future: _database.retrieveTracks(),
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
          //                     String trackName = snapshot.data[index]['name'];
          //                     String trackDescription =
          //                         snapshot.data[index]['desc'];
          //                     int numberOfPoses = snapshot.data[index]['count'];

          //                     return InkWell(
          //                       onTap: () {
          //                         Navigator.of(context).push(
          //                           MaterialPageRoute(
          //                             builder: (context) => EachTrackPage(
          //                               trackName: trackName,
          //                               trackDescription: trackDescription,
          //                               numberOfPoses: numberOfPoses,
          //                             ),
          //                           ),
          //                         );
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
          //                               // Expanded(
          //                               //   child: Center(
          //                               //     child: SizedBox(
          //                               //       width: screeWidth * IMAGE_MULT,
          //                               //       child:
          //                               //           Image.asset('assets/images/child.png'),
          //                               //     ),
          //                               //   ),
          //                               // ),
          //                               // Row(
          //                               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                               //   children: [
          //                               //     Text(
          //                               //       trackName[0].toUpperCase() +
          //                               //           trackName.substring(1) +
          //                               //           ' track',
          //                               //       maxLines: 1,
          //                               //       softWrap: false,
          //                               //       overflow: TextOverflow.fade,
          //                               //       style: TextStyle(
          //                               //         fontSize: 22.0,
          //                               //         fontWeight: FontWeight.bold,
          //                               //         color: Palette.black,
          //                               //       ),
          //                               //     ),
          //                               //     ClipOval(
          //                               //       child: Material(
          //                               //         color: Palette.lightDarkShade,
          //                               //         child: InkWell(
          //                               //           splashColor: Palette.lightDarkShade,
          //                               //           child: SizedBox(
          //                               //             width: 38,
          //                               //             height: 38,
          //                               //             child: Center(
          //                               //               child: Icon(
          //                               //                 Icons.play_arrow,
          //                               //                 size: 20,
          //                               //                 color: Colors.white,
          //                               //               ),
          //                               //             ),
          //                               //           ),
          //                               //           onTap: () {},
          //                               //         ),
          //                               //       ),
          //                               //     ),
          //                               //   ],
          //                               // ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.end,
          //                                 children: [
          //                                   Padding(
          //                                     padding: const EdgeInsets.only(
          //                                         left: 16.0),
          //                                     child: Text(
          //                                       trackName[0].toUpperCase() +
          //                                           trackName.substring(1) +
          //                                           ' track',
          //                                       maxLines: 1,
          //                                       softWrap: false,
          //                                       overflow: TextOverflow.fade,
          //                                       style: TextStyle(
          //                                         fontSize: 22.0,
          //                                         fontWeight: FontWeight.bold,
          //                                         color: Palette.black,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   InkWell(
          //                                     onTap: () {
          //                                       print('Play button tapped !');
          //                                     },
          //                                     child: Container(
          //                                       decoration: BoxDecoration(
          //                                         color: Palette.lightDarkShade,
          //                                         borderRadius:
          //                                             BorderRadius.only(
          //                                                 topRight:
          //                                                     Radius.circular(
          //                                                         8.0),
          //                                                 bottomLeft:
          //                                                     Radius.circular(
          //                                                         8.0)),
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
          //         // Container(
          //         //   color: Colors.black,
          //         //   child: Column(
          //         //     children: [
          //         //       Container(
          //         //         height: 24,
          //         //         width: double.maxFinite,
          //         //         decoration: BoxDecoration(
          //         //           color: Colors.white,
          //         //           borderRadius: BorderRadius.only(
          //         //             bottomLeft: Radius.circular(8.0),
          //         //             bottomRight: Radius.circular(8.0),
          //         //           ),
          //         //         ),
          //         //       ),
          //         //       Text(
          //         //         'Privacy policy', // Update the quote from backend
          //         //         style: TextStyle(
          //         //           fontSize: 16.0,
          //         //           fontWeight: FontWeight.bold,
          //         //           color: Colors.white,
          //         //         ),
          //         //       ),
          //         //     ],
          //         //   ),
          //         // ),
          //         SizedBox(height: 16.0),
          //         Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 width: double.maxFinite,
          //                 height: 2,
          //                 color: Palette.black.withOpacity(0.2),
          //               ),
          //               SizedBox(height: 16.0),
          //               Row(
          //                 children: [
          //                   Icon(
          //                     Icons.privacy_tip,
          //                     color: Palette.black.withOpacity(0.6),
          //                   ),
          //                   SizedBox(width: 8.0),
          //                   Text(
          //                     'Privacy policy', // Update the quote from backend
          //                     style: TextStyle(
          //                       fontSize: 16.0,
          //                       fontWeight: FontWeight.bold,
          //                       color: Palette.black.withOpacity(0.6),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(height: 8.0),
          //               Row(
          //                 children: [
          //                   Icon(
          //                     Icons.email,
          //                     color: Palette.black.withOpacity(0.6),
          //                   ),
          //                   SizedBox(width: 8.0),
          //                   Text(
          //                     'Contact us', // Update the quote from backend
          //                     style: TextStyle(
          //                       fontSize: 16.0,
          //                       fontWeight: FontWeight.bold,
          //                       color: Palette.black.withOpacity(0.6),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(height: 8.0),
          //               Row(
          //                 children: [
          //                   Icon(
          //                     Icons.info,
          //                     color: Palette.black.withOpacity(0.6),
          //                   ),
          //                   SizedBox(width: 8.0),
          //                   Text(
          //                     'About', // Update the quote from backend
          //                     style: TextStyle(
          //                       fontSize: 16.0,
          //                       fontWeight: FontWeight.bold,
          //                       color: Palette.black.withOpacity(0.6),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         // SizedBox(height: 30.0)
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
