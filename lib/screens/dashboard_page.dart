import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/utils/sign_in.dart';

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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Souvik',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Palette.black,
                        ),
                      ),
                      Stack(
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
                                  child: SizedBox(width: 38.0, child: Image.network(imageUrl)),
                                )
                              : Container(),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Inhale the future, exhale the past.', // Update the quote from backend
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.black.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  // Your favourites
                  Text(
                    'For beginners',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  FutureBuilder(
                    future: _database.retrievePoses(trackName: 'beginners'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String poseTitle = snapshot.data[0]['title'];
                        String poseSubtitle = snapshot.data[0]['sub'];

                        return Container(
                          width: screeWidth * 0.4,
                          height: screeWidth * 0.36,
                          decoration: BoxDecoration(
                              color: Palette.mediumShade,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  poseTitle[0].toUpperCase() + poseTitle.substring(1) + ' pose',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.black,
                                  ),
                                ),
                                Text(
                                  poseSubtitle[0].toUpperCase() + poseSubtitle.substring(1),
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
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
